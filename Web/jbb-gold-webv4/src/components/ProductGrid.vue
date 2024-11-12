<template>
    <v-row>
        <v-col xs="6" sm="4" md="3" xl="3" xxl="2" lg="3" v-for="(product, index) in props.products" :key="index">
            <ProductCard :product="product"/>
        </v-col>
    </v-row>
</template>

<script setup>
import ProductCard from './ProductCard.vue';

const props = defineProps({
    products: {
        type: Array,
        required: true,
    }
});
</script>