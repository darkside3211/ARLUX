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

  async getProductById(productId) {
    try {
      const response = await api.get(`/products/${productId}`);
      return response.data;
    } catch (error) {
      console.error("Error Fetching Product:", error);
      throw error;
    }
  },

  formatPrice(price) {
    const number = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'PHP'
    });
    return number.format(price);
  },
};
