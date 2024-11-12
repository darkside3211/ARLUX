<template>
    <v-container>
        <div class="d-flex align-center justify-center text-h3 font-weight-bold ma-4">STOCKS</div>
        <PopularProducts v-if="productStore.popularProducts.length !== 0" :products="productStore.popularProducts" />
        <v-card class="my-4" :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="green-darken-1"
            :loading="productStore.loading" :disabled="productStore.loading">
            <v-card-title>
                Current Stock
                <v-container>
                    <v-text-field v-model="searchQuery" label="Search" prepend-inner-icon="mdi-magnify"
                        :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" hide-details
                        single-line></v-text-field>
                </v-container>
            </v-card-title>
            <v-card-subtitle>
                <v-row>
                    <v-col>
                        As of {{ date.toLocaleString(undefined, dateOptions) }}
                        <v-spacer></v-spacer>
                        s
                    </v-col>
                </v-row>
            </v-card-subtitle>
            <v-card-text>
                <v-btn color="green" variant="flat" prepend-icon="mdi-plus" @click="setAdd">
                    Add New
                </v-btn>
                <ProductTable :search-query="searchQuery" :products="productStore.products" />
            </v-card-text>
            <v-card-actions>
                <v-spacer />
                <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" @click="refreshProductTable">
                    <v-icon>mdi-refresh</v-icon>
                    Refresh
                </v-btn>
            </v-card-actions>
        </v-card>
        <v-row>
            <v-col cols="6">
                <v-card class="mt-4" :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'"
                    color="yellow-darken-4" :loading="productStore.loading" :disabled="productStore.loading">
                    <v-card-title>
                        Low Stocks
                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString("en-US", dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <ProductTable :products="productStore.lowStock"
                            :sort-by="[{ key: 'stockCount', order: 'asc' }]" />
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer />
                        <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'"
                            @click="refreshProductTable">
                            <v-icon>mdi-refresh</v-icon>
                            Refresh
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
            <v-col cols="6">
                <v-card class="mt-4" :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'" color="red-darken-3"
                    :loading="productStore.loading" :disabled="productStore.loading">
                    <v-card-title>
                        Out of Stock
                    </v-card-title>
                    <v-card-subtitle>As of {{ date.toLocaleString("en-US", dateOptions) }}</v-card-subtitle>
                    <v-card-text>
                        <ProductTable :products="productStore.outOfStock"
                            :sort-by="[{ key: 'stockCount', order: 'asc' }]" />
                    </v-card-text>
                    <v-card-actions>
                        <v-spacer />
                        <v-btn :variant="globalStore.theme === 'light' ? 'flat' : 'outlined'"
                            @click="refreshProductTable">
                            <v-icon>mdi-refresh</v-icon>
                            Refresh
                        </v-btn>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </v-container>

    <AddProduct v-model:show="showAdd" @add-product="handleNewProduct" />
</template>

<script setup>
import ProductTable from '@/components/admin/stocks/ProductTable.vue';
import PopularProducts from '@/components/PopularProducts.vue';
import AddProduct from '@/components/admin/stocks/AddProduct.vue';
import { ref, onMounted, onUnmounted } from 'vue';
import { useProductStore } from '@/stores/productStore';
import { useGlobalStore } from '@/stores/globalStore';
import { useAdminConfigStore } from '@/stores/adminConfigStore';

const productStore = useProductStore();
const globalStore = useGlobalStore();
const adminConfigStore = useAdminConfigStore();
const searchQuery = ref('');
const showAdd = ref(false);

let refreshID;

const date = ref(new Date());
const dateOptions = {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: 'numeric',
    minute: 'numeric',
    second: 'numeric'
};

onMounted(() => {
    productStore.fetchAllProducts();
    refreshID = setInterval(() => {
        date.value = new Date();
        productStore.fetchAllProducts();
    }, adminConfigStore.refreshInterval);
});

onUnmounted(() => {
    clearInterval(refreshID);
});


const setAdd = () => {
    showAdd.value = true;
}

const handleNewProduct = (product) => {
    console.log('new product added: ', product);
    refreshProductTable();
}


const refreshProductTable = () => {
    date.value = new Date();
    productStore.fetchAllProducts();
}
</script>