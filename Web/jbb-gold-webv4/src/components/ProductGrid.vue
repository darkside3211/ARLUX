<template>
    <v-row>
        <v-col cols="6" sm="6" md="3" v-for="(product, index) in props.products" :key="index">
            <ProductCard :product="product" />
        </v-col>
    </v-row>
</template>

<script setup>
import { defineProps } from 'vue';
import ProductCard from './ProductCard.vue';

const props = defineProps({
    products: {
        type: Array,
        required: true,
    }
});
</script>