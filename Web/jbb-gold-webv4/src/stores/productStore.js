import { productService } from "@/services/productService";
import { defineStore } from "pinia";
import { useAdminConfigStore } from "./adminConfigStore";
import { adminService } from "@/services/adminService";

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
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
    async editProduct(productItem) {
      this.loading = true;
      this.error = null;
      try {
        await adminService.editProduct(productItem);
        await this.fetchAllProducts();
      } catch (error) {
        this.error = error;
      } finally {
        this.loading = false;
      }
    },
    async setSelectedProduct(product) {
      this.currentProduct = product;
    }
  },
  getters: {
    currentProducts: (state) =>
      state.products.filter((item) => item.stockCount > 0),
    outOfStock: (state) =>
      state.products.filter((item) => item.stockCount <= 0),
    lowStock: (state) =>
      state.products.filter(
        (item) =>
          item.stockCount <= useAdminConfigStore().lowStockThreshold &&
          item.stockCount !== 0
      ),
    popularProducts: (state) =>
      state.products.filter((item) => item.soldCount > 0),
  },
});
