import React, { Component } from 'react'
import { Link } from 'react-router-dom';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/OrderDetail';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import Divider from '@material-ui/core/Divider';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
// core components
import EnhancedTable from '../components/EnhancedTable';
//
import { getCookiesValue } from '../utils/helpers'
import { notify } from '../components/Notification';

class OrderDetailView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      orderStatuses: [],
      selectedStatus: 1,
      cartDetails: [],
      order: null,
      province: '',
      district: '',
      commune: '',
    }

    window.OrderStatusAPIsService_Query({ PageSize: 50 })
      .then(result => this.setState({ orderStatuses: result.json.result.items }))
      .then(() => window.OrderAPIsService_Search({ ID: this.props.match.params.orderID }))
      .then(result => this.setState({
        order: result.json.result.items[0],
        cartDetails: convertCartDetailsToDataTable(result.json.result.items[0].cart.cartDetails),
        selectedStatus: result.json.result.items[0].status.id,
      }))
      .catch(error => console.log(error));
  }

  handleUpdateClick() {
    window.OrderAPIsService_UpdateStatus({
      ID: this.props.match.params.orderID,
      StatusID: this.state.selectedStatus,
    }, getCookiesValue('authToken'))
      .then(result => {
        switch (result.statusCode) {
          case 404:
          case 500:
            notify(result.json.error.message, result.json.error.detail, "error");
            break;
          case 200:
            notify(result.json.error.message, 'Update Order Status successfull', "success");
            break;
          default:
            break;
        }
      })
      .catch(error => console.log(error));
  }

  render() {
    const { classes } = this.props;
    if (!this.state.order) return null;
    return (
      <div className={classes.root}>
        <div className={classes.row}><Typography variant="h4">Order Details and Change Order Status</Typography></div>
        <div className={classes.content}>
          <Card>
            <CardHeader title="Orders information" />
            <Divider />
            <CardContent>
              <Typography variant="subtitle2">General information</Typography>
              <Grid container spacing={3} style={{ marginTop: 8 }}>
                <Grid item xs={12} sm={4} md={2}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Order ID" size='small' value={this.state.order.id}
                  />
                </Grid>
                <Grid item xs={12} sm={4} md={2}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Order Phone" size='small' value={this.state.order.phone}
                  />
                </Grid>
                <Grid item xs={12} sm={4} md={2}>
                  <TextField className={classes.input} id="product-cate" fullWidth variant="outlined"
                    label="Order Status" size='small'
                    select value={this.state.selectedStatus}
                    onChange={e => this.setState({ selectedStatus: parseInt(e.target.value, 10) })}
                    SelectProps={{ native: true }}
                    InputLabelProps={{ shrink: true }}
                  >
                    {this.state.orderStatuses.map(opt => (
                      <option key={opt.id} value={opt.id}>{opt.status}</option>
                    ))}
                  </TextField>
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Guest Firstname" size='small' value={this.state.order.firstname}
                  />
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Guest Lastname" size='small' value={this.state.order.lastname}
                  />
                </Grid>
                <Grid item xs={12} sm={4} md={4}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Province name" size='small' value={this.state.order.province}
                  />
                </Grid>
                <Grid item xs={12} sm={4} md={4}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="District name" size='small' value={this.state.order.district}
                  />
                </Grid>
                <Grid item xs={12} sm={4} md={4}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Commune name" size='small' value={this.state.order.commune}
                  />
                </Grid>
                <Grid item xs={12} sm={6} md={6}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Address" size='small' value={this.state.order.address}
                  />
                </Grid>
                <Grid item xs={12} sm={6} md={6}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Note" size='small' value={this.state.order.note}
                  />
                </Grid>
              </Grid>
              <Divider />
              <Typography variant="subtitle2" style={{ marginTop: 8 }}>Cart information</Typography>
              <EnhancedTable
                headCells={headCells}
                rows={this.state.cartDetails}
                onRequestSort={() => { }}
                count={this.state.cartDetails.length}
                page={0}
                onChangePage={() => { }}
                rowsPerPage={25}
                onChangeRowsPerPage={() => { }}
                onChangeSelected={() => { }}
              />
              <Grid container spacing={3} style={{ marginTop: 8 }}>
                <Grid item xs={12} sm={6} md={3}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Subtotal" size='small' value={this.state.order.cart.subtotal}
                  />
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Delivery" size='small' value={this.state.order.cart.delivery}
                  />
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Discount" size='small' value={this.state.order.cart.discount}
                  />
                </Grid>
                <Grid item xs={12} sm={6} md={3}>
                  <TextField className={classes.input} fullWidth variant="outlined" InputLabelProps={{
                    shrink: true,
                  }}
                    label="Total" size='small' value={this.state.order.cart.total}
                  />
                </Grid>
              </Grid>
            </CardContent>
            <Divider />
            <CardActions>
              <div className={classes.row}>
                <span className={classes.spacer} />
                <Link to='/admin/orders'>
                  <Button className={classes.cancelButton}>Back</Button>
                </Link>
                <Button color="primary" variant="contained"
                  onClick={() => this.handleUpdateClick()}
                >
                  Update
                </Button>
              </div>
            </CardActions>
          </Card>
        </div>
      </div>
    )
  }
}

export default withStyles(styles, { withTheme: true })(OrderDetailView);

const headCells = [
  { id: 'code', numeric: false, label: 'Code' },
  { id: 'productTitle', numeric: false, label: 'Product Title' },
  { id: 'categoryTitle', numeric: false, label: 'Category' },
  { id: 'price', numeric: true, label: 'Price' },
  { id: 'quantity', numeric: true, label: 'Quantity' },
  { id: 'total', numeric: true, label: 'Total' },
];

function convertCartDetailsToDataTable(cartDetails) {
  cartDetails = cartDetails.map((item, index) => ({
    ...item,
    id: index,
    code: item.product.code,
    productTitle: item.product.title,
    categoryTitle: item.product.category.title,
  }));
  return cartDetails;
}