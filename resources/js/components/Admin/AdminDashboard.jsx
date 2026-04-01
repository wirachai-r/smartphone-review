import React, { useEffect, useState } from "react";
import { getPhones } from "../../services/phones";
import { getCategories } from "../../services/categories";
import { getAllReviews } from "../../services/reviews";
import { getUsers } from "../../services/users";
import { FaEye, FaHeart, FaStar } from "react-icons/fa";
import { useNavigate } from "react-router-dom";
import { Card, Row, Col } from "react-bootstrap";
import { Pie } from "react-chartjs-2";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";

ChartJS.register(ArcElement, Tooltip, Legend);

const AdminDashboard = () => {
    const [phones, setPhones] = useState([]);
    const [popularPhones, setPopularPhones] = useState([]);
    const [popularLikes, setPopularLikes] = useState([]);
    const [counts, setCounts] = useState({
        categories: 0,
        phones: 0,
        reviews: 0,
        users: 0,
        reviewsList: []
    });
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const fetchData = async () => {
        setLoading(true);
        try {
            const [phoneData, categories, reviews, users] = await Promise.all([
                getPhones(),
                getCategories(),
                getAllReviews(),
                getUsers()
            ]);

            setPhones(phoneData);
            setCounts({
                categories: Array.isArray(categories) ? categories.length : 0,
                phones: Array.isArray(phoneData) ? phoneData.length : 0,
                reviews: Array.isArray(reviews) ? reviews.length : 0,
                users: Array.isArray(users) ? users.length : 0,
                reviewsList: Array.isArray(reviews) ? reviews : []
            });

            // ยอดนิยม
            setPopularPhones([...phoneData].sort((a, b) => (b.views || 0) - (a.views || 0)).slice(0, 10));
            setPopularLikes([...phoneData].sort((a, b) => (b.likes || 0) - (a.likes || 0)).slice(0, 10));
        } catch (error) {
            console.error(error);
            alert("ไม่สามารถโหลดข้อมูลได้");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchData();
    }, []);

    // Pie chart รีวิว
    const reviewStatusCounts = counts.reviewsList.reduce(
        (acc, review) => {
            acc[review.status] = (acc[review.status] || 0) + 1;
            return acc;
        },
        { approved: 0, pending: 0, rejected: 0 }
    );

    const pieData = {
        labels: ["อนุมัติ", "รอตรวจสอบ", "ปฏิเสธ"],
        datasets: [
            {
                data: [reviewStatusCounts.approved, reviewStatusCounts.pending, reviewStatusCounts.rejected],
                backgroundColor: ["green", "orange", "red"]
            }
        ]
    };

    if (loading) return <p className="text-center mt-5">กำลังโหลด...</p>;

    return (
        <div>
            <div className="d-flex align-items-center mt-2 mb-4">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    หน้าสรุปข้อมูล
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            {/* Summary Cards */}
            <div className="row g-3 mb-3">
                <div className="col-6 col-md-3">
                    <div className="card text-center hover-list" onClick={() => navigate(`/admin/categories`)} style={{ cursor: "pointer" }}>
                        <div className="card-body">
                            <h5 className="card-title">แบรนด์</h5>
                            <p className="card-text">{counts.categories}</p>
                        </div>
                    </div>
                </div>

                <div className="col-6 col-md-3">
                    <div className="card text-center hover-list" onClick={() => navigate(`/admin/phones`)} style={{ cursor: "pointer" }}>
                        <div className="card-body">
                            <h5 className="card-title">โทรศัพท์</h5>
                            <p className="card-text">{counts.phones}</p>
                        </div>
                    </div>
                </div>

                <div className="col-6 col-md-3">
                    <div className="card text-center hover-list" onClick={() => navigate(`/admin/reviews`)} style={{ cursor: "pointer" }}>
                        <div className="card-body">
                            <h5 className="card-title">รีวิว</h5>
                            <p className="card-text">{counts.reviews}</p>
                        </div>
                    </div>
                </div>

                <div className="col-6 col-md-3">
                    <div className="card text-center hover-list" onClick={() => navigate(`/admin/users`)} style={{ cursor: "pointer" }}>
                        <div className="card-body">
                            <h5 className="card-title">ผู้ใช้</h5>
                            <p className="card-text">{counts.users}</p>
                        </div>
                    </div>
                </div>
            </div>

            <div className="row g-3 mb-3">
                <div className="col-12 col-lg-4">
                    <div className="card h-100 border-1 rounded">
                        <div className="card-header bg-light fw-bold fs-5">สัดส่วนรีวิวตามสถานะ</div>
                        <div className="card-body">
                            <Pie data={pieData} />
                        </div>
                    </div>
                </div>

                <div className="col-12 col-lg-4">
                    <div className="card h-100 border-1 rounded">
                        <div className="card-header bg-light fw-bold fs-5">มือถือยอดเข้าชมสูงสุด</div>
                        <div className="card-body p-0">
                            <ul className="list-group list-group-flush rounded">
                                {popularPhones.map((phone, index) => (
                                    <li key={phone.id} className="list-group-item d-flex justify-content-between align-items-center px-3 py-2 hover-list" onClick={() => navigate(`/admin/phones/edit/${phone.id}`)} style={{ cursor: "pointer" }}>
                                        <div className="d-flex align-items-center gap-3">
                                            <div className="rank-number">{index + 1}</div>
                                            <span className="fw-medium">{phone.model}</span>
                                        </div>
                                        <div className="text-muted d-flex align-items-center gap-1">
                                            <FaEye />
                                            <span>{phone.views?.toLocaleString() || 0}</span>
                                        </div>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    </div>
                </div>

                <div className="col-12 col-lg-4">
                    <div className="card h-100 border-1 rounded">
                        <div className="card-header bg-light fw-bold fs-5">มือถือยอดถูกใจสูงสุด</div>
                        <div className="card-body p-0">
                            <ul className="list-group list-group-flush rounded">
                                {popularLikes.map((phone, index) => (
                                    <li key={phone.id} className="list-group-item d-flex justify-content-between align-items-center px-3 py-2 hover-list" onClick={() => navigate(`/admin/phones/edit/${phone.id}`)} style={{ cursor: "pointer" }}>
                                        <div className="d-flex align-items-center gap-3">
                                            <div className="rank-number">{index + 1}</div>
                                            <span className="fw-medium">{phone.model}</span>
                                        </div>
                                        <div className="text-muted d-flex align-items-center gap-1">
                                            <FaHeart className="text-danger" />
                                            <span>{phone.likes?.toLocaleString() || 0}</span>
                                        </div>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>


            {/* มือถือเปิดตัวล่าสุด */}
            <div className="d-flex align-items-center mt-4 mb-3">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    มือถือเปิดตัวล่าสุด
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            <div className="row g-3 mb-5 mt-3">
                {phones.sort((a, b) => new Date(b.release_date) - new Date(a.release_date)).slice(0, 12).map((phone) => (
                    <div key={phone.id} className="col-6 col-sm-4 col-md-3 col-lg-2">
                        <div className="card h-100 rounded position-relative border-1 phone-card" style={{ cursor: "pointer", backgroundColor: "#f9f9f9" }} onClick={() => navigate(`/admin/phones/edit/${phone.id}`)}>
                            <div style={{ width: "100%", aspectRatio: "3/4", overflow: "hidden", borderRadius: "5px 5px 0 0", display: "flex", alignItems: "center", justifyContent: "center", position: "relative" }}>
                                {phone.main_image_url ? <img src={phone.main_image_url} alt={phone.model} style={{ width: "100%", height: "100%", objectFit: "cover" }} /> : <span style={{ color: "#555", fontSize: "0.9rem" }}>No Image</span>}
                                <div style={{ position: "absolute", top: 5, right: 5, display: "flex", flexDirection: "column", alignItems: "flex-end", gap: "3px" }}>
                                    <span style={{ backgroundColor: "red", color: "white", fontSize: "0.7rem", fontWeight: "bold", padding: "2px 5px", borderRadius: "3px" }}>NEW</span>
                                    <span style={{ backgroundColor: "rgba(0,0,0,0.6)", color: "white", fontSize: "0.7rem", fontWeight: "bold", padding: "2px 5px", borderRadius: "3px", display: "flex", alignItems: "center", gap: "4px" }}>
                                        <FaStar className="text-warning" />
                                        {Number(phone.average_rating)?.toFixed(1) || "0.0"}
                                    </span>
                                </div>
                            </div>
                            <div className="card-body d-flex flex-column">
                                <h6 className="card-title text-center fs-6">{phone.model}</h6>
                                <p className="text-center text-success mb-1">{phone.price ? `${phone.price} บาท` : "-"}</p>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default AdminDashboard;
