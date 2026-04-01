import React, { useState, useEffect } from "react";
import { getPhones } from "../../services/phones";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { useNavigate } from "react-router-dom";
import { FaEye, FaHeart, FaStar } from "react-icons/fa";

const MySwal = withReactContent(Swal);
const ITEMS_PER_PAGE = 12;

const ManagePhones = () => {
    const [phones, setPhones] = useState([]);
    const [filteredPhones, setFilteredPhones] = useState([]);
    const [loading, setLoading] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [searchName, setSearchName] = useState("");
    const navigate = useNavigate();

    // โหลดข้อมูลมือถือ
    const fetchPhones = async () => {
        setLoading(true);
        try {
            const data = await getPhones();
            setPhones(data);
            setFilteredPhones(data);
        } catch (error) {
            console.error(error);
            MySwal.fire("Error", "ไม่สามารถโหลดโทรศัพท์ได้", "error");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchPhones();
    }, []);

    // กรองตามชื่อรุ่นและเรียงตามวันที่วางจำหน่าย
    useEffect(() => {
        let filtered = phones.filter((p) =>
            p.model.toLowerCase().includes(searchName.toLowerCase())
        );

        // เรียงจากใหม่ → เก่า
        filtered.sort((a, b) => new Date(b.release_date) - new Date(a.release_date));

        setFilteredPhones(filtered);
        setCurrentPage(1);
    }, [searchName, phones]);


    // Pagination
    const totalPages = Math.ceil(filteredPhones.length / ITEMS_PER_PAGE);
    const paginatedPhones = filteredPhones.slice(
        (currentPage - 1) * ITEMS_PER_PAGE,
        currentPage * ITEMS_PER_PAGE
    );

    return (
        <div>
            <div className="d-flex align-items-center mt-2 mb-4">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    จัดการโทรศัพท์
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            {/* ปุ่มเพิ่มและช่องค้นหา */}
            <div className="d-flex flex-column flex-sm-row mb-3 gap-2">
                <button
                    className="btn btn-primary"
                    style={{ whiteSpace: "nowrap" }}
                    onClick={() => navigate("/admin/phones/add")}
                >
                    + เพิ่มโทรศัพท์ใหม่
                </button>
                <input
                    type="text"
                    className="form-control flex-grow-1"
                    placeholder="ค้นหาชื่อรุ่น..."
                    value={searchName}
                    onChange={(e) => setSearchName(e.target.value)}
                />
            </div>

            {/* แสดงรายการมือถือ */}
            {loading ? (
                <p className="text-center">กำลังโหลด...</p>
            ) : filteredPhones.length === 0 ? (
                <p className="text-center">ไม่พบโทรศัพท์</p>
            ) : (
                <div className="row g-3">
                    {paginatedPhones.map((phone) => (
                        <div key={phone.id} className="col-6 col-sm-4 col-md-3 col-lg-2">
                            <div
                                className="card h-100 rounded position-relative border-1 phone-card"
                                style={{
                                    cursor: "pointer",
                                    backgroundColor: "#f9f9f9",
                                    transition: "all 0.3s ease",
                                }}
                                onClick={() => navigate(`/admin/phones/edit/${phone.id}`)}
                            >
                                <div
                                    style={{
                                        width: "100%",
                                        aspectRatio: "3 / 4",
                                        overflow: "hidden",
                                        borderRadius: "5px 5px 0 0",
                                        backgroundColor: "#f9f9f9",
                                        display: "flex",
                                        alignItems: "center",
                                        justifyContent: "center",
                                    }}
                                >
                                    {phone.main_image_url ? (
                                        <img
                                            src={phone.main_image_url}
                                            alt={phone.model}
                                            style={{ width: "100%", height: "100%", objectFit: "cover" }}
                                        />
                                    ) : (
                                        <span style={{ color: "#555", fontSize: "0.9rem" }}>No Image</span>
                                    )}

                                    <div
                                        style={{
                                            position: "absolute",
                                            top: 5,
                                            right: 5,
                                            display: "flex",
                                            flexDirection: "column",
                                            alignItems: "flex-end",
                                            gap: "3px"
                                        }}
                                    >
                                        {/* ดาว + คะแนนรวม */}
                                        <span
                                            style={{
                                                backgroundColor: "rgba(0,0,0,0.6)",
                                                color: "white",
                                                fontSize: "0.7rem",
                                                fontWeight: "bold",
                                                padding: "2px 5px",
                                                borderRadius: "3px",
                                                display: "flex",
                                                alignItems: "center",
                                                gap: "4px"
                                            }}
                                        >
                                            <FaStar className="text-warning" />
                                            {Number(phone.average_rating)?.toFixed(1) || "0.0"}
                                        </span>
                                    </div>
                                </div>
                                <div className="card-body d-flex flex-column">
                                    <h6
                                        className="card-title text-center fs-6"
                                        style={{
                                            whiteSpace: "normal",
                                            overflow: "visible",
                                            wordWrap: "break-word",
                                        }}
                                    >
                                        {phone.model}
                                    </h6>
                                    <p className="text-center text-success mb-1">
                                        {phone.price ? `${phone.price} บาท` : "-"}
                                    </p>
                                    <div className="d-flex justify-content-center gap-3 mt-auto text-muted">
                                        <span className="d-flex align-items-center gap-1">
                                            <FaEye /> {phone.views?.toLocaleString() || 0}
                                        </span>
                                        <span className="d-flex align-items-center gap-1">
                                            <FaHeart /> {phone.likes?.toLocaleString() || 0}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Pagination */}
            {totalPages > 1 && (
                <nav aria-label="Page navigation example" className="mt-4">
                    <ul className="pagination justify-content-center">
                        <li className={`page-item ${currentPage === 1 ? "disabled" : ""}`}>
                            <button
                                className="page-link"
                                onClick={() => setCurrentPage(currentPage - 1)}
                                disabled={currentPage === 1}
                            >
                                ก่อนหน้า
                            </button>
                        </li>
                        {Array.from({ length: totalPages }, (_, index) => (
                            <li
                                key={index + 1}
                                className={`page-item ${currentPage === index + 1 ? "active" : ""}`}
                            >
                                <button
                                    className="page-link"
                                    onClick={() => setCurrentPage(index + 1)}
                                >
                                    {index + 1}
                                </button>
                            </li>
                        ))}
                        <li
                            className={`page-item ${currentPage === totalPages ? "disabled" : ""}`}
                        >
                            <button
                                className="page-link"
                                onClick={() => setCurrentPage(currentPage + 1)}
                                disabled={currentPage === totalPages}
                            >
                                ถัดไป
                            </button>
                        </li>
                    </ul>
                </nav>
            )}
        </div>
    );
};

export default ManagePhones;
