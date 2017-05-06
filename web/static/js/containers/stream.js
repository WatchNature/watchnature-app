import React from 'react'
import { connect } from 'react-redux'
import { fetchAllPosts } from '../actions'
import PostSummarCard from '../components/post/summary-card'

const PostList = (props) => (
  <div>
    {props.posts.map((post) => (
      <PostSummarCard key={post.id} post={post} />
    ))}
  </div>
)

class Stream extends React.Component {
  componentDidMount () {
    this.props.fetchAllPosts()
  }

  render() {
    return (
      <div className="c-container pa3">
        <PostList posts={this.props.posts} />
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    posts: state.posts.all,
    fetching: state.fetching
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    fetchAllPosts: () => {
      dispatch(fetchAllPosts())
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Stream)
