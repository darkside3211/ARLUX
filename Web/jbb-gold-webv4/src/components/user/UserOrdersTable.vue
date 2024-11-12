<template>
    <v-data-table density="comfortable" :expanded="orderStore.orders" select-strategy="single" :sort-by="props.sortBy"
        :items-per-page="props.itemsPerPage" return-object :search="props.searchQuery" :headers="headers"
        :items="props.orders" :height="props.height" item-value="createdAt">
        <template v-slot:item.productItems="{ item }">
            <div>
                {{ getTotalAmount(item.productItems, item.deliveryAmount) }}
            </div>
        </template>
        <template v-slot:item.updatedAt="{ item }">
            <div>
                {{ `${new Date(item.updatedAt).toLocaleString('en-US', dateOptions)}` }}
            </div>
        </template>
        <template v-slot:expanded-row="{ columns, item }">
            <tr v-for="orderItems in item.productItems">
                <td :colspan="columns.length">
                    <v-list-item :key="orderItems" :prepend-avatar="orderItems.images[0]"
                        @click="checkProductInfo(orderItems.productID)">
                        <v-list-item-subtitle>
                            <strong>{{ orderItems.name }}</strong>
                            <div>{{ `Quantity: ${orderItems.quantity} | Subtotal:
                                ${productService.formatPrice(orderItems.amount *
                                orderItems.quantity)} | Size: ${orderItems.size}` }}
                            </div>
                        </v-list-item-subtitle>

                    </v-list-item>
                </td>
            </tr>
        </template>
        <template v-slot:item.orderStatus="{ item }">
            <v-btn :variant="item.orderStatus !== 'Completed' ? 'flat' : 'outlined'"
                :color="setOrderColor(item.orderStatus)" :text="item.orderStatus" class="text-uppercase" size="small"
                @click="selectedItem = item, actionDialog = item.orderStatus !== 'toPay'"></v-btn>
        </template>
        <template v-slot:item.referenceNumber="{ item }">
            <router-link href="https://www.lbcexpress.com/track/" target="_blank"
                @click="copyTracking(item.referenceNumber)">{{ item.referenceNumber }}</router-link>
        </template>
    </v-data-table>


    <v-dialog v-model="loading">
        <v-card>
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

    <ProductDetail :product="selectedProduct" :show="showDetails" @update:show="showDetails = $event" />
</template>

<script setup>
import { ref } from 'vue';
import ProductDetail from '@/components/ProductDetail.vue';
import { productService } from '@/services/productService';
import { useOrderStore } from '@/stores/orderStore';

const orderStore = useOrderStore();

const selectedItem = ref(null);
const selectedProduct = ref(null);
const showDetails = ref(false);
const loading = ref(false);
const error = ref(null);

const actionDialog = ref(false);


const props = defineProps({
    orders: {
        type: Array,
        required: true,
    },
    searchQuery: {
        type: String,
    },
    height: {
        type: Number,
        default: 400,
    },
    itemsPerPage: {
        type: Number,
        default: 10,
    },
    sortBy: {
        type: Array,
        default: [{ key: 'updatedAt', order: 'asc' }]
    }
});

function setSelected(event, row) {
    selectedItem.value = row.item;
}

function getTotalAmount(productItems, deliveryAmount) {
    const sum = productItems.reduce((total, item) => {
        const amount = Number(item.amount) || 0;
        const quantity = Number(item.quantity) || 0;
        const delivery = Number(deliveryAmount) || 0;
        return total + (amount * quantity) + delivery;
    }, 0);

    return productService.formatPrice(sum);
}

const dateOptions = {
    weekday: 'long',
    month: 'long',
    day: 'numeric',
    hour: 'numeric',
    minute: 'numeric'
};

const headers = ref([
    { title: 'Date', key: 'updatedAt', align: 'start' },
    { title: 'Actions', key: 'orderStatus', align: 'end', sortable: false },
    { title: 'Items', key: 'productItems.length', align: 'end' },
    { title: 'Total Amount', key: 'productItems', align: 'end' },
    { title: 'Tracking', key: 'referenceNumber', align: 'end' },
    { title: 'Reference', key: 'checkoutID', align: 'end' },
]);



function setOrderColor(order) {
    switch (order) {
        case 'toPay':
            return 'indigo';
        case 'toShip':
            return 'orange';
        case 'toReceive':
            return 'grey';
        case 'Completed':
            return 'green';
        default:
            return 'red';
    }
}

function checkProductInfo(productID) {
    loading.value = true;
    error.value = null;
    productService.getProductById(productID).then(
        (product) => {
            selectedProduct.value = product;
            loading.value = false;
            showDetails.value = true;
        }
    ).catch((err) => {
        error.value = err;
        loading.value = false;
    });
}

const updateOrder = (updatedOrder) => {
    loading.value = true;
    error.value = null;
    orderStore.modifyOrder(updatedOrder).then(
        (result) => {
            loading.value = false;
            orderStore.getAllOrders();
        }
    ).catch(
        (err) => {
            error.value = err.message;
            loading.value = false;
            orderStore.getAllOrders();
        }
    );
}

const copyTracking = (refNumber) => {
    navigator.clipboard.writeText(refNumber);

    alert(`Copied to Clipboard (${refNumber}) Paste tracking number to the field and press track`);
}
</script>