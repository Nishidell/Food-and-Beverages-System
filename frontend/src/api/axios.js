import axios from "axios";

const BASE_URL = import.meta.env.VITE_API_URL || "http://localhost:21917";

const api = axios.create({
    baseURL: BASE_URL,
});

export default api;