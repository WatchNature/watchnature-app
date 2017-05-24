import { combineReducers } from 'redux'
import posts from './posts'
import session from './session'
import notifications from './notifications'

export default combineReducers({
  posts,
  session,
  notifications
})
