<template>
  <section class="container">
    <h1>Sign Up</h1>

    <form @submit.prevent="signup">
      <div class="form-group" v-bind:class="{ 'form-group--error': $v.user.first_name.$error }">
        <label class="form__label">First Name</label>
        <input class="form__input" v-model.trim="user.first_name" @input="$v.user.first_name.$touch()">
      </div>
      <span class="form-group__message" v-if="$v.user.first_name.$error">First name is required</span>

      <div class="form-group" v-bind:class="{ 'form-group--error': $v.user.last_name.$error }">
        <label class="form__label">Last Name</label>
        <input class="form__input" v-model.trim="user.last_name" @input="$v.user.last_name.$touch()">
      </div>
      <span class="form-group__message" v-if="$v.user.last_name.$error">First name is required</span>

      <div class="form-group" v-bind:class="{ 'form-group--error': $v.user.email.$error }">
        <label class="form__label">Email</label>
        <input class="form__input" type="email" v-model.trim="user.email" @input="$v.user.email.$touch()">
      </div>
      <span class="form-group__message" v-if="$v.user.email.$error">Please enter a valid email address</span>

      <div class="form-group" v-bind:class="{ 'form-group--error': $v.user.password.$error }">
        <label class="form__label">Password</label>
        <input class="form__input" type="password" v-model.trim="user.password" @input="$v.user.password.$touch()">
      </div>
      <span class="form-group__message" v-if="$v.user.password.$error && !$v.user.password.required">A password is required.</span>
      <span class="form-group__message" v-if="!$v.user.password.minLength">Password must have at least {{ $v.user.password.$params.minLength.min }} characters.</span>
      <span class="form-group__message" v-if="!$v.user.password.maxLength">Password cannot have more than {{ $v.user.password.$params.maxLength.max }} characters.</span>

      <div v-if="!$v.user.$invalid">
        <input type="submit" value="Sign Up">
      </div>
      <div v-else>
        <input type="submit" value="Sign Up" disabled>
      </div>
    </form>
  </section>
</template>

<script>
import Axios from 'axios'
import { required, minLength, maxLength, email } from 'vuelidate/lib/validators'

export default {
  name: 'Signup',

  data () {
    return {
      user: {
        first_name: '',
        last_name: '',
        email: '',
        password: ''
      },
      errors: {}
    }
  },

  methods: {
    signup () {
      this.$store.dispatch('signUp', { user: this.user })
        .then(response => {
          this.$router.push('/')
          this.$store.dispatch('notifications/add', {
            type: 'success',
            message: 'Successfully signed up and logged in!'
          })
        })
        .catch(response => {
          console.log('Error signing up:')
          console.log(response.response.data.errors)

          if (response.response.data.errors.email) {
            this.$store.dispatch('notifications/add', {
              type: 'error',
              message: 'Unable to sign up, that email is already taken!'
            })
          } else {
            this.$store.dispatch('notifications/add', {
              type: 'error',
              message: 'Something went wrong, unable to sign up!'
            })
          }

        })
    }
  },

  validations: {
    user: {
      first_name: {
        required
      },
      last_name: {
        required
      },
      email: {
        required,
        email
      },
      password: {
        required,
        minLength: minLength(6),
        maxLength:maxLength(200)
      }
    }
  }
}
</script>
