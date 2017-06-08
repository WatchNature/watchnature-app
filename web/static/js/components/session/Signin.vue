<template>
  <section class="container">
    <h1>Sign In</h1>

    <form @submit.prevent="signin">
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" id="email" v-model="email">
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" v-model="password">
      </div>
      <div class="form-actions">
        <input type="submit" value="Sign In">
      </div>
    </form>
  </section>
</template>

<script>
export default {
  name: 'Signup',

  data () {
    return {
      email: '',
      password: ''
    }
  },

  methods: {
    signin () {
      const payload = {
        email: this.email,
        password: this.password
      }

      this.$store.dispatch('signIn', payload)
        .then(response => {
          this.$router.push('/')
        })
        .catch(response => {
          alert(response.response.data.errors[0].detail)
        })

    }
  }
}
</script>
