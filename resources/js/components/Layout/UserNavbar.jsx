import React, { useContext, useState } from "react";
import { NavLink, Link, useNavigate } from "react-router-dom";
import { AuthContext } from "../../context/AuthContext";
import { Dropdown, Button } from "react-bootstrap"; // ✅ import react-bootstrap

const UserNavbar = () => {
    const { user, logout } = useContext(AuthContext);
    const navigate = useNavigate();
    const [showMobileMenu, setShowMobileMenu] = useState(false);

    const handleLogout = async () => {
        try {
            await logout();
            navigate("/login");
        } catch (error) {
            console.error("Logout ล้มเหลว:", error);
        }
    };

    const toggleMenu = () => setShowMobileMenu((prev) => !prev);
    const closeMenu = () => setShowMobileMenu(false);

    const links = [
        { name: "หน้าแรก", path: "/" },
        { name: "โทรศัพท์", path: "/phones" },
        // ...(user?.role === "admin" ? [{ name: "ผู้ดูแลระบบ", path: "/admin" }] : []),
    ];

    return (
        <>
            {/* 🌐 Mobile Navbar */}
            <nav className="navbar navbar-light bg-white d-md-none shadow-sm border-bottom">
                <div className="container-fluid d-flex justify-content-between align-items-center">
                    {/* โลโก้ */}
                    <Link className="navbar-brand fw-bold text-orange" to="/">
                        Smart<span className="text-dark">Review</span>
                    </Link>

                    <div className="d-flex align-items-center gap-2">
                        {/* ปุ่ม Dropdown สำหรับผู้ใช้ */}
                        {user && (
                            <Dropdown align="end">
                                <Dropdown.Toggle
                                    variant="light"
                                    size="sm"
                                    style={{ padding: "0.25rem 0.5rem" }}
                                >
                                    {user.avatar_url ? (
                                        <img
                                            src={user.avatar_url}
                                            alt={user.name}
                                            style={{
                                                width: "20px",
                                                height: "20px",
                                                borderRadius: "50%",
                                                objectFit: "cover",
                                            }}
                                        />
                                    ) : (
                                        <span>👤</span>
                                    )}
                                </Dropdown.Toggle>

                                <Dropdown.Menu>
                                    <Dropdown.Item onClick={() => navigate("/profile")}>
                                        โปรไฟล์
                                    </Dropdown.Item>
                                    {user.role === "admin" && (
                                        <Dropdown.Item onClick={() => navigate("/admin")}>
                                            ผู้ดูแลระบบ
                                        </Dropdown.Item>
                                    )}
                                    <Dropdown.Item onClick={handleLogout} className="text-danger">
                                        ออกจากระบบ
                                    </Dropdown.Item>
                                </Dropdown.Menu>
                            </Dropdown>
                        )}

                        {/* ปุ่ม ☰ สำหรับเปิดเมนูหลัก */}
                        <Button variant="primary" size="sm" onClick={toggleMenu}>
                            ☰
                        </Button>
                    </div>
                </div>
            </nav>

            {/* 📱 Mobile Sidebar */}
            <div
                className={`offcanvas-backdrop fade ${showMobileMenu ? "show visible" : ""}`}
                onClick={closeMenu}
            ></div>

            <div
                className={`offcanvas offcanvas-end ${showMobileMenu ? "show visible" : ""} bg-orange text-white`}
            >
                <div className="offcanvas-header border-bottom border-light">
                    <h5 className="offcanvas-title fw-bold">เมนู</h5>

                    <button
                        type="button"
                        className="btn-close btn-close-white"
                        onClick={closeMenu}
                    ></button>
                </div>

                <div className="offcanvas-body p-0 d-flex flex-column">
                    <nav className="nav flex-column flex-grow-1">
                        {links.map((link) => (
                            <NavLink
                                key={link.path}
                                to={link.path}
                                end
                                onClick={closeMenu}
                                className={({ isActive }) =>
                                    `nav-link px-3 py-2 fw-semibold ${isActive ? "active bg-light text-orange" : "text-white hover-light"}`
                                }
                            >
                                {link.name}
                            </NavLink>
                        ))}
                    </nav>
                </div>

                {!user && (
                    <div className="p-3 border-top border-light">
                        <NavLink
                            to="/login"
                            className="btn btn-light w-100 mb-2"
                            onClick={closeMenu}
                        >
                            เข้าสู่ระบบ
                        </NavLink>
                        <NavLink
                            to="/register"
                            className="btn btn-outline-light w-100"
                            onClick={closeMenu}
                        >
                            ลงทะเบียน
                        </NavLink>
                    </div>
                )}

            </div>

            {/* 💻 Desktop Navbar */}
            <nav className="navbar navbar-expand-md navbar-light bg-white d-none d-md-flex shadow-sm border-bottom">
                <div className="container">
                    <Link className="navbar-brand fw-bold text-orange" to="/">
                        Smart<span className="text-dark">Review</span>
                    </Link>

                    <div className="collapse navbar-collapse show">
                        <ul className="navbar-nav me-auto">
                            {links.map((link) => (
                                <li className="nav-item" key={link.path}>
                                    <NavLink
                                        className={({ isActive }) =>
                                            `nav-link fw-semibold ${isActive ? "text-orange" : "text-dark"}`
                                        }
                                        to={link.path}
                                        end
                                    >
                                        {link.name}
                                    </NavLink>
                                </li>
                            ))}
                        </ul>

                        <ul className="navbar-nav ms-auto">
                            {user ? (
                                <li className="nav-item">
                                    <Dropdown align="end">
                                        <Dropdown.Toggle
                                            variant="light"
                                            className="d-flex align-items-center gap-2"
                                        >
                                            {user.avatar_url ? (
                                                <img
                                                    src={user.avatar_url} // เปลี่ยนจาก user.avatar
                                                    alt={user.name}
                                                    style={{
                                                        width: "30px",
                                                        height: "30px",
                                                        borderRadius: "50%",
                                                        objectFit: "cover",
                                                    }}
                                                />
                                            ) : (
                                                <span>👤</span>
                                            )}
                                            <span>{user.name}</span>
                                        </Dropdown.Toggle>

                                        <Dropdown.Menu>
                                            <Dropdown.Item onClick={() => navigate("/profile")}>
                                                โปรไฟล์
                                            </Dropdown.Item>
                                            {user.role === "admin" && (
                                                <Dropdown.Item onClick={() => navigate("/admin")}>
                                                    ผู้ดูแลระบบ
                                                </Dropdown.Item>
                                            )}
                                            <Dropdown.Item onClick={handleLogout} className="text-danger">
                                                ออกจากระบบ
                                            </Dropdown.Item>
                                        </Dropdown.Menu>
                                    </Dropdown>
                                </li>
                            ) : (
                                <>
                                    <li className="nav-item">
                                        <NavLink
                                            className={({ isActive }) =>
                                                `nav-link fw-semibold ${isActive ? "text-orange" : "text-dark"}`
                                            }
                                            to="/login"
                                        >
                                            เข้าสู่ระบบ
                                        </NavLink>
                                    </li>
                                    <li className="nav-item">
                                        <NavLink
                                            className={({ isActive }) =>
                                                `nav-link fw-semibold ${isActive ? "text-orange" : "text-dark"}`
                                            }
                                            to="/register"
                                        >
                                            ลงทะเบียน
                                        </NavLink>
                                    </li>
                                </>
                            )}
                        </ul>
                    </div>
                </div>
            </nav>
        </>
    );
};

export default UserNavbar;
