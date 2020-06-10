import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import * as serviceWorker from './serviceWorker';
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom';
// material-ui
import { ThemeProvider } from '@material-ui/styles';
import theme from './theme';
// core components
import Authentication from './layouts/Authentication';
import Administration from './layouts/Administration';
import Notification from './components/Notification';
//
import store from './redux/store';
import './assets/css/styles.css'

ReactDOM.render(
  <Provider store={store}>
    <ThemeProvider theme={theme}>
      <BrowserRouter>
        <Switch>
          <Route path="/admin/auth" render={props => <Authentication {...props} />} />
          <Route path="/admin" render={props => <Administration {...props} />} />

          <Redirect from="/" to="/admin/auth" />
        </Switch>
      </BrowserRouter>
      <Notification />
    </ThemeProvider>
  </Provider>
  , document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
