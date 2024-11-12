<template>
    <v-dialog v-model="props.show" max-width="800" transition="dialog-bottom-transition">
        <v-card>
            <!-- Dialog Header with Close Button -->
            <v-toolbar dense flat color="grey-darken-4" dark>
                <v-toolbar-title>{{ product.name }}</v-toolbar-title>
                <v-spacer></v-spacer>
                <v-btn icon @click="closeDialog">
                    <v-icon>mdi-close</v-icon>
                </v-btn>
            </v-toolbar>

            <!-- Image Carousel -->
            <v-carousel cycle height="512" hide-delimiter-background>
                <v-carousel-item v-for="(image, index) in product.imageUrls" :key="index">
                    <v-img :src="image" contain height="100%" />
                </v-carousel-item>
            </v-carousel>

            <!-- Product Details -->
            <v-card-text>
                <div class="text-h5 mb-2">{{ product.name }}</div>

                <!-- Rating and Stock -->
                <v-row align="center" class="mb-2">
                    <v-rating readonly half-increments length="5" size="24" :model-value="props.product.averageRating"
                        active-color="amber">
                    </v-rating>
                    <span class="ml-2">({{ product.averageRating }})</span>
                </v-row>

                <!-- Stock and Sold Count -->
                <v-row align="center" class="mb-2">
                    <v-chip color="amber lighten-4" class="ma-1">Remaining: {{ product.stockCount }}</v-chip>
                    <v-chip color="green lighten-4" class="ma-1">Sold: {{ product.soldCount }}</v-chip>
                </v-row>

                <!-- Price -->
                <div class="text-h6 text-yellow-darken-4 font-weight-bold mb-2">
                    {{ productService.formatPrice(product.price) }}
                </div>

                <!-- Category -->
                <div class="text-caption mb-2">
                    Category: <span class="font-weight-medium">{{ product.category }}</span>
                </div>

                <!-- Description -->
                <v-divider class="my-4" />
                <div class="text-body-2">
                    <v-icon left color="grey-darken-1">mdi-information-outline</v-icon>
                    {{ product.description }}
                </div>
            </v-card-text>
        </v-card>
    </v-dialog>
</template>

<script setup>
import { productService } from '@/services/productService';
import { useRouter } from 'vue-router';
import { ref } from 'vue';

const props = defineProps({
    product: {
        type: Object,
    },
    show: {
        type: Boolean,
        required: true,
    },
    showActions: {
        type: Boolean,
        default: true,
    }
});

const emit = defineEmits(['update:show']);
const router = useRouter();

const closeDialog = () => {
    emit('update:show', false);
};

</script>

<style scoped>
.text-h5 {
    font-weight: 500;
}

.text-primary {
    color: #1976d2 !important;
    /* Adjust to your primary color */
}
</style>