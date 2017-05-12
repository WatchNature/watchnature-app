import * as types from '../constants/action-types'

export function fetchAllPosts() {
  return (dispatch) => {
    dispatch(fetchAllPostsStart())

    fetch('/api/posts')
      .then(response => {
        return response.json()
      })
      .then(response => {
        let posts = response.data
        dispatch(fetchAllPostsSuccess(posts))
      })
      .catch(err => {
        console.error(err)
      })
  }
}

export function fetchAllPostsStart() {
  return {
    type: types.FETCH_ALL_POSTS_START,
    fetching: true
  }
}

export function fetchAllPostsSuccess(posts) {
  return {
    type: types.FETCH_ALL_POSTS_SUCCESS,
    fetching: false,
    posts: posts
  }
}

export function fetchAllPostsError(message) {
  return {
    type: types.FETCH_ALL_POSTS_ERROR,
    fetching: false
  }
}
