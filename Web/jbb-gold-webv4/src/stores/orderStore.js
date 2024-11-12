import { defineStore } from "pinia";
import { ref, computed } from "vue";
import { adminService } from "@/services/adminService";
import api from "@/services/apiCore";
import { getAuth, getIdToken } from "firebase/auth";

export const useOrderStore = defineStore("orderStore", () => {
  //States
  const orders = ref([]);
  const loading = ref(false);
  const error = ref(null);
  const toPayOrders = computed(() => {
    return orders.value.filter((item) => item.orderStatus === "toPay");
  });
  const toShipOrders = computed(() => {
    return orders.value.filter((item) => item.orderStatus === "toShip");
  });
  const toReceiveOrders = computed(() => {
    return orders.value.filter((item) => item.orderStatus === "toReceive");
  });
  const completedOrders = computed(() => {
    return orders.value.filter((item) => item.orderStatus === "Completed");
  });
  const failedOrders = computed(() => {
    return orders.value.filter((item) => item.orderStatus === "failed");
  });

  async function getAllOrders(startDate, endDate) {
    loading.value = true;
    error.value = null;
    try {
      const response = await adminService.getAllOrders(startDate, endDate);
      orders.value = response;
    } catch (error) {
      error.value = error;
    } finally {
      loading.value = false;
    }
  }

  async function modifyOrder(newOrder) {
    loading.value = true;
    error.value = null;
    try {
      const response = await adminService.modifyOrder(newOrder);
      await getAllOrders();
    } catch (error) {
      console.error("unable to modify order: ", error);
      throw error;
    } finally {
      loading.value = false;
    }
  }

  async function getUserOrders() {
    loading.value = true;
    error.value = null;

    try {
      const auth = getAuth();
      const idTokenResult = await getIdToken(auth.currentUser);
      const response = await api.get("/users/auth/orders", {
        headers: {
          Authorization: `Bearer ${idTokenResult}`,
          "Content-Type": "application/json",
        },
      });

      if (response.status === 200) {
        orders.value = response.data;
      }
    } catch (err) {
      console.error("Failed to fetch user orders: ", error);
      error.value = err.message;
    } finally {
      loading.value = false;
    }
  }

  return {
    orders,
    loading,
    error,
    toPayOrders,
    toShipOrders,
    toReceiveOrders,
    completedOrders,
    failedOrders,
    //actions
    getAllOrders,
    getUserOrders,
    modifyOrder,
  };
});
