import axios from "axios";

const baseURLs = [
  "https://jbb-back-end-m6mv.onrender.com/api",
  "http://localhost:8000/api"
]

// Create an Axios instance
const api = axios.create({
  baseURL: baseURLs[0],
});

export default api;
