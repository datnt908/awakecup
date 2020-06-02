import React, { Component } from 'react';
import PropTypes from 'prop-types';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../../theme/styles/EnhancedTable';
import TableHead from '@material-ui/core/TableHead';
import TableCell from '@material-ui/core/TableCell';
import TableRow from '@material-ui/core/TableRow';
import TableSortLabel from '@material-ui/core/TableSortLabel';

class EnhancedTableHead extends Component {
  state = { orderBy: '', order: 'asc' }

  handleRequestSore = (property) => {
    const isAsc = this.state.orderBy === property && this.state.order === 'asc';
    this.setState({
      order: isAsc ? 'desc' : 'asc',
      orderBy: property,
    });
    this.props.onRequestSort(`${property} ${isAsc ? 'desc' : 'asc'}`)
  }

  render() {
    const { classes } = this.props;
    return (
      <TableHead>
        <TableRow>
          {this.props.headCells.map((headCell) => (
            <TableCell
              key={headCell.id}
              align={headCell.numeric ? 'right' : 'left'}
              sortDirection={this.state.orderBy === headCell.id ? this.state.order : false}
            >
              <TableSortLabel
                active={this.state.orderBy === headCell.id}
                direction={this.state.orderBy === headCell.id ? this.state.order : 'asc'}
                onClick={() => this.handleRequestSore(headCell.id)}
              >
                {headCell.label}
                {this.state.orderBy === headCell.id ? (
                  <span className={classes.visuallyHidden}>
                    {this.state.order === 'desc' ? 'sorted descending' : 'sorted ascending'}
                  </span>
                ) : null}
              </TableSortLabel>
            </TableCell>
          ))}
        </TableRow>
      </TableHead>
    );
  }
}

EnhancedTableHead.propTypes = {
  headCells: PropTypes.array.isRequired,
  onRequestSort: PropTypes.func.isRequired,
};

export default withStyles(styles, { withTheme: true })(EnhancedTableHead);