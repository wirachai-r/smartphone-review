import React, { useState, useEffect, useRef } from "react";
import ReactCrop from "react-image-crop";
import "react-image-crop/dist/ReactCrop.css";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import {
    getCategories,
    createCategory,
    updateCategory,
    deleteCategory,
} from "../../services/categories";
import { FaEdit, FaTrash } from "react-icons/fa";
import { Modal, Button } from "react-bootstrap"; // เพิ่ม import

const MySwal = withReactContent(Swal);
const FIXED_WIDTH = 200;
const FIXED_HEIGHT = 200;
const ITEMS_PER_PAGE = 10; // แสดงแบรนด์ต่อหน้า

const ManageCategories = () => {
    const [categories, setCategories] = useState([]);
    const [loading, setLoading] = useState(false);
    const [editingId, setEditingId] = useState(null);
    const [name, setName] = useState("");
    const [brandImage, setBrandImage] = useState(null);
    const [previewUrl, setPreviewUrl] = useState(null);
    const [modalImageUrl, setModalImageUrl] = useState(null);
    const [crop, setCrop] = useState({
        unit: "px",
        width: FIXED_WIDTH,
        height: FIXED_HEIGHT,
        x: 0,
        y: 0,
    });
    const [imageRef, setImageRef] = useState(null);
    const [showModal, setShowModal] = useState(false);
    const [currentPage, setCurrentPage] = useState(1);
    const fileInputRef = useRef(null);

    const fetchCategories = async () => {
        setLoading(true);
        try {
            const data = await getCategories();
            setCategories(data);
        } catch (error) {
            console.error(error);
            MySwal.fire("Error", "ไม่สามารถโหลดแบรนด์ได้", "error");
        }
        setLoading(false);
    };

    useEffect(() => {
        fetchCategories();
    }, []);

    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setModalImageUrl(URL.createObjectURL(file));
            setCrop({ unit: "px", width: FIXED_WIDTH, height: FIXED_HEIGHT, x: 0, y: 0 });
            setShowModal(true);
        }
    };

    // ฟังก์ชันตัดรูปเป็นสี่เหลี่ยม
    const getCroppedImage = async () => {
        if (!imageRef || !crop.width || !crop.height) return null;

        const canvas = document.createElement("canvas");
        canvas.width = crop.width;    // ✅ ใช้ขนาดจริงจาก crop
        canvas.height = crop.height;
        const ctx = canvas.getContext("2d");

        const scaleX = imageRef.naturalWidth / imageRef.width;
        const scaleY = imageRef.naturalHeight / imageRef.height;

        ctx.drawImage(
            imageRef,
            crop.x * scaleX,
            crop.y * scaleY,
            crop.width * scaleX,
            crop.height * scaleY,
            0,
            0,
            crop.width,   // ✅ ไม่ฟิกค่า 200 อีกต่อไป
            crop.height
        );

        return new Promise((resolve) => {
            canvas.toBlob((blob) => resolve(blob), "image/jpeg");
        });
    };

    const handleCropSave = async () => {
        const croppedBlob = await getCroppedImage();
        if (croppedBlob) {
            setBrandImage(croppedBlob);
            setPreviewUrl(URL.createObjectURL(croppedBlob));
        }
        setModalImageUrl(null);
        setShowModal(false);
        if (fileInputRef.current) fileInputRef.current.value = null; // ล้างชื่อไฟล์
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        if (!name.trim()) return MySwal.fire("Warning", "กรุณากรอกชื่อแบรนด์", "warning");

        const formData = new FormData();
        formData.append("name", name);
        if (brandImage) formData.append("brand_image", brandImage, "cropped.jpg");

        try {
            if (editingId) {
                formData.append("_method", "PUT");
                await updateCategory(editingId, formData);
                MySwal.fire("Success", "แก้ไขแบรนด์เรียบร้อย", "success");
            } else {
                await createCategory(formData);
                MySwal.fire("Success", "เพิ่มแบรนด์เรียบร้อย", "success");
            }
            setName("");
            setBrandImage(null);
            setPreviewUrl(null);
            setEditingId(null);
            if (fileInputRef.current) fileInputRef.current.value = null;
            fetchCategories();
        } catch (error) {
            console.error(error);
            MySwal.fire("Error", "ไม่สามารถบันทึกแบรนด์ได้", "error");
        }
    };

    const handleEdit = (cat) => {
        setEditingId(cat.id);
        setName(cat.name);
        setPreviewUrl(cat.brand_image_url || null);
        setBrandImage(null);
    };

    const handleDelete = async (id) => {
        const result = await MySwal.fire({
            title: "คุณแน่ใจหรือไม่?",
            text: "การลบแบรนด์จะไม่สามารถกู้คืนได้!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#d33",
            cancelButtonColor: "#3085d6",
            confirmButtonText: "ลบ",
            cancelButtonText: "ยกเลิก",
        });

        if (result.isConfirmed) {
            try {
                await deleteCategory(id);
                MySwal.fire("สำเร็จ!", "ลบแบรนด์เรียบร้อย", "success");
                fetchCategories();
            } catch (error) {
                console.error(error);

                // ถ้า backend ส่ง message มา
                let msg = "ไม่สามารถลบแบรนด์ได้";
                if (error.response && error.response.data && error.response.data.message) {
                    msg = error.response.data.message;
                }

                MySwal.fire("เกิดข้อผิดพลาด", msg, "error");
            }
        }
    };


    // Pagination
    const totalPages = Math.ceil(categories.length / ITEMS_PER_PAGE);
    const paginatedCategories = categories.slice(
        (currentPage - 1) * ITEMS_PER_PAGE,
        currentPage * ITEMS_PER_PAGE
    );

    return (
        <div>
            <div className="d-flex align-items-center mt-2 mb-4">
                <h3 className="fw-bold mb-0" style={{ borderLeft: "6px solid #0b5ed7", paddingLeft: 10, marginRight: 10, whiteSpace: "nowrap" }}>
                    จัดการแบรนด์
                </h3>
                <div style={{ flex: 1, height: 2, backgroundColor: "#e4e4e4" }}></div>
            </div>

            {/* Form */}
            <div className="card mb-4 border rounded">
                <div className="card-header text-black fw-medium">
                    {editingId ? "แก้ไขชื่อแบรนด์" : "เพิ่มชื่อแบรนด์ใหม่"}
                </div>
                <div className="card-body">
                    <form onSubmit={handleSubmit} className="row g-3 align-items-end">
                        <div className="col-md-6">
                            <input
                                type="text"
                                className="form-control"
                                placeholder="ชื่อแบรนด์"
                                value={name}
                                onChange={(e) => setName(e.target.value)}
                                required
                            />
                        </div>

                        <div className="col-md-6">
                            <input
                                type="file"
                                accept="image/*"
                                onChange={handleFileChange}
                                className="form-control"
                                ref={fileInputRef}
                            />
                        </div>

                        <div className="col-md-12 d-grid">
                            <button type="submit" className="btn btn-primary mb-2">
                                {editingId ? "แก้ไข" : "เพิ่ม"}
                            </button>
                            {editingId && (
                                <button
                                    type="button"
                                    className="btn btn-secondary"
                                    onClick={() => {
                                        setEditingId(null);
                                        setName("");
                                        setBrandImage(null);
                                        setPreviewUrl(null);
                                        if (fileInputRef.current) fileInputRef.current.value = null;
                                    }}
                                >
                                    ยกเลิก
                                </button>
                            )}
                        </div>

                        {previewUrl && (
                            <div className="col-12 mt-3">
                                <strong>Preview:</strong>
                                <div className="mt-2">
                                    <img
                                        src={previewUrl}
                                        alt="Preview"
                                        style={{
                                            width: "200px",
                                            height: "auto",
                                            borderRadius: "8px",
                                            border: "1px solid #ccc",
                                        }}
                                    />
                                </div>
                            </div>
                        )}
                    </form>
                </div>
            </div>

            {/* Category List */}
            <div className="card border rounded">
                {/* <div className="card-header text-black fw-medium">รายการแบรนด์</div> */}
                <div className="card-body p-0">
                    {loading ? (
                        <p className="p-3 text-center">กำลังโหลด...</p>
                    ) : categories.length === 0 ? (
                        <p className="p-3 text-center">ยังไม่มีแบรนด์</p>
                    ) : (
                        <div className="table-responsive rounded">
                            <table
                                className="table table-sm align-middle mb-0"
                                style={{ minWidth: "800px", borderCollapse: "collapse" }}
                            >
                                <thead className="table-light">
                                    <tr>
                                        <th className="text-start p-3 fw-medium">#</th>
                                        <th className="text-start p-3 fw-medium">รูปภาพ</th>
                                        <th className="text-start p-3 fw-medium">ชื่อ</th>
                                        <th className="text-start p-3 fw-medium">จัดการ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {paginatedCategories.map((cat, index) => (
                                        <tr key={cat.id}>
                                            <td className="text-start p-3">{(currentPage - 1) * ITEMS_PER_PAGE + index + 1}</td>
                                            <td className="p-3" style={{ verticalAlign: "middle" }}>
                                                {cat.brand_image_url ? (
                                                    <img
                                                        src={cat.brand_image_url}
                                                        alt={cat.name}
                                                        style={{
                                                            width: "120px",
                                                            height: "100px",
                                                            objectFit: "cover",
                                                            borderRadius: "8px",
                                                            border: "1px solid #ddd",
                                                        }}
                                                    />
                                                ) : (
                                                    <div
                                                        style={{
                                                            width: "120px",
                                                            height: "100px",
                                                            backgroundColor: "#e0e0e0",
                                                            color: "#555",
                                                            display: "flex",
                                                            alignItems: "center",
                                                            justifyContent: "center",
                                                            borderRadius: "8px",
                                                            border: "1px solid #ccc",
                                                            fontSize: "0.9rem",
                                                            fontWeight: "500",
                                                            margin: "0",
                                                        }}
                                                    >
                                                        No Image
                                                    </div>
                                                )}
                                            </td>
                                            <td className="text-start p-3" style={{ whiteSpace: "nowrap" }}>{cat.name}</td>
                                            <td className="text-start p-3">
                                                <button onClick={() => handleEdit(cat)} className="btn btn-warning btn-sm me-2">
                                                    <FaEdit className="me-1 mb-1" /> แก้ไข
                                                </button>
                                                <button onClick={() => handleDelete(cat.id)} className="btn btn-danger btn-sm">
                                                    <FaTrash className="me-1 mb-1" /> ลบ
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                </div>

            </div>

            {/* Custom Pagination */}
            {totalPages > 1 && (
                <nav aria-label="Page navigation example" className="mt-4">
                    <ul className="pagination justify-content-center">
                        {/* ปุ่มก่อนหน้า */}
                        <li className={`page-item ${currentPage === 1 ? "disabled" : ""}`}>
                            <button
                                className="page-link d-flex align-items-center gap-1"
                                onClick={() => setCurrentPage(currentPage - 1)}
                                disabled={currentPage === 1}
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
                            >
                                ถัดไป <i className="bi bi-chevron-right"></i>
                            </button>
                        </li>
                    </ul>
                </nav>
            )}

            {/* Crop Modal */}
            <Modal show={showModal} onHide={() => setShowModal(false)} centered>
                <Modal.Header closeButton>
                    <Modal.Title>ตัดรูปแบรนด์</Modal.Title>
                </Modal.Header>
                <Modal.Body className="text-center">
                    {modalImageUrl && (
                        <ReactCrop
                            src={modalImageUrl}
                            crop={crop}
                            onChange={(newCrop) => setCrop(newCrop)}
                            onComplete={(c) => setCrop(c)}
                            minWidth={50}   // ขนาดขั้นต่ำ
                            minHeight={50}
                            // aspect={1}
                            keepSelection={true}
                        >
                            <img
                                src={modalImageUrl}
                                alt="Modal Preview"
                                ref={setImageRef}
                                style={{ maxWidth: "100%", maxHeight: "400px", display: "block", margin: "0 auto" }}
                            />
                        </ReactCrop>
                    )}
                    <small className="text-muted d-block mt-2">
                        ลากสี่เหลี่ยมเพื่อเลือกตำแหน่งที่ต้องการ
                    </small>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={() => setShowModal(false)}>ปิด</Button>
                    <Button variant="primary" onClick={handleCropSave}>บันทึก</Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
};

export default ManageCategories;
