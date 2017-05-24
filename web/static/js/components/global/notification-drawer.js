import React from 'react'
import { connect } from 'react-redux'
import { dismissNotification } from '../../actions/notifications'
import Notification from './notification'


class NotificationDrawer extends React.Component {
  render () {
    return (
      <div>
        {this.props.notifications.map((notification) => (
          <Notification
            key={notification.id}
            notification={notification}
            onClick={this.props.dismissNotification}
          />
        ))}
      </div>
    )
  }
}

const mapStateToProps = (state, ownProps) => {
  return {
    notifications: state.notifications.all
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    dismissNotification: (notification) => {
      dispatch(dismissNotification(notification))
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(NotificationDrawer)
