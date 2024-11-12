<template>
    <v-container>
        <div class="d-flex align-center justify-center text-h3 font-weight-bold ma-4">ACCOUNTS</div>
        <v-card class="my-4" :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="green-darken-1"
            :loading="loading" :disabled="loading">
            <v-card-title>
                Customers
                <v-container>
                    <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                        :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                        single-line></v-text-field>
                </v-container>

            </v-card-title>
            <v-card-subtitle>As of {{ date.toLocaleString(undefined, dateOptions) }}</v-card-subtitle>
            <v-card-text>
                <UsersTable :search-query="searchQuery" :users="users" />
            </v-card-text>
            <v-card-actions>
                <v-spacer />
                <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" @click="refreshUsersTable">
                    <v-icon>mdi-refresh</v-icon>
                    Refresh
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-container>
</template>

<script setup>
import UsersTable from '@/components/admin/users/UsersTable.vue';
import { ref, onMounted, onUnmounted } from 'vue';
import { adminService } from '@/services/adminService';
import { useGlobalStore } from '@/stores/globalStore';
import { useAdminConfigStore } from '@/stores/adminConfigStore';

const globalStore = useGlobalStore();
const adminConfigStore = useAdminConfigStore();

const searchQuery = ref('');
const users = ref([]);
const loading = ref(false);

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
    refreshUsersTable();
    refreshID = setInterval(() => {
        date.value = new Date();
        refreshUsersTable();
    }, adminConfigStore.refreshInterval);
});

onUnmounted(() => {
    clearInterval(refreshID);
});


function refreshUsersTable() {
    loading.value = true;
    date.value = new Date();
    adminService.getAllUsers().then(
        (data) => {
            users.value = data;
            loading.value = false;
        }
    ).catch((err) => { loading.value = false; });
}
</script>