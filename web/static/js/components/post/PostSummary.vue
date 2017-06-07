<template lang="html">
  <article class="article">
    <p>{{ post.description }}</p>

    <div v-if="post.user" class="mb2">
      By <router-link :to="{ name: 'userprofile', params: { id: post.user.id }}">{{ post.user.email }}</router-link>
    </div>

    <div v-if="post.location_name">
      At {{ post.location_name }}, {{ post.location.lat }}, {{ post.location.lng }}
    </div>
  </article>
</template>

<script>
export default {
  name: 'PostSummary',

  props: {
    post: {
      type: Object,
      required: true
    }
  }
}
</script>

<style scoped>
  .article-container {
    margin: 2rem 0;
  }

  .article + .article {
    margin-top: 2rem;
  }
</style>
