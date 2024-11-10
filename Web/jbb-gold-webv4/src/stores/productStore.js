import { productService } from "@/services/productService";
import { defineStore } from "pinia";

export const useProductStore = defineStore("productStore", {
  state: () => ({
    products: [], // Array to store all products
    currentProduct: null, // Currently selected/viewed product
    error: null, // Store error messages
    loading: false, // Loading state indicator
    searchQuery: "", // Current search query
    searchResults: [], // Array to store search results
    searchLoading: false, // Search operation loading state
    searchError: null, // Search-specific error messages
  }),
  actions: {
    async fetchAllProducts() {
      this.loading = true;
      this.error = null;

      try {
        const result = await productService.getAllProducts();
        this.products = result;
      } catch (error) {
        this.error = error.message;
      } finally {
        this.loading = false;
      }
    },
  },
});
