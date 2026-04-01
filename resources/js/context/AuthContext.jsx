import React, { createContext, useState, useEffect } from "react";
import { logout as apiLogout } from "../services/auth";

export const AuthContext = createContext();

const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem("user");
    return saved ? JSON.parse(saved) : null;
  });

  // ✅ login() จะอัปเดต state และ localStorage พร้อมกัน
  const login = (userData) => {
    setUser(userData);
    localStorage.setItem("user", JSON.stringify(userData));
  };

  // ✅ logout() จะเรียก API แล้วล้างทุกอย่าง
  const logout = async () => {
    try {
      await apiLogout();
    } catch (e) {
      console.error("Logout error:", e);
    } finally {
      setUser(null);
      localStorage.removeItem("user");
      localStorage.removeItem("token");
    }
  };

  useEffect(() => {
    const saved = localStorage.getItem("user");
    if (saved) setUser(JSON.parse(saved));
  }, []);

  return (
    <AuthContext.Provider value={{ user, setUser, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export default AuthProvider;
