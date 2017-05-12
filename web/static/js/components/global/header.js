import React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { signout } from '../../actions/session'

class Header extends React.Component {
  renderUserMenu () {
    if (this.props.authenticated) {
      return (
        <div>
          {this.props.currentUser.email}
          <button onClick={this.props.signout}>Sign Out</button>
        </div>
      )
    } else {
      return (
        <div>
          <Link to="/sessions/signin">Sign In</Link>
          <Link to="/sessions/signup">Sign Up</Link>
        </div>
      )
    }
  }

  render () {
    return (
      <header className="c-globalheader bc-blue fixed top-0 left-0 w-100 pa3 tc">
        <Link to="/">
          <img src="/images/wn-logo.png" alt="Watch Nature" />
        </Link>

        {this.renderUserMenu()}
      </header>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    authenticated: state.session.authenticated,
    currentUser: state.session.currentUser
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    signout: () => {
      dispatch(signout())
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Header)
