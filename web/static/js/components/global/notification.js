import React from 'react'

class Notification extends React.Component {
  constructor () {
    super()
    this._dismissNotification = this._dismissNotification.bind(this)
  }

  _dismissNotification () {
    this.props.onClick(this.props.notification)
  }

  render () {
    return (
      <div
        className={
          'fixed top-0 right-0 z-999 bg-green white pa3 ma2 ' +
            this.props.notification.id +
            ' ' +
            this.props.notification.type
        }
        onClick={this._dismissNotification}
      >
        <span>{this.props.notification.message}</span>
      </div>
    )
  }
}

export default Notification
