<template>
    <PageNotFound v-if="userStore.error" :message="userStore.error" />
    <v-container class="py-4" fluid>
        <!-- Profile Header -->
        <v-card class="mx-auto mb-4">
            <v-card-title>
                <v-avatar size="50" class="mr-3" :image="userAvatar">
                </v-avatar>
                {{ userInfo.username ?? userInfo.email }}
                <router-link v-if="userStore.isAdmin" to="/admin">
                    <strong class="font-italic text-subtitle-1">Administrator</strong>
                </router-link>

            </v-card-title>
            <v-card-subtitle>
                Cart Items: <strong>{{ cartItems }}</strong> | Orders: <strong>{{ orderStore.orders.length }}</strong>
            </v-card-subtitle>
            <v-card-actions>
                <v-btn class="text-amber-darken-3" variant="outlined">
                    Edit Profile
                </v-btn>
            </v-card-actions>
        </v-card>

        <!-- My Purchases Section -->
        <v-card :loading="orderStore.loading" class="mb-4" outlined>
            <v-card-title class="subtitle-1 font-weight-bold">My Purchases</v-card-title>
            <v-divider></v-divider>
            <v-row class="pa-4" justify="space-around">
                <v-col cols="2" class="text-center">
                    <v-badge color="amber" overlap :content="orderStore.orders.length" class="mb-2">
                        <v-btn icon variant="tonal" @click="selectedOrders = orderStore.orders">
                            <v-icon size="24">mdi-view-grid</v-icon>
                        </v-btn>
                    </v-badge>
                    <div>All</div>
                </v-col>
                <v-col cols="2" class="text-center">
                    <v-badge color="amber" overlap :content="orderStore.toPayOrders.length" class="mb-2">
                        <v-btn icon variant='tonal' @click="selectedOrders = orderStore.toPayOrders">
                            <v-icon size="24">mdi-cash-check</v-icon>
                        </v-btn>
                    </v-badge>
                    <div>To Pay</div>
                </v-col>
                <v-col cols="2" class="text-center">
                    <v-badge color="amber" overlap :content="orderStore.toShipOrders.length" class="mb-2">
                        <v-btn icon variant='tonal' @click="selectedOrders = orderStore.toShipOrders">
                            <v-icon size="24">mdi-truck</v-icon>
                        </v-btn>
                    </v-badge>
                    <div>To Ship</div>
                </v-col>
                <v-col cols="2" class="text-center">
                    <v-badge color="amber" overlap :content="orderStore.toReceiveOrders.length" class="mb-2">
                        <v-btn icon variant='tonal' @click="selectedOrders = orderStore.toReceiveOrders">
                            <v-icon size="24">mdi-shopping</v-icon>
                        </v-btn>
                    </v-badge>
                    <div>To Receive</div>
                </v-col>
                <v-col cols="2" class="text-center">
                    <v-badge color="amber" overlap :content="orderStore.completedOrders.length" class="mb-2">
                        <v-btn icon variant='tonal' @click="selectedOrders = orderStore.completedOrders">
                            <v-icon size="24">mdi-store-check</v-icon>
                        </v-btn>
                    </v-badge>
                    <div>Completed</div>
                </v-col>
            </v-row>
            <UserOrdersTable v-if="selectedOrders.length !== 0" :orders="selectedOrders" />
        </v-card>

        <!-- Support Section -->
        <v-card class="mb-4" outlined>
            <v-card-title>
                <v-icon color="grey darken-1" class="mr-2">mdi-headset</v-icon>
                <div>
                    Message Us
                    <v-subtitle-2>Help regarding your recent purchase or app usage.</v-subtitle-2>
                </div>
            </v-card-title>
        </v-card>

        <!-- Settings Section -->
        <v-card class="mb-4" outlined>
            <v-list-item-group>
                <v-list-item>
                    <v-list-item-content>FAQs</v-list-item-content>
                    <v-list-item-icon>
                        <v-icon>mdi-chevron-right</v-icon>
                    </v-list-item-icon>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item>
                    <v-list-item-content>About Us</v-list-item-content>
                    <v-list-item-icon>
                        <v-icon>mdi-chevron-right</v-icon>
                    </v-list-item-icon>
                </v-list-item>
                <v-divider></v-divider>
                <v-list-item>
                    <v-list-item-content>Terms and Privacy Policy</v-list-item-content>
                    <v-list-item-icon>
                        <v-icon>mdi-chevron-right</v-icon>
                    </v-list-item-icon>
                </v-list-item>
            </v-list-item-group>
        </v-card>

        <!-- Account Actions Section -->
        <v-card class="pa-4" outlined>
            <div class="text-center mb-2 grey--text">Created: 10/27/2024 10:34 AM</div>
            <div class="text-center mb-4 grey--text">Updated: 10/27/2024 11:03 AM</div>

            <v-btn color="red darken-2" class="mb-3" outlined block>Delete Account</v-btn>
            <v-btn color="amber" @click="handleSignOut" block>Sign Out</v-btn>
        </v-card>
    </v-container>
</template>

<script setup>
import router from '@/router';
import { authService } from '@/services/authService';
import { useUserStore } from '@/stores/userStore';
import { useOrderStore } from '@/stores/orderStore';
import PageNotFound from './PageNotFound.vue';
import UserOrdersTable from '@/components/user/UserOrdersTable.vue';
import { onMounted, ref } from 'vue';

const userStore = useUserStore();
const orderStore = useOrderStore();
const selectedOrders = ref([]);

const userInfo = userStore.userInfo;
const userAvatar = userStore.user.photoURL;

const cartItems = userInfo.cartItems.length;

onMounted(() => {
    orderStore.getUserOrders();
})

function handleSignOut() {
    authService.logout().then(() => {
        router.replace("/");
    });
}
</script>

<style scoped>
.v-avatar>.v-icon {
    font-size: 28px;
}

.v-list-item-content {
    font-weight: 500;
}
</style>