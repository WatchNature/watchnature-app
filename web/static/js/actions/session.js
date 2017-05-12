import * as types from '../constants/action-types'

export function signin(credentials) {
  return (dispatch) => {
    fetch('/auth/identity/callback', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(credentials)}
    )
      .then(response => {
        return response.json()
      })
      .then(response => {
        dispatch(signinSuccess(response))
      })
      .catch(err => {
        dispatch(signinError(err))
      })
  }
}

export function signinSuccess(response) {
  return {
    type: types.SESSION_SIGNIN_SUCCESS,
    response: response
  }
}

export function signinError(message) {
  return {
    type: types.SESSION_SIGNIN_ERROR,
    message: message
  }
}

export function signout() {
  return {
    type: types.SESSION_SIGNOUT
  }
}
