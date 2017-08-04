import _ from 'lodash'

// Posts can have more than one observation,
// but for the current version, the UI doesn't allow
// more than one observation to be created with a post.
const blankPost = {
  observations: [{
    species: {},
    species_id: null,
    description: '',
    location_name: '',
    location: {
      coordinates: [0, 0],
      type: 'Point'
    },
    tag_ids: [],
    images: [
      {
        url: null
      }
    ]
  }]
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
      return state.post.observations[0].description
    },

    location (state) {
      return state.post.observations[0].location
    },

    locationName (state) {
      return state.post.observations[0].location_name
    },

    imageUrl (state) {
      return state.post.observations[0].images[0].url
    },

    tagIds (state) {
      return state.post.observations[0].tag_ids
    },

    species (state) {
      return state.post.observations[0].species
    }
  },

  mutations: {
    addDescription (state, description) {
      state.post.observations[0].description = description
    },

    addLocation (state, { location, locationName }) {
      state.post.observations[0].location = location
      state.post.observations[0].location_name = locationName
    },

    addImageUrl (state, { url }) {
      state.post.observations[0].images[0].url = url
    },

    addTagIds (state, ids) {
      state.post.observations[0].tag_ids = ids
    },

    addSpecies (state, species) {
      let observation = state.post.observations[0]
      observation.species = species
      observation.species_id = species.id
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

    addImageUrl (context, { url }) {
      return new Promise((resolve, reject) => {
        context.commit('addImageUrl', { url })
        resolve()
      })
    },

    addTagids (context, ids) {
      return new Promise((resolve, reject) => {
        context.commit('addTagIds', ids)
        resolve()
      })
    },

    addSpecies (context, species) {
      return new Promise((resolve, reject) => {
        context.commit('addSpecies', species)
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
