import api from "./api";

export const getCategories = async () => {
    const res = await api.get("/categories");
    return res.data;
};

export const getCategoryById = async (id) => {
    const res = await api.get(`/categories/${id}`);
    return res.data;
};

export const createCategory = async (data) => {
    const res = await api.post("/admin/categories", data, {
        headers: { "Content-Type": "multipart/form-data" },
    });
    return res.data;
};

export const updateCategory = async (id, data) => {
    data.append("_method", "PUT"); // Laravel ใช้ method spoofing
    const res = await api.post(`/admin/categories/${id}`, data, {
        headers: { "Content-Type": "multipart/form-data" },
    });
    return res.data;
};

export const deleteCategory = async (id) => {
    const res = await api.delete(`/admin/categories/${id}`);
    return res.data;
};

