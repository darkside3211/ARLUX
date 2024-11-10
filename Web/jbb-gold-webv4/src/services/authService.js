import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
  signOut,
  GoogleAuthProvider,
  signInWithPopup,
  sendEmailVerification,
  sendPasswordResetEmail,
  getAuth,
} from "firebase/auth";
import { useGlobalStore } from "@/stores/globalStore";

export const authService = {
  async register(email, password) {
    try {
      const userCredential = await createUserWithEmailAndPassword(
        getAuth(),
        email,
        password
      );

      await sendEmailVerification(userCredential.user);
      return userCredential.user;
    } catch (error) {
      console.error("Error registering user:", error.code);
      throw error;
    }
  },
  async login(email, password) {
    try {
      const userCredential = await signInWithEmailAndPassword(
        getAuth(),
        email,
        password
      );
      return userCredential.user;
    } catch (err) {
      console.error("Error logging in user: ", err.code);
      throw err;
    }
  },
  async signInWithGoogle() {
    const provider = new GoogleAuthProvider();
    try {
      const result = await signInWithPopup(getAuth(), provider);
      return result.user;
    } catch (error) {
      console.error("Google sign-in error:", error);
      throw error;
    }
  },
  async sendVerifyEmail() {
    const user = getAuth().currentUser;
    if (user) {
      try {
        await sendEmailVerification(user);
        console.log("Verification email sent");
      } catch (error) {
        console.error("Error sending verification email:", error);
        throw error;
      }
    } else {
      throw new Error("No user is currently signed in.");
    }
  },
  async passwordResetEmail(email) {
    try {
      await sendPasswordResetEmail(getAuth(), email);
      return {
        success: true,
        message: "Password reset link sent to your email",
      };
    } catch (error) {
      console.error("Password reset error:", error);
      return {
        success: false,
        message: error.message || "An unexpected error occurred.",
      };
    }
  },
  async logout() {
    try {
      const globalStore = useGlobalStore();
      await signOut(getAuth());
      console.log("User signed out successfully");
      globalStore.setThemeMode("light");
    } catch (error) {
      console.error("Logout error:", error);
      throw error;
    }
  },
};
