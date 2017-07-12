<template lang="html">
  <article class="post_summary">
    <observation-list
      :observations="post.observations"
    ></observation-list>

    <div v-if="post.user" class="post_summary__meta">
      By <router-link :to="{ name: 'userprofile', params: { id: post.user.id }}">{{ post.user.email }}</router-link>
    </div>
  </article>
</template>

<script>
import ObservationList from './observation/ObservationList.vue'

export default {
  name: 'PostSummary',

  components: {
    ObservationList
  },

  props: {
    post: {
      type: Object,
      required: true
    }
  }
}
</script>

<style scoped>
.post_summary {
  background-color: white;
}

.post_summary + .post_summary {
  margin-top: 1rem;
}

.post_summary__meta {
  padding: 1rem;
}
</style>
