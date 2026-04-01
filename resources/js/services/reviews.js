// resources/js/services/reviews.js
import api from "./api"; // ใช้ instance ที่ตั้งค่าไว้

// ดึงรีวิวของมือถือ
export const getReviews = async (phoneId) => {
    const res = await api.get(`/phones/${phoneId}/reviews`);
    return res.data;
};

// สร้างรีวิวใหม่
export const createReview = async (phoneId, data) => {
    const res = await api.post(`/phones/${phoneId}/reviews`, data);
    return res.data;
};

// ลบรีวิว
export const deleteReview = async (id) => {
    const res = await api.delete(`/reviews/${id}`);
    return res.data;
};

// อัปเดตรายการรีวิว
export const updateReview = async (id, data) => {
    const res = await api.put(`/reviews/${id}`, data); // ใช้ PUT จริงๆ
    return res.data;
};

// อัปเดตสถานะรีวิว (สำหรับ admin)
export const updateReviewStatus = async (id, data) => {
    const res = await api.patch(`/admin/reviews/${id}/status`, data);
    return res.data;
};

export const getAllReviews = async () => {
    const res = await api.get("/admin/reviews"); // ต้องสร้าง route /admin/reviews
    return res.data;
};

export const hasReviewed = async (phoneId) => {
    const res = await api.get(`/reviews/hasReviewed?phoneId=${phoneId}`);
    return res.data.reviewed; // true/false
};

export const getReviewsByUser = async (userId) => {
    const response = await api.get(`/users/${userId}/reviews`);
    return response.data;
};
