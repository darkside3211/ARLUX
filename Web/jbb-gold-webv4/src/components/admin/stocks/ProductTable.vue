<template>
    <v-data-table density="comfortable" select-strategy="single" v-model:sort-by="props.sortBy" items-per-page="10" return-object
        :search="props.searchQuery" :headers="headers" :items="props.products" height="400" item-value="name"
        @click:row="setSelected">
        <template v-slot:item.stockCount="{ item }">
            <div class="text-end">
                <v-chip :color="setStockColor(item.stockCount)" :text="item.stockCount.toString()" class="text-uppercase"
                    size="small" label></v-chip>
            </div>
        </template>
        <template v-slot:item.averageRating="{ item }">
            <v-rating :model-value="item.averageRating" color="orange-darken-2" density="compact" size="small" readonly
                half-increments></v-rating>
        </template>
    </v-data-table>

    <EditProduct v-if="selectedItem" :product="selectedItem" :show="editProduct" @update:show="editProduct = $event"
        @save-product="saveProduct" />

    <v-dialog v-model="resultDialog" max-width="256">
        <v-card title="Edit Product">
            <v-card-text>
                <v-progress-circular indeterminate v-if="loading"></v-progress-circular>
                <div v-else-if="error">{{ error }}</div>
                <div v-else>Success</div>
            </v-card-text>
            <v-card-actions v-if="!loading">
                <v-btn text="Close" variant="text" @click="resultDialog = false"></v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script setup>
import { ref } from 'vue';
import { adminService } from '@/services/adminService';
import { productService } from '@/services/productService';
import { useAdminConfigStore } from '@/stores/adminConfigStore';
import EditProduct from './EditProduct.vue';

const adminConfigStore = useAdminConfigStore();

const editProduct = ref(false);
const selectedItem = ref(null);

const loading = ref(false);
const error = ref(null);
const resultDialog = ref(false);

const props = defineProps({
    products: {
        type: Array,
        required: true,
    },
    searchQuery: {
        type: String,
    },
    sortBy: {
        type: Array,
        default: [{ key: 'stockCount', order: 'asc' }]
    }
});

function setSelected(event, row) {
    console.log("Clicked Item: ", row.item);
    selectedItem.value = row.item;
    editProduct.value = true;
}

const saveProduct = (updatedProduct) => {
    const {_id, ...newProduct} = updatedProduct;
    resultDialog.value = true;
    loading.value = true;
    error.value = null;
    adminService.editProduct(newProduct).then(
        (result) => {
            loading.value = false;
        }
    ).catch((err) => {
        loading.value = false;
        error.value = err;
    });
};

const headers = ref([
    { title: 'Name', key: 'name', align: 'start' },
    { title: 'Category', key: 'category', align: 'start' },
    { title: 'Stock', key: 'stockCount', align: 'end' },
    { title: 'Sold', key: 'soldCount', align: 'end' },
    {
        title: 'Rating',
        key: 'averageRating',
        align: 'center'
    },
    {
        title: 'Price(₱)',
        key: 'price', value: item => `${productService.formatPrice(item.price)}`,
        align: 'end'
    },
]);

function setStockColor(count) {
    if (count !== 0) {
        if (count > adminConfigStore.lowStockThreshold) {
            return 'green';
        } else {
            return 'orange';
        }
    } else {
        return 'red';
    }
}

</script>