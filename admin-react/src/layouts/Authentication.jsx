import React, { Component } from 'react';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/Authentication';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import Grid from '@material-ui/core/Grid';
import Typography from '@material-ui/core/Typography';
import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
//
import { notify } from '../components/Notification';
import { setCookiesValue, hashToSHA1, getCookiesValue } from '../utils/helpers';

const quote = "Hella narwhal Cosby sweater McSweeney's, salvia kitsch before they sold out High Life.";

class Authentication extends Component {
  constructor(props) {
    super(props);
    this.state = { username: '', password: '' }
    window.AccountAPIsService_CheckAuth(getCookiesValue('authToken'))
      .then(() => this.props.history.push('admin/dashboard'));
  }

  handleSignInClick = () => {
    const requestBody = {
      username: this.state.username,
      sha1Pass: hashToSHA1(this.state.password),
    };
    window.AccountAPIsService_Authenticate(requestBody)
      .then(result => {
        switch (result.statusCode) {
          case 401:
          case 404:
          case 500:
            notify(result.json.error.message, result.json.error.detail, "error");
            break;
          case 200:
            setCookiesValue("authToken", result.json.result.token);
            this.props.history.push('/admin/dashboard');
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
      <>
        <AppBar className={classes.appbar} color='primary' position='fixed'>
          <Toolbar>
            <a className="navbar-brand" rel="noopener noreferrer" href="http://awakecup.ddns.net" target="_blank" >
              Coffee<small>Awakecup</small>
            </a>
          </Toolbar>
        </AppBar>
        <div className={classes.root}>
          <Grid className={classes.grid} container>
            <Grid className={classes.quoteContainer} item lg={5}>
              <div className={classes.quote}>
                <div className={classes.quoteInner}>
                  <Typography className={classes.quoteText} variant="h2">{quote}</Typography>
                </div>
              </div>
            </Grid>
            <Grid className={classes.content} item lg={7} xs={12}>
              <div className={classes.content}>
                <div className={classes.contentBody}>
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
                </div>
              </div>
            </Grid>
          </Grid>
        </div>
      </>
    );
  }
}

export default withStyles(styles, { withTheme: true })(Authentication);

function validateInput(username, password) {
  if ("" === username.trim())
    return false;
  if ("" === password.trim())
    return false;
  return true;
}