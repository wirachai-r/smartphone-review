import React, { useState, useContext } from "react";
import { Link, useNavigate } from "react-router-dom";
import { register as registerApi } from "../../services/auth";
import { AuthContext } from "../../context/AuthContext";
import Swal from "sweetalert2";
import { FaEye, FaEyeSlash } from "react-icons/fa";

const Register = () => {
  const navigate = useNavigate();
  const { login } = useContext(AuthContext);

  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
  });

  const [showPassword, setShowPassword] = useState(false);
  const [showConfirm, setShowConfirm] = useState(false);

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const data = await registerApi(
        formData.name,
        formData.email,
        formData.password,
        formData.password_confirmation
      );

      if (data.user && data.token) {
        localStorage.setItem("token", data.token);
        login(data.user);

        Swal.fire({
          icon: "success",
          title: "สมัครสมาชิกสำเร็จ",
          text: `ยินดีต้อนรับคุณ ${data.user.name}`,
          timer: 2000,
          showConfirmButton: false,
        });

        navigate("/");
      }
    } catch (err) {
      if (err.response && err.response.status === 422) {
        const errors = err.response.data.errors;
        const messages = Object.values(errors).flat().join("<br>");
        Swal.fire({
          icon: "error",
          title: "เกิดข้อผิดพลาด",
          html: messages,
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "เกิดข้อผิดพลาด",
          text: "กรุณาตรวจสอบข้อมูลและลองใหม่อีกครั้ง",
        });
      }
    }
  };

  return (
    <div className="container mt-5" style={{ maxWidth: "450px" }}>
      <h3 className="text-center mb-4">สมัครสมาชิก</h3>

      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label className="form-label">ชื่อ-นามสกุล</label>
          <input
            type="text"
            name="name"
            className="form-control"
            value={formData.name}
            onChange={handleChange}
            required
            placeholder="กรอกชื่อ-นามสกุล"
          />
        </div>

        <div className="mb-3">
          <label className="form-label">อีเมล</label>
          <input
            type="email"
            name="email"
            className="form-control"
            value={formData.email}
            onChange={handleChange}
            required
            placeholder="กรอกอีเมล"
          />
        </div>

        {/* ช่องรหัสผ่าน */}
        <div className="mb-3 position-relative">
          <label className="form-label">รหัสผ่าน</label>
          <input
            type={showPassword ? "text" : "password"}
            name="password"
            className="form-control"
            value={formData.password}
            onChange={handleChange}
            required
            placeholder="กรอกรหัสผ่าน"
          />
          <span
            onClick={() => setShowPassword(!showPassword)}
            style={{
              position: "absolute",
              right: "10px",
              top: "38px",
              cursor: "pointer",
              color: "#6c757d",
            }}
          >
            {showPassword ? <FaEyeSlash /> : <FaEye />}
          </span>
        </div>

        {/* ช่องยืนยันรหัสผ่าน */}
        <div className="mb-3 position-relative">
          <label className="form-label">ยืนยันรหัสผ่าน</label>
          <input
            type={showConfirm ? "text" : "password"}
            name="password_confirmation"
            className="form-control"
            value={formData.password_confirmation}
            onChange={handleChange}
            required
            placeholder="ยืนยันรหัสผ่าน"
          />
          <span
            onClick={() => setShowConfirm(!showConfirm)}
            style={{
              position: "absolute",
              right: "10px",
              top: "38px",
              cursor: "pointer",
              color: "#6c757d",
            }}
          >
            {showConfirm ? <FaEyeSlash /> : <FaEye />}
          </span>
        </div>

        <button type="submit" className="btn btn-success w-100">
          สมัครสมาชิก
        </button>
      </form>

      <p className="text-center mt-3">
        มีบัญชีแล้ว? <Link to="/login">เข้าสู่ระบบ</Link>
      </p>
    </div>
  );
};

export default Register;
