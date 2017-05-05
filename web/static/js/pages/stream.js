import React from 'react'
import PostSummarCard from '../components/post/summary-card'

const PostList = (props) => (
  <div>
    {props.posts.map((post) => (
      <PostSummarCard key={post.id} post={post} />
    ))}
  </div>
)

class Stream extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      posts: []
    }
  }

  componentDidMount() {
    fetch('/api/posts')
      .then(response => {
        return response.json()
      })
      .then(response => {
        console.log(response.data)
        let posts = response.data
        this.setState({ posts: posts })
      })
      .catch(err => {
        console.error(err)
      })
  }

  render() {
    return (
      <div className="container">
        <PostList posts={this.state.posts} />
      </div>
    )
  }
}

export default Stream
