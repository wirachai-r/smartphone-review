import React, { useState, useContext } from "react";
import { useNavigate, Link } from "react-router-dom";
import { login as loginApi } from "../../services/auth";
import { AuthContext } from "../../context/AuthContext";
import Swal from "sweetalert2";
import { FaEye, FaEyeSlash } from "react-icons/fa";

const Login = () => {
  const navigate = useNavigate();
  const { login } = useContext(AuthContext);

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showPassword, setShowPassword] = useState(false); // 👈 state สำหรับเปิด/ปิดรหัสผ่าน

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const data = await loginApi(email, password);

      if (data.user && data.token) {
        localStorage.setItem("token", data.token);
        login(data.user);

        Swal.fire({
          icon: "success",
          title: "เข้าสู่ระบบสำเร็จ",
          text: `ยินดีต้อนรับคุณ ${data.user.name}`,
          timer: 2000,
          showConfirmButton: false,
        });

        navigate("/");
      }
    } catch (err) {
      if (
        err.response &&
        err.response.data &&
        err.response.data.errors &&
        err.response.data.errors.email
      ) {
        Swal.fire({
          icon: "error",
          title: "เข้าสู่ระบบไม่สำเร็จ",
          text: err.response.data.errors.email[0],
        });
      } else if (
        err.response &&
        err.response.data &&
        err.response.data.message
      ) {
        Swal.fire({
          icon: "error",
          title: "เกิดข้อผิดพลาด",
          text: err.response.data.message,
        });
      } else {
        Swal.fire({
          icon: "error",
          title: "เกิดข้อผิดพลาด",
          text: "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้",
        });
      }
    }
  };

  return (
    <div className="container mt-5" style={{ maxWidth: "400px" }}>
      <h3 className="text-center mb-4">เข้าสู่ระบบ</h3>

      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label className="form-label">อีเมล</label>
          <input
            type="email"
            name="email"
            className="form-control"
            placeholder="กรอกอีเมล"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
          />
        </div>

        <div className="mb-3 position-relative">
          <label className="form-label">รหัสผ่าน</label>
          <input
            type={showPassword ? "text" : "password"}
            className="form-control"
            placeholder="กรอกรหัสผ่าน"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
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

        <button type="submit" className="btn btn-primary w-100">
          เข้าสู่ระบบ
        </button>
      </form>

      <p className="text-center mt-3">
        ยังไม่มีบัญชี? <Link to="/register">สมัครสมาชิก</Link>
      </p>
    </div>
  );
};

export default Login;
