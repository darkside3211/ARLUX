<template>
    <v-dialog v-model="showDialog" max-width="400">
        <v-card>
            <v-card-title>
                Add To Cart
            </v-card-title>
            <!-- Footer Buttons -->
            <v-card-actions v-if="props.showActions" class="justify-end">

                <v-btn color="amber bg-grey-darken-2 mx-2" variant="tonal" @click="addToCart">
                    <v-icon left>mdi-cart</v-icon>
                    Add to Cart
                </v-btn>
                < <v-btn variant="tonal" @click="showDialog = false">
                    <v-icon left>mdi-cart</v-icon>
                    Cancel
                    </v-btn>
            </v-card-actions>
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
});

const emit = defineEmits(['update:show', 'add-to-cart']);
const showDialog = ref(props.show);

const selectedVariant = ref(props.product.sizes[0]);

const addToCart = () => {
    emit('add-to-cart', props.product);
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