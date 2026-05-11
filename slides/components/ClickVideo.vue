<script setup>
import { ref, onMounted, watch } from 'vue'

const props = defineProps({
  src: String,
  regions: {
    type: Array,
    required: true,
    // Format: [{ start: 0, end: 3 }, { start: 10, end: 15 }]
  },
  autoplay: Boolean,
  controls: Boolean,
})

const videoRef = ref(null)
const currentRegion = ref(0)

const onTimeUpdate = () => {
  const video = videoRef.value
  const { end } = props.regions[currentRegion.value] || {}
  if (video && end != null && video.currentTime >= end) {
    currentRegion.value++
    const next = props.regions[currentRegion.value]
    if (next) {
      video.currentTime = next.start
    } else {
      video.pause()
    }
  }
}

onMounted(() => {
  const video = videoRef.value
  if (props.autoplay) {
    const start = props.regions[0]?.start ?? 0
    video.currentTime = start
    video.play()
  }
})
</script>

<template>
  <video
    ref="videoRef"
    :autoplay="autoplay"
    :controls="controls"
    @timeupdate="onTimeUpdate"
    @loadedmetadata="() => {
      const start = regions[0]?.start ?? 0
      videoRef.value.currentTime = start
    }"
    style="max-width: 100%;"
  >
    <source :src="src" type="video/webm" />
    Your browser does not support the video tag.
  </video>
</template>