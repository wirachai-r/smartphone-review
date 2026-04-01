import React from "react";
import PhoneForm from "./PhoneForm";
import { useNavigate } from "react-router-dom";

const AddPhone = () => {
    const navigate = useNavigate();

    return (
        <div>
            <h2 className="mb-4">เพิ่มโทรศัพท์ใหม่</h2>
            <div className="card">
                <PhoneForm
                    onSaved={() => navigate("/admin/phones")}
                    onCancel={() => navigate("/admin/phones")}
                />
            </div>
        </div>
    );
};

export default AddPhone;
