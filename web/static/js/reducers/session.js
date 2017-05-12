import * as types from '../constants/action-types'
import Cookie from 'js-cookie'

const initialState = {
  currentUser: Cookie.getJSON('currentUser') || {},
  authToken: Cookie.get('authToken') || null,
  authenticated: Cookie.get('authToken') ? true : false,
  errors: []
}

const session = (state = initialState, action) => {
  const response = action.response

  switch(action.type) {
    case types.SESSION_SIGNIN_SUCCESS:
      Cookie.set('currentUser', response.data)
      Cookie.set('authToken', response.meta.token, { expires: 7 })

      return Object.assign({}, state, {
        currentUser: response.data,
        authToken: response.meta.token,
        authenticated: true
      })

    case types.SESSION_SIGNIN_ERROR:
      return Object.assign({}, state, {
        errors: [action.message]
      })

    case types.SESSION_SIGNOUT:
      Cookie.remove('currentUser')
      Cookie.remove('authToken')

      return Object.assign({}, state, {
        currentUser: {},
        authToken: null,
        authenticated: false
      })

    case types.SESSION_SIGNUP_SUCCESS:
      Cookie.set('currentUser', action.user)

      return Object.assign({}, state, {
        currentUser: action.user
      })

    case types.SESSION_SIGNUP_ERROR:
      return Object.assign({}, state, {
        errors: [action.message]
      })

    default:
      return state
  }
}

export default session
