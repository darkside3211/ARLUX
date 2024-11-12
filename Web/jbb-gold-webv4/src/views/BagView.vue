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
                Cart Items: <strong>{{ cartItems }}</strong>
            </v-card-subtitle>
        </v-card>

        <!-- My Purchases Section -->
        <UserBagTable :cart="cartStore.carts" :loading="cartStore.loading"/>

    </v-container>
</template>

<script setup>
import { useUserStore } from '@/stores/userStore';
import { useCartStore } from '@/stores/cartStore';
import PageNotFound from './PageNotFound.vue';
import UserBagTable from '@/components/user/UserBagTable.vue';
import { onMounted } from 'vue';

const userStore = useUserStore();
const cartStore = useCartStore();

const userInfo = userStore.userInfo;
const userAvatar = userStore.user.photoURL;

const cartItems = userInfo.cartItems.length;

onMounted(() => {
    cartStore.getCartItems();
})

</script>

<style scoped>
.v-avatar>.v-icon {
    font-size: 28px;
}

.v-list-item-content {
    font-weight: 500;
}
</style>