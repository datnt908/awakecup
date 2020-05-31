import React, { Component } from 'react';
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

// core components
import EnhancedTable from '../components/EnhancedTable';
//
import { CategoryAPIsService, ProductAPIsService } from '../utils/apiCalling';

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
    }
    getAllCategories()
      .then(result => this.setState({ categories: result.items }))
      .catch(error => console.log(error));
  }


  componentDidMount = () => {
    const { search, code, title, categoryID, price } = {
      search: document.getElementById('product-search').value,
      code: document.getElementById('product-code').value,
      title: document.getElementById('product-title').value,
      categoryID: 0 === this.state.selectedCate ? '' : this.state.selectedCate,
      price: parseInt(document.getElementById('product-price').value, 10),
    }
    getProducts(code, title, categoryID, price, search, this.state.sorting, this.state.pageNo, this.state.pageSize)
      .then(result => this.setState({
        products: result.items,
        totalProducts: result.totalRows,
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
                    <TextField id="product-category" fullWidth variant="outlined" label="Product Category" size='small'
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
                    <TextField id="product-price" fullWidth variant="outlined" label="Product Price" size='small' type="number" />
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
          />
        </div>
      </div>
    );
  }
}

ProductsView.propTypes = {

};

export default withStyles(styles, { withTheme: true })(ProductsView);


const headCells = [
  { id: 'id', numeric: true, label: 'ID' },
  { id: 'code', numeric: false, label: 'Code' },
  { id: 'title', numeric: false, label: 'Product Title' },
  { id: 'price', numeric: true, label: 'Price' },
  { id: 'category', numeric: false, label: 'Category' },
];

async function getAllCategories() {
  try {
    const response = await CategoryAPIsService.search();
    const json = await response.json();
    return json.result;
  } catch (error) {
    throw error;
  }
}

async function getProducts(code, title, categoryID, price, search, sorting, pageNo, pageSize) {
  try {
    const response = await ProductAPIsService.search('', code, title, '', categoryID, price, '', '', search, sorting, pageNo, pageSize);
    const json = await response.json();
    json.result.items = json.result.items.map(x => ({
      ...x,
      category: x.category.title,
    }));
    return json.result;
  } catch (error) {
    throw error;
  }
}
