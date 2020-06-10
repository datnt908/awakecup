import React, { Component } from 'react';
import PropTypes from 'prop-types';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../../theme/styles/EnhancedTable';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';
import TableFooter from '@material-ui/core/TableFooter';
import TablePagination from '@material-ui/core/TablePagination';
import Checkbox from '@material-ui/core/Checkbox';

// core component
import EnhancedTableHead from './EnhancedTableHead';
import TablePaginationActions from './TablePaginationActions';


class EnhancedTable extends Component {
  state = { selected: [] }

  handleSelectItem(id) {
    const selectedIndex = this.state.selected.indexOf(id);
    let newSelected = [];

    if (selectedIndex === -1) {
      newSelected = newSelected.concat(this.state.selected, id);
    } else if (selectedIndex === 0) {
      newSelected = newSelected.concat(this.state.selected.slice(1));
    } else if (selectedIndex === this.state.selected.length - 1) {
      newSelected = newSelected.concat(this.state.selected.slice(0, -1));
    } else if (selectedIndex > 0) {
      newSelected = newSelected.concat(
        this.state.selected.slice(0, selectedIndex),
        this.state.selected.slice(selectedIndex + 1),
      );
    }

    this.setState({ selected: newSelected });
    this.props.onChangeSelected(newSelected);
  }

  handleSelectAllClick(e) {
    if (e.target.checked) {
      const newSelected = this.props.rows.map((row) => row.id);
      this.setState({ selected: newSelected });
      this.props.onChangeSelected(newSelected);
      return;
    }
    this.setState({ selected: [] });
    this.props.onChangeSelected([]);
  }

  render() {
    const { classes } = this.props;
    return (
      <TableContainer component={Paper}>
        <Table aria-label="simple table" className={classes.table}>
          <EnhancedTableHead
            headCells={this.props.headCells}
            onRequestSort={this.props.onRequestSort}
            rowCount={this.props.rows.length}
            selectedNo={this.state.selected.length}
            onSelectAllClick={e => this.handleSelectAllClick(e)}
          />
          <TableBody>
            {this.props.rows.map((row) => (
              <TableRow key={row.id} hover onClick={() => this.handleSelectItem(row.id)}>
                <TableCell padding="checkbox">
                  <Checkbox checked={isSelected(this.state.selected, row.id)}
                    onClick={() => this.handleSelectItem(row.id)}
                  />
                </TableCell>
                {this.props.headCells.map(headCell => {
                  return (
                    <TableCell key={headCell.id} align={headCell.numeric ? 'right' : 'left'}>
                      {row[headCell.id]}
                    </TableCell>
                  );
                })}
              </TableRow>
            ))}
          </TableBody>
          <TableFooter>
            <TableRow>
              <TablePagination
                rowsPerPageOptions={[5, 10, 25]}
                count={this.props.count}
                rowsPerPage={this.props.rowsPerPage}
                page={this.props.page}
                SelectProps={{ native: true }}
                onChangePage={(e, page) => this.props.onChangePage(page)}
                onChangeRowsPerPage={e => this.props.onChangeRowsPerPage(parseInt(e.target.value, 10))}
                ActionsComponent={TablePaginationActions}
              />
            </TableRow>
          </TableFooter>
        </Table>
      </TableContainer>
    );
  }
}

EnhancedTable.propTypes = {
  headCells: PropTypes.array.isRequired,
  rows: PropTypes.array.isRequired,
  onRequestSort: PropTypes.func.isRequired,
  count: PropTypes.number.isRequired,
  page: PropTypes.number.isRequired,
  onChangePage: PropTypes.func.isRequired,
  rowsPerPage: PropTypes.number.isRequired,
  onChangeRowsPerPage: PropTypes.func.isRequired,
  onChangeSelected: PropTypes.func.isRequired,
};

export default withStyles(styles, { withTheme: true })(EnhancedTable);

function isSelected(selected, id) {
  return selected.indexOf(id) !== -1;
}