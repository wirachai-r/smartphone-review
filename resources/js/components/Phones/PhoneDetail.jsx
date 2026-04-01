import React, { useEffect, useState, useContext, useRef } from "react";
import { useParams, useNavigate } from "react-router-dom";
import { FaEye, FaHeart } from "react-icons/fa";
import { RiRam2Line } from "react-icons/ri";
import { HiMiniCpuChip, HiOutlineDevicePhoneMobile } from "react-icons/hi2";
import { IoIosAperture, IoIosBatteryFull } from "react-icons/io";
import { Carousel, Image, Modal, Button } from "react-bootstrap";
import 'bootstrap/dist/css/bootstrap.min.css';
import Swal from "sweetalert2";
import { AuthContext } from "../../context/AuthContext";
import ReviewForm from "../Reviews/ReviewForm";
import ReviewsList from "../Reviews/ReviewsList";
import { incrementViews } from "../../services/phones";
import { toggleLike, getLikes, checkLiked } from "../../services/likes";
import { getReviews, hasReviewed } from "../../services/reviews";
import { FaStar, FaStarHalfAlt, FaRegStar } from "react-icons/fa";

const PhoneDetail = () => {
    const { id } = useParams();
    const [phone, setPhone] = useState(null);
    const [loading, setLoading] = useState(true);
    const [activeIndex, setActiveIndex] = useState(0);
    const [showModal, setShowModal] = useState(false);
    const [modalIndex, setModalIndex] = useState(0);
    const [showFullSpecs, setShowFullSpecs] = useState(false);
    const [summary, setSummary] = useState({});
    const [liked, setLiked] = useState(false);
    const [likes, setLikes] = useState(0);
    const [showReviewModal, setShowReviewModal] = useState(false);

    const { user } = useContext(AuthContext);
    const navigate = useNavigate();
    const viewIncrementedRef = useRef(false);
    const [reviewed, setReviewed] = useState(false);

    const [reviews, setReviews] = useState([]);
    const [averageRating, setAverageRating] = useState(0);

    // ฟังก์ชันดึงข้อมูลมือถือ
    const fetchPhoneDetails = async () => {
        setLoading(true);
        try {
            const res = await fetch(`/api/phones/${id}`);
            const data = await res.json();

            const summaryObj = data.summary ? JSON.parse(data.summary) : {};
            setSummary(summaryObj);

            const images = data.images || [];
            setPhone({ ...data, images });

            if (user) {
                const [likeCount, likeStatus] = await Promise.all([
                    getLikes(data.id),
                    checkLiked(data.id),
                ]);
                setLikes(likeCount.likes);
                setLiked(likeStatus.liked);
            }
        } catch (err) {
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    // เพิ่ม view แค่ครั้งเดียว
    useEffect(() => {
        const incrementViewOnce = async () => {
            if (!viewIncrementedRef.current) {
                await incrementViews(id);
                viewIncrementedRef.current = true;
            }
        };
        incrementViewOnce();
    }, [id]);

    // ดึงข้อมูลมือถือ
    useEffect(() => {
        fetchPhoneDetails();
    }, [id, user]);

    const handleLike = async () => {
        if (!user) {
            Swal.fire({
                icon: "warning",
                title: "กรุณาล็อกอิน",
                text: "คุณต้องล็อกอินก่อนถึงจะกด ถูกใจ ได้",
                confirmButtonColor: "#e96e00",
            });
            return;
        }

        try {
            const res = await toggleLike(phone.id);
            setLiked(res.liked);
            setLikes((prev) => (res.liked ? prev + 1 : prev - 1));
        } catch (err) {
            console.error(err);
            Swal.fire({
                icon: "error",
                title: "เกิดข้อผิดพลาด",
                text: "ไม่สามารถกด ถูกใจ ได้",
                confirmButtonColor: "#e96e00",
            });
        }
    };

    useEffect(() => {
        if (!phone || !user) return;

        const checkReviewStatus = async () => {
            try {
                const has = await hasReviewed(phone.id);
                setReviewed(has);
            } catch (err) {
                console.error(err);
            }
        };

        checkReviewStatus();
    }, [phone, user]);

    // ฟังก์ชันดึงรีวิว
    const fetchReviews = async () => {
        try {
            const data = await getReviews(id);
            setReviews(data);

            if (data.length > 0) {
                const avg = data.reduce((sum, r) => sum + r.rating, 0) / data.length;
                setAverageRating(avg);
            } else {
                setAverageRating(0);
            }
        } catch (err) {
            console.error(err);
        }
    };

    // ดึงรีวิวพร้อมกับข้อมูลมือถือ
    useEffect(() => {
        fetchReviews();
    }, [id]);

    // ฟังก์ชันสร้างดาวจากคะแนน
    const renderStars = (rating) => {
        const stars = [];
        for (let i = 1; i <= 5; i++) {
            if (i <= Math.floor(rating)) {
                stars.push(<FaStar key={i} className="text-warning" />);
            } else if (i - rating < 1) {
                stars.push(<FaStarHalfAlt key={i} className="text-warning" />);
            } else {
                stars.push(<FaRegStar key={i} className="text-warning" />);
            }
        }
        return stars;
    };

    if (loading) return <p className="text-center mt-5">กำลังโหลด...</p>;
    if (!phone) return <p className="text-center mt-5 text-danger">ไม่พบข้อมูลมือถือ</p>;

    return (
        <div className="mt-4">
            <div className="card border-0">
                <div className="d-flex align-items-center p-3">
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
                                className="breadcrumb-item text-primary"
                                style={{ cursor: "pointer" }}
                                onClick={() => navigate("/phones")}
                            >
                                โทรศัพท์ทั้งหมด
                            </li>
                            <li className="breadcrumb-item active text-dark"
                                style={{ cursor: "pointer" }}
                                onClick={() => navigate("/phones/" + phone.id)}
                            >
                                {phone.model}
                            </li>
                        </ol>
                    </nav>
                </div>
                <div className="mp-2 p-3">
                    <h1 className="fw-bold p-3 text-center bg-gray rounded-2 text-black">{phone.model}</h1>
                </div>
                <div className="row g-0">
                    {/* รูปหลัก + Carousel */}
                    <div className="col-md-6 text-center p-3">
                        {phone.images && phone.images.length > 0 ? (
                            <>
                                <Carousel
                                    activeIndex={activeIndex}
                                    onSelect={(idx) => setActiveIndex(idx)}
                                    controls
                                    indicators={false}
                                    interval={null}
                                >
                                    {phone.images.map((img, idx) => (
                                        <Carousel.Item key={idx}>
                                            <Image
                                                className="d-block w-100 border rounded"
                                                src={img.url}
                                                alt={`Slide ${idx}`}
                                                loading="lazy"
                                                style={{
                                                    maxHeight: "350px",
                                                    objectFit: "contain",
                                                    cursor: "pointer",
                                                }}
                                                onClick={() => {
                                                    setModalIndex(idx);
                                                    setShowModal(true);
                                                }}
                                            />
                                        </Carousel.Item>
                                    ))}
                                </Carousel>

                                {/* Thumbnails */}
                                <div className="d-flex overflow-auto gap-2 mt-2">
                                    {phone.images.map((img, idx) => (
                                        <Image
                                            className="rounded"
                                            key={idx}
                                            src={img.url}
                                            alt={`Thumb ${idx}`}
                                            loading="lazy"
                                            style={{
                                                width: "100px",
                                                height: "100px",
                                                objectFit: "cover",
                                                border:
                                                    idx === activeIndex
                                                        ? "2px solid #4e86da"
                                                        : "1px solid #ddd",
                                                cursor: "pointer",
                                            }}
                                            onClick={() => setActiveIndex(idx)}
                                        />
                                    ))}
                                </div>
                            </>
                        ) : (
                            // ถ้าไม่มีรูป
                            <div
                                className="d-flex align-items-center justify-content-center border rounded bg-light text-secondary"
                                style={{
                                    height: "400px",
                                    fontSize: "24px",
                                    fontWeight: "bold",
                                }}
                            >
                                No Image
                            </div>
                        )}

                        {/* ขนาดเครื่อง, น้ำหนัก, สี */}
                        <div className="mt-3 mb-3 d-flex flex-column align-items-center border rounded p-3" style={{ background: "#f9f9f9" }}>

                            {phone.colors && phone.colors.length > 0 && (
                                <div className="d-flex flex-wrap justify-content-center gap-2">
                                    {phone.colors.map((c, i) => (
                                        <div
                                            key={i}
                                            className="d-flex align-items-center gap-1 border rounded p-1"
                                            style={{ background: "#f9f9f9" }}
                                        >
                                            <div
                                                style={{
                                                    width: "20px",
                                                    height: "20px",
                                                    backgroundColor: c.hex,
                                                    borderRadius: "50%",
                                                    border: "1px solid #ccc",
                                                }}
                                            ></div>
                                            <span>{c.name}</span>
                                        </div>
                                    ))}
                                </div>
                            )}

                            <div className="d-flex align-items-center gap-2 mt-2">
                                <h6 className="fw-bold mb-0">ขนาดเครื่อง:</h6>
                                <p className="mb-0">{summary.dimensions || "-"}</p>
                            </div>

                            <div className="d-flex align-items-center gap-2 mt-2">
                                <h6 className="fw-bold mb-0">น้ำหนัก:</h6>
                                <p className="mb-0">{summary.weight || "-"}</p>
                            </div>
                        </div>

                    </div>

                    {/* ข้อมูลมือถือ */}
                    <div className="col-md-6 p-3">
                        <div className="mb-3">
                            <div className="rounded text-center">
                                <div className="text-center">
                                    {phone.category?.brand_image_url ? (
                                        <img
                                            src={phone.category.brand_image_url}
                                            alt={phone.category.name}
                                            style={{ maxWidth: "100px", height: "80px", objectFit: "contain" }}
                                            className="d-block mx-auto rounded"
                                        />
                                    ) : (
                                        <div
                                            className="d-flex align-items-center justify-content-center rounded mx-auto"
                                            style={{
                                                width: "100px",
                                                height: "80px",
                                                backgroundColor: "#f1f1f1",
                                                border: "1px solid #ccc",
                                                fontWeight: "500",
                                                color: "#555",
                                            }}
                                        >
                                            No Image
                                        </div>
                                    )}

                                    {/* ชื่อแบรนด์อยู่ด้านล่าง */}
                                    <p
                                        className="mt-1 mb-0"
                                        style={{
                                            fontSize: "1rem",
                                            fontWeight: "500",
                                            color: "#333",
                                            whiteSpace: "nowrap",
                                            overflow: "hidden",
                                            textOverflow: "ellipsis",
                                        }}
                                    >
                                        {phone.category?.name || "ไม่มีแบรนด์"}
                                    </p>
                                </div>

                            </div>


                            {/* Views + Likes */}
                            <div className="d-flex align-items-center justify-content-between mt-3">
                                {/* ซ้าย: Views + Likes */}
                                <div className="d-flex align-items-center gap-3">
                                    <span className="text-muted d-flex align-items-center gap-1">
                                        <FaEye /> {phone.views || 0}
                                    </span>

                                    <span className="text-muted d-flex align-items-center gap-1">
                                        <FaHeart className="text-danger" /> {likes || 0}
                                    </span>

                                    {/* <span className="text-muted d-flex align-items-center gap-1">
                                        {renderStars(averageRating)} ({Number(averageRating)?.toFixed(1) || "0.0"})
                                    </span> */}
                                    <span className="text-muted d-flex align-items-center gap-1">
                                        <FaStar className="text-warning" /> ({Number(averageRating)?.toFixed(1) || "0.0"})
                                    </span>
                                </div>

                                {/* ขวา: ปุ่ม Like สวย ๆ */}
                                <button
                                    onClick={handleLike}
                                    className={`btn ${liked ? "btn-danger" : "btn-outline-danger"} d-flex align-items-center gap-2`}
                                >
                                    <FaHeart />
                                    {liked ? "ถูกใจแล้ว" : "ถูกใจ"}
                                </button>
                            </div>

                            <div className="row text-center mt-2">
                                <div className="col-6 col-lg-4 p-2">
                                    <div className="border rounded p-3 h-100">
                                        <HiOutlineDevicePhoneMobile size={40} className="mb-2" />
                                        <h6 className="fw-bold">ขนาดหน้าจอ</h6>
                                        <p>{summary.screen || "-"}</p>
                                    </div>
                                </div>

                                <div className="col-6 col-lg-4 p-2">
                                    <div className="border rounded p-3 h-100">
                                        <IoIosAperture size={40} className="mb-2" />
                                        <h6 className="fw-bold">กล้อง</h6>
                                        <p>{summary.camera || "-"}</p>
                                    </div>
                                </div>

                                <div className="col-6 col-lg-4 p-2">
                                    <div className="border rounded p-3 h-100">
                                        <HiMiniCpuChip size={40} className="mb-2" />
                                        <h6 className="fw-bold">CPU</h6>
                                        <p>{summary.cpu || "-"}</p>
                                    </div>
                                </div>

                                <div className="col-6 col-lg-4 p-2">
                                    <div className="border rounded p-3 h-100">
                                        <RiRam2Line size={40} className="mb-2" />
                                        <h6 className="fw-bold">หน่วยความจำ</h6>
                                        <p>{summary.memory || "-"}</p>
                                    </div>
                                </div>

                                <div className="col-6 col-lg-4 p-2">
                                    <div className="border rounded p-3 h-100">
                                        <IoIosBatteryFull size={40} className="mb-2" />
                                        <h6 className="fw-bold">แบตเตอรี่</h6>
                                        <p>{summary.battery || "-"}</p>
                                    </div>
                                </div>

                                <div className="col-6 col-lg-4 p-2">
                                    <div className="border rounded p-3 h-100">
                                        <h2 className="mb-2">OS</h2>
                                        <h6 className="fw-bold">ระบบปฏิบัติการ</h6>
                                        <p>{summary.os || "-"}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div className="mt-5 text-center p-1">
                            <h3 className="fw-bold">{phone.model}</h3>

                            <h5>ราคา {phone.price} บาท</h5>
                        </div>
                    </div>

                    {/* Specs */}
                    <div className="col-md-12 p-3">
                        <div className="d-flex align-items-center mb-4">
                            <h3
                                className="fw-bold mb-0"
                                style={{
                                    borderLeft: "6px solid #0b5ed7",
                                    paddingLeft: "10px",
                                    marginRight: "10px",
                                    whiteSpace: "nowrap", // ป้องกันข้อความตัดบรรทัด
                                }}
                            >
                                รายละเอียด
                            </h3>
                            <div style={{ flex: 1, height: "2px", backgroundColor: "#e4e4e4" }}></div>
                        </div>
                        <div
                            className="phone-specs mt-4"
                            style={{
                                maxHeight: showFullSpecs ? "none" : "1000px",
                                overflow: "hidden",
                                transition: "max-height 0.3s",
                            }}
                        >
                            <div
                                dangerouslySetInnerHTML={{
                                    __html: phone.specs || "<p>ไม่มีข้อมูลรายละเอียด</p>",
                                }}
                            />
                        </div>
                        <button
                            className="btn btn-link p-0 mt-2"
                            onClick={() => setShowFullSpecs(!showFullSpecs)}
                        >
                            {showFullSpecs ? "ย่อ ..." : "ดูเพิ่มเติม ..."}
                        </button>
                    </div>

                    <div className="d-flex align-items-center mb-4 mt-4">
                        <h3
                            className="fw-bold mb-0"
                            style={{
                                borderLeft: "6px solid #0b5ed7",
                                paddingLeft: "10px",
                                marginRight: "10px",
                                whiteSpace: "nowrap", // ป้องกันข้อความตัดบรรทัด
                            }}
                        >
                            รีวิว ({reviews.length})
                        </h3>
                        <div style={{ flex: 1, height: "2px", backgroundColor: "#e4e4e4" }}></div>
                    </div>

                    <div className="text-center mb-3">
                        <Button
                            className="btn d-flex align-items-center justify-content-center gap-2"
                            style={{
                                border: "2px dashed #adb5bd",
                                backgroundColor: "#f8f9fa",
                                color: "#495057",
                                width: "100%",
                                padding: "0.5rem 1rem",
                                borderRadius: "0.5rem"
                            }}
                            variant="primary"
                            onClick={() => {
                                if (!user) {
                                    Swal.fire({
                                        icon: "warning",
                                        title: "กรุณาล็อกอิน",
                                        text: "คุณต้องล็อกอินก่อนถึงจะเขียนรีวิวได้",
                                        confirmButtonColor: "#e96e00",
                                    });
                                    return;
                                }

                                if (reviewed) {
                                    Swal.fire({
                                        icon: "info",
                                        title: "คุณได้เขียนรีวิวไปแล้ว",
                                        text: "คุณสามารถแก้ไขรีวิวที่มีอยู่หรือดูรีวิวของคุณได้",
                                        confirmButtonColor: "#e96e00",
                                    });
                                    return;
                                }

                                setShowReviewModal(true);
                            }}
                        >
                            เขียนรีวิว
                        </Button>
                    </div>

                    <Modal
                        show={showReviewModal}
                        onHide={() => setShowReviewModal(false)}
                        size="lg"
                        centered
                    >
                        <Modal.Header closeButton>
                            <Modal.Title>เขียนรีวิว {phone.model}</Modal.Title>
                        </Modal.Header>
                        <Modal.Body>
                            <Modal.Body>
                                <ReviewForm phoneId={phone.id} onSuccess={fetchPhoneDetails} onClose={() => setShowReviewModal(false)} />
                            </Modal.Body>
                        </Modal.Body>
                    </Modal>

                    <ReviewsList phoneId={phone.id} currentUser={user} />
                </div>
            </div>

            {/* Modal */}
            <Modal show={showModal} onHide={() => setShowModal(false)} size="lg" centered>
                <Modal.Header closeButton>
                    <Modal.Title>รูปภาพ</Modal.Title>
                </Modal.Header>
                <Modal.Body className="p-0">
                    <Carousel activeIndex={modalIndex} onSelect={(idx) => setModalIndex(idx)} interval={null}>
                        {phone.images.map((img, idx) => (
                            <Carousel.Item key={idx}>
                                <Image className="d-block w-100" src={img.url} alt={`Slide ${idx}`} style={{ objectFit: "contain", maxHeight: "80vh" }} />
                            </Carousel.Item>
                        ))}
                    </Carousel>
                </Modal.Body>
                <Modal.Footer>
                    <Button variant="secondary" onClick={() => setShowModal(false)}>ปิด</Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
};

export default PhoneDetail;
