<template>
  <header>
    <h1>
      <router-link to="/">
        <img src="/images/wn-logo.png" alt="Watch Nature">
      </router-link>
    </h1>

    <nav v-if="!userIsAuthenticated">
      <router-link to="/signup">Sign Up</router-link>
      <router-link to="/signin">Sign In</router-link>
    </nav>

    <nav v-if="userIsAuthenticated">
      <router-link
        class="dn dib-m"
        :to="{ name: 'userprofile', params: { id: currentUser.id }}"
      >
        {{ currentUser.email }}
      </router-link>

      <button
        class="input-reset button-reset ma0 pa0 white bg-transparent bn f5"
        @click.prevent="signOut"
        type="button"
      >
        Sign Out
      </button>
    </nav>
  </header>
</template>

<script>
import _ from 'lodash'

export default {
  computed: {
    userIsAuthenticated () {
      return !_.isEmpty(this.$store.state.currentUser)
    },

    currentUser () {
      return this.$store.state.currentUser
    }
  },

  methods: {
    signOut () {
      this.$store.commit('removeCurrentUser')
      this.$store.commit('removeAuthToken')
    }
  }
}
</script>

<style lang="stylus" scoped>
@import '../../../../assets/css/_vars'

header
  background-color #316fbc
  background linear-gradient(to bottom, rgba(9,141,193,1) 0%, rgba(49,111,188,1) 100%)
  color #ffffff
  overflow hidden
  display flex
  align-items center
  padding $space-2
  position fixed
  top 0
  left 0
  width 100%

img
  max-width 160px

a
  color #ffffff

h1
  float left
  flex 1 auto
  margin 0
  a
    text-decoration none

nav
  float right

button
  margin-left $space-2
  -webkit-appearance none
</style>
