<template>
  <v-app :theme="themeSet.theme">
    <v-app-bar app scroll-behavior="hide" color="grey-darken-4">
      <v-app-bar-title>
        <NavBar />
      </v-app-bar-title>

    </v-app-bar>
    <v-main class="d-flex flex-column">
      <v-container fluid class="flex-grow-1 pa-0">
        <div class="content-container pa-4">
          <RouterView />
        </div>
        <AboutUs />
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup>
import { RouterView } from 'vue-router';
import NavBar from './components/NavBar.vue';
import AboutUs from './components/AboutUs.vue';
import { useGlobalStore } from './stores/globalStore';

const themeSet = useGlobalStore();
</script>

<style scoped>
.content-container {
  margin: auto 80px;
  /* Centers the content and limits its width */
}
</style>

<style>
.full-width-divider {
  position: relative;
  left: calc(-50vw + 50%);
  width: 100vw;
  padding: 0px 24px 0px;
  /* Centers the full-width divider */
}
</style>