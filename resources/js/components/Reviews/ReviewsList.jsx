import React, { useEffect, useState } from "react";
import { getReviews, deleteReview, getReviewsByUser } from "../../services/reviews";
// import CommentsList from "./CommentsList";
import { Button, Modal } from "react-bootstrap";
import { FaStar, FaEdit, FaTrash } from "react-icons/fa";
import Swal from "sweetalert2";
import ReviewForm from "./ReviewForm";
import { Link } from "react-router-dom"; // ด้านบนของไฟล์

const ReviewsList = ({ phoneId, userId, currentUser }) => {
    const [reviews, setReviews] = useState([]);
    const [loading, setLoading] = useState(false);
    const [showEditModal, setShowEditModal] = useState(false);
    const [selectedReview, setSelectedReview] = useState(null);
    const [showAll, setShowAll] = useState(false);

    // mapping สถานะเป็นภาษาไทย
    const statusThai = {
        approved: "อนุมัติ",
        pending: "รอตรวจสอบ",
        rejected: "ปฏิเสธ",
    };

    // mapping สีตามสถานะ
    const statusColor = {
        approved: "green",
        pending: "orange",
        rejected: "red",
    };

    const fetchReviews = async () => {
        setLoading(true);
        try {
            let data = [];
            if (userId) {
                data = await getReviewsByUser(userId); // รีวิวของผู้ใช้
            } else if (phoneId) {
                data = await getReviews(phoneId); // รีวิวของมือถือ
            }

            // เรียงรีวิวจากล่าสุดก่อน
            data.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
            setReviews(data);
        } catch (error) {
            console.error(error);
            Swal.fire("Error", "ไม่สามารถโหลดรีวิวได้", "error");
        }
        setLoading(false);
    };

    const handleDelete = async (id) => {
        const result = await Swal.fire({
            title: "คุณแน่ใจหรือไม่?",
            text: "การลบรีวิวจะไม่สามารถกู้คืนได้!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "ลบ",
            cancelButtonText: "ยกเลิก",
        });

        if (result.isConfirmed) {
            try {
                await deleteReview(id);
                Swal.fire("Deleted!", "รีวิวถูกลบแล้ว", "success");
                fetchReviews();
            } catch (error) {
                console.error(error);
                Swal.fire("Error", "ลบรีวิวไม่สำเร็จ", "error");
            }
        }
    };

    const handleEditSuccess = () => {
        fetchReviews();
        setShowEditModal(false);
        Swal.fire("Updated!", "รีวิวถูกแก้ไขเรียบร้อยแล้ว", "success");
    };

    useEffect(() => {
        fetchReviews();
    }, [phoneId, userId]);

    if (loading) return <p>Loading reviews...</p>;

    const displayedReviews = showAll ? reviews : reviews.slice(0, 2);

    return (
        <div>
            {reviews.length === 0 && (
                <p className="text-center text-muted">ยังไม่มีรีวิว</p>
            )}

            {displayedReviews.map((review) => (
                <div key={review.id}>
                    {review.phone && (
                        <h5 className="text-muted d-block mb-1">
                            รีวิวสำหรับ:{" "}
                            <Link
                                to={`/phones/${review.phone.id}`}
                                className="fw-bold text-decoration-none"
                            >
                                {review.phone.brand} {review.phone.model}
                            </Link>
                        </h5>
                    )}
                    <div className="card mb-3">
                        <div className="card-body">
                            <div className="d-flex justify-content-between align-items-start">
                                <div>

                                    <h5 className="fw-bold">{review.body}</h5>
                                    <div className="mb-1">
                                        {[...Array(5)].map((_, idx) => (
                                            <FaStar
                                                key={idx}
                                                color={idx < review.rating ? "#ffc107" : "#e4e5e9"}
                                            />
                                        ))}
                                    </div>
                                    <small className="text-muted d-block">
                                        by
                                        <div className="fw-bold d-inline">
                                            {" "} {review.user.name} |{" "}
                                        </div>
                                        {new Date(review.created_at).toLocaleString("th-TH", {
                                            day: "2-digit",
                                            month: "short",
                                            year: "numeric",
                                            hour: "2-digit",
                                            minute: "2-digit",
                                        })} น.
                                        {currentUser?.id === review.user_id && (
                                            <>
                                                | สถานะ:  <span className="fw-bold" style={{ color: statusColor[review.status] }}>
                                                    {statusThai[review.status]}
                                                </span>
                                            </>
                                        )}
                                    </small>
                                </div>

                                {currentUser?.id === review.user_id && (
                                    <div className="d-flex gap-1">
                                        <Button
                                            variant="warning"
                                            size="sm"
                                            onClick={() => {
                                                setSelectedReview(review);
                                                setShowEditModal(true);
                                            }}
                                        >
                                            <FaEdit />
                                        </Button>
                                        <Button
                                            variant="danger"
                                            size="sm"
                                            onClick={() => handleDelete(review.id)}
                                        >
                                            <FaTrash />
                                        </Button>
                                    </div>
                                )}
                            </div>

                            {/* <CommentsList reviewId={review.id} currentUser={currentUser} /> */}
                        </div>
                    </div>
                </div>
            ))}

            {reviews.length > 2 && (
                <div className="text-center mb-3">
                    <Button
                        variant="link"
                        onClick={() => setShowAll(!showAll)}
                    >
                        {showAll ? "ย่อ..." : "ดูเพิ่มเติม..."}
                    </Button>
                </div>
            )}

            {showEditModal && selectedReview && (
                <Modal
                    size="lg"
                    centered
                    show={showEditModal}
                    onHide={() => setShowEditModal(false)}
                >
                    <Modal.Header closeButton>
                        <Modal.Title>แก้ไขรีวิว</Modal.Title>
                    </Modal.Header>
                    <Modal.Body>
                        <ReviewForm
                            phoneId={phoneId}
                            review={selectedReview}
                            onSuccess={handleEditSuccess}
                            onClose={() => setShowEditModal(false)}
                        />
                    </Modal.Body>
                </Modal>
            )}
        </div>
    );
};

export default ReviewsList;
