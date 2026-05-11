<!--
  Usage:

```md
---
layout: two-cols
---

# Left

This shows on the left

::right::

# Right

This shows on the right
```

-->

<script setup lang="ts">
const props = defineProps({
  class: {
    type: String,
  },
  layoutClass: {
    type: String,
  },
  ratio: {
    type: String,
    default: '1-1',
  }
})

const parseRatio = (ratioString: string) => {
  const parts = ratioString.split('-')
  if (parts.length !== 2) return { left: 1, right: 1 }
  
  const left = parseFloat(parts[0]) || 1
  const right = parseFloat(parts[1]) || 1
  
  return { left, right }
}


const { left, right } = parseRatio(props.ratio)
const gridStyle = {
  gridTemplateColumns: `${left}fr ${right}fr`
}
</script>



<template>
  <div 
    class="slidev-layout two-columns w-full h-full grid gap-5" 
    :class="props.layoutClass"
    :style="gridStyle"
  >
    <div class="col-left" :class="props.class">
      <slot />
    </div>
    <div class="col-right" :class="props.class">
      <slot name="right" />
    </div>
  </div>
</template>>