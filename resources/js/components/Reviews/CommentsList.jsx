import React, { useEffect, useState } from "react";
import { getComments, addComment, updateComment, deleteComment } from "../../services/comments";
import { Button, Form, InputGroup } from "react-bootstrap";
import { FaEdit, FaTrash, FaSave, FaTimes } from "react-icons/fa";
import Swal from "sweetalert2";

const CommentsList = ({ reviewId, currentUser }) => {
  const [comments, setComments] = useState([]);
  const [newComment, setNewComment] = useState("");
  const [loading, setLoading] = useState(false);
  const [editingId, setEditingId] = useState(null);
  const [editingText, setEditingText] = useState("");

  const fetchComments = async () => {
    try {
      const data = await getComments(reviewId);
      setComments(data);
    } catch (error) {
      console.error(error);
    }
  };

  const handleAddComment = async (e) => {
    e.preventDefault();
    if (!newComment.trim()) return;
    setLoading(true);
    try {
      await addComment(reviewId, { body: newComment });
      setNewComment("");
      fetchComments();
    } catch (error) {
      console.error(error);
    }
    setLoading(false);
  };

  const handleEditComment = (comment) => {
    setEditingId(comment.id);
    setEditingText(comment.body);
  };

  const handleUpdateComment = async (id) => {
    if (!editingText.trim()) return;
    setLoading(true);
    try {
      await updateComment(id, { body: editingText });
      setEditingId(null);
      setEditingText("");
      fetchComments();
    } catch (error) {
      console.error(error);
    }
    setLoading(false);
  };

  const handleDeleteComment = async (id) => {
    const result = await Swal.fire({
      title: "คุณแน่ใจหรือไม่?",
      text: "การลบความคิดเห็นนี้จะไม่สามารถกู้คืนได้!",
      icon: "warning",
      showCancelButton: true,
      confirmButtonColor: "#d33",
      cancelButtonColor: "#3085d6",
      confirmButtonText: "ลบ",
      cancelButtonText: "ยกเลิก",
    });

    if (result.isConfirmed) {
      try {
        await deleteComment(id);
        fetchComments();
        Swal.fire("ลบแล้ว!", "ความคิดเห็นถูกลบเรียบร้อยแล้ว", "success");
      } catch (error) {
        console.error(error);
        Swal.fire("เกิดข้อผิดพลาด", "ไม่สามารถลบความคิดเห็นได้", "error");
      }
    }
  };

  useEffect(() => {
    fetchComments();
  }, [reviewId]);

  return (
    <div className="mt-3 ps-3 border-start">
      {comments.map((c) => (
        <div
          key={c.id}
          className="mb-2 d-flex justify-content-between align-items-center"
        >
          <div className="d-flex align-items-center gap-2 w-100 m-1">
            <div className="fw-bold">{c.user.name}:</div>
            {editingId === c.id ? (
              <InputGroup size="sm">
                <Form.Control
                  value={editingText}
                  onChange={(e) => setEditingText(e.target.value)}
                />
              </InputGroup>
            ) : (
              <div>{c.body}</div>
            )}
          </div>

          {currentUser?.id === c.user_id && (
            <div className="d-flex gap-1">
              {editingId === c.id ? (
                <>
                  <Button
                    size="sm"
                    variant="success"
                    onClick={() => handleUpdateComment(c.id)}
                    title="บันทึก"
                  >
                    <FaSave />
                  </Button>
                  <Button
                    size="sm"
                    variant="secondary"
                    onClick={() => setEditingId(null)}
                    title="ยกเลิก"
                  >
                    <FaTimes />
                  </Button>
                </>
              ) : (
                <>
                  <Button
                    size="sm"
                    variant="warning"
                    onClick={() => handleEditComment(c)}
                    title="แก้ไข"
                  >
                    <FaEdit />
                  </Button>
                  <Button
                    size="sm"
                    variant="danger"
                    onClick={() => handleDeleteComment(c.id)}
                    title="ลบ"
                  >
                    <FaTrash />
                  </Button>
                </>
              )}
            </div>
          )}
        </div>
      ))}

      {currentUser && (
        <Form onSubmit={handleAddComment} className="mt-2">
          <Form.Group className="mb-2">
            <Form.Control
              type="text"
              placeholder="เพิ่มความคิดเห็น..."
              value={newComment}
              onChange={(e) => setNewComment(e.target.value)}
            />
          </Form.Group>
          <Button type="submit" size="sm" disabled={loading}>
            {loading ? "กำลังโพสต์..." : "โพสต์ความคิดเห็น"}
          </Button>
        </Form>
      )}
    </div>
  );
};

export default CommentsList;
