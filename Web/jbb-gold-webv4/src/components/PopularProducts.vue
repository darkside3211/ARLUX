<template>
    <v-data-iterator :items="props.products" :items-per-page="itemsPerPage">
        <template v-slot:header="{ page, pageCount, prevPage, nextPage }">
            <h1 class="text-h4 font-weight-bold d-flex justify-space-between mb-4 align-center">
                <div class="text-truncate">
                    Most Popular Jewelries
                </div>

                <div class="d-flex align-center">
                    <v-btn class="me-8" variant="text" @click="onClickSeeAll">
                        <span class="text-decoration-underline text-none">See all</span>
                    </v-btn>

                    <div class="d-inline-flex">
                        <v-btn :disabled="page === 1" class="me-2" icon="mdi-arrow-left" size="small" variant="tonal"
                            @click="prevPage"></v-btn>
                        <v-btn :disabled="page === pageCount" icon="mdi-arrow-right" size="small" variant="tonal"
                            @click="nextPage"></v-btn>
                    </div>
                </div>
            </h1>
        </template>

        <template v-slot:default="{ items }">
            <v-row>
                <v-col v-for="(item, i) in items" :key="i" cols="12" sm="6" xl="3">
                    <v-card variant="outlined" @click="selectedProduct = item.raw, showDetails = true">
                        <v-img :src="item.raw.imageUrls[0]" height="150" cover></v-img>
                        <v-list-item density="comfortable" lines="three">
                            <template v-slot:title>
                                <strong class="text-h6">
                                    {{ item.raw.name }}
                                </strong>
                            </template>
                            <template v-slot:subtitle>
                                <div class="d-flex justify-space-between mb-2 align-center">
                                    <v-rating size="24" length="5" :model-value="item.raw.averageRating" active-color="amber"></v-rating>
                                    <div>Sold: {{ item.raw.soldCount }}</div>
                                </div>

                                <div>{{ item.raw.description }}</div>

                            </template>
                        </v-list-item>
                    </v-card>
                </v-col>
            </v-row>
        </template>

        <template v-slot:footer="{ page, pageCount }">
            <v-footer class="justify-space-between text-body-2 mt-4" color="surface-variant">
                Total Jewelries: {{ props.products.length }}

                <div>
                    Page {{ page }} of {{ pageCount }}
                </div>
            </v-footer>
        </template>
    </v-data-iterator>

    <ProductDetail :product="selectedProduct" :show="showDetails" :show-actions="false"
        @update:show="showDetails = $event" />
</template>

<script setup>
import { shallowRef, ref } from 'vue';
import ProductDetail from './ProductDetail.vue';

const props = defineProps({
    products: {
        type: Array,
        required: true,
    }
});

const itemsPerPage = shallowRef(4);
const selectedProduct = ref(props.products[0]);
const showDetails = ref(false);

function onClickSeeAll() {
    itemsPerPage.value = itemsPerPage.value === 4 ? props.products.length : 4;
}
</script>