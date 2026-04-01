import React from "react";
import { Routes, Route } from "react-router-dom";
import UserLayout from "./Layout/UserLayout";
import AdminLayout from "./Layout/AdminLayout";
import Home from "./Home";
import PhonesList from "./Phones/PhonesList";
import PhoneDetail from "./Phones/PhoneDetail";
import Login from "./Auth/Login";
import Register from "./Auth/Register";
import Profile from "./Auth/Profile";
import ProtectedRoute from "./ProtectedRoute";
import ProtectedAdminRoute from "./ProtectedAdminRoute";
import AdminDashboard from "./Admin/AdminDashboard";
import ManagePhones from "./Admin/ManagePhones";
import ManageCategories from "./Admin/ManageCategories";
import ManageUsers from "./Admin/ManageUsers";
import ManageReviews from "./Admin/ManageReviews";
import AddPhone from "./Admin/ManagePhones/AddPhone";
import EditPhone from "./Admin/ManagePhones/EditPhone";

const App = () => (
    <Routes>
        {/* User routes */}
        <Route element={<UserLayout />}>
            <Route path="/" element={<Home />} />
            <Route path="/phones" element={<PhonesList />} />
            <Route path="/phones/:id" element={<PhoneDetail />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/profile" element={<ProtectedRoute><Profile /></ProtectedRoute>} />
        </Route>

        {/* Admin routes */}
        <Route path="/admin/*" element={<ProtectedAdminRoute><AdminLayout /></ProtectedAdminRoute>}>
            <Route index element={<AdminDashboard />} />
            <Route path="phones" element={<ManagePhones />} />
            <Route path="phones/add" element={<AddPhone />} />
            <Route path="phones/edit/:id" element={<EditPhone />} />
            <Route path="categories" element={<ManageCategories />} />
            <Route path="users" element={<ManageUsers />} />
            <Route path="reviews" element={<ManageReviews />} />
        </Route>
    </Routes>
);

export default App;
