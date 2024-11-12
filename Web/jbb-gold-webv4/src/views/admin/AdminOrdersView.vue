<template>
    <v-container>
        <div class="d-flex align-center justify-center text-h3 font-weight-bold ma-4">ORDERS</div>
        <v-row>
            <v-col lg="6" md="12">
                <v-card :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="orange"
                    :loading="orderStore.loading" :disabled="orderStore.loading">
                    <v-card-title>
                        To Ship

                        <v-container>
                            <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                                :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                                single-line></v-text-field>
                        </v-container>

                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString('en-US', dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <OrdersTable :search-query="searchQuery" :orders="orderStore.toShipOrders" :height="360"
                            :items-per-page="10" />
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
            <v-col lg="6" md="6">
                <v-card :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="grey-lighten-1"
                    :loading="orderStore.loading" :disabled="orderStore.loading">
                    <v-card-title>
                        To Receive
                        <v-container>
                            <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                                :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                                single-line></v-text-field>
                        </v-container>

                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString('en-US', dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <OrdersTable :search-query="searchQuery" :orders="orderStore.toReceiveOrders" :height="360"
                            :items-per-page="10" />
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
        <v-row>
            <v-col lg="6" md="6">
                <v-card :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="blue"
                    :loading="orderStore.loading" :disabled="orderStore.loading">
                    <v-card-title>
                        To Pay

                        <v-container>
                            <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                                :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                                single-line></v-text-field>
                        </v-container>

                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString('en-US', dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <OrdersTable :search-query="searchQuery" :orders="orderStore.toPayOrders" :height="256"
                            :items-per-page="5" />
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
            <v-col lg="6" md="6">
                <v-card :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="green"
                    :loading="orderStore.loading" :disabled="orderStore.loading">
                    <v-card-title>
                        Completed
                        <v-container>
                            <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                                :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                                single-line></v-text-field>
                        </v-container>

                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString('en-US', dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <OrdersTable :search-query="searchQuery" :orders="orderStore.completedOrders" :height="256"
                            :items-per-page="5" />
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
        <v-card class="mx-2 my-2" variant="tonal" color="green-lighten-1" :loading="orderStore.loading"
            :disabled="orderStore.loading">
            <v-card-title>
                Order History

                <v-container>
                    <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                        :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                        single-line></v-text-field>
                </v-container>

            </v-card-title>
            <v-card-subtitle>As of {{ date.toLocaleString('en-US', dateOptions) }}</v-card-subtitle>
            <v-card-text>
                <OrdersTable :search-query="searchQuery" :orders="orderStore.orders" :height="360"
                    :items-per-page="10" />
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
import OrdersTable from '@/components/admin/orders/OrdersTable.vue';
import { ref, onMounted, onUnmounted } from 'vue';
import { useOrderStore } from '@/stores/orderStore';
import { useAdminConfigStore } from '@/stores/adminConfigStore';
import { useGlobalStore } from '@/stores/globalStore';

const searchQuery = ref('');
const orderStore = useOrderStore();
const adminConfigStore = useAdminConfigStore();
const globalStore = useGlobalStore();

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
    orderStore.getAllOrders();
    refreshID = setInterval(() => {
        date.value = new Date();
        orderStore.getAllOrders();
    }, adminConfigStore.refreshInterval);
});

onUnmounted(() => {
    clearInterval(refreshID);
});

const refreshProductTable = () => {
    date.value = new Date();
    orderStore.getAllOrders();
}
</script>