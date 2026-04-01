import api from "./api";

export const toggleLike = async (phoneId) => {
  const res = await api.post(`/phones/${phoneId}/like`);
  return res.data;
};

export const getLikes = async (phoneId) => {
  const res = await api.get(`/phones/${phoneId}/likes`);
  return res.data;
};

export const checkLiked = async (phoneId) => {
  const res = await api.get(`/phones/${phoneId}/like`);
  return res.data; // { liked: true/false }
};
