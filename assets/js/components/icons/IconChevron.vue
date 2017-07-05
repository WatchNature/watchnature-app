<template>
  <svg v-if="dir == 'left'" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" :stroke="stroke" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
    <polyline points="15 18 9 12 15 6"/>
  </svg>

  <svg v-else xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" :stroke="stroke" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <polyline points="9 18 15 12 9 6"/>
  </svg>
</template>

<script>
export default {
  name: 'IconChevron',

  props: {
    stroke: {
      type: String,
      required: false,
      default () { return '#ffffff' }
    },
    dir: {
      type: String,
      default: () => { return 'left' }
    }
  }
}
</script>
