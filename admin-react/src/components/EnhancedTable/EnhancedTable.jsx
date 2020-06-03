import React, { Component } from 'react';
import PropTypes from 'prop-types';
// material-ui
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableRow from '@material-ui/core/TableRow';
import Paper from '@material-ui/core/Paper';
import TableFooter from '@material-ui/core/TableFooter';
import TablePagination from '@material-ui/core/TablePagination';

// core component
import EnhancedTableHead from './EnhancedTableHead';
import TablePaginationActions from './TablePaginationActions';


class EnhancedTable extends Component {
  render() {
    return (
      <TableContainer component={Paper}>
        <Table aria-label="simple table">
          <EnhancedTableHead
            headCells={this.props.headCells}
            onRequestSort={this.props.onRequestSort}
          />
          <TableBody>
            {this.props.rows.map((row) => (
              <TableRow key={row.id}>
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
};

export default EnhancedTable;