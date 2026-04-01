// resources/js/services/users.js
import api from "./api"; // ✅ ใช้ instance ที่ตั้งค่าไว้

// ดึงผู้ใช้ทั้งหมด
export const getUsers = async () => {
  try {
    const response = await api.get("/admin/users"); // เรียกจาก route แอดมิน
    return Array.isArray(response.data) ? response.data : [];
  } catch (error) {
    console.error("getUsers error:", error.response || error);
    return [];
  }
};

// อัปเดต role หรือ status ของผู้ใช้ (เฉพาะ admin)
export const updateUserRoleStatus = async (id, data) => {
  try {
    const response = await api.put(`/admin/users/${id}/role-status`, data);
    return response.data.user; // คืนข้อมูล user ใหม่
  } catch (error) {
    console.error("updateUserRoleStatus error:", error.response || error);
    throw error;
  }
};

// ลบผู้ใช้
export const deleteUser = async (id) => {
  try {
    const response = await api.delete(`/admin/users/${id}`);
    return response.data;
  } catch (error) {
    console.error("deleteUser error:", error.response || error);
    throw error;
  }
};
