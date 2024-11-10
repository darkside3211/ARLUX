<template>
    <div class="text-center justify-center mt-16">
        <div class="mb-10">
            <v-icon color="amber-darken-1" size="8rem">mdi-alert</v-icon>
        </div>
        <div class="text-h2 mb-6">{{ message }}</div>
        <div>
            <v-btn @click="goBack" class="bg-amber font-weight-medium">Go Back</v-btn>
        </div>
    </div>
</template>

<script setup>
import router from '@/router';
import { defineProps } from 'vue';

defineProps({
    message: {
        type: String,
        default: "Page Not Found"
    }
});

function goBack() {
    router.replace("/");
}
</script>