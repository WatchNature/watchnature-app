import * as types from '../constants/action-types'
import Cookie from 'js-cookie'

const initialState = {
  currentUser: Cookie.getJSON('currentUser') || {},
  authToken: Cookie.get('authToken') || null,
  authenticated: Cookie.get('authToken') ? true : false
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
      console.log(action.message)
      return state

    case types.SESSION_SIGNOUT:
      Cookie.remove('currentUser')
      Cookie.remove('authToken')

      return Object.assign({}, state, {
        currentUser: {},
        authToken: null,
        authenticated: false
      })

    default:
      return state
  }
}

export default session
