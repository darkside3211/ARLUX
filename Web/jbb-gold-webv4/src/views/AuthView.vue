<template>
    <div>
        <div v-if="index === 0" class="text-h3 text-yellow-darken-3 mb-5 mt-16 font-weight-black title text-center">
            Welcome Back
        </div>
        <div v-else-if="index === 1"
            class="text-h3 text-yellow-darken-3 mb-5 mt-16 font-weight-black title text-center">
            Create an Account
        </div>
        <div v-else class="text-h3 text-yellow-darken-3 mb-5 mt-16 font-weight-black title text-center">
            Verify Email
        </div>
        <v-carousel hide-delimiters :show-arrows="false" v-model="index">
            <v-carousel-item class="mx-auto">
                <v-card :disabled="loading" :loading="loading" elevation="1" max-width="448" rounded="lg">
                    <div class="text-subtitle-1 text-medium-emphasis">Account</div>
                    <v-text-field v-model="email" :readonly="loading" :rules="[rules.required, rules.email]"
                        density="compact" placeholder="Email address" prepend-inner-icon="mdi-email-outline"
                        variant="outlined"></v-text-field>

                    <div class="text-subtitle-1 text-medium-emphasis d-flex align-center justify-space-between">
                        Password
                        <a class="text-caption text-decoration-none text-amber-darken-2" href="#"
                            rel="noopener noreferrer" target="_blank">
                            Forgot login password?</a>
                    </div>

                    <v-text-field v-model="password" :readonly="loading" :rules="[rules.required, rules.password]"
                        counter :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'" hint="At least 8 characters"
                        label="..." :type="visible ? 'text' : 'password'" density="compact"
                        placeholder="Enter your password" prepend-inner-icon="mdi-lock-outline" variant="outlined"
                        @click:append-inner="visible = !visible"></v-text-field>

                    <v-card class="mb-12" color="surface-variant" variant="tonal">
                        <v-card-text class="text-medium-emphasis text-caption">
                            Warning: After 3 consecutive failed login attempts, you account will be temporarily
                            locked
                            for three
                            hours. If you must login now, you can also click "Forgot login password?" below to reset
                            the
                            login
                            password.
                        </v-card-text>
                    </v-card>

                    <v-btn :disabled="!valid" @click="onLogin" :loading="loading" class="mb-8" color="amber"
                        size="large" variant="outlined" block>
                        Log In
                    </v-btn>

                    <google-button class="mx-auto d-flex align-center justify-center gap-2" @click="onGoogle"></google-button>

                    <div v-if="error" class="text-caption text-red">{{ error }}</div>

                    <v-card-text class="text-center">
                        <v-btn @click="index = 1" class="mb-8" color="black" size="small" variant="text">
                            Signup Now ->
                        </v-btn>
                    </v-card-text>
                </v-card>
            </v-carousel-item>

            <!-- SIGN UP -->
            <v-carousel-item class="mx-auto">
                <v-card :disabled="loading" :loading="loading" elevation="1" max-width="448" rounded="lg">
                    <div class="text-subtitle-1 text-medium-emphasis">Account</div>
                    <v-text-field v-model="email" :readonly="loading" :rules="[rules.required, rules.email]"
                        density="compact" placeholder="Email address" prepend-inner-icon="mdi-email-outline"
                        variant="outlined"></v-text-field>


                    <v-text-field v-model="password" :readonly="loading" :rules="[rules.required, rules.password]"
                        counter :append-inner-icon="visible ? 'mdi-eye-off' : 'mdi-eye'" hint="At least 8 characters"
                        label="..." :type="visible ? 'text' : 'password'" density="compact"
                        placeholder="Enter your password" prepend-inner-icon="mdi-lock-outline" variant="outlined"
                        @click:append-inner="visible = !visible"></v-text-field>

                    <v-card class="mb-12" color="surface-variant" variant="tonal">
                        <v-card-text class="text-medium-emphasis text-caption">
                            Note: After registering, please verify your email before logging in. In order to checkout
                            your selected products
                            you need to fillup your shipping information first.
                        </v-card-text>
                    </v-card>

                    <v-btn :disabled="!valid" @click="onRegister" :loading="loading" class="mb-8" color="amber"
                        size="large" variant="outlined" block>
                        Create Account
                    </v-btn>
                    <google-button class="mx-auto d-flex align-center justify-center gap-2" @click="onGoogle"></google-button>

                    <div v-if="error" class="text-caption text-red">{{ error }}</div>

                    <v-card-text class="text-center">
                        <v-btn @click="index = 0" class="mb-8" color="black" size="small" variant="text">
                            <- Login Now </v-btn>
                    </v-card-text>
                </v-card>
            </v-carousel-item>

            <!-- VERIFY EMAIL -->

            <v-carousel-item class="mx-auto">
                <v-card elevation="1" max-width="448" rounded="lg">
                    <v-card class="mb-12" color="surface-variant" variant="tonal">
                        <v-card-text class="text-medium-emphasis text-caption">
                            Please Verify Your Email Before Logging In
                        </v-card-text>
                    </v-card>

                    <v-btn :href="`https://${emailProvider}`" type="submit" @click="verifyClicked" target="_blank"
                        class="mb-8" color="amber" size="large" variant="outlined" block>
                        VERIFY EMAIL
                    </v-btn>
                </v-card>
            </v-carousel-item>

        </v-carousel>
    </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useUserStore } from '@/stores/userStore';
import { authService } from '@/services/authService';
import { useRouter } from 'vue-router';
import { useGlobalStore } from '@/stores/globalStore';
import GoogleButton from '@/components/GoogleButton.vue';

const globalStore = useGlobalStore();
const userStore = useUserStore();
const loading = ref(false);
const error = ref(null);
const router = useRouter();

const email = ref('');
const password = ref('');

const emailProvider = computed(() => {
    const match = email.value.match(/@(.+)/);
    return match && match[1] || '';
})

const valid = computed(() => {
    return email.value !== '' && password.value !== '';
});
const index = ref(0);
const visible = ref(false);

onMounted(() => {
    if (userStore.isAuthenticated) {
        index.value = 2;
    }
});

const rules = {
    required: value => !!value || 'This field is required.',
    password: value => value.length >= 8 || 'Min 8 characters.',
    email: value => {
        const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        return pattern.test(value) || 'Invalid e-mail.'
    },
}

const onLogin = () => {
    loading.value = true;
    error.value = null;
    authService.login(email.value, password.value).then(
        (user) => {
            userStore.setUser(user);
            if (!userStore.user.emailVerified) {
                error.value = "Please verify your email before logging in.";
                index.value = 2;
                return;
            }

            if (userStore.isAdmin) {
                globalStore.setThemeMode('dark');
            }
            router.push("/account");
        }
    ).catch((err) => {
        switch (err.code) {
            case "auth/invalid-credential":
                error.value = "Your email or password is incorrect";
                break;
            case "auth/wrong-password":
                error.value =
                    "The password is invalid or the user does not have a password.";
                break;
            case "auth/user-not-found":
                error.value =
                    "There is no user record corresponding to this identifier. The user may have been deleted.";
                break;
            default:
                error.value = err.code;
                break;
        }
        loading.value = false;
    });
}

const onGoogle = () => {
    loading.value = true;
    error.value = null;
    authService.signInWithGoogle().then(
        (user) => {
            userStore.setUser(user);
            if (!userStore.user.emailVerified) {
                error.value = "Please verify your email before logging in.";
                index.value = 2;
                return;
            }

            if (userStore.isAdmin) {
                globalStore.setThemeMode('dark');
            }
            router.push("/account");
        }
    ).catch((err) => {
        error.value = err;
        loading.value = false;
    });
}

const verifyClicked = () => {
    loading.value = false;
    error.value = null;
    router.replace("/account");
}

const onRegister = () => {
    error.value = null;
    authService.register(email.value, password.value).then(
        (user) => {
            userStore.setUser(user);
            loading.value = false;
            index.value = 2;
        }
    ).catch((err) => {
        switch (err.code) {
            case "auth/invalid-email":
                error.value = "The email address is badly formatted.";
                break;
            case "auth/weak-password":
                error.value = "The password must be 6 characters long or more.";
                break;
            case "auth/email-already-in-use":
                error.value =
                    "The email address is already in use by another account.";
                break;
            default:
                error.value = err.code;
                break;
        }
    });
}

</script>