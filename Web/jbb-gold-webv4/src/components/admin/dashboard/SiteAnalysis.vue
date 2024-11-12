<template>
    <v-card>
        <v-card-title>
            Site Analytics
        </v-card-title>
        <v-card-subtitle>
            From {{ currentDate }}
        </v-card-subtitle>
        <v-card-text>
            <VueApexCharts :height="props.height" width="100%" type="area" :options="chartOptions" :series="series">
            </VueApexCharts>
        </v-card-text>
        <v-card-actions>
            <v-spacer />
            <v-btn @click="refreshAnalytics">
                <v-icon>mdi-refresh</v-icon>
                Refresh
            </v-btn>
        </v-card-actions>
    </v-card>

</template>

<script setup>
import VueApexCharts from 'vue3-apexcharts';
import { ref, onMounted, onUnmounted, computed } from 'vue';
import { adminService } from '@/services/adminService';
import { useAdminConfigStore } from '@/stores/adminConfigStore';

let analyticsID;
const props = defineProps({
    height: {
        type: String || Number,
        default: 256
    }
});
const series = ref([]);
const currentDate = computed(() => {
    const d = new Date();
    var day = d.getDay(),
        diff = d.getDate() - day + (day == 0 ? -6 : 0); // adjust when day is sunday
    return new Date(d.setDate(diff)).toLocaleDateString(undefined, {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric',
    });
});

function refreshAnalytics() {
    adminService.getAnalytics().then(
        (analytics) => {
            series.value = analytics;
        }
    )
}

onMounted(() => {
    refreshAnalytics();

    analyticsID = setInterval(() => {
        refreshAnalytics()
    }, useAdminConfigStore().refreshInterval);
});

onUnmounted(() => {
    clearInterval(analyticsID);
})

const chartOptions = {
    stroke: {
        curve: 'smooth'
    },
    markers: {
        size: 5,
    },
    xaxis: {
        categories: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
    },
    noData: {
        text: 'No data to display',
        align: 'center',
        verticalAlign: 'middle',
        offsetX: 0,
        offsetY: 0,
        style: {
            color: 'white',
            fontSize: '64px',
        }
    },
    theme: {
        mode: 'dark',
        palette: 'palette1',
    }
};
</script>
