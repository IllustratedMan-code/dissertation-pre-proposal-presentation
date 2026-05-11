<script setup lang="ts">
import { computed } from 'vue'
import { resolveAssetUrl } from '../layoutHelper.ts'
import {parseRatio } from '../layoutHelper.ts'

const props = defineProps({
  image: {
    type: String,
  },
  class: {
    type: String,
  },
  ratio: {
    type: String,
    default: '1-1',
  },
})

const i = computed(() => resolveAssetUrl(props.image))
const { left, right } = parseRatio(props.ratio)
const gridStyle = {
  gridTemplateColumns: `${left}fr ${right}fr`
}

</script>

<template>
 <div 
    class="grid w-full h-full auto-rows-fr"
    :style="gridStyle"
  >
    <div class="p-3 w-full h-full flex flex-col items-center justify-center">
	 <img :src="i" class="max-w-full max-h-full min-h-0  -z-10" />
 	 <div class=" text-sm text-left opacity-70">
              <slot name="caption" />
      	 </div>
    </div>
    <div class="slidev-layout default" :class="props.class">
      <slot />
    </div>
  </div>
</template>