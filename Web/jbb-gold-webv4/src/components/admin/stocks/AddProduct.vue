<template>
  <v-dialog v-model="props.show" max-width="800">
    <v-card>
      <v-card-title>
        <span class="text-h6">Add New Product</span>
      </v-card-title>

      <v-card-text>
        <div class="image-grid">
          Images:
          <v-file-input label="Upload Images" v-model="files" multiple show-size accept="image/*"
            prepend-icon="mdi-camera" @change="onFileChange"></v-file-input>
          <v-row>
            <v-col v-for="(url, index) in previewImages" :key="index" cols="4">
              <v-img :src="url" height="100" contain></v-img>
            </v-col>
          </v-row>
        </div>

        <v-divider class="my-4"></v-divider>

        <!-- Editable Fields -->

        <v-form ref="form" v-model="formValid">
          <v-text-field label="Product Name" v-model="newProduct.name"
            :rules="[v => !!v || 'Name is required']"></v-text-field>

          <v-text-field label="Price" type="number" v-model="newProduct.price" prefix="₱"
            :rules="[v => !isNaN(parseFloat(v)) || 'Invalid price']"></v-text-field>

          <v-select label="Category" v-model="newProduct.category" :items="['Earring', 'Necklace', 'Bracelet', 'Ring']"
            :rules="[v => !!v || 'Category is required']"></v-select>

          <v-textarea label="Description" v-model="newProduct.description" :auto-grow="true"></v-textarea>

          <v-divider class="my-4"></v-divider>
          <h3>Sizes</h3>
          <v-row v-for="(size, index) in newProduct.sizes" :key="index" align="center">
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
        <v-btn :disabled="!formValid" color="green" @click="submitProduct">
          Save
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>

  <v-dialog v-model="loading" max-width="320" persistent>
    <v-list class="py-2" color="primary" elevation="12" rounded="lg">
      <v-list-item title="Adding Product...">
        <template v-slot:prepend>
          <div class="pe-4">
            <v-icon color="primary" size="x-large"></v-icon>
          </div>
        </template>

        <template v-slot:append>
          <v-progress-circular color="primary" indeterminate="disable-shrink" size="16" width="2"></v-progress-circular>
        </template>
      </v-list-item>
    </v-list>
  </v-dialog>
</template>

<script setup>
import { ref, reactive, watch } from 'vue';
import { adminService } from '@/services/adminService';

const props = defineProps({
  show: {
    type: Boolean,
    default: false,
  },
});

const loading = ref(false);

const emit = defineEmits(['update:show', 'add-product']);

const formValid = ref(false);
const files = ref([]);
const previewImages = ref([]);
const newProduct = reactive({
  name: '',
  price: 0,
  category: '',
  description: '',
  sizes: [],
  stockCount: 0,
});

const addSize = () => {
  newProduct.sizes.push({
    size: '',
    additionalAmount: 0,
    quantity: 1,
  });
};

const removeSize = (index) => {
  newProduct.sizes.splice(index, 1);
};

const closeDialog = () => {
  emit('update:show', false);
};

const onFileChange = () => {
  previewImages.value = Array.from(files.value).map(file =>
    URL.createObjectURL(file)
  );
};

const submitProduct = async () => {

  const formData = new FormData();
  formData.append('name', newProduct.name);
  formData.append('price', newProduct.price);
  formData.append('description', newProduct.description);
  formData.append('category', newProduct.category);
  formData.append('sizes', JSON.stringify(newProduct.sizes));

  files.value.forEach((file) => formData.append('files', file));

  adminService.addNewProduct(formData).then(
    (data) => {
      emit('add-product', data.product);
      alert('Product Added Successfully');
      closeDialog();
    }
  ).catch((error) => {
    alert('Failed to Add Product');
  });

}

// Reset form on dialog open
watch(() => props.show, (newVal) => {
  if (newVal) {
    Object.assign(newProduct, {
      name: '',
      price: 0,
      category: '',
      description: '',
      sizes: [],
      stockCount: 0,
    });
    files.value = [];
    previewImages.value = [];
  }
});
</script>

<style scoped>
/* Optional styling for the dialog */
</style>