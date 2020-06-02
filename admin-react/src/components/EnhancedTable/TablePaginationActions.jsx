import React from 'react';
import PropTypes from 'prop-types';
// material-ui
import { useTheme } from '@material-ui/core/styles';
import IconButton from '@material-ui/core/IconButton';
import FirstPageIcon from '@material-ui/icons/FirstPage';
import KeyboardArrowLeft from '@material-ui/icons/KeyboardArrowLeft';
import KeyboardArrowRight from '@material-ui/icons/KeyboardArrowRight';
import LastPageIcon from '@material-ui/icons/LastPage';

function TablePaginationActions(props) {
  const theme = useTheme();
  const lastPage = Math.max(0, Math.ceil(props.count / props.rowsPerPage) - 1);

  return (
    <div style={{ flexShrink: 0, marginLeft: 10 }}>
      <IconButton onClick={e => props.onChangePage(e, 0)} disabled={props.page === 0}>
        {theme.direction === 'rtl' ? <LastPageIcon /> : <FirstPageIcon />}
      </IconButton>
      <IconButton onClick={e => props.onChangePage(e, props.page - 1)} disabled={props.page === 0}>
        {theme.direction === 'rtl' ? <KeyboardArrowRight /> : <KeyboardArrowLeft />}
      </IconButton>
      <IconButton onClick={e => props.onChangePage(e, props.page + 1)} disabled={props.page >= lastPage}>
        {theme.direction === 'rtl' ? <KeyboardArrowLeft /> : <KeyboardArrowRight />}
      </IconButton>
      <IconButton onClick={e => props.onChangePage(e, lastPage)} disabled={props.page >= lastPage}>
        {theme.direction === 'rtl' ? <FirstPageIcon /> : <LastPageIcon />}
      </IconButton>
    </div>
  );
}

TablePaginationActions.propTypes = {
  count: PropTypes.number.isRequired,
  onChangePage: PropTypes.func.isRequired,
  page: PropTypes.number.isRequired,
  rowsPerPage: PropTypes.number.isRequired,
};

export default TablePaginationActions;