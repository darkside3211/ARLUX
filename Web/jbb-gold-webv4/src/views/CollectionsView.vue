<template>
    <div class="text-center">
        <div class="text-h3 text-yellow-darken-3 mb-5 mt-16 font-weight-black title">
            Our Products
        </div>
        <div class="text-h6 font-weight-medium font-italic subtitle mb-10">
            Discover exquisite jewelry pieces that tell your unique story
        </div>
    </div>
    <v-divider class="my-8"></v-divider>
    <v-row v-if="productStore.loading">
        <v-col cols="4" v-for="n in 12">
            <v-skeleton-loader class="mx-auto border" max-width="300" type="image, article">
            </v-skeleton-loader>
        </v-col>
    </v-row>
    <PageNotFound v-else-if="productStore.error" :message="productStore.error" />
    <ProductGrid v-else :products="productStore.products" />
</template>

<script setup>
import { onMounted } from 'vue';
import { useProductStore } from '@/stores/productStore';
import ProductGrid from '@/components/ProductGrid.vue';
import PageNotFound from './PageNotFound.vue';

const productStore = useProductStore();

onMounted(() => {
    productStore.fetchAllProducts();
});

</script>

<style scoped>
.title {
    font-family: 'Times New Roman', Times, serif;
}

.subtitle {
    font-family: 'Times New Roman', Times, serif;
}
</style>