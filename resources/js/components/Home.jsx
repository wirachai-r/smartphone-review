import React, { useState, useEffect } from "react";
import { getPhones } from "../services/phones";
import { FaEye, FaHeart, FaStar } from "react-icons/fa";
import { useNavigate } from "react-router-dom";

const ITEMS_PER_MONTH = 6;
const MONTHS_TO_SHOW = 3;

const Home = () => {
    const [phones, setPhones] = useState([]);
    const [popularPhones, setPopularPhones] = useState([]);
    const [popularLikes, setPopularLikes] = useState([]);
    const [latestPhonesByMonth, setLatestPhonesByMonth] = useState({});
    const [loading, setLoading] = useState(false);
    const [showMore, setShowMore] = useState({});
    const [allMonths, setAllMonths] = useState([]);
    const [shownMonths, setShownMonths] = useState([]);
    const navigate = useNavigate();

    const fetchPhones = async () => {
        setLoading(true);
        try {
            const data = await getPhones(); // ตอนนี้ API คืน likes มาแล้ว
            setPhones(data);

            // มือถือยอดนิยม 10 อันดับตาม views
            const popular = [...data]
                .sort((a, b) => (b.views || 0) - (a.views || 0))
                .slice(0, 10);
            setPopularPhones(popular);

            // มือถือยอดถูกใจสูงสุด 10 อันดับ ตาม likes
            const popularByLikes = [...data]
                .sort((a, b) => (b.likes || 0) - (a.likes || 0))
                .slice(0, 10);
            setPopularLikes(popularByLikes);

            // แบ่งมือถือตามเดือน
            const months = {};
            data.forEach((phone) => {
                const date = new Date(phone.release_date);
                const key = `${date.toLocaleString("th-TH", { month: "long" })} ${date.getFullYear()}`;
                if (!months[key]) months[key] = [];
                months[key].push(phone);
            });

            // เรียงเดือนล่าสุดก่อน
            const sortedMonths = Object.keys(months).sort(
                (a, b) => new Date(months[b][0].release_date) - new Date(months[a][0].release_date)
            );

            setLatestPhonesByMonth(months);
            setAllMonths(sortedMonths);
            setShownMonths(sortedMonths.slice(0, MONTHS_TO_SHOW));

            // กำหนด showMore สำหรับแต่ละเดือน
            const initialShowMore = {};
            sortedMonths.forEach((month) => {
                initialShowMore[month] = ITEMS_PER_MONTH;
            });
            setShowMore(initialShowMore);
        } catch (error) {
            console.error(error);
            alert("ไม่สามารถโหลดข้อมูลโทรศัพท์ได้");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchPhones();
    }, []);

    if (loading) return <p className="text-center mt-5">กำลังโหลด...</p>;

    return (
        <div className="mt-4">
            {/* มือถือเปิดตัวล่าสุด */}
            <div className="d-flex align-items-center mt-5 mb-3">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    มือถือเปิดตัวล่าสุด
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            <div className="row g-3 mb-5 mt-3">
                {phones
                    .sort((a, b) => new Date(b.release_date) - new Date(a.release_date))
                    .slice(0, 12)
                    .map((phone) => (
                        <div key={phone.id} className="col-6 col-sm-4 col-md-3 col-lg-2">
                            <div
                                className="card h-100 rounded position-relative border-1 phone-card"
                                style={{ cursor: "pointer", backgroundColor: "#f9f9f9" }}
                                onClick={() => navigate(`/phones/${phone.id}`)}
                            >
                                {/* รูปมือถือ */}
                                <div
                                    style={{
                                        width: "100%",
                                        aspectRatio: "3/4",
                                        overflow: "hidden",
                                        borderRadius: "5px 5px 0 0",
                                        display: "flex",
                                        alignItems: "center",
                                        justifyContent: "center",
                                        position: "relative"
                                    }}
                                >
                                    {phone.main_image_url ? (
                                        <img
                                            src={phone.main_image_url}
                                            alt={phone.model}
                                            style={{ width: "100%", height: "100%", objectFit: "cover" }}
                                        />
                                    ) : (
                                        <span style={{ color: "#555", fontSize: "0.9rem" }}>No Image</span>
                                    )}

                                    {/* ป้าย NEW + ดาว + คะแนนอยู่มุมบนขวา */}
                                    <div
                                        style={{
                                            position: "absolute",
                                            top: 5,
                                            right: 5,
                                            display: "flex",
                                            flexDirection: "column",
                                            alignItems: "flex-end",
                                            gap: "3px"
                                        }}
                                    >
                                        {/* ป้าย NEW */}
                                        <span
                                            style={{
                                                backgroundColor: "red",
                                                color: "white",
                                                fontSize: "0.7rem",
                                                fontWeight: "bold",
                                                padding: "2px 5px",
                                                borderRadius: "3px"
                                            }}
                                        >
                                            NEW
                                        </span>

                                        {/* ดาว + คะแนนรวม */}
                                        <span
                                            style={{
                                                backgroundColor: "rgba(0,0,0,0.6)",
                                                color: "white",
                                                fontSize: "0.7rem",
                                                fontWeight: "bold",
                                                padding: "2px 5px",
                                                borderRadius: "3px",
                                                display: "flex",
                                                alignItems: "center",
                                                gap: "4px"
                                            }}
                                        >
                                            <FaStar className="text-warning" />
                                            {Number(phone.average_rating)?.toFixed(1) || "0.0"}
                                        </span>
                                    </div>
                                </div>

                                {/* ชื่อ + ราคา */}
                                <div className="card-body d-flex flex-column">
                                    <h6
                                        className="card-title text-center fs-6"
                                        style={{
                                            whiteSpace: "normal",
                                            overflow: "visible",
                                            textOverflow: "clip",
                                            wordWrap: "break-word"
                                        }}
                                    >
                                        {phone.model}
                                    </h6>
                                    <p className="text-center text-success mb-1">{phone.price ? `${phone.price} บาท` : "-"}</p>
                                </div>
                            </div>
                        </div>


                    ))}
            </div>

            {/* มือถือยอดนิยม */}
            <div className="d-flex align-items-center mt-5 mb-3">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    มือถือยอดนิยม 10 อันดับ
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            <div className="row g-4 mb-5 mt-3">
                <div className="col-12 col-lg-6">
                    <div className="card shadow-sm h-100 border-1 rounded">
                        <div className="card-header bg-light fw-bold fs-5">มือถือยอดเข้าชมสูงสุด</div>
                        <div className="card-body p-0">
                            <ul className="list-group list-group-flush rounded">
                                {popularPhones.map((phone, index) => (
                                    <li key={phone.id} className="list-group-item d-flex justify-content-between align-items-center px-3 py-2 hover-list" onClick={() => navigate(`/phones/${phone.id}`)} style={{ cursor: "pointer" }}>
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

                <div className="col-12 col-lg-6">
                    <div className="card shadow-sm h-100 border-1 rounded">
                        <div className="card-header bg-light fw-bold fs-5">มือถือยอดถูกใจสูงสุด</div>
                        <div className="card-body p-0">
                            <ul className="list-group list-group-flush rounded">
                                {popularLikes.map((phone, index) => (
                                    <li key={phone.id} className="list-group-item d-flex justify-content-between align-items-center px-3 py-2 hover-list" onClick={() => navigate(`/phones/${phone.id}`)} style={{ cursor: "pointer" }}>
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

            {/* มือถือเปิดตัวใหม่ */}
            <div className="d-flex align-items-center mt-5 mb-3">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    มือถือเปิดตัวใหม่
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            {/* มือถือเปิดตัวใหม่ ตามเดือน */}
            {shownMonths.map((month) => {
                const phonesInMonth = latestPhonesByMonth[month];
                if (!phonesInMonth) return null;
                return (
                    <div key={month} className="mb-4 mt-4">
                        <h5 className="fw-medium">เดือน {month}</h5>
                        <div className="row g-3">
                            {phonesInMonth.slice(0, showMore[month]).map((phone) => (
                                <div key={phone.id} className="col-6 col-sm-4 col-md-3 col-lg-2">
                                    <div className="card h-100 rounded position-relative border-1 phone-card" style={{ cursor: "pointer", backgroundColor: "#f9f9f9" }} onClick={() => navigate(`/phones/${phone.id}`)}>
                                        <div style={{ width: "100%", aspectRatio: "3/4", overflow: "hidden", borderRadius: "5px 5px 0 0", display: "flex", alignItems: "center", justifyContent: "center" }}>
                                            {phone.main_image_url ? <img src={phone.main_image_url} alt={phone.model} style={{ width: "100%", height: "100%", objectFit: "cover" }} /> : <span style={{ color: "#555", fontSize: "0.9rem" }}>No Image</span>}
                                            {/* ป้าย NEW + ดาว + คะแนนอยู่มุมบนขวา */}
                                            <div
                                                style={{
                                                    position: "absolute",
                                                    top: 5,
                                                    right: 5,
                                                    display: "flex",
                                                    flexDirection: "column",
                                                    alignItems: "flex-end",
                                                    gap: "3px"
                                                }}
                                            >
                                                {/* ดาว + คะแนนรวม */}
                                                <span
                                                    style={{
                                                        backgroundColor: "rgba(0,0,0,0.6)",
                                                        color: "white",
                                                        fontSize: "0.7rem",
                                                        fontWeight: "bold",
                                                        padding: "2px 5px",
                                                        borderRadius: "3px",
                                                        display: "flex",
                                                        alignItems: "center",
                                                        gap: "4px"
                                                    }}
                                                >
                                                    <FaStar className="text-warning" />
                                                    {Number(phone.average_rating)?.toFixed(1) || "0.0"}
                                                </span>
                                            </div>
                                        </div>
                                        <div className="card-body d-flex flex-column">
                                            <h6 className="card-title text-center fs-6" style={{ whiteSpace: "normal", overflow: "visible", textOverflow: "clip", wordWrap: "break-word" }}>{phone.model}</h6>
                                            <p className="text-center text-success mb-1">{phone.price ? `${phone.price} บาท` : "-"}</p>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>

                        {showMore[month] < phonesInMonth.length && (
                            <div className="text-center mt-2">
                                <button className="btn btn-outline-primary btn-sm" onClick={() => setShowMore({ ...showMore, [month]: showMore[month] + ITEMS_PER_MONTH })}>
                                    ดูเพิ่มเติม
                                </button>
                            </div>
                        )}
                    </div>
                );
            })}

            {shownMonths.length < allMonths.length && (
                <div className="text-center mt-3 mb-5">
                    <button className="btn d-flex align-items-center justify-content-center gap-2" style={{ border: "2px dashed #adb5bd", backgroundColor: "#f8f9fa", color: "#495057", width: "100%", padding: "0.5rem 1rem", borderRadius: "0.5rem" }} onClick={() => setShownMonths(allMonths.slice(0, shownMonths.length + MONTHS_TO_SHOW))}>
                        ดูเพิ่มเติม
                    </button>
                </div>
            )}
        </div>
    );
};

export default Home;
