<template>
    <v-dialog v-model="props.show" max-width="600">
        <v-card>
            <v-card-title>
                <span class="text-h6">Order Details</span>
            </v-card-title>

            <v-card-subtitle>
                <span>
                    {{ `Added On: ${new Date(props.order.createdAt).toLocaleString('en-US', dateOptions)}` }}
                </span>
                <br />
                <span>
                    {{ `Updated At: ${new Date(props.order.updatedAt).toLocaleString('en-US', dateOptions)}` }}
                </span>
            </v-card-subtitle>

            <v-card-text>
                <!-- Display Order Summary -->
                <p><strong>Customer:</strong> {{ props.order.username }}</p>
                <p><strong>Order Reference:</strong> {{ props.order.checkoutID }}</p>
                <v-card variant="outlined" title="Address" class="my-4">
                    <v-divider />
                    <v-card-text class="text-medium-emphasize">
                        <div><strong>Address Line:</strong> {{ props.order.address.line1 }}</div>
                        <div><strong>Nearest Landmark:</strong> {{ props.order.address.line2 }}</div>
                        <div><strong>State:</strong> {{ props.order.address.city }} | {{ props.order.address.state }}
                        </div>
                        <div><strong>Zip-Code:</strong> {{ props.order.address.postal_code }}</div>
                    </v-card-text>
                </v-card>

                <v-card title="Ordered Items:" variant="tonal">
                    <v-divider />
                    <v-list dense>
                        <v-list-item v-for="(item, index) in props.order.productItems" :key="index"
                            :prepend-avatar="item.images[0]">
                            <v-list-item-title>{{ item.name }}</v-list-item-title>
                            <v-list-item-subtitle>Quantity: {{ item.quantity }}</v-list-item-subtitle>
                            <v-list-item-subtitle>Subtotal: {{
                                productService.formatPrice(item.quantity * item.amount) }}</v-list-item-subtitle>
                            <v-list-item-subtitle>Size: {{ item.size }}</v-list-item-subtitle>
                        </v-list-item>
                    </v-list>
                </v-card>

                <v-divider class="my-4"></v-divider>

                <!-- Editable Fields -->
                <v-form ref="form" v-model="formValid">
                    <v-select :disabled="props.order.orderStatus === 'Completed'" label="Order Status"
                        v-model="editableOrder.orderStatus" :items="remainingStatuses"
                        :rules="[v => !!v && v !== props.order.orderStatus || 'Order status is required']"></v-select>

                    <v-text-field
                        :disabled="props.order.orderStatus === 'toReceive' || props.order.orderStatus === 'Completed'"
                        label="Delivery Amount" v-model="editableOrder.deliveryAmount" type="number"
                        :rules="deliveryAmountRules" prefix="₱"></v-text-field>

                    <v-text-field
                        :disabled="props.order.orderStatus === 'toReceive' || props.order.orderStatus === 'Completed'"
                        label="Tracking Number" v-model="editableOrder.referenceNumber"
                        :rules="trackingNumberRules"></v-text-field>
                </v-form>

                <div class="text-h6">
                    <v-spacer />
                    Total: {{ productService.formatPrice(totalAmount) }}
                </div>
            </v-card-text>


            <!-- Action Buttons -->
            <v-card-actions>
                <v-btn text color="red" @click="closeDialog">Cancel</v-btn>
                <v-spacer></v-spacer>
                <v-btn :disabled="!formValid" color="green" @click="saveChanges">
                    Save
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script setup>
import { ref, watch, reactive, computed } from 'vue';
import { productService } from '@/services/productService';

const props = defineProps({
    order: {
        type: Object,
    },
    show: {
        type: Boolean,
        default: false,
    },
});

const emit = defineEmits(['update:show', 'update-order']);


// Editable local copy of the order
const editableOrder = reactive({ ...props.order });
const formValid = ref(false);
const totalAmount = computed(() => {
    return getTotalAmount();
});

// Order Status Options
const orderStatusValue = ref(4);
const orderColors = ['indigo', 'orange', 'grey', 'green'];
const statuses = ['toPay', 'toShip', 'toReceive', 'Completed'];
const startIndex = statuses.indexOf('toShip');

// Slice from the element after "toShip" (startIndex + 1) to the end
const remainingStatuses = startIndex !== -1 ? statuses.slice(startIndex + 1) : [];


// Watch for changes in the dialog visibility to reset order data
watch(() => props.show, (newVal) => {
    if (newVal) {
        Object.assign(editableOrder, props.order);
    }
});

// Close dialog
const closeDialog = () => {
    emit('update:show', false);
};

// Save changes and emit updated order data
const saveChanges = () => {
    emit('update-order', {
        checkoutID: editableOrder.checkoutID,
        newStatus: editableOrder.orderStatus,
        deliveryAmount: editableOrder.deliveryAmount,
        referenceNumber: editableOrder.referenceNumber
    });
    closeDialog();
};

function getTotalAmount() {
    return props.order.productItems.reduce((total, item) => {
        const amount = Number(item.amount) || 0;
        const quantity = Number(item.quantity) || 0;
        const delivery = Number(editableOrder.deliveryAmount) || 0;
        return total + (amount * quantity) + delivery;
    }, 0);
}

const deliveryAmountRules = [
    (v) => v !== null || 'Delivery amount is required',
    (v) => v > 0 || 'Delivery amount must be greater than zero',
];

const trackingNumberRules = [
    (v) => v !== null && v !== '' || 'Tracking number is required',
    (v) => v !== 'pending' || 'Tracking number cannot be "pending"',
];
</script>

<style scoped>
.text-h6 {
    font-weight: bold;
}

.v-card-text p {
    margin: 8px 0;
}
</style>