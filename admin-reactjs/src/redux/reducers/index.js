import { combineReducers } from 'redux';
import notifyReducer from './notifyReducer';

export default combineReducers({
  notificator: notifyReducer,
});