import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import PageNotFound from "@/views/PageNotFound.vue";
import CollectionsView from "@/views/CollectionsView.vue";
import { useUserStore } from "@/stores/userStore";
import AccountView from "@/views/AccountView.vue";
import AuthView from "@/views/AuthView.vue";
import AdminView from "@/views/AdminView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/collections",
      name: "collections",
      component: CollectionsView,
    },
    {
      path: "/account",
      name: "account",
      component: AccountView,
      meta: { requiresAuth: true },
    },
    {
      path: "/login",
      name: "login",
      component: AuthView,
    },
    {
      path: "/admin",
      name: "admin",
      component: AdminView,
      meta: { requiresAuth: true, requiresAdmin: true },
    },
    {
      path: "/:pathMatch(.*)*",
      component: PageNotFound,
    },
  ],
});

router.beforeEach(async (to, from, next) => {
  const requiresAuth = to.matched.some((record) => record.meta.requiresAuth);
  const requiresAdmin = to.matched.some((record) => record.meta.requiresAdmin);
  const userStore = useUserStore();

  if (requiresAuth) {
    await userStore.initializeAuthListener();
    if (!userStore.isAuthenticated) {
      next("/login");
    } else if (requiresAdmin && !userStore.isAdmin) {
      next("/");
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router;
