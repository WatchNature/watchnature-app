<template lang="html">
  <section class="article-container">
    <post-summary
      v-for="post in allPosts"
      :key="post.id"
      :post="post"
    ></post-summary>
  </section>
</template>

<script>
import PostSummary from './PostSummary.vue'

export default {
  name: 'PostList',

  components: {
    PostSummary
  },

  computed: {
    allPosts () {
      return this.$store.getters['posts/allPosts']
    }
  }
}
</script>
