const notifications = {
  namespaced: true,
  state: {
    all: [
      {
        id: "notification-uuid",
        type: "info",
        message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam magnam dolores minus ratione, doloremque quisquam cupiditate, totam! Debitis quas dolorem minima temporibus magnam necessitatibus. Illum magnam fugiat aut pariatur nihil."
      },
      {
        id: "notification-uuid3",
        type: "success",
        message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam magnam dolores minus ratione, doloremque quisquam cupiditate, totam! Debitis quas dolorem minima temporibus magnam necessitatibus. Illum magnam fugiat aut pariatur nihil.",
        dismissAfter: 2000
      },
      {
        id: "notification-uuid2",
        type: "error",
        message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam magnam dolores minus ratione, doloremque quisquam cupiditate, totam! Debitis quas dolorem minima temporibus magnam necessitatibus. Illum magnam fugiat aut pariatur nihil.",
        dismissAfter: 1000
      }
    ]
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
    dismiss (context, notificationId) {
      return new Promise((resolve, reject) => {
        context.commit('dismiss', notificationId)
        resolve()
      })
    }
  }
}

export default notifications
