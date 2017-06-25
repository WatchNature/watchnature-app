import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import cookies from 'js-cookie'

import notifications from './modules/notifications'
import posts from './modules/posts'
import postWizard from './modules/post-wizard'

Vue.use(Vuex)

const store = new Vuex.Store({
  strict: process.env.NODE_ENV !== 'production',

  state: {
    currentUser: cookies.getJSON('currentUser'),
    authToken: cookies.get('authToken')
  },

  modules: {
    notifications,
    posts,
    postWizard
  },

  getters: {
    currentUser (state) {
      return state.currentUser
    }
  },

  mutations: {
    setCurrentUser (state, user) {
      state.currentUser = user

      if (state.currentUser) {
        cookies.set('currentUser', state.currentUser)
      } else {
        cookies.remove('currentUser')
      }
    },

    setAuthToken (state, token) {
      state.authToken = token

      if (state.authToken) {
        cookies.set('authToken', state.authToken)
        axios.defaults.headers.common['Authorization'] = `Bearer ${state.authToken}`
      } else {
        cookies.remove('authToken')
        delete axios.defaults.headers.common['Authorization']
      }
    },

    removeCurrentUser (state) {
      state.currentUser = {}
      cookies.remove('currentUser')
    },

    removeAuthToken (state) {
      state.authToken = ''
      cookies.remove('authToken')
    }
  },

  actions: {
    signIn (context, payload) {
      return new Promise((resolve, reject) => {
        // eslint-disable-next-line no-undef
        axios.post(`${APP_BASE_URL}/auth/identity/callback`, payload)
          .then((response) => {
            context.commit('setCurrentUser', response.data.data)
            context.commit('setAuthToken', response.data.meta.token)
            resolve(response)
          })
          .catch((error) => reject(error))
      })
    },

    signUp (context, payload) {
      return new Promise((resolve, reject) => {
        // eslint-disable-next-line no-undef
        axios.post(`${API_BASE_URL}/users`, payload)
          .then((response) => {
            console.log(response)
            // context.commit('setCurrentUser', response.data.data)
            // context.commit('setAuthToken', response.data.meta.token)
            resolve(response)
          })
          .catch((error) => reject(error))
      })
    }
  }
})

export default store
