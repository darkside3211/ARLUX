<template>
    <div>
        <v-dialog v-model="isSearchOpen" width="100%" persistent hide-overlay>
            <v-card class="elevation-1 search-bar">
                <v-text-field v-model="searchQuery" label="Search..." outlined append-icon="mdi-close"
                    @click:append="closeSearch" @input="onInput" ref="searchInput" hide-details />
                <v-menu v-if="filteredSuggestions.length" v-model="menu" activator="parent" open-on-click
                    transition="scale-transition" offset-y>
                    <v-list>
                        <v-list-item v-for="(suggestion, index) in filteredSuggestions" :key="index"
                            @click="selectSuggestion(suggestion)">
                            <v-list-item-content>{{ suggestion }}</v-list-item-content>
                        </v-list-item>
                    </v-list>
                </v-menu>
            </v-card>
        </v-dialog>
    </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';

const isSearchOpen = ref(false);
const searchQuery = ref('');
const menu = ref(false);
const suggestions = ref([
    'Gold Necklace',
    'Diamond Earrings',
    'Silver Bracelet',
    'Engagement Ring',
    'Wedding Band',
]); // Sample data; replace with actual data if needed.

const filteredSuggestions = computed(() =>
    searchQuery.value
        ? suggestions.value.filter((item) =>
            item.toLowerCase().includes(searchQuery.value.toLowerCase())
        )
        : []
);

// Open search dialog and focus the input field
const openSearch = () => {
    isSearchOpen.value = true;
    menu.value = false;
    setTimeout(() => {
        if (refs.searchInput) refs.searchInput.focus();
    }, 100);
};

// Close search dialog
const closeSearch = () => {
    isSearchOpen.value = false;
    searchQuery.value = '';
};

// Update menu state based on input
const onInput = () => {
    menu.value = !!searchQuery.value;
};

// Handle suggestion selection
const selectSuggestion = (suggestion) => {
    searchQuery.value = suggestion;
    menu.value = false;
    // Navigate to search results or trigger a search here
    closeSearch();
};

// Expose the `openSearch` method to be called from parent component
onMounted(() => {
    openSearch();
});

</script>

<style scoped>
.search-bar {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    z-index: 1000;
    padding: 8px;
}

.v-text-field__append-inner .mdi-close {
    cursor: pointer;
}
</style>