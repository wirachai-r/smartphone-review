import React, { useState, useEffect, useContext, useRef } from "react";
import { AuthContext } from "../../context/AuthContext";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { Modal, Button, Card } from "react-bootstrap";
import ReactCrop from "react-image-crop";
import "react-image-crop/dist/ReactCrop.css";
import api from "../../services/api";
import ReviewsList from "../Reviews/ReviewsList";
import { useNavigate } from "react-router-dom";


const MySwal = withReactContent(Swal);
const FIXED_SIZE = 200;

const Profile = () => {
    const { user, setUser } = useContext(AuthContext);
    const [form, setForm] = useState({ name: "", email: "", avatar: null });
    const [preview, setPreview] = useState(null);
    const [modalImageUrl, setModalImageUrl] = useState(null);
    const [crop, setCrop] = useState({
        unit: "px",
        width: FIXED_SIZE,
        height: FIXED_SIZE,
        x: 0,
        y: 0,
        aspect: 1, // ✅ ทำให้เป็นสี่เหลี่ยมจัตุรัส (พร้อม resize)
    });
    const [imageRef, setImageRef] = useState(null);
    const [showModal, setShowModal] = useState(false);
    const fileInputRef = useRef(null);
    const navigate = useNavigate();

    useEffect(() => {
        if (user) {
            setForm({ name: user.name, email: user.email, avatar: null });

            // ✅ ถ้ายังไม่มี avatar ให้เป็นสีเทา
            setPreview(
                user.avatar_url
                    ? user.avatar_url
                    : "data:image/svg+xml;base64," +
                    btoa(
                        `<svg width="160" height="160" xmlns="http://www.w3.org/2000/svg">
                        <rect width="160" height="160" fill="#cccccc"/>
                        <text x="50%" y="50%" dominant-baseline="middle" text-anchor="middle" fill="#666666" font-size="20">No Image</text>
                      </svg>`
                    )
            );
        }
    }, [user]);


    const handleFileChange = (e) => {
        const file = e.target.files[0];
        if (file) {
            setModalImageUrl(URL.createObjectURL(file));
            setShowModal(true);
        }
    };

    // ✅ ฟังก์ชันตัดรูปเป็นวงกลมจริง
    const getCircularCroppedImage = async () => {
        if (!imageRef || !crop.width || !crop.height) return null;
        const canvas = document.createElement("canvas");
        const ctx = canvas.getContext("2d");

        canvas.width = FIXED_SIZE;
        canvas.height = FIXED_SIZE;

        const scaleX = imageRef.naturalWidth / imageRef.width;
        const scaleY = imageRef.naturalHeight / imageRef.height;

        ctx.beginPath();
        ctx.arc(FIXED_SIZE / 2, FIXED_SIZE / 2, FIXED_SIZE / 2, 0, 2 * Math.PI);
        ctx.closePath();
        ctx.clip(); // ✅ ทำให้วาดในวงกลมเท่านั้น

        ctx.drawImage(
            imageRef,
            crop.x * scaleX,
            crop.y * scaleY,
            crop.width * scaleX,
            crop.height * scaleY,
            0,
            0,
            FIXED_SIZE,
            FIXED_SIZE
        );

        return new Promise((resolve) => {
            canvas.toBlob((blob) => resolve(blob), "image/png");
        });
    };

    const handleCropSave = async () => {
        const croppedBlob = await getCircularCroppedImage();
        if (croppedBlob) {
            setForm((prev) => ({ ...prev, avatar: croppedBlob }));
            setPreview(URL.createObjectURL(croppedBlob));
        }
        setShowModal(false);
        if (fileInputRef.current) fileInputRef.current.value = null;
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            // ✅ อัปเดตข้อมูลทั่วไป (ชื่อ/อีเมล)
            const response = await api.put("/profile", {
                name: form.name,
                email: form.email,
            });

            let updatedUser = response.data;

            // ✅ ถ้ามีการอัปโหลด avatar
            if (form.avatar) {
                const avatarData = new FormData();
                avatarData.append("avatar", form.avatar);
                const avatarRes = await api.post("/profile/avatar", avatarData, {
                    headers: { "Content-Type": "multipart/form-data" },
                });
                updatedUser = avatarRes.data;
                setPreview(avatarRes.data.avatar_url);
            }

            // ✅ อัปเดต user ใน context และ localStorage พร้อมกัน
            setUser(updatedUser);
            localStorage.setItem("user", JSON.stringify(updatedUser));

            MySwal.fire("สำเร็จ", "อัปเดตโปรไฟล์เรียบร้อย", "success");
        } catch (error) {
            console.error(error);
            MySwal.fire("ผิดพลาด", "ไม่สามารถอัปเดตโปรไฟล์ได้", "error");
        }
    };

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
                            onClick={() => navigate("/profile")}
                        >
                            โปรไฟล์
                        </li>
                    </ol>
                </nav>
            </div>
            <Card className="border-1 p-4 rounded">
                <div className="row align-items-center">
                    {/* Avatar */}
                    <div className="col-md-4 text-center mb-4 mb-md-0">
                        <div className="position-relative d-inline-block">
                            <img
                                src={preview}
                                alt="Avatar"
                                className="shadow-sm"
                                style={{
                                    width: "160px",
                                    height: "160px",
                                    objectFit: "cover",
                                    borderRadius: "50%", // ✅ แสดงผลเป็นวงกลม
                                    border: "4px solid #f0f0f0",
                                }}
                            />
                            <input
                                type="file"
                                accept="image/*"
                                ref={fileInputRef}
                                onChange={handleFileChange}
                                className="form-control mt-3"
                            />
                        </div>
                    </div>

                    {/* Profile Form */}
                    <div className="col-md-8">
                        <h4 className="fw-bold mb-3 text-primary">ข้อมูลส่วนตัว</h4>
                        <form onSubmit={handleSubmit}>
                            <div className="mb-3">
                                <label className="form-label">ชื่อ</label>
                                <input
                                    type="text"
                                    name="name"
                                    className="form-control"
                                    value={form.name}
                                    onChange={(e) =>
                                        setForm((prev) => ({ ...prev, name: e.target.value }))
                                    }
                                    required
                                />
                            </div>

                            <div className="mb-3">
                                <label className="form-label">อีเมล</label>
                                <input
                                    type="email"
                                    name="email"
                                    className="form-control"
                                    value={form.email}
                                    onChange={(e) =>
                                        setForm((prev) => ({ ...prev, email: e.target.value }))
                                    }
                                    required
                                />
                            </div>

                            <Button type="submit" variant="primary" className="px-4 mt-2">
                                บันทึกการเปลี่ยนแปลง
                            </Button>
                        </form>
                    </div>
                </div>
            </Card>

            <div className="d-flex align-items-center mb-4 mt-5">
                <h3
                    className="fw-bold mb-0"
                    style={{
                        borderLeft: "6px solid #0b5ed7",
                        paddingLeft: "10px",
                        marginRight: "10px",
                        whiteSpace: "nowrap", // ป้องกันข้อความตัดบรรทัด
                    }}
                >
                    รีวิวของคุณ
                </h3>
                <div style={{ flex: 1, height: "2px", backgroundColor: "#e4e4e4" }}></div>
            </div>
            <ReviewsList currentUser={user} userId={user?.id} />

            {/* Modal สำหรับ Crop */}
            <Modal show={showModal} onHide={() => setShowModal(false)} centered>
                <Modal.Header closeButton>
                    <Modal.Title>ตัดรูปโปรไฟล์</Modal.Title>
                </Modal.Header>
                <Modal.Body className="text-center">
                    {modalImageUrl && (
                        <ReactCrop
                            src={modalImageUrl}
                            crop={crop}
                            onChange={(newCrop) => setCrop(newCrop)} // ✅ ให้ย้ายได้อิสระ
                            onComplete={(c) => setCrop(c)}
                            circularCrop
                            aspect={1} // ✅ วงกลมสมบูรณ์
                            ruleOfThirds={false}
                            minWidth={50}   // ขนาดขั้นต่ำ
                            minHeight={50}
                        >
                            <img
                                src={modalImageUrl}
                                alt="Modal Preview"
                                ref={setImageRef}
                                style={{
                                    maxWidth: "100%",
                                    maxHeight: "400px",
                                    display: "block",
                                    margin: "0 auto",
                                    objectFit: "contain",
                                }}
                            />
                        </ReactCrop>
                    )}
                    <small className="text-muted d-block mt-2">
                        สามารถลากวงกลมเพื่อย้ายตำแหน่งได้
                    </small>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={() => setShowModal(false)}>
                        ปิด
                    </Button>
                    <Button variant="primary" onClick={handleCropSave}>
                        บันทึก
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
};

export default Profile;
