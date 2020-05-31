import React, { Component } from 'react';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/SignInView';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Typography from '@material-ui/core/Typography';
//
import { notify } from '../components/Notification';
import { setCookiesValue } from '../utils/helper';
import { AccountAPIsService } from '../utils/apiCalling';

class SignInView extends Component {
  state = { username: '', password: '' }

  handleSignInClick = () => {
    AccountAPIsService.signIn(this.state.username, this.state.password)
      .then(response => response.json())
      .then(json => {
        switch (json.error.code) {
          case 401:
          case 404:
          case 500:
            notify(json.error.message, json.error.detail, "error");
            break;
          case 200:
            setCookiesValue("authToken", json.result.token);
            window.location.replace("/admin/dashboard");
            break;
          default:
            break;
        }
      })
      .catch(error => console.log(error));
  }

  render() {
    const { classes } = this.props;

    return (
      <form className={classes.form}>
        <Typography className={classes.title} variant="h2">
          Sign in
        </Typography>
        <Typography align="center" className={classes.sugestion} color="textSecondary" variant="body1">
          login with your administration account
        </Typography>
        <TextField className={classes.textField} fullWidth
          label="Username" type="text" required variant="outlined"
          value={this.state.username}
          onChange={e => this.setState({ username: e.target.value })}
        />
        <TextField className={classes.textField} fullWidth
          label="Password" type="password" required variant="outlined"
          value={this.state.password}
          onChange={e => this.setState({ password: e.target.value })}
        />
        <Button className={classes.signInButton} fullWidth
          color="primary" size="large" variant="contained"
          disabled={!validateInput(this.state.username, this.state.password)}
          onClick={this.handleSignInClick}
        >
          Sign in now
        </Button>
      </form>
    );
  }
}

SignInView.propTypes = {

};

export default withStyles(styles, { withTheme: true })(SignInView);

function validateInput(username, password) {
  if ("" === username.trim())
    return false;
  if ("" === password.trim())
    return false;
  return true;
}