<template>
  <router-link
    v-if="from"
    :to="from"
    :class="classes"
  >
     ← Back
  </router-link>

  <button
    v-else
    @click="goBack"
    :class="classes"
  >
     ← Back
  </button>
</template>

<script setup>
import { computed } from 'vue'


defineProps({
  from: {
    type: String,
    default: 'vocab',
  },
})

const goBack = () => history.back();

const classes = "absolute bottom-6 right-4 " +
           "bg-gray-100 text-gray-800 border border-gray-300 " +
           "dark:bg-gray-800 dark:text-gray-100 dark:border-gray-600 " +
           "rounded px-3 py-1 shadow hover:bg-gray-200 dark:hover:bg-gray-700";

</script>