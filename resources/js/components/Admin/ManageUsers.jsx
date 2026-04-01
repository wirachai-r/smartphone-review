import React, { useEffect, useState } from "react";
import { getUsers, updateUserRoleStatus, deleteUser } from "../../services/users";
import { FaTrash } from "react-icons/fa";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { Form } from "react-bootstrap";

const MySwal = withReactContent(Swal);
const ITEMS_PER_PAGE = 10;

const ManageUsers = () => {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);

    const fetchUsers = async () => {
        setLoading(true);
        try {
            const data = await getUsers();
            setUsers(Array.isArray(data) ? data : []);
        } catch (error) {
            console.error(error);
            MySwal.fire("ข้อผิดพลาด", "ไม่สามารถโหลดข้อมูลผู้ใช้ได้", "error");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchUsers();
    }, []);

    const handleDelete = async (id) => {
        const result = await MySwal.fire({
            title: "คุณแน่ใจหรือไม่?",
            text: "การลบผู้ใช้จะไม่สามารถกู้คืนได้!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "ลบ",
            cancelButtonText: "ยกเลิก",
        });

        if (result.isConfirmed) {
            try {
                await deleteUser(id);
                MySwal.fire("สำเร็จ!", "ลบผู้ใช้เรียบร้อยแล้ว", "success");
                fetchUsers();
            } catch (error) {
                console.error(error);
                MySwal.fire("ข้อผิดพลาด", "ไม่สามารถลบผู้ใช้ได้", "error");
            }
        }
    };

    const handleRoleChange = async (userId, newRole) => {
        try {
            const user = await updateUserRoleStatus(userId, { role: newRole });
            setUsers((prev) =>
                prev.map((u) => (u.id === userId ? user : u))
            );
            MySwal.fire("สำเร็จ", `บทบาทของผู้ใช้ถูกเปลี่ยนเป็น ${newRole}`, "success");
        } catch (error) {
            console.error(error);
            MySwal.fire("ข้อผิดพลาด", "ไม่สามารถอัปเดตบทบาทได้", "error");
        }
    };

    const handleStatusChange = async (userId, newStatus) => {
        try {
            const user = await updateUserRoleStatus(userId, { status: newStatus });
            setUsers((prev) =>
                prev.map((u) => (u.id === userId ? user : u))
            );
            MySwal.fire("สำเร็จ", `สถานะของผู้ใช้ถูกเปลี่ยนเป็น ${newStatus}`, "success");
        } catch (error) {
            console.error(error);
            MySwal.fire("ข้อผิดพลาด", "ไม่สามารถอัปเดตสถานะได้", "error");
        }
    };

    const totalPages = Math.ceil(users.length / ITEMS_PER_PAGE);
    const paginatedUsers = Array.isArray(users)
        ? users.slice(
            (currentPage - 1) * ITEMS_PER_PAGE,
            currentPage * ITEMS_PER_PAGE
        )
        : [];

    return (
        <div>
            <div className="d-flex align-items-center mt-2 mb-4">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    จัดการผู้ใช้
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            <div className="card border rounded">
                <div className="card-body p-0">
                    {loading ? (
                        <p className="p-3 text-center">กำลังโหลดข้อมูล...</p>
                    ) : users.length === 0 ? (
                        <p className="p-3 text-center">ยังไม่มีผู้ใช้</p>
                    ) : (
                        <div className="table-responsive rounded">
                            <table className="table table-sm align-middle mb-0">
                                <thead className="table-light">
                                    <tr>
                                        <th className="text-start p-3 fw-medium">#</th>
                                        <th className="text-start p-3 fw-medium">รูปประจำตัว</th>
                                        <th className="text-start p-3 fw-medium">ชื่อ</th>
                                        <th className="text-start p-3 fw-medium">อีเมล</th>
                                        <th className="text-start p-3 fw-medium">บทบาท</th>
                                        <th className="text-start p-3 fw-medium">สถานะ</th>
                                        <th className="text-start p-3 fw-medium">จัดการ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {paginatedUsers.map((user, index) => (
                                        <tr key={user.id}>
                                            <td className="p-3">{(currentPage - 1) * ITEMS_PER_PAGE + index + 1}</td>
                                            <td className="p-3">
                                                {user.avatar_url ? (
                                                    <img
                                                        src={user.avatar_url}
                                                        alt={user.name}
                                                        style={{ width: 40, height: 40, borderRadius: "50%" }}
                                                    />
                                                ) : (
                                                    <div
                                                        style={{ width: 40, height: 40, borderRadius: "50%", backgroundColor: "#dee2e6" }}
                                                    ></div>
                                                )}
                                            </td>
                                            <td className="p-3">{user.name}</td>
                                            <td className="p-3">{user.email}</td>
                                            <td className="p-3">
                                                <select
                                                    value={user.role}
                                                    onChange={(e) => handleRoleChange(user.id, e.target.value)}
                                                    className="form-select form-select-sm"
                                                >
                                                    <option value="user">ผู้ใช้</option>
                                                    <option value="admin">ผู้ดูแล</option>
                                                </select>
                                            </td>
                                            <td className="p-3">
                                                <Form.Check
                                                    type="switch"
                                                    id={`status-switch-${user.id}`}
                                                    label={user.status === "active" ? "ใช้งาน" : "ถูกระงับ"}
                                                    checked={user.status === "active"}
                                                    onChange={(e) => handleStatusChange(user.id, e.target.checked ? "active" : "banned")}
                                                    style={{
                                                        color: user.status === "active" ? "#28a745" : "#dc3545", // เขียว / แดง
                                                        fontWeight: "bold",
                                                    }}
                                                />
                                            </td>
                                            <td className="p-3">
                                                <button className="btn btn-danger btn-sm" onClick={() => handleDelete(user.id)}>
                                                    <FaTrash className="me-1" /> ลบ
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                </div>
            </div>

            {/* Pagination */}
            {totalPages > 1 && (
                <nav className="mt-4">
                    <ul className="pagination justify-content-center">
                        <li className={`page-item ${currentPage === 1 ? "disabled" : ""}`}>
                            <button className="page-link" onClick={() => setCurrentPage(currentPage - 1)}>ก่อนหน้า</button>
                        </li>
                        {Array.from({ length: totalPages }, (_, i) => (
                            <li key={i + 1} className={`page-item ${currentPage === i + 1 ? "active" : ""}`}>
                                <button className="page-link" onClick={() => setCurrentPage(i + 1)}>{i + 1}</button>
                            </li>
                        ))}
                        <li className={`page-item ${currentPage === totalPages ? "disabled" : ""}`}>
                            <button className="page-link" onClick={() => setCurrentPage(currentPage + 1)}>ถัดไป</button>
                        </li>
                    </ul>
                </nav>
            )}
        </div>
    );
};

export default ManageUsers;
