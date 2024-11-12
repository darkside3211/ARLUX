<template>
    <v-data-table item-value="cartID" hover show-select :items-per-page="-1" :items="props.cart" :headers="headers"
        return-object :loading="props.loading" v-model="selectedProducts" @click:row="setSelected">
        <template v-slot:top>
            <v-toolbar flat class="px-4">
                <v-toolbar-title>
                    My Bag
                </v-toolbar-title>
                <v-divider class="mx-4" inset vertical></v-divider>
                <v-spacer></v-spacer>
                <div class="text-h6 text-amber-darken-3 font-weight-bold mx-6">Total: {{
                    productService.formatPrice(getTotalAmount()) }}</div>
                <v-btn variant="flat" color="amber" @click="proceedToCheckOut">CHECKOUT</v-btn>
            </v-toolbar>
        </template>
        <template v-slot:item.name="{ item }">
            <v-avatar :image="item.imageUrls[0]" size="24"></v-avatar>
            {{ item.name }}
        </template>
        <template v-slot:item.price="{ item }">
            {{ productService.formatPrice(item.price) }}
        </template>
        <template v-slot:item.size="{ item }">
            {{ item.size.size }} | {{ productService.formatPrice(item.size.additionalAmount) }}
        </template>
        <template v-slot:item.quantity="{ item }">
            x{{ item.quantity }}
        </template>
        <template v-slot:item.subTotal="{ item }">
            <div class="text-subtitle-1 text-amber-darken-3 font-weight-bold mx-6">{{
                productService.formatPrice((item.price * item.quantity) + item.size.additionalAmount) }}</div>
        </template>
    </v-data-table>

    <ProductDetail :product="selectedProduct" :show="showDetails" @update:show="showDetails = $event" />
</template>

<script setup>
import { ref } from 'vue';
import { productService } from '@/services/productService';
import { useUserStore } from '@/stores/userStore';
import { useRouter } from 'vue-router';
import ProductDetail from '../ProductDetail.vue';

const selectedProduct = ref(null);
const router = useRouter();
const userStore = useUserStore();
const showDetails = ref(false);
const selectedProducts = ref([]);

const emit = defineEmits(['update:selectedCart']);
const props = defineProps({
    loading: Boolean,
    cart: {
        type: Array,
        required: true,
        default: [],
    },
    searchQuery: {
        type: String,
    },
    height: {
        type: Number,
        default: 400,
    },
});

function setSelected(event, row) {
    selectedProducts.value.push(row.item);
    selectedProduct.value = row.item;
    showDetails.value = true;
}

function getTotalAmount() {
    return selectedProducts.value.reduce((total, item) => {
        return total + (item.price + item.size.additionalAmount) * item.quantity
    }, 0);
}

function proceedToCheckOut() {
    if (userStore.user.emailVerified && userStore.userInfo.addresses.length > 0 && userStore.userInfo.username && userStore.userInfo.phone) {
        //PROCEED
    } else {
        router.push("/account");
    }
}

const headers = ref([
    { title: 'Name', key: 'name', align: 'start' },
    { title: 'Base Price', key: 'price', align: 'end', },
    { title: 'Size/Amount', key: 'size', align: 'end' },
    { title: 'Quantity', key: 'quantity', align: 'end' },
    { title: 'SubTotal', key: 'subTotal', align: 'end' },
]);


</script>
