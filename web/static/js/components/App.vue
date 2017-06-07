<template>
  <div>
    <global-header></global-header>

    <router-view></router-view>
  </div>
</template>

<script>
import GlobalHeader  from './global/GlobalHeader.vue'

export default {
  name: 'App',

  components: {
    GlobalHeader
  }
}
</script>

<style media="screen">
  body {
    margin: 0;
  }
</style>
