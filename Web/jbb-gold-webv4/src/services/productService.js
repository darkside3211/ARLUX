import api from "@/services/apiCore";

export const productService = {
  async getAllProducts() {
    try {
      const response = await api.get("/products");
      return response.data;
    } catch (error) {
      console.error("Error Fetching All Products:", error);
      throw error;
    }
  },

  formatPrice(price) {
    const number = Number(price);
    return isNaN(number) ? "N/A" : `₱${number.toFixed(2)}`;
  },
};
