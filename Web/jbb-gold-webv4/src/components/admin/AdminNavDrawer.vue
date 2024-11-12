<template>
    <v-navigation-drawer v-model="isOpen" width="200">
        <v-list>
            <v-list-item link to="/account" :prepend-avatar="userStore.user.photoURL" :title="userInfo.username"
                :subtitle="userStore.isAdmin ? 'Administrator' : 'Staff'"></v-list-item>
        </v-list>

        <v-divider></v-divider>
        <v-list-item link prepend-icon="mdi-view-dashboard" title="Dashboard" to="/admin"></v-list-item>
        <v-list-item link prepend-icon="mdi-invoice-list" title="Orders" to="/admin/orders"></v-list-item>
        <v-list-item link prepend-icon="mdi-shopping" title="Stock" to="/admin/stock"></v-list-item>
        <v-list-item link prepend-icon="mdi-account" title="Accounts" to="/admin/accounts"></v-list-item>
    </v-navigation-drawer>
</template>

<script setup>
import { useUserStore } from '@/stores/userStore';
import { computed } from 'vue';

const props = defineProps(['modelValue']);
const emit = defineEmits(['update:modelValue']);

const userStore = useUserStore();
const userInfo = userStore.userInfo;


const isOpen = computed({
    get: () => props.modelValue,
    set: (value) => emit('update:modelValue', value)
});
</script>