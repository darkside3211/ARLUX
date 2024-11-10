import { defineStore } from "pinia";
import { ref } from "vue";
export const useGlobalStore = defineStore("globalStore", () => {
  const theme = ref("light");

  function setThemeMode(newTheme) {
    theme.value = newTheme;
  }
  return {
    theme,
    setThemeMode,
  };
});
