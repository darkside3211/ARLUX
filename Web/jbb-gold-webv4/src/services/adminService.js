import api from "@/services/apiCore";

export const adminService = {
  async getAnalytics() {
    try {
      const response = await api.get("/analytics/weekly");
      return response.data;
    } catch (error) {
      console.error("unable to get analytics: ", error);
      throw error;
    }
  },

  async getAllUsers() {
    try {
      const response = await api.get("/users");
      console.log(response.data);
      return response.data;
    } catch (error) {
      console.error("unable to get users: ", error);
      throw error;
    }
  },

  async getAllOrders(startDate, endDate) {
    try {
      let response;

      if (startDate && endDate) {
        response = await api.get(
          "/orders",
          { startDate, endDate },
          {
            headers: {
              "Content-type": "application/json",
            },
          }
        );
      } else {
        response = await api.get("/orders");
      }

      return response.data;
    } catch (error) {
      console.error("unable to get orders: ", error);
      throw error;
    }
  },

  async modifyOrder(newOrder) {
    try {
      const response = await api.put("/orders/status", newOrder, {
        headers: {
          "Content-Type": "application/json",
        },
      });

      return response.data;
    } catch (error) {
      console.error("unable to modify order: ", error);
      throw error;
    }
  },

  async addNewProduct(newProduct) {
    try {
      const response = await api.post("/products", newProduct, {
        headers: {
          'Content-Type': 'multipart/form-data'
        }
      });

      return response;
    } catch (error) {
      console.error("unable to add product:", error.message);
      throw error;
    }
  },

  async editProduct(productId, formData) {
    try {
      const response = await api.put(`/products/${productId}`, formData, {
        headers: {
          "Content-Type": "application/json",
        },
      });
      return response.data;
    } catch (error) {
      console.error("unable to update product: ", error);
      throw error;
    }
  },
};
