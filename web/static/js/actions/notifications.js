import * as types from '../constants/action-types'
import { uniqueId } from 'lodash'

export function addNotification(notification) {
  return {
    type: types.ADD_NOTIFICATION,
    notification: {
      id: uniqueId('notification-'),
      type: notification.type,
      message: notification.message,
      dismissAfter: 3000
    }
  }
}

export function dismissNotification(notification) {
  return {
    type: types.DISMISS_NOTIFICATION,
    id: notification.id
  }
}
