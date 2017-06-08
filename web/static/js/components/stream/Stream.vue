<template>
  <section class="container">
    <header>
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
