import axios from 'axios'

const tags = {
  namespaced: true,

  state: {
    all: []
  },

  getters: {
    allTags (state) {
      return state.all
    }
  },

  mutations: {
    replace (state, tags) {
      state.all = tags
    },

    add (state, tagData) {
      state.all.push(tagData)
    }
  },

  actions: {
    findAll (context) {
      return new Promise((resolve, reject) => {
        axios.get('tags')
          .then(response => {
            const tags = response.data.data
            context.commit('replace', tags)
            resolve(response.data.data)
          })
          .catch(response => {
            console.error(response)
            reject(response)
          })
      })
    }
  }
}

export default tags
