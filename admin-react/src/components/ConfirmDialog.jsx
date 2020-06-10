import React, { Component } from 'react'
import PropTypes from 'prop-types'
// material-ui
import Button from '@material-ui/core/Button';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogContentText from '@material-ui/core/DialogContentText';
import DialogTitle from '@material-ui/core/DialogTitle';

export default class AlertDialog extends Component {
  render() {
    return (
      <Dialog
        open={this.props.open}
        onClose={this.props.onClose}
      >
        <DialogTitle>{this.props.title}</DialogTitle>
        <DialogContent>
          <DialogContentText>{this.props.description}</DialogContentText>
        </DialogContent>
        <DialogActions>
          <Button onClick={this.props.onAgree}>
            Agree
          </Button>
          <Button onClick={this.props.onDisagree} color="primary">
            Disagree
          </Button>
        </DialogActions>
      </Dialog>
    )
  }
}

AlertDialog.propTypes = {
  open: PropTypes.bool.isRequired,
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  onClose: PropTypes.func.isRequired,
  onDisagree: PropTypes.func.isRequired,
  onAgree: PropTypes.func.isRequired,
}