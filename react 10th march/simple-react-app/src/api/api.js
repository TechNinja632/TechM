import axios from "axios";
import MockAdapter from "axios-mock-adapter";

let data = [
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

const mock = new MockAdapter(axios, { delayResponse: 1000 });

mock.onGet("/data").reply(200, { data });

mock.onPost("/data").reply((config) => {
  const newEntry = JSON.parse(config.data);
  data.push(newEntry);
  return [200, { data }];
});

export const fetchData = async () => {
  const response = await axios.get("/data");
  return response;
};

export const addData = async (newEntry) => {
  const response = await axios.post("/data", newEntry);
  return response;
};
