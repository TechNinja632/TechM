import React, { useState } from "react";
import ChildComponent from "./ChildComponent";
import { addData } from "../api/api";

const initialData = [
  {
    course: "Angular",
    description:
      "We learnt to build Single Page Applications (SPA) in Angular.",
    doubts:
      "Getting slapped with errors left and right but yeah fixed it finally should find out why.",
  },
  {
    course: "React",
    description: "Today, we're learning React.",
    doubts: "I'm not sure about the difference between Angular and React.",
  },
  {
    course: "Flutter",
    description: "Tomorrow, we'll learn Flutter.",
    doubts: "Couldn't understand the difference it would bring.",
  },
];

function ParentComponent() {
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const [formData, setFormData] = useState({
    subject: "",
    learnt: "",
    doubts: "",
  });
  const [data, setData] = useState(initialData);
  const [formError, setFormError] = useState("");

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!formData.subject || !formData.learnt || !formData.doubts) {
      setFormError("All fields are required.");
      return;
    }
    setFormError("");
    setLoading(true);
    try {
      const newEntry = {
        course: formData.subject,
        description: formData.learnt,
        doubts: formData.doubts,
      };
      const response = await addData(newEntry);
      console.log(response.data);
      setData(response.data.data);
      setLoading(false);
    } catch (error) {
      setError("Error updating data");
      setLoading(false);
    }
  };

  return (
    <div className="parent-component">
      <h2>Parent</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="subject" className="form-label">
            Subject
          </label>
          <input
            type="text"
            className={`form-control ${
              formError && !formData.subject ? "is-invalid" : ""
            }`}
            id="subject"
            name="subject"
            value={formData.subject}
            onChange={handleChange}
          />
        </div>
        <div className="mb-3">
          <label htmlFor="learnt" className="form-label">
            What I Learnt
          </label>
          <input
            type="text"
            className={`form-control ${
              formError && !formData.learnt ? "is-invalid" : ""
            }`}
            id="learnt"
            name="learnt"
            value={formData.learnt}
            onChange={handleChange}
          />
        </div>
        <div className="mb-3">
          <label htmlFor="doubts" className="form-label">
            Doubts
          </label>
          <input
            type="text"
            className={`form-control ${
              formError && !formData.doubts ? "is-invalid" : ""
            }`}
            id="doubts"
            name="doubts"
            value={formData.doubts}
            onChange={handleChange}
          />
        </div>
        {formError && <p className="text-danger">{formError}</p>}
        <button type="submit" className="btn btn-primary">
          Submit
        </button>
      </form>
      {loading ? (
        <p>Loading...</p>
      ) : error ? (
        <p>{error}</p>
      ) : (
        <ChildComponent data={data} />
      )}
    </div>
  );
}

export default ParentComponent;
