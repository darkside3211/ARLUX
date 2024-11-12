<template>
    <v-data-table density="comfortable" show-expand expand-on-click select-strategy="single" :sort-by="props.sortBy"
        :items-per-page="props.itemsPerPage" return-object :search="props.searchQuery" :headers="headers"
        :items="props.users" :height="props.height" item-value="email">
        <template v-slot:item.username="{ item }">
            <strong>{{ item.username || item.email }}</strong>
        </template>
        <template v-slot:item.status="{ item }">
            <div class="text-end">
                <v-btn @click="" :color="setStatusColor(item.status)" :text="item.status" class="text-uppercase" size="small"
                    label></v-btn>
            </div>
        </template>
        <template v-slot:item.createdAt="{ item }">
            <div>
                {{ `${new Date(item.createdAt).toLocaleString('en-US', dateOptions)}` }}
            </div>
        </template>
        <template v-slot:expanded-row="{ columns, item }">
            <tr v-for="address in item.addresses">
                <td :colspan="columns.length">
                    <v-list-item :key="address">
                        <v-list-item-subtitle>
                            <strong>{{ address.line1 }}</strong>
                            <p>{{ address.line2 }}</p>
                            <p>{{ address.city }} | {{ address.state }} | {{ address.postal_code }}</p>
                        </v-list-item-subtitle>

                    </v-list-item>
                </td>
            </tr>
        </template>
    </v-data-table>
</template>

<script setup>
import { ref } from 'vue';

const dialog = ref(false);
const selectedUser = ref(null);

const props = defineProps({
    users: {
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
        default: [{ key: 'createdAt', order: 'desc' }]
    }
});

const headers = ref([
    { title: 'Name', key: 'username', align: 'start' },
    { title: 'Email', key: 'email', align: 'end' },
    { title: 'Contact', key: 'phone', align: 'end' },
    { title: 'Status', key: 'status', align: 'end' },
    { title: 'Orders', key: 'orders', value: item => item.orders.length, align: 'end' },
    { title: 'Carts', key: 'cart', value: item => item.cartItems.length, align: 'end' },
    { title: 'Joined At', key: 'createdAt', align: 'end' },

]);

const dateOptions = {
    weekday: 'long',
    month: 'long',
    day: 'numeric',
    hour: 'numeric',
    minute: 'numeric'
};

function setStatusColor(status) {
    switch (status) {
        case 'pending':
            return 'cyan';
        case 'active':
            return 'green';
        default:
            return 'red';
    }
}
</script>