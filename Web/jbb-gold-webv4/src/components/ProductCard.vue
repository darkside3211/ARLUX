<template>
    <v-card @click="toDetails" class="mx-auto" max-width="344" variant="outlined">
        <v-img height="200px" :src="props.product.imageUrls[0]" :lazy-src="logo" cover>
            <template v-slot:placeholder>
                <div class="d-flex align-center justify-center fill-height">
                    <v-progress-circular color="grey-lighten-4" indeterminate></v-progress-circular>
                </div>
            </template>
        </v-img>

        <v-card-title>
            <div class="text-subtitle-1 font-weight-bold nav-link">{{ props.product.name }}</div>
        </v-card-title>
        <v-card-subtitle>
            <v-rating readonly half-increments length="5" size="24" :model-value="props.product.averageRating"
                active-color="amber">
            </v-rating>

            <span class="text-caption align-center">
                ({{ props.product.soldCount }})
            </span>
        </v-card-subtitle>
        <div class="ml-4">
            <div class="text-subtitle-1 text-yellow-darken-4 font-weight-bold">{{
                productService.formatPrice(props.product.price)
            }}</div>
            <v-chip v-if="props.product.modelUrl" prepend-icon="mdi-cube-scan" class="text-uppercase" size="small"
                label>
                3D View
            </v-chip>
        </div>

        <v-card-actions>
            <v-btn color="yellow-darken-4" class="font-weight-bold">Buy Now</v-btn>
            <v-spacer></v-spacer>
        </v-card-actions>
    </v-card>

</template>

<script setup>
import logo from "@/assets/images/jbb_logo.png";
import { productService } from '@/services/productService';
import { useRouter } from 'vue-router';

const router = useRouter();
const props = defineProps({
    product: {
        type: Object,
        required: true,
    },
});

const toDetails = () => {
    router.push(`/collection/${props.product.id}`);
}
</script>

<style scoped>
/* Base style for navigation links */
.nav-link {
    text-decoration: none;
}
</style>