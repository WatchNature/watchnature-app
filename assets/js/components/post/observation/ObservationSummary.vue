<template>
  <div>
    <header class="observation_summary__header">
      <span
        v-if="observation.species"
        v-text="startCase(observation.species.common_name)"
      ></span>

      <span v-text="observation.location_name"></span>
    </header>

    <div class="observation_summary__image">
      <img v-if="firstImageUrl" :src="firstImageUrl" />
    </div>

    <div class="observation_summary__description">
      <p v-text="observation.description"></p>
    </div>
  </div>
</template>

<script>
import { startCase } from 'lodash'

export default {
  name: 'ObservationSummary',

  props: {
    observation: {
      type: Object,
      required: true
    }
  },

  computed: {
    firstImageUrl () {
      const images = this.observation.images

      if (images.length > 0) {
        return images[0].url
      } else {
        return null
      }
    }
  },

  methods: {
    startCase (str) {
      return startCase(str)
    }
  }
}
</script>

<style lang="stylus" scoped>
@import '../../../../../assets/css/_vars'

.observation_summary__image
  background $gray-1
  min-height 400px
  width 100%
  display flex
  align-items center
  justify-content center

.observation_summary__header
  padding $space-2
  display flex
  justify-content space-between

.observation_summary__description
  padding $space-2

.observation_summary__description > p
  margin 0
</style>
