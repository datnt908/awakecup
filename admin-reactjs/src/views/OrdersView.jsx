import React, { Component } from 'react';
import PropTypes from 'prop-types';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/OrdersView';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import Divider from '@material-ui/core/Divider';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Collapse from '@material-ui/core/Collapse';
import IconButton from '@material-ui/core/IconButton';
import KeyboardArrowDownIcon from '@material-ui/icons/KeyboardArrowDown';
import KeyboardArrowUpIcon from '@material-ui/icons/KeyboardArrowUp';
import Typography from '@material-ui/core/Typography';
// core components
import EnhancedTable from '../components/EnhancedTable';
//
import { OrderStatusAPIsService, OrderAPIsService } from '../utils/apiCalling';



class OrdersView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      openFilter: false,
      orderStatuses: [],
      selectedStatus: 0,
      orders: [],
      totalOrders: 0,
      sorting: 'id asc',
      pageNo: 1,
      pageSize: 5,
    }
    getAllOrderStatuses()
      .then(result => this.setState({ orderStatuses: result.items }))
      .catch(error => console.log(error));
  }

  componentDidMount = () => {
    const { search, id, phone, statusID, firstname, lastname } = {
      search: document.getElementById('order-search').value,
      id: document.getElementById('order-id').value,
      phone: document.getElementById('order-phone').value,
      statusID: 0 === this.state.selectedStatus ? '' : this.state.selectedStatus,
      firstname: document.getElementById('order-firstname').value,
      lastname: document.getElementById('order-lastname').value,
    }
    getOrders(id, firstname, lastname, statusID, phone, search, this.state.sorting, this.state.pageNo, this.state.pageSize)
      .then(result => this.setState({
        orders: result.items,
        totalOrders: result.totalRows,
      }))
      .catch(error => console.log(error));
  }

  handleRequestSort = (sorting) => {
    if (sorting.indexOf('category') !== -1)
      sorting = sorting.replace('category', 'categoryId');
    this.state.sorting = sorting;
    this.componentDidMount();
  }

  handleSearchClick = () => {
    this.componentDidMount();
  }

  handlePageChange = (pageNo) => {
    this.state.pageNo = pageNo + 1;
    this.componentDidMount();
  }

  handleChangeRowsPerPage = (pageSize) => {
    this.state.pageSize = pageSize;
    this.componentDidMount();
  }


  render() {
    const { classes } = this.props;
    return (
      <div className={classes.root}>
        Products
        <div className={classes.content}>
          <Card>
            <CardHeader title="Order filter" />
            <Divider />
            <CardContent>
              <Grid container spacing={3}>
                <Grid item xs={12}>
                  <TextField id="order-search" fullWidth variant="outlined" label="Search" size='small' />
                </Grid>
                <Grid item xs={12} style={{ paddingTop: 0, paddingBottom: 0 }}>
                  <IconButton aria-label="expand row" size="small"
                    onClick={() => this.setState({ openFilter: !this.state.openFilter })}
                  >
                    {this.state.openFilter ? <KeyboardArrowUpIcon /> : <KeyboardArrowDownIcon />}
                  </IconButton>
                  <Typography variant="caption">
                    {this.state.openFilter ? "Hide advanced filter" : "Show advanced filter"}
                  </Typography>
                </Grid>
              </Grid>
            </CardContent>
            <Collapse in={this.state.openFilter} timeout="auto">
              <CardContent>
                <Grid container spacing={3}>
                  <Grid item xs={12} sm={4}>
                    <TextField id="order-id" fullWidth variant="outlined" label="Order ID" size='small' />
                  </Grid>
                  <Grid item xs={12} sm={4}>
                    <TextField id="order-phone" fullWidth variant="outlined" label="Order phone" size='small' />
                  </Grid>
                  <Grid item xs={12} sm={4}>
                    <TextField id="order-status" fullWidth variant="outlined" label="Order Status" size='small'
                      select value={this.state.selectedStatus}
                      onChange={e => this.setState({ selectedStatus: parseInt(e.target.value, 10) })}
                      SelectProps={{ native: true }}
                    >
                      <option value={0}></option>
                      {this.state.orderStatuses.map(opt => (
                        <option key={opt.id} value={opt.id}>{opt.status}</option>
                      ))}
                    </TextField>
                  </Grid>
                  <Grid item xs={12} sm={6}>
                    <TextField id="order-firstname" fullWidth variant="outlined" label="Order Firstname" size='small' type="number" />
                  </Grid>
                  <Grid item xs={12} sm={6}>
                    <TextField id="order-lastname" fullWidth variant="outlined" label="Order Lastname" size='small' type="number" />
                  </Grid>
                </Grid>
              </CardContent>
            </Collapse>
            <Divider />
            <CardActions>
              <Button color="primary" variant="contained" onClick={this.handleSearchClick}>Search</Button>
            </CardActions>
          </Card>
        </div>
        <div className={classes.content}>
          <EnhancedTable
            headCells={headCells}
            rows={this.state.orders}
            onRequestSort={this.handleRequestSort}
            count={this.state.totalOrders}
            page={this.state.pageNo - 1}
            onChangePage={page => this.handlePageChange(page)}
            rowsPerPage={this.state.pageSize}
            onChangeRowsPerPage={this.handleChangeRowsPerPage}
          />
        </div>
      </div>
    );
  }
}

OrdersView.propTypes = {

};

export default withStyles(styles, { withTheme: true })(OrdersView);

const headCells = [
  { id: 'id', numeric: true, label: 'ID' },
  { id: 'firstname', numeric: false, label: 'Firstname' },
  { id: 'lastname', numeric: false, label: 'Lastname' },
  { id: 'cartID', numeric: true, label: 'Cart ID' },
  { id: 'status', numeric: false, label: 'Status' },
  { id: 'phone', numeric: false, label: 'Phone' },
];

async function getAllOrderStatuses() {
  try {
    const response = await OrderStatusAPIsService.search();
    const json = await response.json();
    return json.result;
  } catch (error) {
    throw error;
  }
}

async function getOrders(id, firstname, lastname, statusID, phone, search, sorting, pageNo, pageSize) {
  try {
    const response = await OrderAPIsService.search(id, firstname, lastname, statusID, phone, search, sorting, pageNo, pageSize);
    const json = await response.json();
    json.result.items = json.result.items.map(x => ({
      ...x,
      cartID: x.cart.id,
      status: x.status.status,
    }));
    return json.result;
  } catch (error) {
    throw error;
  }
}
