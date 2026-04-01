// resources/js/services/phones.js
import api from "./api";

export const getPhones = async () => {
  const res = await api.get("/phones");
  return res.data;
};

export const getPhoneById = async (id) => {
  const res = await api.get(`/phones/${id}`);
  return res.data;
};

export const updatePhone = async (id, data) => {
  const res = await api.put(`/admin/phones/${id}`, data); // <-- เพิ่ม /admin
  return res.data;
};

export const createPhone = async (data) => {
  const res = await api.post("/admin/phones", data); // สำหรับสร้างก็ต้อง /admin ด้วย
  return res.data;
};

export const deletePhone = async (id) => {
  const res = await api.delete(`/admin/phones/${id}`);
  return res.data;
};

export const incrementViews = async (id) => {
  const res = await api.patch(`/phones/${id}/views`);
  return res.data;
};

export const getCategories = async () => {
  const res = await api.get("/categories");
  return res.data;
};
