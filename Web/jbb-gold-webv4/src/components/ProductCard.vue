<template>
    <v-card class="mx-auto" max-width="344" variant="outlined">
        <v-img height="200px" :src="props.product.imageUrls[0]" cover></v-img>

        <v-card-title>
            <span class="text-h6 font-weight-bold">{{ props.product.name }}</span>
        </v-card-title>

        <v-row class="ml-2" align="center">
            <v-col cols="auto">
                <v-rating readonly half-increments length="5" size="32" :model-value="props.product.averageRating"
                    active-color="amber" color="amber-lighten-2" />
            </v-col>
            <v-col cols="auto">
                <div>{{ props.product.averageRating.toFixed(1) }}</div>
            </v-col>
        </v-row>

        <v-card-subtitle>
            <span class="text-h6 font-weight-bold">{{ productService.formatPrice(props.product.price) }}</span>
        </v-card-subtitle>

        <v-card-actions>
            <v-btn color="yellow-darken-4" class="font-weight-bold">View Details</v-btn>
            <v-spacer></v-spacer>
            <v-btn :icon="show ? 'mdi-chevron-up' : 'mdi-chevron-down'" @click="show = !show"></v-btn>
        </v-card-actions>

        <v-expand-transition>
            <div v-show="show">
                <v-divider></v-divider>
                <v-card-text class="text-subtitle-1">
                    {{ props.product.description }}
                </v-card-text>
            </div>
        </v-expand-transition>
    </v-card>
</template>

<script setup>
import { defineProps, ref } from 'vue';
import { productService } from '@/services/productService';

const show = ref(false);

const props = defineProps({
    product: {
        type: Object,
        required: true,
    },
});

</script>