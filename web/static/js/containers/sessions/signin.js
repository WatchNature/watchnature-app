import React from 'react'
import { connect } from 'react-redux'
import { signin } from '../../actions/session'

class Signin extends React.Component {
  constructor (props) {
    super(props)
    this.state = {credentials: {email: '', password: ''}}
    this.onChange = this.onChange.bind(this)
    this.onSave = this.onSave.bind(this)
  }

  onChange(event) {
    const field = event.target.name
    const credentials = this.state.credentials
    credentials[field] = event.target.value
    return this.setState({credentials: credentials})
  }

  onSave(event) {
    event.preventDefault()
    this.props.signin(this.state.credentials)
  }

  render() {
    return (
      <div className="c-container pa3">
        <form>
          <div className="mb3">
            <label className="db" htmlFor="email">Email</label>
            <input
              className="db w-100" type="email" id="email" name="email"
              value={this.state.credentials.email}
              onChange={this.onChange}
            />
          </div>
          <div className="mb3">
            <label className="db" htmlFor="password">Password</label>
            <input
              className="db w-100" type="password" id="password" name="password"
              value={this.state.credentials.password}
              onChange={this.onChange}
            />
          </div>
          <div>
            <input type="submit" value="Sign In" onClick={this.onSave} />
          </div>
        </form>
      </div>
    )
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    signin: (credentials) => {
      dispatch(signin(credentials))
    }
  }
}

export default connect(null, mapDispatchToProps)(Signin)
