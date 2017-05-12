import React from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router-dom'
import { signout } from '../../actions/session'

class Header extends React.Component {
  renderUserMenu () {
    if (this.props.authenticated) {
      return (
        <div>
          <span className="white f6">{this.props.currentUser.email}</span>
          <button
            className="ml3 f6 button-reset pa0 bg-black-20 white pa2 bw0"
            onClick={this.props.signout}
          >Sign Out</button>
        </div>
      )
    } else {
      return (
        <div>
          <Link
            className="f6 pa0 bg-black-20 white pa2 dib no-underline"
            to="/sessions/signin"
          >Sign In</Link>
          <Link
            className="f6 pa0 bg-black-20 white pa2 ml2 dib no-underline"
            to="/sessions/signup"
          >Sign Up</Link>
        </div>
      )
    }
  }

  render () {
    return (
      <header className="c-globalheader bc-blue fixed top-0 left-0 w-100 pa3 flex items-center justify-between">
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
