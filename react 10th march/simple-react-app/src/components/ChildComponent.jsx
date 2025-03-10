import React from "react";

function ChildComponent({ data }) {
  return (
    <div className="child-component">
      <h3>Data taken from Parent:</h3>
      {Array.isArray(data) ? (
        data.map((item, index) => (
          <div key={index}>
            <h4>{item.course}</h4>
            <p>
              <strong>What I Learnt:</strong> {item.description}
            </p>
            <p>
              <strong>Doubts:</strong> {item.doubts}
            </p>
          </div>
        ))
      ) : (
        <p>No data available</p>
      )}
    </div>
  );
}

export default ChildComponent;
