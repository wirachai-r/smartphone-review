// resources/js/services/auth.js
import api from "./api";

export const login = async (email, password) => {
  const res = await api.post("/login", { email, password });
  return res.data;
};

export const register = async (name, email, password, password_confirmation) => {
  const res = await api.post("/register", {
    name,
    email,
    password,
    password_confirmation,
  });
  return res.data;
};

export const logout = async () => {
  const res = await api.post("/logout");
  return res.data;
};

export const getUser = async () => {
  const res = await api.get("/user");
  return res.data;
};
