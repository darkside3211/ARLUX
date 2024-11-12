import { createApp } from "vue";
import { createPinia } from "pinia";

import App from "./App.vue";
import router from "./router";

import "@mdi/font/css/materialdesignicons.css";
import "vuetify/styles";
import { createVuetify } from "vuetify";
import VueApexCharts from "vue3-apexcharts";
import * as components from "vuetify/components";
import * as directives from "vuetify/directives";
import { useUserStore } from "./stores/userStore";
import { initializeApp } from "firebase/app";
import { firebaseConfig } from "./firebase";

const vuetify = createVuetify({
  components,
  directives,
  theme: {
    defaultTheme: "light",
  },
});

initializeApp(firebaseConfig);
const app = createApp(App);
const pinia = createPinia();

app.use(pinia);
app.use(router);
app.use(vuetify);
app.use(VueApexCharts);

const userStore = useUserStore();

userStore.initializeAuthListener();

app.mount("#app");
