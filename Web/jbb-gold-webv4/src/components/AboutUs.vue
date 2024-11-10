<template>
    <v-footer class="bg-grey-darken-3 text-center d-flex flex-column footer-container">
        <div>
            <v-btn v-for="icon in icons" :key="icon" :icon="icon" class="mx-4" variant="text"></v-btn>
        </div>

        <div class="pt-0 subtitle font-italic">
            At JBB GOLD, we believe in redefining the way you experience luxury. With
            a passion for craftsmanship and innovation, we combine timeless jewelry
            designs with cutting-edge technology to offer a truly immersive shopping
            experience. Our fine jewelry collection is now more accessible than ever
            through our advanced 3D viewing and augmented reality (AR) features.
        </div>

        <v-divider></v-divider>

        <div class="subtitle font-italic">
            {{ new Date().getFullYear() }} — <strong>JBB Gold</strong>
        </div>
    </v-footer>


</template>

<script setup>
const icons = [
    'mdi-facebook',
    'mdi-facebook-messenger',
    'mdi-instagram',
]
</script>

<style scoped>

.subtitle {
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif
}
</style>