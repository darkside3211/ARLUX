<template>
    <div class="custom-nav-bar bg-grey-darken-4">
        <v-container fluid>
            <v-row align="center" justify="center" class="py-3">
                <v-col class="d-flex align-center justify-space-between" style="max-width: 1200px;">
                    <!-- Logo -->
                    <router-link to="/" class="mr-4">
                        <v-img :src="logo" contain :width="64" aspect-ratio="1/1" />
                    </router-link>

                    <!-- Navigation Links -->
                    <div class="d-flex align-center" v-if="mdAndUp">
                        <router-link to="/" :class="['nav-link', { 'active-link': isActive('/') }]">
                            Home
                        </router-link>
                        <router-link to="/collections"
                            :class="['nav-link', { 'active-link': isActive('/collections') }]">
                            Collections
                        </router-link>
                        <router-link to="/support" :class="['nav-link', { 'active-link': isActive('/support') }]">
                            Support
                        </router-link>
                    </div>

                    <!-- Divider -->
                    <div v-if="$vuetify.display.mdAndUp"> | </div>
                    <!-- Icons (Display only icons on small screens) -->
                    <div class="d-flex align-center">
                        <v-icon :class="['icon-link', { 'active-icon': isActive('/search') }]">
                            mdi-magnify
                        </v-icon>
                        <v-badge color="amber" overlap :content="cartStore.carts.length || 0">
                            <v-icon :class="['icon-link', { 'active-icon': isActive('/bag') }]"
                                @click="navigateTo('bag')">
                                mdi-shopping
                            </v-icon>
                        </v-badge>


                        <v-btn icon :class="['icon-link', { 'active-icon': isActive('/account') }]"
                            @click="navigateTo('account')">
                            <v-avatar v-if="userStore.isAuthenticated && userStore.user.photoURL"
                                :image="userStore.user.photoURL">
                            </v-avatar>
                            <v-avatar v-else icon="mdi-account"
                                :class="['icon-link', { 'active-icon': isActive('/account') }]">
                            </v-avatar>
                        </v-btn>

                        <v-icon v-if="userStore.isAdmin" @click="toggleTheme">
                            mdi-theme-light-dark
                        </v-icon>
                    </div>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>

<script setup>
import { useRouter, useRoute } from 'vue-router';
import logo from '@/assets/images/jbb_logo.png';
import { useDisplay } from 'vuetify/lib/framework.mjs';
import { useUserStore } from '@/stores/userStore';
import { useGlobalStore } from '@/stores/globalStore';
import { useCartStore } from '@/stores/cartStore';

const globalStore = useGlobalStore();
const cartStore = useCartStore();
const router = useRouter();
const route = useRoute();
const userStore = useUserStore();

const { mdAndUp } = useDisplay();


const toggleTheme = () => {
    const isDark = globalStore.theme === 'dark';
    globalStore.setThemeMode(isDark ? 'light' : 'dark');
};

// Function to check if the current route matches the given path
const isActive = (path) => route.path === path;

// Function to navigate to specific routes
const navigateTo = (route) => {
    switch (route) {
        case 'search':
            router.push('/search');
            break;
        case 'account':
            if (userStore.isAuthenticated) {
                router.push('/account');
            } else {
                router.push('/login');
            }
            break;
        case 'bag':
            router.push('/bag');
            break;
        default:
            break;
    }
};


</script>

<style scoped>
.text-white {
    color: white !important;
}

.text-decoration-none {
    text-decoration: none;
}

/* Base style for navigation links */
.nav-link {
    color: white;
    text-decoration: none;
    padding: 8px 16px;
}

/* Highlight active link text with yellow-darken-1 */
.active-link {
    color: #fdd835 !important;
    /* Vuetify yellow-darken-1 color */
    border-bottom: 2px solid #fdd835;
    /* underline with yellow-darken-1 */
    font-weight: bold;
}

/* Base style for icons */
.icon-link {
    color: white;
    cursor: pointer;
    margin: 0 12px;
}

/* Style for active icons */
.active-icon {
    color: #fdd835 !important;
    /* Vuetify yellow-darken-1 color for active icon */
}
</style>