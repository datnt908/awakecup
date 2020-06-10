import React, { Component } from 'react'
import { Link } from 'react-router-dom';
// material-ui
import { withStyles } from '@material-ui/core/styles';
import styles from '../theme/styles/ProductView';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import Card from '@material-ui/core/Card';
import CardHeader from '@material-ui/core/CardHeader';
import Divider from '@material-ui/core/Divider';
import CardContent from '@material-ui/core/CardContent';
import CardActions from '@material-ui/core/CardActions';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
//
import DEFAULT_IMG from '../assets/images/product_default_img.jpg'
import { getCookiesValue } from '../utils/helpers'
import { notify } from '../components/Notification';

class CreateProductView extends Component {
  constructor(props) {
    super(props);
    this.state = {
      imgFile: null,
      imgSrc: '',
      categories: [],
      selectedCate: 0,
    }

    window.CategoryAPIsService_Query({ PageSize: 50 })
      .then(result => this.setState({ categories: result.json.result.items }))
      .catch(error => console.log(error));
  }

  handleImageChange(e) {
    const reader = new FileReader();
    const file = e.target.files[0];
    reader.onloadend = () => {
      this.setState({
        imgFile: file,
        imgSrc: reader.result,
      });
    }
    reader.readAsDataURL(file);
  }

  handleCreateClick() {
    const formData = {
      Code: document.getElementById('product-code').value,
      Title: document.getElementById('product-title').value,
      Description: document.getElementById('product-desc').value,
      CategoryID: 0 === this.state.selectedCate ? '' : this.state.selectedCate,
      Price: parseInt(document.getElementById('product-price').value, 10),
      Image: this.state.imgFile,
    };

    if (isNaN(formData.Price)) formData.Price = 0;

    window.ProductAPIsService_Create(formData, getCookiesValue('authToken'))
      .then(result => {
        switch (result.statusCode) {
          case 400:
          case 404:
          case 500:
            notify(result.json.error.message, result.json.error.detail, "error");
            break;
          case 200:
            notify(result.json.error.message, 'Create new Product successfull', "success");
            break;
          default:
            break;
        }
      })
      .catch(error => console.log(error));
  }

  render() {
    const { classes } = this.props;
    let { imgSrc } = this.state;
    if ('' === imgSrc) imgSrc = DEFAULT_IMG;

    return (
      <div className={classes.root}>
        <div className={classes.row}><Typography variant="h4">Create new Product</Typography></div>
        <div className={classes.content}>
          <Card>
            <CardHeader title="Products information" />
            <Divider />
            <CardContent>
              <Grid container spacing={3}>
                <Grid item xs={12} sm={6} md={4}>
                  <input accept="image/*" hidden id="raised-button-file" type="file"
                    onChange={e => this.handleImageChange(e)}
                  />
                  <label htmlFor="raised-button-file">
                    <Button variant="text" component="span" className={classes.button}>Upload</Button>
                  </label>
                  <img src={imgSrc} className={classes.image} alt="product-imgfile" />
                </Grid>
                <Grid item xs={12} sm={6} md={8}>
                  <TextField className={classes.input} id="product-code" fullWidth variant="outlined"
                    label="Product Code" size='small' />
                  <TextField className={classes.input} id="product-title" fullWidth variant="outlined"
                    label="Product Title" size='small' />
                  <TextField className={classes.input} id="product-desc" fullWidth variant="outlined"
                    label="Product Description" size='small' multiline rows={5} rowsMax={16} />
                  <TextField className={classes.input} id="product-cate" fullWidth variant="outlined"
                    label="Product Category" size='small'
                    select value={this.state.selectedCate}
                    onChange={e => this.setState({ selectedCate: parseInt(e.target.value, 10) })}
                    SelectProps={{ native: true }}
                  >
                    <option value={0}></option>
                    {this.state.categories.map(opt => (
                      <option key={opt.id} value={opt.id}>{opt.title}</option>
                    ))}
                  </TextField>
                  <TextField className={classes.input} id="product-price" fullWidth variant="outlined"
                    label="Product Price" size='small' type="number" />
                </Grid>
              </Grid>
            </CardContent>
            <Divider />
            <CardActions>
              <div className={classes.row}>
                <span className={classes.spacer} />
                <Link to='/admin/products'>
                  <Button className={classes.cancelButton}>Cancel</Button>
                </Link>
                <Button color="primary" variant="contained"
                  onClick={() => this.handleCreateClick()}
                >
                  Create
                </Button>
              </div>
            </CardActions>
          </Card>
        </div>
      </div>
    );
  }
}

export default withStyles(styles, { withTheme: true })(CreateProductView);
