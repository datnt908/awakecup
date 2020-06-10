import React, { Component } from 'react';
import { Link } from 'react-router-dom';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/ProductsView';
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
import ConfirmDialog from '../components/ConfirmDialog'
//
import { getCookiesValue } from '../utils/helpers'
import { notify } from '../components/Notification';

class ProductsView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      openFilter: false,
      categories: [],
      selectedCate: 0,
      products: [],
      totalProducts: 0,
      sorting: 'id asc',
      pageNo: 1,
      pageSize: 5,
      selected: [],
      openDeleteDialog: false,
    }

    window.CategoryAPIsService_Query({ PageSize: 50 })
      .then(result => this.setState({ categories: result.json.result.items }))
      .catch(error => console.log(error));
  }

  componentDidMount() {
    this.getProducts({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  getProducts = (object) => {
    const { Sorting, PageNo, PageSize } = object;
    const prices = document.getElementsByName('product-price')[0].value.split(',');
    const queryObj = {
      Code: document.getElementById('product-code').value,
      Title: document.getElementById('product-title').value,
      CategoryID: 0 === this.state.selectedCate ? '' : this.state.selectedCate,
      PriceFrom: parseInt(prices[0], 10) * 1000,
      PriceTo: parseInt(prices[1], 10) * 1000,
      Search: document.getElementById('product-search').value,
      Sorting, PageNo, PageSize,
    }
    if (queryObj.PriceFrom > queryObj.PriceTo)
      [queryObj.PriceFrom, queryObj.PriceTo] = [queryObj.PriceTo, queryObj.PriceFrom]
    window.ProductAPIsService_Search(queryObj)
      .then(result => this.setState({
        products: convertProductsToDataTable(result.json.result.items),
        totalProducts: result.json.result.totalRows,
        sorting: Sorting,
        pageNo: PageNo,
        pageSize: PageSize,
      }))
      .catch(error => console.log(error));
  }

  handleRequestSort = (Sorting) => {
    this.getProducts({ Sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  handleSearchClick = () => {
    this.getProducts({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  handlePageChange = (pageNo) => {
    this.getProducts({ Sorting: this.state.sorting, PageNo: pageNo + 1, PageSize: this.state.pageSize, });
  }

  handleChangeRowsPerPage = (pageSize) => {
    this.getProducts({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: pageSize, });
  }

  handleChangeSelected = (selected) => {
    this.setState({ selected: selected });
  }

  handleDeleteSelected = async () => {
    let isSuccess = true;
    for (let index = 0; index < this.state.selected.length; index++) {
      const id = this.state.selected[index];
      try {
        const result = await window.ProductAPIsService_Delete(id, getCookiesValue('authToken'))
        switch (result.statusCode) {
          case 400:
          case 401:
          case 404:
          case 500:
            isSuccess = false;
            break;
          default:
            break;
        }
      } catch (error) { console.log(error); isSuccess = false; }
    }
    if (isSuccess)
      notify("Success", 'Delete selected product(s) successfull', "success");
    else
      notify("Error", 'Delete selected product(s) has one or more error', "error");
    this.setState({ openDeleteDialog: false, selected: [] });
    this.getProducts({ Sorting: this.state.sorting, PageNo: this.state.pageNo, PageSize: this.state.pageSize, });
  }

  render() {
    const { classes } = this.props;
    const productCode = this.state.selected[0] ? getProductsByID(this.state.products, this.state.selected[0]).code : 'PRO00000';
    return (
      <div className={classes.root}>
        <div className={classes.row}>
          <Typography variant="h4">Products</Typography>
          <span className={classes.spacer} />
          <Button variant="text" className={classes.toolbarBtn} disabled={0 === this.state.selected.length}
            onClick={() => this.setState({ openDeleteDialog: true })}
          >
            Delete
          </Button>
          <Link to={`/admin/products/update-${productCode}`} style={{ textDecoration: 'none' }}>
            <Button variant="text" className={classes.toolbarBtn} disabled={1 !== this.state.selected.length}>
              Update
            </Button>
          </Link>
          <Link to="/admin/products/create" style={{ textDecoration: 'none' }}>
            <Button variant="contained" className={classes.toolbarBtn} color="primary">Create</Button>
          </Link>
        </div>
        <div className={classes.content}>
          <Card>
            <CardHeader title="Products filter" />
            <Divider />
            <CardContent>
              <Grid container spacing={3}>
                <Grid item xs={12}>
                  <TextField id="product-search" fullWidth variant="outlined" label="Search" size='small' />
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
                  <Grid item xs={12} sm={6} md={3}>
                    <TextField id="product-code" fullWidth variant="outlined" label="Product Code" size='small' />
                  </Grid>
                  <Grid item xs={12} sm={6} md={3}>
                    <TextField id="product-title" fullWidth variant="outlined" label="Product Title" size='small' />
                  </Grid>
                  <Grid item xs={12} sm={6} md={3}>
                    <TextField id="product-cate" fullWidth variant="outlined" label="Product Category" size='small'
                      select value={this.state.selectedCate}
                      onChange={e => this.setState({ selectedCate: parseInt(e.target.value, 10) })}
                      SelectProps={{ native: true }}
                    >
                      <option value={0}></option>
                      {this.state.categories.map(opt => (
                        <option key={opt.id} value={opt.id}>{opt.title}</option>
                      ))}
                    </TextField>
                  </Grid>
                  <Grid item xs={12} sm={6} md={3}>
                    <Typography>Product Price (x1000)</Typography>
                    <Slider name='product-price' max={100} defaultValue={[0, 100]} valueLabelDisplay="auto" />
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
            rows={this.state.products}
            onRequestSort={this.handleRequestSort}
            count={this.state.totalProducts}
            page={this.state.pageNo - 1}
            onChangePage={page => this.handlePageChange(page)}
            rowsPerPage={this.state.pageSize}
            onChangeRowsPerPage={this.handleChangeRowsPerPage}
            onChangeSelected={this.handleChangeSelected}
          />
        </div>
        <ConfirmDialog
          open={this.state.openDeleteDialog}
          title="Delete selected product(s)?"
          description="Are you sure you want to delete this product(s)?"
          onClose={() => this.setState({ openDeleteDialog: false })}
          onDisagree={() => this.setState({ openDeleteDialog: false })}
          onAgree={this.handleDeleteSelected}
        />
      </div>
    );
  }
}

export default withStyles(styles, { withTheme: true })(ProductsView);

const headCells = [
  { id: 'code', numeric: false, label: 'Code' },
  { id: 'productTitle', numeric: false, label: 'Product Title' },
  { id: 'price', numeric: true, label: 'Price' },
  { id: 'categoryTitle', numeric: false, label: 'Category' },
];

function convertProductsToDataTable(products) {
  products = products.map(item => ({
    ...item,
    productTitle: item.title,
    categoryTitle: item.category.title,
  }));
  return products;
}

function getProductsByID(products, id) {
  return products.find(product => product.id === id);
}