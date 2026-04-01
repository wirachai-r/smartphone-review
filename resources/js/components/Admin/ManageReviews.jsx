import React, { useEffect, useState } from "react";
import { getAllReviews, updateReview } from "../../services/reviews";
import { Pagination, Card, Form } from "react-bootstrap";
import { FaStar } from "react-icons/fa";
import Swal from "sweetalert2";

const ITEMS_PER_PAGE = 10;

const statusColor = {
    approved: "green",
    pending: "orange",
    rejected: "red",
};

const statusThai = {
    approved: "อนุมัติ",
    pending: "รอตรวจสอบ",
    rejected: "ปฏิเสธ",
};

const ManageReviews = ({ currentUser }) => {
    const [reviews, setReviews] = useState([]);
    const [loading, setLoading] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [filterStatus, setFilterStatus] = useState(""); // "" = แสดงทั้งหมด

    const fetchReviews = async () => {
        setLoading(true);
        try {
            const data = await getAllReviews();
            data.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
            setReviews(Array.isArray(data) ? data : []);
        } catch (error) {
            console.error(error);
            Swal.fire("ข้อผิดพลาด", "ไม่สามารถโหลดรีวิวได้", "error");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchReviews();
    }, []);

    const handleStatusChange = async (reviewId, newStatus) => {
        try {
            await updateReview(reviewId, { status: newStatus });
            Swal.fire(
                "สำเร็จ",
                `สถานะรีวิวถูกเปลี่ยนเป็น ${statusThai[newStatus]}`,
                "success"
            );
            fetchReviews();
        } catch (error) {
            console.error(error);
            Swal.fire("ข้อผิดพลาด", "ไม่สามารถอัปเดตสถานะรีวิวได้", "error");
        }
    };

    // กรองรีวิวตามสถานะ
    const filteredReviews = filterStatus
        ? reviews.filter((r) => r.status === filterStatus)
        : reviews;

    const totalPages = Math.ceil(filteredReviews.length / ITEMS_PER_PAGE);
    const paginatedReviews = filteredReviews.slice(
        (currentPage - 1) * ITEMS_PER_PAGE,
        currentPage * ITEMS_PER_PAGE
    );

    return (
        <div>
            <div className="d-flex align-items-center mt-2 mb-4">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    จัดการรีวิว
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            {/* ตัวกรองสถานะ */}
            <div className="mb-3 d-flex align-items-center gap-2">
                <Form.Select
                    size="md"
                    value={filterStatus}
                    onChange={(e) => {
                        setFilterStatus(e.target.value);
                        setCurrentPage(1); // reset ไปหน้าแรกเวลากรอง
                    }}
                >
                    <option value="">ทั้งหมด</option>
                    <option value="approved">อนุมัติ</option>
                    <option value="pending">รอตรวจสอบ</option>
                    <option value="rejected">ปฏิเสธ</option>
                </Form.Select>
            </div>

            {loading ? (
                <p className="text-center">กำลังโหลดรีวิว...</p>
            ) : filteredReviews.length === 0 ? (
                <p className="text-center text-muted">ยังไม่มีรีวิว</p>
            ) : (
                <>
                    {paginatedReviews.map((review) => (
                        <Card key={review.id} className="mb-3">
                            <Card.Body>
                                <h5 className="fw-bold">{review.body}</h5>
                                <div className="mb-1">
                                    {[...Array(5)].map((_, idx) => (
                                        <FaStar
                                            key={idx}
                                            color={idx < review.rating ? "#ffc107" : "#e4e5e9"}
                                        />
                                    ))}
                                </div>
                                <p>
                                    โดย: <span className="fw-bold">{review.user.name}</span> |{" "}
                                    {new Date(review.created_at).toLocaleString("th-TH", {
                                        day: "2-digit",
                                        month: "short",
                                        year: "numeric",
                                        hour: "2-digit",
                                        minute: "2-digit",
                                    })}{" "}
                                    น.
                                </p>
                                <p>
                                    โทรศัพท์รุ่น: <span className="fw-bold">{review.phone.model}</span>
                                </p>

                                {/* แสดง select พร้อมสี */}
                                <Form.Select
                                    size="sm"
                                    value={review.status}
                                    onChange={(e) =>
                                        handleStatusChange(review.id, e.target.value)
                                    }
                                    className="mb-2"
                                    style={{ color: statusColor[review.status] }}
                                >
                                    <option value="approved" style={{ color: statusColor.approved }}>
                                        {statusThai.approved}
                                    </option>
                                    <option value="pending" style={{ color: statusColor.pending }}>
                                        {statusThai.pending}
                                    </option>
                                    <option value="rejected" style={{ color: statusColor.rejected }}>
                                        {statusThai.rejected}
                                    </option>
                                </Form.Select>
                            </Card.Body>
                        </Card>
                    ))}

                    {/* Pagination */}
                    {totalPages > 1 && (
                        <Pagination className="justify-content-center mt-3">
                            <Pagination.Prev
                                disabled={currentPage === 1}
                                onClick={() => setCurrentPage(currentPage - 1)}
                            />
                            {Array.from({ length: totalPages }, (_, i) => (
                                <Pagination.Item
                                    key={i + 1}
                                    active={currentPage === i + 1}
                                    onClick={() => setCurrentPage(i + 1)}
                                >
                                    {i + 1}
                                </Pagination.Item>
                            ))}
                            <Pagination.Next
                                disabled={currentPage === totalPages}
                                onClick={() => setCurrentPage(currentPage + 1)}
                            />
                        </Pagination>
                    )}
                </>
            )}
        </div>
    );
};

export default ManageReviews;
