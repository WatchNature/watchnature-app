import React from 'react'

const Post = () => (
  <div>
    Post
  </div>
)

// const PostList = () => (

// )

class Stream extends React.Component {
  componentDidMount () {
    fetch('/api/posts')
      .then(response => {
        let posts = response.posts

        this.setState({
          posts: posts
        })
      })
      .catch(err => {
        console.error(err)
      })
  }

  render () {
    return (
      <div>
        The Stream
      </div>
    )
  }
}

export default Stream
