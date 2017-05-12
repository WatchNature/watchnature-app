import React from 'react'
import { connect } from 'react-redux'
import { Redirect } from 'react-router-dom'
import { signup } from '../../actions/session'

class Signup extends React.Component {
  constructor (props) {
    super(props)

    this.state = {
      user: {
        first_name: '',
        last_name: '',
        email: '',
        password: ''
      }
    }

    this.onChange = this.onChange.bind(this)
    this.onSave = this.onSave.bind(this)
  }

  onChange(event) {
    const field = event.target.name
    const user = this.state.user
    user[field] = event.target.value
    return this.setState({user: user})
  }

  onSave(event) {
    event.preventDefault()
    this.props.signup(this.state.user)
  }

  render() {
    return (
      <div className="c-container pa3">
        {(this.props.currentUser.email && !this.props.authenticated ? <Redirect to="/sessions/signin" /> : null)}
        <form>
          <div className="mb3">
            <label className="db" htmlFor="first_name">First Name</label>
            <input className="db w-100" type="text" id="first_name" name="first_name"
              value={this.state.user.first_name}
              onChange={this.onChange}
            />
          </div>
          <div className="mb3">
            <label className="db" htmlFor="last_name">Last Name</label>
            <input className="db w-100" type="text" id="last_name" name="last_name"
              value={this.state.user.last_name}
              onChange={this.onChange}
            />
          </div>
          <div className="mb3">
            <label className="db" htmlFor="email">Email</label>
            <input className="db w-100" type="email" id="email" name="email"
              value={this.state.user.email}
              onChange={this.onChange}
            />
          </div>
          <div className="mb3">
            <label className="db" htmlFor="password">Password</label>
            <input className="db w-100" type="password" id="password" name="password"
              value={this.state.user.password}
              onChange={this.onChange}
            />
          </div>
          <div>
            <input type="submit" value="Sign Up" onClick={this.onSave} />
          </div>
        </form>
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    currentUser: state.session.currentUser,
    authenticated: state.session.authenticated
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    signup: (userData) => {
      dispatch(signup(userData))
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Signup)
