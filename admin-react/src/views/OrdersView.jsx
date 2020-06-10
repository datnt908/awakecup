import React, { Component } from 'react';
import { Link } from 'react-router-dom';
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
import Slider from '@material-ui/core/Slider';

// core components
import EnhancedTable from '../components/EnhancedTable';


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
      selected: [],
    }
    window.OrderStatusAPIsService_Query({ PageSize: 50 })
      .then(result => this.setState({ orderStatuses: result.json.result.items }))
      .catch(error => console.log(error));
  }

  componentDidMount = () => {
    this.getOrders({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  getOrders = (object) => {
    const { Sorting, PageNo, PageSize } = object;
    const totals = document.getElementsByName('order-total')[0].value.split(',');
    const queryObj = {
      ID: document.getElementById('order-id').value,
      Fullname: document.getElementById('order-fullname').value,
      Phone: document.getElementById('order-phone').value,
      StatusID: 0 === this.state.selectedStatus ? '' : this.state.selectedStatus,
      TotalFrom: parseInt(totals[0], 10) * 1000,
      TotalTo: parseInt(totals[1], 10) * 1000,
      Search: document.getElementById('order-search').value,
      Sorting, PageNo, PageSize,
    }
    if (queryObj.PriceFrom > queryObj.PriceTo)
      [queryObj.PriceFrom, queryObj.PriceTo] = [queryObj.PriceTo, queryObj.PriceFrom]
    window.OrderAPIsService_Search(queryObj)
      .then(result => this.setState({
        orders: convertOrdersToDataTable(result.json.result.items),
        totalOrders: result.json.result.totalRows,
        sorting: Sorting,
        pageNo: PageNo,
        pageSize: PageSize,
      }))
      .catch(error => console.log(error));
  }

  handleRequestSort = (Sorting) => {
    this.getOrders({ Sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  handleSearchClick = () => {
    this.getOrders({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  handlePageChange = (pageNo) => {
    this.getOrders({ Sorting: this.state.sorting, PageNo: pageNo + 1, PageSize: this.state.pageSize, });
  }

  handleChangeRowsPerPage = (pageSize) => {
    this.getOrders({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: pageSize, });
  }

  handleChangeSelected = (selected) => {
    this.setState({ selected: selected });
  }

  render() {
    const { classes } = this.props;
    const orderID = this.state.selected[0] ? this.state.selected[0] : '0000000001';
    return (
      <div className={classes.root}>
        <div className={classes.row}>
          <Typography variant="h4">Orders</Typography>
          <span className={classes.spacer} />
          <Link to={`/admin/orders/detail-${orderID}`} style={{ textDecoration: 'none' }}>
            <Button disabled={1 !== this.state.selected.length} variant="contained" className={classes.toolbarBtn} color="primary">
              Detail
            </Button>
          </Link>
        </div>
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
                    <TextField id="order-id" fullWidth variant="outlined" label="Order ID" size='small' type="number" />
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
                  <Grid item xs={12} sm={4}>
                    <Typography>Order Total (x1000)</Typography>
                    <Slider name='order-total' max={1000} defaultValue={[0, 1000]} valueLabelDisplay="auto" />
                  </Grid>
                  <Grid item xs={12} sm={8}>
                    <TextField id="order-fullname" fullWidth variant="outlined" label="Order Guest's fullname" size='small' />
                  </Grid>
                  <Grid item xs={12} sm={4}>
                    <TextField id="order-phone" fullWidth variant="outlined" label="Order Guest's phone" size='small' type="number" />
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
            onChangeSelected={this.handleChangeSelected}
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
  { id: 'id', numeric: false, label: 'ID' },
  { id: 'firstname', numeric: false, label: 'Firstname' },
  { id: 'lastname', numeric: false, label: 'Lastname' },
  { id: 'status', numeric: false, label: 'Status' },
  { id: 'phone', numeric: false, label: 'Phone' },
  { id: 'total', numeric: true, label: 'Total' },
];

function convertOrdersToDataTable(orders) {
  orders = orders.map(item => ({
    ...item,
    status: item.status.status,
    total: item.cart.total,
  }));
  return orders;
}