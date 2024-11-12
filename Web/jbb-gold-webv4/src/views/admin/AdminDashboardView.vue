<template>
    <v-container>
        <div class="d-flex align-center justify-center text-h3 font-weight-bold ma-4">DASHBOARD</div>
        <SiteAnalysis class="mb-4" />
        <div class="my-4">
            <PopularProducts v-if="productStore.popularProducts.length !== 0"
                :products="productStore.popularProducts" />
        </div>

        <v-row>
            <v-col cols="6" xs="12">
                <v-card :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="blue-lighten-1"
                    :loading="orderStore.loading" :disabled="orderStore.loading">
                    <v-card-title>
                        <router-link to="/admin/orders" class="text-blue">Orders</router-link>
                        <v-container>
                            <v-text-field density="comfortable" v-model="orderSearch" label="Search"
                                prepend-inner-icon="mdi-magnify"
                                :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                                single-line></v-text-field>
                        </v-container>

                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString('en-US', dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <OrdersTable :search-query="orderSearch" :orders="orderStore.orders" :items-per-page="10" />
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer />
                        <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'"
                            @click="refreshProductTable">
                            <v-icon>mdi-refresh</v-icon>
                            Refresh
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
            <v-col cols="6" xs="12">
                <v-card :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="green-lighten-1"
                    :loading="productStore.loading" :disabled="productStore.loading">
                    <v-card-title>
                        <router-link to="/admin/stock" class="text-green">Stock</router-link>
                        <v-container>
                            <v-text-field density="comfortable" v-model="stockSearch" label="Search"
                                prepend-inner-icon="mdi-magnify"
                                :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                                single-line></v-text-field>
                        </v-container>

                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString(undefined, dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <ProductTable :search-query="stockSearch" :products="productStore.products" />
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer />
                        <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'"
                            @click="refreshProductTable">
                            <v-icon>mdi-refresh</v-icon>
                            Refresh
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>

        <v-card class="my-4" :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="orange-lighten-1"
            :loading="productStore.loading" :disabled="productStore.loading">
            <v-card-title>
                <router-link to="/admin/accounts" class="text-orange">Users</router-link>
                <v-container>
                    <v-text-field density="comfortable" v-model="userSearch" label="Search"
                        prepend-inner-icon="mdi-magnify" :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'"
                        hide-details single-line></v-text-field>
                </v-container>

            </v-card-title>
            <v-card-subtitle>As of {{ date.toLocaleString(undefined, dateOptions) }}</v-card-subtitle>
            <v-card-text>
                <UsersTable :search-query="userSearch" :users="userStore" />
            </v-card-text>
            <v-card-actions>
                <v-spacer />
                <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" @click="refreshProductTable">
                    <v-icon>mdi-refresh</v-icon>
                    Refresh
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-container>
</template>

<script setup>
import PopularProducts from '@/components/PopularProducts.vue';
import ProductTable from '@/components/admin/stocks/ProductTable.vue';
import OrdersTable from '@/components/admin/orders/OrdersTable.vue';
import UsersTable from '@/components/admin/users/UsersTable.vue';
import SiteAnalysis from '@/components/admin/dashboard/SiteAnalysis.vue';
import { useProductStore } from '@/stores/productStore';
import { useOrderStore } from '@/stores/orderStore';
import { useAdminConfigStore } from '@/stores/adminConfigStore';
import { useGlobalStore } from '@/stores/globalStore';
import { onMounted, ref, onUnmounted } from 'vue';
import { adminService } from '@/services/adminService';

const orderSearch = ref('');
const stockSearch = ref('');
const userSearch = ref('');
const userStore = ref([]);
const globalStore = useGlobalStore();
const orderStore = useOrderStore();
const productStore = useProductStore();
const adminConfigStore = useAdminConfigStore();

let refreshID;

const date = ref(new Date());
const dateOptions = {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: 'numeric',
    minute: 'numeric',
    second: 'numeric'
};

onMounted(() => {
    refreshProductTable();
    refreshID = setInterval(() => {
        refreshProductTable();
    }, adminConfigStore.refreshInterval);
});

onUnmounted(() => {
    clearInterval(refreshID);
});

const refreshProductTable = () => {
    date.value = new Date();
    orderStore.getAllOrders();
    productStore.fetchAllProducts();
    adminService.getAllUsers().then((data) => userStore.value = data);
}
</script>