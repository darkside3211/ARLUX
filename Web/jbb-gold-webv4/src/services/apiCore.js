import axios from "axios";

// Create an Axios instance
const api = axios.create({
  baseURL: "https://jbb-back-end-m6mv.onrender.com/api",
  timeout: 10000,
});

export default api;
