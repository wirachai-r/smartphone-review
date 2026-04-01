import React, { useContext, useState } from "react";
import { NavLink, Link, useNavigate } from "react-router-dom";
import { AuthContext } from "../../context/AuthContext";

const links = [
    { name: "หน้าสรุปข้อมูล", path: "/admin" },
    { name: "จัดการแบรนด์", path: "/admin/categories" },
    { name: "จัดการโทรศัพท์", path: "/admin/phones" },
    { name: "จัดการริวิว", path: "/admin/reviews" },
    { name: "จัดการผู้ใช้", path: "/admin/users" },
];

const AdminNavbar = () => {
    const { logout } = useContext(AuthContext);
    const navigate = useNavigate();
    const [showMobileMenu, setShowMobileMenu] = useState(false);

    const handleLogout = async () => {
        try {
            await logout();
            navigate("/login");
        } catch (error) {
            console.error("Logout failed:", error);
        }
    };

    const toggleMenu = () => setShowMobileMenu((prev) => !prev);
    const closeMenu = () => setShowMobileMenu(false);

    return (
        <>
            {/* 🌐 Mobile Top Navbar */}
            <nav className="navbar navbar-light bg-white d-md-none shadow-sm border-bottom">
                <div className="container-fluid d-flex justify-content-between align-items-center">
                    <Link className="navbar-brand fw-bold text-orange" to="/admin">
                        <span className="navbar-brand fw-bold text-orange">ผู้ดูแลระบบ</span>
                    </Link>
                    <button className="btn btn-orange btn-sm text-white" onClick={toggleMenu}>
                        ☰
                    </button>
                </div>
            </nav>

            {/* 📱 Mobile Sidebar */}
            <>
                <div
                    className={`offcanvas-backdrop fade ${showMobileMenu ? "show visible" : ""}`}
                    onClick={closeMenu}
                ></div>

                <div
                    className={`offcanvas offcanvas-end custom-slide ${showMobileMenu ? "show visible" : ""} bg-orange text-white`}
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
                                        `nav-link px-3 py-2 fw-semibold ${isActive ? "active bg-light text-orange" : "text-white hover-light"
                                        }`
                                    }
                                >
                                    {link.name}
                                </NavLink>
                            ))}
                        </nav>

                        <div className="border-top border-light p-3">
                            <button
                                className="btn btn-outline-light w-100 mb-2"
                                onClick={() => {
                                    navigate("/");
                                    closeMenu();
                                }}
                            >
                                หน้าหลัก
                            </button>
                            <button
                                className="btn btn-dark w-100"
                                onClick={() => {
                                    handleLogout();
                                    closeMenu();
                                }}
                            >
                                ออกจากระบบ
                            </button>
                        </div>
                    </div>
                </div>
            </>

            {/* 💻 Desktop Sidebar */}
            <aside
                className="d-none d-md-flex flex-column bg-white vh-100 border-end position-fixed"
                style={{ width: "250px" }}
            >

                <Link className="navbar-brand fw-bold text-orange" to="/admin">
                    <div className="p-4 text-center border-bottom">
                        <h4 className="fw-bold text-orange">ผู้ดูแลระบบ</h4>
                    </div>
                </Link>

                <nav className="nav flex-column p-2 flex-grow-1">
                    {links.map((link) => (
                        <NavLink
                            key={link.path}
                            to={link.path}
                            end
                            className={({ isActive }) =>
                                `nav-link rounded fw-semibold ${isActive ? "active text-orange" : "text-dark"
                                }`
                            }
                        >
                            {link.name}
                        </NavLink>
                    ))}
                </nav>
                <div className="mt-auto p-3 border-top">
                    <button
                        className="btn btn-outline-dark w-100 mb-2"
                        onClick={() => navigate("/")}
                    >
                        หน้าหลัก
                    </button>
                    <button className="btn btn-danger w-100" onClick={handleLogout}>
                        ออกจากระบบ
                    </button>
                </div>
            </aside>
        </>
    );
};

export default AdminNavbar;
