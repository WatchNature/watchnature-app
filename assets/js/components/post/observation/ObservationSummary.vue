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

<style scoped>
.observation_summary__image {
  background-color: black;
  height: 400px;
  width: 100%;
}

.observation_summary__header {
  padding: 1rem;
  display: flex;
  justify-content: space-between;
}

.observation_summary__description {
  padding: 1rem;
}

.observation_summary__description > p {
  margin: 0;
}
</style>
