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

export function signup(userData) {
  const payload = {
    user: userData
  }

  return (dispatch) => {
    fetch('/api/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(payload)}
    )
      .then(response => {
        return response.json()
      })
      .then(response => {
        dispatch(signupSuccess(response.data))
      })
      .catch(err => {
        dispatch(signupError(err))
      })
  }
}

export function signupSuccess(user) {
  return {
    type: types.SESSION_SIGNUP_SUCCESS,
    user: user
  }
}

export function signupError(message) {
  return {
    type: types.SESSION_SIGNUP_ERROR,
    message: message
  }
}
