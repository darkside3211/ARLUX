import { defineStore } from "pinia";
import { getAuth, onAuthStateChanged, getIdToken } from "firebase/auth";

import { ref, computed } from "vue";
import api from "@/services/apiCore";
import { useGlobalStore } from "./globalStore";

export const useUserStore = defineStore("userStore", () => {
  const user = ref(null);
  const userInfo = ref(null);
  const loading = ref(false);
  const error = ref(null);
  const isAdmin = ref(false);
  const isAuthenticated = computed(() => !!user.value);

  async function setUser(newUser) {
    user.value = newUser;
  }

  function setAdminStatus(status) {
    const globalStore = useGlobalStore();
    if (status) {
      globalStore.setThemeMode("dark");
    }
    isAdmin.value = status;
  }

  async function checkAdminStatus() {
    const auth = getAuth();
    if (auth.currentUser) {
      const idTokenResult = await auth.currentUser.getIdTokenResult();
      setAdminStatus(idTokenResult.claims.admin === true);
    }
  }

  async function initializeAuthListener() {
    return new Promise((resolve, reject) => {
      const auth = getAuth();
      onAuthStateChanged(
        auth,
        async (firebaseUser) => {
          setUser(firebaseUser);
          if (firebaseUser) {
            await checkAdminStatus();
            await getUserInfo();
          } else {
            setAdminStatus(false);
          }
          resolve(firebaseUser);
        },
        reject
      );
    });
  }

  async function getUserInfo() {
    loading.value = true;
    error.value = null;
    try {
      const auth = getAuth();
      const idTokenResult = await getIdToken(auth.currentUser);
      const response = await api.get("/users/auth/register", {
        headers: {
          Authorization: `Bearer ${idTokenResult}`,
          "Content-Type": "application/json",
        },
      });

      userInfo.value = response.data;
    } catch (err) {
      console.error("Failed to fetch user info: ", error);
      error.value = err.message;
    } finally {
      loading.value = false;
    }
  }

  return {
    user,
    userInfo,
    loading,
    error,
    isAdmin,
    isAuthenticated,

    //actions
    setUser,
    getUserInfo,
    setAdminStatus,
    checkAdminStatus,
    initializeAuthListener,
  };
});
