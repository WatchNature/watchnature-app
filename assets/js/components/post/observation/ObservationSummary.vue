<template>
  <div>
    <header class="observation_summary__header">
      <span>observation.common_name</span>
      <span v-text="observation.location_name"></span>
    </header>

    <div class="observation_summary__image"></div>

    <div class="observation_summary__description">
      <p v-text="observation.description"></p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ObservationSummary',

  props: {
    observation: {
      type: Object,
      required: true
    }
  }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../assets/css/_vars'

.observation_summary__image
  background $gray
  height 400px
  width 100%

.observation_summary__header
  padding $space-2
  display flex
  justify-content space-between

.observation_summary__description
  padding $space-2

.observation_summary__description > p
  margin 0
</style>
