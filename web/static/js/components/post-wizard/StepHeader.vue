<template>
  <header>
    <router-link v-if="prevUrl" :to="prevUrl" class="mr2" title="Go Back">
      <icon-chevron class="v-mid"></icon-chevron>
    </router-link>

    <span>{{ title }}</span>
  </header>
</template>

<script>
import IconClose from '../icons/IconClose.vue'
import IconChevron from '../icons/IconChevron.vue'

export default {
  name: 'StepHeader',

  components: {
    IconClose,
    IconChevron
  },

  props: {
    title: {
      type: String,
      required: true
    },
    prevUrl: {
      type: String
    }
  }
}
</script>

<style scoped>
  header {
    background-color: #316fbc;
    background: linear-gradient(to bottom, rgba(9,141,193,1) 0%, rgba(49,111,188,1) 100%);
    color: #ffffff;
    overflow: hidden;
    display: flex;
    align-items: center;
    padding: 1rem;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
  }
</style>
