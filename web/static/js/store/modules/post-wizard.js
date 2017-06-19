import _ from 'lodash'

const blankPost = {
  description: '',
  location_name: '',
  location: {
    coordinates: [0, 0],
    type: 'Point'
  }
}

const postWizard = {
  namespaced: true,

  state: {
    post: _.cloneDeep(blankPost)
  },

  getters: {
    post (state) {
      return state.post
    },

    description (state) {
      return state.post.description
    },

    location (state) {
      return state.post.location
    },

    locationName (state) {
      return state.post.location_name
    }
  },

  mutations: {
    addDescription (state, description) {
      state.post.description = description
    },

    addLocation (state, { location, locationName }) {
      state.post.location = location
      state.post.location_name = locationName
    },

    reset (state) {
      state.post = _.cloneDeep(blankPost)
    }
  },

  actions: {
    addDescription (context, description) {
      return new Promise((resolve, reject) => {
        context.commit('addDescription', description)
        resolve()
      })
    },

    addLocation (context, { location, locationName }) {
      return new Promise((resolve, reject) => {
        context.commit('addLocation', { location, locationName })
        resolve()
      })
    },

    reset (context) {
      return new Promise((resolve, reject) => {
        context.commit('reset')
        resolve()
      })
    }
  }
}

export default postWizard
