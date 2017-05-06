import { combineReducers } from 'redux'
import posts from './posts'
import session from './session'

export default combineReducers({
  posts,
  session
})
