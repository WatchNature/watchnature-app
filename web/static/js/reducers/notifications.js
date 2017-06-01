import * as types from '../constants/action-types'

const initialState = {
  all: [
    {
      id: 'notification-1',
      type: 'info',
      message: 'Signed in successfully',
      dismissAfter: 3000
    }
  ]
}

const notifications = (state = initialState, action) => {
  switch (action.type) {
    case types.ADD_NOTIFICATION:
      let notifications = state.all.slice()
      notifications.splice(0, 0, action.notification)

      return Object.assign({}, state, {
        all: notifications
      })

    case types.DISMISS_NOTIFICATION:
      let remainingNotifications = state.all.filter(
        item => item.id !== action.id
      )

      return Object.assign({}, state, {
        all: remainingNotifications
      })

    default:
      return state
  }
}

export default notifications
