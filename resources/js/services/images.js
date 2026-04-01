import api from "./api";

/**
 * อัปโหลดรูปภาพ → คืน { url }
 * @param {File} file
 */
export const uploadImage = async (file) => {
  const formData = new FormData();
  formData.append("image", file);

  try {
    const res = await api.post("/admin/images/upload", formData, {
      headers: { "Content-Type": "multipart/form-data" },
    });

    if (!res.data?.url) {
      throw new Error("No URL returned from server");
    }

    return res.data; // { url: "/storage/Phones/xxx.jpg" }
  } catch (error) {
    console.error("Upload API error:", error.response || error);
    throw error;
  }
};

/**
 * ลบรูปภาพตาม id
 * @param {number|string} id
 */
export const deleteImage = async (id) => {
  try {
    const res = await api.delete(`/admin/images/${id}`);
    return res.data;
  } catch (error) {
    console.error("Delete API error:", error.response || error);
    throw error;
  }
};
