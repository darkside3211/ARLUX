<template>
    <div class="text-center">
        <div class="text-h3 text-yellow-darken-3 mb-5 mt-16 font-weight-black title">
            Welcome to JBB Gold
        </div>
        <div class="text-h6 font-weight-medium font-italic subtitle mb-10">
            Discover exquisite jewelry pieces that tell your unique story
        </div>
        <v-btn class="text-black bg-amber mb-5" @click="toProducts">Shop Now</v-btn>
    </div>
    <v-divider></v-divider>

    <v-container class="text-center justify-center">
        <v-row justify="center">
            <v-col v-for="category in categoryList" :key="category" cols="6" sm="3" md="3">
                <v-btn icon size="128">
                    <v-avatar :image="category.image" size="128"></v-avatar>
                </v-btn>
                <div class="text-subtitle mt-2 subtitle">{{ category.name }}</div>
            </v-col>
        </v-row>
    </v-container>

    <PopularProducts :products="productStore.popularProducts" />

    <v-divider class="my-8"></v-divider>
    <div class="text-h6 font-weight-medium subtitle mb-6">
        Browse Collections
    </div>
    <v-row v-if="productStore.loading">
        <v-col cols="4" v-for="n in 12">
            <v-skeleton-loader class="mx-auto border" max-width="300" type="image, article">
            </v-skeleton-loader>
        </v-col>
    </v-row>
    <PageNotFound v-else-if="productStore.error" :message="productStore.error" />
    <ProductGrid v-else :products="productStore.currentProducts" />

</template>

<script setup>
import router from '@/router';
import { onMounted } from 'vue';
import { useProductStore } from '@/stores/productStore';
import ProductGrid from '@/components/ProductGrid.vue';
import PageNotFound from './PageNotFound.vue';
import PopularProducts from '@/components/PopularProducts.vue';

import ringCategory from "@/assets/images/categories/ring_image.jpg";
import earringCategory from "@/assets/images/categories/earring_image.jpg";
import braceletCategory from "@/assets/images/categories/bracelet_image.jpg";
import necklaceCategory from "@/assets/images/categories/necklace_image.jpg";

const categoryList = [
    {
        name: "Earring",
        image: earringCategory,
    },
    {
        name: "Ring",
        image: ringCategory,
    },
    {
        name: "Bracelet",
        image: braceletCategory,
    },
    {
        name: "Necklace",
        image: necklaceCategory
    },
]

const productStore = useProductStore();

onMounted(() => {
    productStore.fetchAllProducts();
});

function toProducts() {
    router.push('/collections');
}

</script>

<style scoped>
.title {
    font-family: 'Times New Roman', Times, serif;
}

.subtitle {
    font-family: 'Times New Roman', Times, serif;
}
</style>