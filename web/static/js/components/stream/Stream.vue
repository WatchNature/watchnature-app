<template>
  <section class="container">
    <header>
      <h1>The Stream</h1>
      <router-link :to="{ name: 'newpost' }">Add Post</router-link>
    </header>

    <post-list></post-list>
  </section>
</template>

<script>
import PostList from '../post/PostList.vue'

export default {
  name: 'Stream',

  components: {
    PostList
  },

  watch: {
    '$route': () => {
      this.bootstrap()
    }
  },

  methods: {
    bootstrap () {
      this.$store.dispatch('posts/findAll')
    }
  },

  created () {
    this.bootstrap()
  }
}
</script>
