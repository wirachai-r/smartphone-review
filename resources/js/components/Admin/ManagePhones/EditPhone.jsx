import React, { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import PhoneForm from "./PhoneForm";
import { getPhoneById } from "../../../services/phones";
import Swal from "sweetalert2";
import withReactContent from "sweetalert2-react-content";
import { deletePhone } from "../../../services/phones";
import { FaTrash } from "react-icons/fa";

const MySwal = withReactContent(Swal);

const EditPhone = () => {
    const { id } = useParams();
    const navigate = useNavigate();
    const [phone, setPhone] = useState(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchPhone = async () => {
            try {
                const data = await getPhoneById(id);
                setPhone(data);
            } catch (error) {
                console.error(error);
                MySwal.fire("Error", "ไม่พบโทรศัพท์", "error");
            }
            setLoading(false);
        };
        fetchPhone();
    }, [id]);

    if (loading) return <p className="p-3">กำลังโหลด...</p>;
    if (!phone) return null;

    return (
        <div>
            <h2 className="mb-4 fw-medium">แก้ไขโทรศัพท์</h2>
            <div className="card mb-5">
                <PhoneForm
                    phone={phone}
                    onSaved={() => navigate("/admin/phones")}
                    onCancel={() => navigate("/admin/phones")}
                />
            </div>

            <div className="text-center mt-5 mb-5 ">
                <button
                    className="btn d-flex align-items-center justify-content-center gap-2"
                    style={{
                        border: "2px dashed #d33",      // เส้นประสีแดง
                        backgroundColor: "#ffffff",     // สีพื้นอ่อน
                        color: "#721c24",               // สีตัวหนังสือเข้ม
                        width: "100%",
                        padding: "0.5rem 1rem",
                        borderRadius: "0.5rem",
                        transition: "all 0.2s",
                    }}
                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = "#f5c6cb"} // hover
                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = "#ffffff"}
                    onClick={async () => {
                        const result = await MySwal.fire({
                            title: "คุณแน่ใจหรือไม่?",
                            text: "การลบโทรศัพท์จะไม่สามารถกู้คืนได้!",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#d33",
                            cancelButtonColor: "#3085d6",
                            confirmButtonText: "ลบ",
                            cancelButtonText: "ยกเลิก",
                        });

                        if (result.isConfirmed) {
                            try {
                                await deletePhone(phone.id);
                                MySwal.fire("Deleted!", "ลบโทรศัพท์เรียบร้อย", "success");
                                navigate("/admin/phones");
                            } catch (error) {
                                console.error(error);
                                MySwal.fire("Error", "ไม่สามารถลบโทรศัพท์ได้", "error");
                            }
                        }
                    }}
                >
                    <FaTrash className="me-1" /> ลบโทรศัพท์
                </button>
            </div>


        </div>
    );
};

export default EditPhone;
