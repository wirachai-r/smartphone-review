import React, { useState, useEffect } from "react";
import { getPhones, getCategories } from "../../services/phones";
import { FaEye, FaHeart, FaStar } from "react-icons/fa";
import { useNavigate } from "react-router-dom";

const ITEMS_PER_PAGE = 12; // แสดงมือถือต่อหน้า

const PhonesList = () => {
    const [phones, setPhones] = useState([]);
    const [filteredPhones, setFilteredPhones] = useState([]);
    const [categories, setCategories] = useState([]);
    const [searchName, setSearchName] = useState("");
    const [selectedCategories, setSelectedCategories] = useState([]); // รองรับหลายแบรนด์
    const [minPrice, setMinPrice] = useState("");
    const [maxPrice, setMaxPrice] = useState("");
    const [sortOrder, setSortOrder] = useState("newest"); // newest | oldest | views | likes
    const [loading, setLoading] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const [checkAll, setCheckAll] = useState(true);
    const navigate = useNavigate();

    const fetchPhonesAndCategories = async () => {
        setLoading(true);
        try {
            const [phonesData, categoriesData] = await Promise.all([
                getPhones(),
                getCategories(),
            ]);
            setPhones(phonesData);
            setFilteredPhones(phonesData);
            setCategories(categoriesData);
        } catch (err) {
            console.error(err);
            alert("ไม่สามารถโหลดข้อมูลมือถือหรือแบรนด์ได้");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchPhonesAndCategories();
    }, []);

    useEffect(() => {
        let filtered = [...phones];

        // filter ชื่อรุ่น
        if (searchName) {
            filtered = filtered.filter((p) =>
                p.model.toLowerCase().includes(searchName.toLowerCase())
            );
        }

        // filter ตามแบรนด์
        if (!checkAll && selectedCategories.length > 0) {
            filtered = filtered.filter((p) =>
                selectedCategories.includes(p.category?.id)
            );
        }

        // filter ตามราคา
        if (minPrice) filtered = filtered.filter((p) => p.price >= parseFloat(minPrice));
        if (maxPrice) filtered = filtered.filter((p) => p.price <= parseFloat(maxPrice));

        // sort
        filtered.sort((a, b) => {
            switch (sortOrder) {
                case "newest":
                    return new Date(b.release_date) - new Date(a.release_date);
                case "oldest":
                    return new Date(a.release_date) - new Date(b.release_date);
                case "views":
                    return (b.views || 0) - (a.views || 0);
                case "likes":
                    return (b.likes || 0) - (a.likes || 0);
                default:
                    return 0;
            }
        });

        setFilteredPhones(filtered);
        setCurrentPage(1); // reset page
    }, [searchName, selectedCategories, minPrice, maxPrice, sortOrder, phones, checkAll]);

    // Pagination
    const totalPages = Math.ceil(filteredPhones.length / ITEMS_PER_PAGE);
    const paginatedPhones = filteredPhones.slice(
        (currentPage - 1) * ITEMS_PER_PAGE,
        currentPage * ITEMS_PER_PAGE
    );

    const handleCategoryCheck = (catId) => {
        if (selectedCategories.includes(catId)) {
            setSelectedCategories(selectedCategories.filter((id) => id !== catId));
        } else {
            setSelectedCategories([...selectedCategories, catId]);
        }
        setCheckAll(false);
    };

    const handleCheckAll = () => {
        setCheckAll(true);
        setSelectedCategories([]);
    };

    if (loading) return <p className="text-center mt-5">กำลังโหลด...</p>;
    if (phones.length === 0) return <p className="text-center mt-5">ไม่มีข้อมูลมือถือ</p>;

    return (
        <div className="mt-4 mb-5">
            <div className="d-flex align-items-center mb-4">
                <nav aria-label="breadcrumb">
                    <ol className="breadcrumb mb-0">
                        <li
                            className="breadcrumb-item text-primary"
                            style={{ cursor: "pointer" }}
                            onClick={() => navigate("/")}
                        >
                            หน้าหลัก
                        </li>
                        <li
                            className="breadcrumb-item"
                            style={{ cursor: "pointer" }}
                            onClick={() => navigate("/phones")}
                        >
                            โทรศัพท์ทั้งหมด
                        </li>
                    </ol>
                </nav>
            </div>
            <div className="row">
                {/* ฟิลเตอร์ ซ้าย */}
                <div className="col-md-3 mb-3">
                    <h3 className="fw-bold mb-3" >ค้นหา / กรอง</h3>
                    <input
                        type="text"
                        className="form-control mb-2"
                        placeholder="ค้นหาชื่อรุ่น..."
                        value={searchName}
                        onChange={(e) => setSearchName(e.target.value)}
                    />

                    <div className="mb-3">
                        <label>แบรนด์</label>
                        <div className="form-check">
                            <input
                                type="checkbox"
                                className="form-check-input"
                                checked={checkAll}
                                onChange={handleCheckAll}
                                id="checkAll"
                            />
                            <label htmlFor="checkAll" className="form-check-label">ทุกแบรนด์</label>
                        </div>
                        {categories.map((cat) => (
                            <div className="form-check" key={cat.id}>
                                <input
                                    type="checkbox"
                                    className="form-check-input"
                                    checked={selectedCategories.includes(cat.id)}
                                    onChange={() => handleCategoryCheck(cat.id)}
                                    id={`cat-${cat.id}`}
                                />
                                <label htmlFor={`cat-${cat.id}`} className="form-check-label">{cat.name}</label>
                            </div>
                        ))}
                    </div>

                    <div className="mb-3">
                        <label>ราคา (บาท)</label>
                        <div className="d-flex gap-2">
                            <input
                                type="number"
                                className="form-control"
                                placeholder="ต่ำสุด"
                                value={minPrice}
                                onChange={(e) => setMinPrice(e.target.value)}
                            />
                            <input
                                type="number"
                                className="form-control"
                                placeholder="สูงสุด"
                                value={maxPrice}
                                onChange={(e) => setMaxPrice(e.target.value)}
                            />
                        </div>
                    </div>

                    <div className="mb-3">
                        <label>เรียงลำดับ</label>
                        <select
                            className="form-select"
                            value={sortOrder}
                            onChange={(e) => setSortOrder(e.target.value)}
                        >
                            <option value="newest">ใหม่ → เก่า</option>
                            <option value="oldest">เก่า → ใหม่</option>
                            <option value="views">ยอดเข้าชมสูงสุด</option>
                            <option value="likes">ยอดถูกใจสูงสุด</option>
                        </select>
                    </div>
                </div>

                {/* แสดงมือถือ ขวา */}
                <div className="col-md-9">
                    <div className="row g-3">
                        {paginatedPhones.length === 0 && (
                            <p className="text-center text-muted">ไม่พบมือถือที่ค้นหา</p>
                        )}

                        {paginatedPhones.map((phone) => (
                            <div key={phone.id} className="col-6 col-sm-4 col-md-4 col-lg-3">
                                <div
                                    className="card h-100 rounded position-relative border-1 phone-card"
                                    style={{ cursor: "pointer", backgroundColor: "#f9f9f9" }}
                                    onClick={() => (window.location.href = `/phones/${phone.id}`)}
                                >
                                    <div
                                        style={{
                                            width: "100%",
                                            aspectRatio: "3/4",
                                            overflow: "hidden",
                                            borderRadius: "5px 5px 0 0",
                                            display: "flex",
                                            alignItems: "center",
                                            justifyContent: "center",
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
                                        <h6 className="card-title text-center fs-6">{phone.model}</h6>
                                        <p className="text-center text-success mb-1">
                                            {phone.price ? `${phone.price} บาท` : "-"}
                                        </p>
                                        <div className="d-flex justify-content-center gap-3 mt-auto text-muted">
                                            <span className="d-flex align-items-center gap-1">
                                                <FaEye /> {phone.views?.toLocaleString() || 0}
                                            </span>
                                            <span className="d-flex align-items-center gap-1">
                                                <FaHeart /> {phone.likes?.toLocaleString() || 0}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>

                    {/* Pagination */}
                    {totalPages > 1 && (
                        <nav aria-label="Page navigation example" className="mt-4">
                            <ul className="pagination justify-content-center">
                                {/* ปุ่มก่อนหน้า */}
                                <li className={`page-item ${currentPage === 1 ? "disabled" : ""}`}>
                                    <button
                                        className="page-link d-flex align-items-center gap-1"
                                        onClick={() => setCurrentPage(currentPage - 1)}
                                        disabled={currentPage === 1}
                                        // style={{
                                        //     color: "#000000",
                                        //     fontWeight: "500",
                                        // }}
                                    >
                                        <i className="bi bi-chevron-left"></i> ก่อนหน้า
                                    </button>
                                </li>

                                {/* หน้าต่างๆ */}
                                {Array.from({ length: totalPages }, (_, index) => (
                                    <li
                                        key={index + 1}
                                        className={`page-item ${currentPage === index + 1 ? "active" : ""}`}
                                    >
                                        <button
                                            className="page-link"
                                            onClick={() => setCurrentPage(index + 1)}
                                        >
                                            {index + 1}
                                        </button>
                                    </li>
                                ))}

                                {/* ปุ่มถัดไป */}
                                <li className={`page-item ${currentPage === totalPages ? "disabled" : ""}`}>
                                    <button
                                        className="page-link d-flex align-items-center gap-1"
                                        onClick={() => setCurrentPage(currentPage + 1)}
                                        disabled={currentPage === totalPages}
                                        // style={{
                                        //     color: "#000000",
                                        //     fontWeight: "500",
                                        // }}
                                    >
                                        ถัดไป <i className="bi bi-chevron-right"></i>
                                    </button>
                                </li>
                            </ul>
                        </nav>
                    )}

                </div>
            </div>
        </div>
    );
};

export default PhonesList;
