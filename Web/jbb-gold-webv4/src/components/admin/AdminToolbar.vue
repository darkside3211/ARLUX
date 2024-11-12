<template>
    <v-app-bar>
        <v-app-bar-nav-icon @click="$emit('toggle-drawer')"></v-app-bar-nav-icon>
        <v-app-bar-title>Administration</v-app-bar-title>
        <v-spacer></v-spacer>
    </v-app-bar>
</template>

<script setup>
defineEmits(['toggle-drawer']);
</script>