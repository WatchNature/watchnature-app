import React from 'react'

class Notification extends React.Component {
  constructor () {
    super()
    this._dismissNotification = this._dismissNotification.bind(this)
  }

  _dismissNotification () {
    this.props.onClick(this.props.notification)
  }

  componentDidMount () {
    const dismissAfter = this.props.notification.dismissAfter

    if (dismissAfter !== undefined) {
      setTimeout(this._dismissNotification, dismissAfter)
    }
  }

  render () {
    return (
      <div
        className={
          `fixed top-0 right-0 z-999 white pa3 ma2 bc-${this.props.notification.type} ${this.props.notification.id}`
        }
        onClick={this._dismissNotification}
      >
        <span>{this.props.notification.message}</span>
      </div>
    )
  }
}

export default Notification
