<template>
    <v-dialog v-model="props.show" max-width="800">
        <v-card>
            <v-card-title>
                <span class="text-h6">Edit Product</span>
            </v-card-title>

            <v-card-text>
                <!-- Image Grid with Toggle Delete and Add Image -->
                <div class="image-grid">
                    <h3>Images:</h3>
                    <v-row>
                        <v-col v-for="(image, index) in editedProduct.images" :key="index" cols="3">
                            <v-img :src="image.url" height="100" contain>
                                <v-btn small icon @click="toggleImageDelete(index)">
                                    <v-icon :color="image.isDelete ? 'red' : 'primary'">
                                        {{ image.isDelete ? 'mdi-delete' : 'mdi-pencil' }}
                                    </v-icon>
                                </v-btn>
                            </v-img>
                        </v-col>
                    </v-row>
                </div>

                <v-divider class="my-4"></v-divider>

                <v-file-input label="Add New Images" v-model="newImages" multiple show-size accept="image/*"
                    prepend-icon="mdi-camera" @change="onNewImageChange"></v-file-input>

                <!-- Editable Fields: Price, Description, Sizes -->
                <v-form ref="form" v-model="formValid">
                    <v-text-field label="Name" v-model="editedProduct.name"
                        :rules="[v => v.length >= 8 || 'Name should be at least 8 characters']"></v-text-field>
                    <v-text-field label="Base Price" type="number" v-model="editedProduct.price" prefix="₱"
                        :rules="[v => !isNaN(parseFloat(v)) || 'Invalid price']"></v-text-field>

                    <v-textarea label="Description" v-model="editedProduct.description" :auto-grow="true"></v-textarea>

                    <v-divider class="my-4"></v-divider>

                    <h3>Sizes</h3>
                    <v-row v-for="(size, index) in editedProduct.sizes" :key="index" align="center">
                        <v-col cols="3">
                            <v-text-field label="Size" v-model="size.size"></v-text-field>
                        </v-col>
                        <v-col cols="4">
                            <v-text-field label="Additional Amount" v-model="size.additionalAmount" type="number"
                                prefix="₱"></v-text-field>
                        </v-col>
                        <v-col cols="4">
                            <v-text-field label="Quantity" v-model="size.quantity" type="number"
                                :rules="[v => v > 0 || 'Quantity must be greater than zero']"></v-text-field>
                        </v-col>
                        <v-col cols="1">
                            <v-btn icon @click="removeSize(index)">
                                <v-icon color="red">mdi-delete</v-icon>
                            </v-btn>
                        </v-col>
                    </v-row>

                    <v-btn text color="blue" @click="addSize">Add Size</v-btn>
                </v-form>
            </v-card-text>

            <!-- Action Buttons -->
            <v-card-actions>
                <v-btn text color="red" @click="closeDialog">Cancel</v-btn>
                <v-spacer></v-spacer>
                <v-btn :disabled="!formValid" color="green" @click="submitChanges">
                    Save Changes
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-dialog>
</template>

<script setup>
import { ref, reactive, watch, computed } from 'vue';
import { adminService } from '@/services/adminService';

const props = defineProps({
    product: Object,
    show: Boolean,
});

const emit = defineEmits(['update:show', 'edit-product']);
const formValid = ref(false);

const editedProduct = reactive({
    ...props.product,
    images: props.product.imageUrls.map(url => ({ url, isDelete: false })),
    sizes: JSON.parse(JSON.stringify(props.product.sizes)), // Deep copy
});

const newImages = ref([]);

// Close dialog
const closeDialog = () => emit('update:show', false);

// Toggle image deletion
const toggleImageDelete = (index) => {
    editedProduct.images[index].isDelete = !editedProduct.images[index].isDelete;
};

// Handle new image preview
const onNewImageChange = () => {
    const imageUrls = Array.from(newImages.value).map(file => URL.createObjectURL(file));
    editedProduct.images.push(...imageUrls.map(url => ({ url, isDelete: false })));
};

// Add or remove sizes
const addSize = () => editedProduct.sizes.push({ size: '', additionalAmount: 0, quantity: 1 });
const removeSize = (index) => editedProduct.sizes.splice(index, 1);

// Submit edited data
const submitChanges = async () => {
    const toDeleteImages = editedProduct.images.filter(image => image.isDelete).map(image => image.url);
    const toKeepImages = editedProduct.images.filter(image => !image.isDelete).map(image => image.url);

    const formData = new FormData();
    formData.append('name', editedProduct.name);
    formData.append('price', editedProduct.price);
    formData.append('description', editedProduct.description);
    formData.append('sizes', JSON.stringify(editedProduct.sizes));
    formData.append('deleteImages', JSON.stringify(toDeleteImages));

    // Add new images
    newImages.value.forEach(file => formData.append('newImages', file));

    try {
        const updatedProduct = await adminService.editProduct(editedProduct.id, formData);
        emit('edit-product', updatedProduct);
        alert('Product updated successfully');
        closeDialog();
    } catch (error) {
        alert('Failed to update product');
    }
};

// Reset form when dialog opens
watch(() => props.show, (newVal) => {
    if (newVal) {
        Object.assign(editedProduct, {
            ...props.product,
            imageUrls: props.product.imageUrls || [],
            images: props.product.imageUrls.map(url => ({ url, isDelete: false })),
            sizes: JSON.parse(JSON.stringify(props.product.sizes)), // Deep copy
        });
        newImages.value = [];
    }
});
</script>

<style scoped>
.image-grid {
    margin-bottom: 1rem;
}
</style>