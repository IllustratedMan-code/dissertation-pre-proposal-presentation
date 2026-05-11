<script setup>
import { onMounted, ref } from 'vue'
import { Fireworks } from 'fireworks-js'

const container = ref(null)

onMounted(() => {
  if (container.value) {
    const fireworks = new Fireworks(container.value, {
      hue: { min: 0, max: 360 },
      delay: { min: 15, max: 30 },
      speed: 2,
      acceleration: 1.05,
      friction: 0.97,
      gravity: 1.5,
      particles: 50,
      traceLength: 3,
      traceSpeed: 10,
      explosion: 5,
      intensity: 30,
      flickering: 50,
      lineStyle: 'round',
      autoresize: true,
    })
    fireworks.start()
  }
})
</script>

<template>
  <div ref="container" class="fixed inset-0 z-50 pointer-events-none" />
</template>