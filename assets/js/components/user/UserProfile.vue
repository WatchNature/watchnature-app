<template lang="html">
  <div class="container">
    <h1>Profile</h1>

    {{ currentUser.email }}
  </div>
</template>

<script>
export default {
  name: 'UserProfile',

  computed: {
    currentUser () {
      return this.$store.getters.currentUser
    }
  }
}
</script>
