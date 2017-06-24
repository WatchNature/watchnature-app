import _ from 'lodash'

const blankPost = {
  observation: {
    description: '',
    location_name: '',
    location: {
      coordinates: [0, 0],
      type: 'Point'
    },
    tag_ids: []
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
    },

    tagIds (state) {
      return state.post.tag_ids
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

    addTagIds (state, ids) {
      state.post.observation.tag_ids = ids
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

    addTagids (context, ids) {
      return new Promise((resolve, reject) => {
        context.commit('addTagIds', ids)
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
