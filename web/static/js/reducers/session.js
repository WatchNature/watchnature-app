import * as types from '../constants/action-types'

const initialState = {
  currentUser: {},
  authToken: null
}

const session = (state = initialState, action) => {
  switch(action.type) {
    case types.SESSION_SIGNIN_SUCCESS:
      console.log(action.message)
      return {}

    case types.SESSION_SIGNIN_ERROR:
      console.log(action.message)
      return {}

    default:
      return state
  }
}

export default session
