import { defineStore } from "pinia";
import { ref, computed } from "vue";
import { adminService } from "@/services/adminService";
import api from "@/services/apiCore";
import { getAuth, getIdToken } from "firebase/auth";

export const useCartStore = defineStore("cartStore", {
  state: () => ({
    carts: [],
    loading: false,
    error: null,
  }),
  actions: {
    async addToCart(productId, quantity, size) {
      this.loading = true;
      this.error = null;
      try {
        const params = {
          productId: productId,
          quantity: parseInt(quantity),
          size: size,
        };
        const auth = getAuth();
        const idTokenResult = await getIdToken(auth.currentUser);
        const response = await api.post("/users/auth/cart", params, {
          headers: {
            Authorization: `Bearer ${idTokenResult}`,
            "Content-Type": "application/json",
          },
        });

        if (response.status === 200) {
          this.getCartItems();
          return true;
        } else {
          return response.data.message;
        }
      } catch (error) {
        this.error = error;
        throw error;
      } finally {
        this.loading = false;
      }
    },

    async getCartItems() {
      this.loading = true;
      this.error = null;
      try {
        const auth = getAuth();
        const idTokenResult = await getIdToken(auth.currentUser);
        const response = await api.get("/users/auth/cart", {
          headers: {
            Authorization: `Bearer ${idTokenResult}`,
            "Content-Type": "application/json",
          },
        });

        if (response.status === 200) {
          this.carts = response.data;
        } else {
          throw new Error(response.data.message);
        }
      } catch (error) {
        this.error = error;
        throw error;
      } finally {
        this.loading = false;
      }
    },
  },
});
