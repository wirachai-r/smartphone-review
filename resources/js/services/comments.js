import api from "./api";

export const getComments = async (reviewId) => {
  const res = await api.get(`/reviews/${reviewId}/comments`);
  return res.data;
};

export const addComment = async (reviewId, data) => {
  const res = await api.post(`/reviews/${reviewId}/comments`, data);
  return res.data;
};

export const updateComment = async (id, data) => {
  const res = await api.put(`/comments/${id}`, data);
  return res.data;
};

export const deleteComment = async (id) => {
  const res = await api.delete(`/comments/${id}`);
  return res.data;
};
