import _ from 'lodash'

const notifications = {
  namespaced: true,
  state: {
    all: []
  },

  getters: {
    all (state) {
      return state.all
    }
  },

  mutations: {
    add (state, notificationData) {
      state.all.push(notificationData)
    },

    dismiss (state, notificationId) {
      state.all = state.all.filter(
        item => item.id !== notificationId
      )
    }
  },

  actions: {
    add (context, payload) {
      return new Promise((resolve, reject) => {
        const notificationData = {
          id: _.uniqueId('notification'),
          type: payload.type,
          message: payload.message,
          dismissAfter: payload.dismissAfter
        }

        context.commit('add', notificationData)
      })
    },

    dismiss (context, notificationId) {
      return new Promise((resolve, reject) => {
        context.commit('dismiss', notificationId)
        resolve()
      })
    }
  }
}

export default notifications
