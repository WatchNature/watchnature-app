<template>
  <section class="container">
    <h1>Sign Up</h1>

    <form @submit.prevent="signup">
      <div>
        <label for="first_name">First Name</label>
        <input type="text" id="first_name" v-model="user.first_name">
      </div>
      <div>
        <label for="last_name">Last Name</label>
        <input type="text" id="last_name" v-model="user.last_name">
      </div>
      <div>
        <label for="email">Email</label>
        <input type="email" id="email" v-model="user.email">
      </div>
      <div>
        <label for="password">Password</label>
        <input type="password" id="password" v-model="user.password">
      </div>
      <div>
        <input type="submit" value="Sign Up">
      </div>
    </form>
  </section>
</template>

<script>
import Axios from 'axios'

export default {
  name: 'Signup',

  data () {
    return {
      user: {
        first_name: '',
        last_name: '',
        email: '',
        password: ''
      }
    }
  },

  methods: {
    signup () {
      this.$store.dispatch('signUp', { user: this.user })
        .then(response => {
          this.$router.push('/')
        })
        .catch(response => {
          // Handle the various error objects that could come through
          console.log(response.response.data.errors)
        })
    }
  }
}
</script>
