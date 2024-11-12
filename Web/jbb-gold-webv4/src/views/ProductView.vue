<template>
    <div>
        <div class="d-flex align-center justify-center">
            <v-row>
                <v-col sm="12" md="12" lg="3">
                    <v-carousel cycle height="545" hide-delimiter-background>
                        <v-carousel-item v-for="(image, index) in product.imageUrls" :key="index">
                            <v-img :src="image" contain height="100%" :lazy-src="logo">
                                <template v-slot:placeholder>
                                    <div class="d-flex align-center justify-center fill-height">
                                        <v-progress-circular color="grey-lighten-4" indeterminate></v-progress-circular>
                                    </div>
                                </template>
                            </v-img>
                        </v-carousel-item>
                    </v-carousel>
                    <v-divider class="my-8"></v-divider>
                </v-col>
                <v-col sm="12" md="12" lg="6">
                    <div>
                        <div class="text-h4 text-yellow-darken-3 mt-4 font-weight-black">
                            {{ product.name }}
                        </div>
                        <div class="font-weight-medium font-italic ">
                            <strong>Category: </strong> {{ product.category }}
                        </div>
                        <v-row class="my-2">
                            <v-chip variant="elevated" color="amber lighten-4" class="ma-1">Remaining: {{
                                product.stockCount
                            }}</v-chip>
                            <v-chip variant="elevated" color="green lighten-4" class="ma-1">Sold: {{ product.soldCount
                                }}</v-chip>
                        </v-row>

                        <v-rating readonly half-increments length="5" size="24" :model-value="product.averageRating"
                            active-color="amber">
                        </v-rating>
                        <span class="ml-2">({{ product.averageRating }})</span>
                        <div class="text-h5 text-yellow-darken-4 font-weight-bold mb-2">
                            Base: {{ productService.formatPrice(product.price) }} |
                            {{ productService.formatPrice((product.price * quantity) + (selectedItem.additionalAmount ||
                                0)) }} ({{ selectedItem.size }} x{{ quantity }})
                        </div>
                        <v-divider class="my-4"></v-divider>
                        <div>
                            <div class="text-h6 font-weight-bold">Description</div>
                            <div class="text-body-1">
                                {{ product.description }}
                            </div>
                        </div>
                        <v-divider class="my-4"></v-divider>
                        <div>
                            <strong>Size: </strong>
                            <v-select :items="product.sizes" :item-props="itemVariants" label="Sizes"
                                v-model="selectedItem" </v-select>
                        </div>
                        <div>
                            <strong>Quantity: </strong>

                            <v-text-field type="number" v-model="quantity" :rules="[v => v > 0 || 'Invalid Quantity']"
                                label="Quantity">
                            </v-text-field>

                        </div>
                    </div>
                    <div>
                        <div class="d-flex align-center justify-center px-16 ma-4">
                            <v-alert border='top' border-color="amber" :closable="true" v-model="showAlert"
                                :text="error">
                            </v-alert>
                        </div>

                        <v-row no-gutters justify="center">
                            <v-col sm="4" md="4" lg="3">
                                <v-btn color="amber" size="large" prepend-icon="mdi-shopping"
                                    :loading="cartStore.loading" :disabled="invalid" @click="addToCart">Add
                                    To
                                    Bag</v-btn>
                            </v-col>
                            <v-col sm="4" md="4" lg="3">
                                <v-btn variant="elevated" color="orange" size="x-large" prepend-icon="mdi-cash-check"
                                    :disabled="invalid">
                                    Buy Now
                                </v-btn>
                            </v-col>
                        </v-row>
                    </div>
                </v-col>
                <v-col sm="12" md="12" lg="3" v-if="product.modelUrl">
                    <div class="html-container">
                        <iframe :src="'/modelViewer/viewer.html'" id="f1" refe="frame1"
                            style="width: 100%; height: 512px;"></iframe>
                    </div>
                    <div>
                        <v-row no-gutters>
                            <v-col cols="3">
                                <v-chip prepend-icon="mdi-mouse-right-click" variant="outlined" label>
                                    Rotate
                                </v-chip>
                            </v-col>
                            <v-col cols="3">
                                <v-chip prepend-icon="mdi-mouse-left-click" variant="outlined" label>
                                    Pan
                                </v-chip>
                            </v-col>
                            <v-col cols="3">
                                <v-chip prepend-icon="mdi-mouse-move-vertical" variant="outlined" label>
                                    Zoom
                                </v-chip>
                            </v-col>
                            <v-col cols="3">
                                <v-chip prepend-icon="mdi-cursor-default-click" variant="outlined" label>
                                    2x Reset
                                </v-chip>
                            </v-col>
                        </v-row>
                    </div>
                </v-col>
            </v-row>
        </div>
    </div>
</template>


<script setup>
window.scrollTo(0, 0);
import logo from "@/assets/images/jbb_logo.png";
import { productService } from '@/services/productService';
import { useUserStore } from "@/stores/userStore";
import { useCartStore } from "@/stores/cartStore";
import { computed, onMounted, ref } from 'vue';
import { useRoute, useRouter } from 'vue-router';

const userStore = useUserStore();
const cartStore = useCartStore();

const route = useRoute();
const router = useRouter();
const productId = computed(() => route.params.id);
const product = ref({});
const selectedItem = ref({});
const quantity = ref(1);
const viewModel = ref(false);
const showAlert = ref(false);
const invalid = computed(() => {
    return quantity.value <= 0;
});
const error = ref(null);

onMounted(() => refreshProduct());

function refreshProduct() {
    error.value = null;
    productService.getProductById(productId.value).then(
        (data) => {
            localStorage.setItem('currentModel', data.modelUrl);
            selectedItem.value = data.sizes[0];
            product.value = data;
            viewModel.value = true;
        }
    ).catch((err) => {
        error.value = err;
    });
}


function itemVariants(item) {
    return {
        title: item.size,
        subtitle: `+${productService.formatPrice(item.additionalAmount)}`
    }
}

function addToCart() {
    error.value = null;
    showAlert.value = false;
    if (userStore.isAuthenticated) {
        cartStore.addToCart(product.value.id, quantity.value, selectedItem.value)
            .then((data) => {
                error.value = cartStore.error;
                error.value = 'Successfully Added to Cart';
                showAlert.value = true;
            }).catch((err) => {
                error.value = err;
                showAlert.value = true;
            });
    } else {
        error.value = "Please Login first";
        showAlert.value = true;
        router.push("/account");
    }

}
</script>

<style>
.html-container {
    display: flex;
    justify-content: center;
    align-items: center;
    /* Add custom styling if needed */
}
</style>
