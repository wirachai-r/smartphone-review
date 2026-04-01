// resources/js/components/reviews/ReviewForm.jsx
import React, { useState, useEffect } from "react";
import { createReview, updateReview } from "../../services/reviews";
import { Button, Form } from "react-bootstrap";
import { FaStar } from "react-icons/fa";
import Swal from "sweetalert2";

const ReviewForm = ({ phoneId, review = null, onSuccess, onClose }) => {
    const [rating, setRating] = useState(5);
    const [hover, setHover] = useState(0);
    const [body, setBody] = useState("");
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        if (review) {
            setRating(review.rating);
            setBody(review.body);
        }
    }, [review]);

    const handleSubmit = async (e) => {
        e.preventDefault();
        setLoading(true);
        try {
            if (review) {
                // แก้ไขรีวิว พร้อมตั้ง status เป็น pending
                await updateReview(review.id, { rating, body, status: "pending" });
                Swal.fire("อัปเดตแล้ว!", "รีวิวถูกแก้ไขเรียบร้อยแล้ว", "success");
            } else {
                // สร้างรีวิวใหม่ 'pending', 'approved', 'rejected'
                await createReview(phoneId, { rating, body });
                Swal.fire("ส่งเรียบร้อย!", "รีวิวของคุณถูกส่งเรียบร้อยแล้ว", "success");
            }
            setRating(5);
            setBody("");
            if (onSuccess) onSuccess();
            if (onClose) onClose();
        } catch (error) {
            console.error(error);
            Swal.fire("เกิดข้อผิดพลาด", "ไม่สามารถบันทึกรีวิวได้", "error");
        }
        setLoading(false);
    };

    return (
        <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-2 text-center">
                <Form.Label>คะแนน</Form.Label>
                <div>
                    {[1, 2, 3, 4, 5].map((star) => (
                        <FaStar
                            key={star}
                            size={30}
                            style={{ cursor: "pointer", marginRight: 5 }}
                            color={star <= (hover || rating) ? "#ffc107" : "#e4e5e9"}
                            onClick={() => setRating(star)}
                            onMouseEnter={() => setHover(star)}
                            onMouseLeave={() => setHover(0)}
                        />
                    ))}
                </div>
            </Form.Group>

            <Form.Group className="mb-2">
                <Form.Label>เนื้อหารีวิว</Form.Label>
                <Form.Control
                    as="textarea"
                    rows={3}
                    value={body}
                    onChange={(e) => setBody(e.target.value)}
                    required
                />
            </Form.Group>

            <div className="d-flex justify-content-end gap-2">
                {onClose && (
                    <Button variant="secondary" onClick={onClose}>
                        ยกเลิก
                    </Button>
                )}
                <Button type="submit" disabled={loading}>
                    {loading
                        ? "กำลังส่ง..."
                        : review
                            ? "อัปเดตรีวิว"
                            : "ส่งรีวิว"}
                </Button>
            </div>
        </Form>
    );
};

export default ReviewForm;
