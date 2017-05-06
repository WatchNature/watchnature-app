import * as types from '../constants/action-types'

const initialState = {
  all: [],
  fetching: false
}

const posts = (state = initialState, action) => {
  switch(action.type) {
    case types.FETCH_ALL_POSTS_START:
      return Object.assign({}, state, {
        fetching: action.fetching
      })

    case types.FETCH_ALL_POSTS_SUCCESS:
      return Object.assign({}, state, {
        all: action.posts,
        fetching: action.fetching
      })

    case types.FETCH_ALL_POSTS_ERROR:
      return Object.assign({}, state, {
        fetching: action.fetching
      })

    default:
      return state
  }
}

export default posts
