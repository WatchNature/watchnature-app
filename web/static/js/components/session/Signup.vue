<template>
  <section class="container">
    <h1>Sign Up</h1>
  
    <form @submit.prevent="signup">
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
        email: '',
        password: ''
      }
    }
  },

  methods: {
    signup () {
      const payload = {
        data: {
          type: 'users',
          attributes: this.user
        }
      }

      Axios.post(`${API_BASE_URL}/users`, payload)
        .then((response) => {
          this.$store.commit('setCurrentUser', response.data.data)
          this.$store.commit('setAuthToken', response.data.meta.token)
          this.$router.push({ path: '/' })
        })
        .catch((error) => {
          console.log(error)
        })
    }
  }
}
</script>
