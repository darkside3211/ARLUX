<template>
    <v-app ref="app" class="rounded rounded-md full-width-divider">
        <AdminToolbar @toggle-drawer="toggleDrawer" />
        <AdminNavDrawer v-model="drawerOpen" />
        <v-main class="d-flex align-center justify-center" style="min-height: 300px;">
            <router-view />
        </v-main>
    </v-app>
</template>

<script setup>
import AdminToolbar from '@/components/admin/AdminToolbar.vue';
import AdminNavDrawer from '@/components/admin/AdminNavDrawer.vue';
import { ref } from 'vue';

const drawerOpen = ref(true);

const toggleDrawer = () => {
    drawerOpen.value = !drawerOpen.value
};

</script>