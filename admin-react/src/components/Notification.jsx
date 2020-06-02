import React, { Component } from 'react';
import { connect } from 'react-redux';
// material-ui 
import Snackbar from '@material-ui/core/Snackbar';
import Alert from '@material-ui/lab/Alert';
import AlertTitle from '@material-ui/lab/AlertTitle';
// redux
import store from '../redux/store';
import { pushNotification, hideNotification } from '../redux/actions/notifyActions';

class Notification extends Component {
  handleClose = (event, reason) => {
    if ('clickaway' === reason)
      return;
    store.dispatch(hideNotification());
  };

  render() {
    return (
      <Snackbar
        open={this.props.notificator.isOpen}
        autoHideDuration={4000}
        onClose={this.handleClose}
        anchorOrigin={{ vertical: 'bottom', horizontal: 'right' }}
      >
        <Alert elevation={6} variant="filled"
          severity={this.props.notificator.notification.type}
          onClose={this.handleClose}
        >
          <AlertTitle>{this.props.notificator.notification.title}</AlertTitle>
          {this.props.notificator.notification.message}
        </Alert>
      </Snackbar>
    );
  }
}

const mapStateToProps = (state) => ({
  notificator: state.notificator,
});

export default connect(mapStateToProps, null)(Notification);
export function notify(title, message, type) {
  const notification = {
    title: title,
    message: message,
    type: "success",
  };

  switch (type) {
    case "success":
    case "error":
    case "info":
    case "warning":
      notification.type = type;
      break;

    default:
      break;
  }
  store.dispatch(pushNotification(notification));
}
