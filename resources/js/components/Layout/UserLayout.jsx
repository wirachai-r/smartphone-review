import React from "react";
import UserNavbar from "./UserNavbar";
import { Outlet } from "react-router-dom";
import "./user.css";

const UserLayout = () => (
  <>
    <UserNavbar />
    <div className="container mt-4">
      <Outlet />
    </div>
  </>
);

export default UserLayout;
