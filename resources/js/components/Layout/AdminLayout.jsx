import React from "react";
import AdminNavbar from "./AdminNavbar";
import { Outlet } from "react-router-dom";
import "./admin.css";

const AdminLayout = () => (
  <div className="container-fluid p-0">
    <AdminNavbar />
    <main className="main-content">
      <Outlet />
    </main>
  </div>
);

export default AdminLayout;
