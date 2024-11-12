import { defineStore } from "pinia";

export const useAdminConfigStore = defineStore('adminConfig', {
    state: () => ({
        lowStockThreshold: 10,
        refreshInterval: 60000,
    }),
    actions: {
        setLowStockThreshold(newThreshold) {
            this.lowStockThreshold = newThreshold;
        }
    }
});