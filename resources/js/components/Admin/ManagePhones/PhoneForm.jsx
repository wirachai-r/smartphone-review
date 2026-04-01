// resources/js/components/phones/PhoneForm.jsx
import React, { useState, useEffect } from "react";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { getCategories } from "../../../services/categories";
import { createPhone, updatePhone } from "../../../services/phones";
import { uploadImage, deleteImage } from "../../../services/images";
import { DragDropContext, Droppable, Draggable } from "@hello-pangea/dnd";
import ReactQuill from "react-quill";
import "react-quill/dist/quill.snow.css";
import { RiRam2Line } from "react-icons/ri";
import { HiMiniCpuChip, HiOutlineDevicePhoneMobile } from "react-icons/hi2";
import { IoIosAperture, IoIosBatteryFull } from "react-icons/io";

const MySwal = withReactContent(Swal);

const PhoneForm = ({ phone, onSaved, onCancel }) => {
    const [model, setModel] = useState(phone?.model || "");
    const [summary, setSummary] = useState(() => {
        if (phone?.summary) {
            try {
                return JSON.parse(phone.summary);
            } catch (error) {
                console.warn("Invalid JSON in phone.summary, fallback to empty summary");
                return {
                    screen: "",
                    camera: "",
                    cpu: "",
                    memory: "",
                    battery: "",
                    os: "",
                    dimensions: "",
                    weight: "",
                };
            }
        } else {
            return {
                screen: "",
                camera: "",
                cpu: "",
                memory: "",
                battery: "",
                os: "",
                dimensions: "",
                weight: "",
            };
        }
    });

    const formatDateForInput = (dateString) => {
        if (!dateString) return "";
        const d = new Date(dateString);
        const yyyy = d.getFullYear();
        const mm = String(d.getMonth() + 1).padStart(2, "0");
        const dd = String(d.getDate()).padStart(2, "0");
        return `${yyyy}-${mm}-${dd}`;
    };

    const [colors, setColors] = useState(
        phone?.colors
            ? phone.colors.map((c) =>
                typeof c === "string" ? { name: c, hex: "#000000" } : c
            )
            : [{ name: "", hex: "#000000" }]
    );
    const [price, setPrice] = useState(phone?.price || "");
    const [releaseDate, setReleaseDate] = useState(formatDateForInput(phone?.release_date));
    const [categoryId, setCategoryId] = useState(phone?.category_id || "");
    const [specs, setSpecs] = useState(phone?.specs || "");
    const [categories, setCategories] = useState([]);
    const [images, setImages] = useState(
        phone?.images?.map((img) => ({ id: img.id, url: img.url })) || []
    );


    useEffect(() => {
        const fetchCategories = async () => {
            try {
                const data = await getCategories();
                setCategories(data);
            } catch (error) {
                console.error(error);
            }
        };
        fetchCategories();
    }, []);

    const handleFilesChange = async (e) => {
        const files = Array.from(e.target.files);
        for (let file of files) {
            try {
                const res = await uploadImage(file);
                setImages((prev) => [
                    ...prev,
                    { id: Date.now() + Math.random(), url: res.url },
                ]);
            } catch (err) {
                console.error(err);
                MySwal.fire("ผิดพลาด", "อัปโหลดรูปไม่สำเร็จ", "error");
            }
        }
        e.target.value = null;
    };

    const handleRemove = async (img) => {
        if (img.id && img.id < 100000) {
            try {
                await deleteImage(img.id);
            } catch (err) {
                console.error(err);
                MySwal.fire("ผิดพลาด", "ลบรูปไม่สำเร็จ", "error");
                return;
            }
        }
        setImages((prev) => prev.filter((i) => i.id !== img.id));
    };

    const handleOnDragEnd = (result) => {
        if (!result.destination) return;
        const reordered = Array.from(images);
        const [moved] = reordered.splice(result.source.index, 1);
        reordered.splice(result.destination.index, 0, moved);
        setImages(reordered);
    };

    const handleAddColor = () =>
        setColors([...colors, { name: "", hex: "#000000" }]);

    const handleRemoveColor = (index) => {
        const newColors = colors.filter((_, i) => i !== index);
        setColors(newColors);
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!model) {
            return MySwal.fire(
                "แจ้งเตือน",
                "กรุณากรอกชื่อรุ่นโทรศัพท์",
                "warning"
            );
        }

        const mainImageUrl = images.length ? images[0].url : null;

        const formData = {
            model,
            summary: JSON.stringify(summary),
            colors: colors.map((c) => ({
                name: c.name,
                hex: c.hex,
            })),
            price: price ? parseInt(price) : null,
            release_date: releaseDate || null,
            category_id: categoryId || null,
            specs,
            main_image_url: mainImageUrl,
            images: images.map((img) => ({ url: img.url })),
        };

        try {
            if (phone?.id) {
                await updatePhone(phone.id, formData);
                MySwal.fire("สำเร็จ", "แก้ไขข้อมูลโทรศัพท์เรียบร้อย", "success");
            } else {
                await createPhone(formData);
                MySwal.fire("สำเร็จ", "เพิ่มโทรศัพท์เรียบร้อย", "success");
            }

            onSaved();
        } catch (error) {
            console.error(error);
            MySwal.fire("ผิดพลาด", "เกิดข้อผิดพลาดในการบันทึกข้อมูล", "error");
        }
    };


    return (
        <div className="card p-3 border-0 shadow-sm">
            <form onSubmit={handleSubmit} className="row g-3">
                {/* รูปภาพ */}
                <div className="col-12">
                    <label className="form-label fw-semibold">รูปภาพโทรศัพท์</label>
                    <div className="border rounded p-3 bg-light">
                        <input
                            type="file"
                            accept="image/*"
                            multiple
                            onChange={handleFilesChange}
                            className="form-control mb-3"
                        />
                        <DragDropContext onDragEnd={handleOnDragEnd}>
                            <Droppable droppableId="images" direction="horizontal">
                                {(provided) => (
                                    <div
                                        className="d-flex"
                                        style={{ overflowX: "auto", gap: "10px", padding: "10px" }}
                                        {...provided.droppableProps}
                                        ref={provided.innerRef}
                                    >
                                        {images.map((img, index) => (
                                            <Draggable
                                                key={img.id}
                                                draggableId={String(img.id)}
                                                index={index}
                                            >
                                                {(provided) => (
                                                    <div
                                                        ref={provided.innerRef}
                                                        {...provided.draggableProps}
                                                        {...provided.dragHandleProps}
                                                        style={{
                                                            userSelect: "none",
                                                            position: "relative",
                                                            ...provided.draggableProps.style,
                                                        }}
                                                    >
                                                        <img
                                                            src={img.url}
                                                            alt={`รูป-${index}`}
                                                            style={{
                                                                width: "150px",
                                                                height: "150px",
                                                                objectFit: "cover",
                                                                border:
                                                                    index === 0
                                                                        ? "3px solid #4e86da"
                                                                        : "2px solid #ddd",
                                                                borderRadius: "8px",
                                                            }}
                                                        />
                                                        <button
                                                            type="button"
                                                            onClick={() => handleRemove(img)}
                                                            className="btn btn-danger btn-sm position-absolute top-0 end-0 m-1"
                                                        >
                                                            ✕
                                                        </button>
                                                        {index === 0 && (
                                                            <span
                                                                className="badge bg-primary text-white position-absolute bottom-0 start-0 m-1"
                                                                style={{ fontSize: "0.8rem" }}
                                                            >
                                                                รูปหลัก
                                                            </span>
                                                        )}
                                                    </div>
                                                )}
                                            </Draggable>
                                        ))}
                                        {provided.placeholder}
                                    </div>
                                )}
                            </Droppable>
                        </DragDropContext>
                    </div>
                </div>

                {/* รุ่น / แบรนด์ */}
                <div className="col-md-6">
                    <label className="form-label fw-semibold">ชื่อรุ่น</label>
                    <input
                        type="text"
                        className="form-control"
                        value={model}
                        onChange={(e) => setModel(e.target.value)}
                        placeholder="กรุณากรอกชื่อรุ่น"
                        required
                    />
                </div>
                <div className="col-md-6">
                    <label className="form-label fw-semibold">แบรนด์</label>
                    <select
                        className="form-select"
                        value={categoryId || ""}
                        onChange={(e) => setCategoryId(e.target.value)}
                        required
                    >
                        <option value="">-- เลือกแบรนด์ --</option>
                        {categories.map((cat) => (
                            <option key={cat.id} value={cat.id}>
                                {cat.name}
                            </option>
                        ))}
                    </select>
                </div>

                {/* Summary (ช่อง input ปกติ) */}
                <div className="col-12">
                    {/* <label className="form-label fw-semibold">
                        คำอธิบายสั้น (Summary)
                    </label> */}
                    {/* Summary (ช่อง input ปกติ) */}
                    <div className="col-12">
                        {/* Card สำหรับสเปกหลัก */}
                        <div className="card border-1 bg-light mb-3">
                            <div className="card-body">
                                <h5 className="fw-bold mb-3">ข้อมูลสเปกหลัก</h5>
                                <div className="row g-3">
                                    {[
                                        { key: "screen", label: "ขนาดหน้าจอ", icon: <HiOutlineDevicePhoneMobile size={20} className="text-primary me-2" /> },
                                        { key: "camera", label: "กล้อง", icon: <IoIosAperture size={20} className="text-primary me-2" /> },
                                        { key: "cpu", label: "ชิป (CPU)", icon: <HiMiniCpuChip size={20} className="text-primary me-2" /> },
                                        { key: "memory", label: "หน่วยความจำ", icon: <RiRam2Line size={20} className="text-primary me-2" /> },
                                        { key: "battery", label: "ความจุแบตเตอรี่", icon: <IoIosBatteryFull size={20} className="text-primary me-2" /> },
                                        { key: "os", label: "ระบบปฏิบัติการ", icon: <h6 className="text-primary fw-bold mb-0 me-2">OS</h6> },
                                    ].map((item) => (
                                        <div className="col-md-6" key={item.key}>
                                            <label className="form-label fw-semibold d-flex align-items-center">
                                                {item.icon}
                                                {item.label}
                                            </label>
                                            <input
                                                type="text"
                                                className="form-control"
                                                value={summary[item.key]}
                                                onChange={(e) =>
                                                    setSummary((prev) => ({
                                                        ...prev,
                                                        [item.key]: e.target.value,
                                                    }))
                                                }
                                                placeholder={`กรุณากรอก${item.label}`}
                                                required
                                            />
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    </div>

                    {/* ช่อง ขนาดเครื่อง และ น้ำหนัก แยกอยู่นอก card */}
                    <div className="col-12">
                        <div className="row g-3 mt-2">
                            <div className="col-md-6">
                                <label className="form-label fw-semibold d-flex align-items-center">
                                    ขนาดเครื่อง
                                </label>
                                <input
                                    type="text"
                                    className="form-control"
                                    value={summary.dimensions}
                                    onChange={(e) =>
                                        setSummary((prev) => ({
                                            ...prev,
                                            dimensions: e.target.value,
                                        }))
                                    }
                                    placeholder="กรุณากรอกขนาดเครื่อง"
                                    required
                                />
                            </div>

                            <div className="col-md-6">
                                <label className="form-label fw-semibold d-flex align-items-center">
                                    น้ำหนัก
                                </label>
                                <input
                                    type="text"
                                    className="form-control"
                                    value={summary.weight}
                                    onChange={(e) =>
                                        setSummary((prev) => ({
                                            ...prev,
                                            weight: e.target.value,
                                        }))
                                    }
                                    placeholder="กรุณากรอกน้ำหนัก"
                                    required
                                />
                            </div>
                        </div>
                    </div>

                </div>

                {/* สี */}
                <div className="col-12">
                    <label className="form-label fw-semibold">
                        สี (สามารถเพิ่มหลายสีได้)
                    </label>
                    {colors.map((color, index) => (
                        <div className="input-group mb-2 align-items-center" key={index}>
                            <input
                                type="color"
                                className="form-control form-control-color me-2"
                                value={color.hex}
                                onChange={(e) => {
                                    const newColors = [...colors];
                                    newColors[index].hex = e.target.value;
                                    setColors(newColors);
                                }}
                                title="เลือกสี"
                                style={{ width: "60px", cursor: "pointer" }}
                            />
                            <input
                                type="text"
                                className="form-control"
                                placeholder="ชื่อสี เช่น Blue, Orange, Silver"
                                value={color.name}
                                onChange={(e) => {
                                    const newColors = [...colors];
                                    newColors[index].name = e.target.value;
                                    setColors(newColors);
                                }}
                            />
                            <button
                                type="button"
                                className="btn btn-outline-danger"
                                onClick={() => handleRemoveColor(index)}
                            >
                                ✕
                            </button>
                        </div>
                    ))}
                    <button
                        type="button"
                        className="btn btn-outline-primary mt-2"
                        onClick={handleAddColor}
                    >
                        + เพิ่มสี
                    </button>

                    {/* Preview สี */}
                    <div className="d-flex flex-wrap gap-2 mt-3">
                        {colors.map(
                            (c, i) =>
                                c.name && (
                                    <div
                                        key={i}
                                        className="d-flex align-items-center"
                                        style={{
                                            gap: "8px",
                                            border: "1px solid #ddd",
                                            borderRadius: "8px",
                                            padding: "5px 10px",
                                            background: "#f9f9f9",
                                        }}
                                    >
                                        <div
                                            style={{
                                                width: "20px",
                                                height: "20px",
                                                backgroundColor: c.hex,
                                                border: "1px solid #ccc",
                                                borderRadius: "50%",
                                            }}
                                        ></div>
                                        <span>{c.name}</span>
                                    </div>
                                )
                        )}
                    </div>
                </div>

                {/* ราคา / วันที่ */}
                <div className="col-md-6">
                    <label className="form-label fw-semibold">ราคา (บาท)</label>
                    <input
                        type="number"
                        className="form-control"
                        value={price}
                        onChange={(e) => setPrice(e.target.value)}
                        placeholder="ใส่ราคาเป็นตัวเลขเท่านั้น"
                    />
                </div>
                <div className="col-md-6">
                    <label className="form-label fw-semibold">วันที่วางจำหน่าย</label>
                    <input
                        type="date"
                        className="form-control"
                        value={releaseDate}
                        onChange={(e) => setReleaseDate(e.target.value)}
                    />

                </div>

                {/* รายละเอียด (Specs) */}
                <div className="col-12">
                    <label className="form-label fw-semibold">รายละเอียด (Specs)</label>
                    <ReactQuill
                        theme="snow"
                        value={specs}
                        onChange={setSpecs}
                        className="rounded quill-editor"
                        modules={{
                            toolbar: [
                                ["bold", "italic", "underline", "strike"],
                                [{ list: "ordered" }, { list: "bullet" }],
                                ["link", "image"],
                                ["clean"],
                            ],
                        }}
                        formats={[
                            "bold",
                            "italic",
                            "underline",
                            "strike",
                            "list",
                            "bullet",
                            "link",
                            "image",
                        ]}
                    />
                </div>

                {/* ปุ่ม */}
                <div className="col-12 d-flex justify-content-end gap-2 mt-4">
                    <button type="submit" className="btn btn-primary px-4">
                        {phone?.id ? "บันทึกการแก้ไข" : "เพิ่มโทรศัพท์"}
                    </button>
                    {onCancel && (
                        <button
                            type="button"
                            className="btn btn-outline-secondary px-4"
                            onClick={onCancel}
                        >
                            ยกเลิก
                        </button>
                    )}
                </div>
            </form>
        </div>
    );
};

export default PhoneForm;
