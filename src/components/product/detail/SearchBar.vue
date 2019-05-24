<template>
  <div id="SearchBar" class="SearchBar-product-warp">
    <el-form id="searchForm">
      <el-row :gutter="10">
        <el-col >
          <el-select
            placeholder="Model/ASIN/SKU"
            clearable
            v-model="searchfield"
            class="placeholder"
          >
            <b>
              <el-option label="Model" value="model"></el-option>
              <el-option label="ASIN" value="asin"></el-option>
              <el-option label="SKU" value="sku"></el-option>
            </b>
          </el-select>
        </el-col>&nbsp;&nbsp;
        <el-col >
          <el-input value="aaa" v-model="fieldValue" placeholder="请输入" style="display:inline-block; width: 150px"/>
        </el-col>&nbsp;&nbsp;
        <el-col >
          <el-select v-model="BU" clearable placeholder="BU" @change="chooseBU">
            <el-option
              v-for="bu in BUList"
              :key="bu.businessUnitId"
              :value="bu.businessUnitId"
              :label="bu.businessUnit"
            ></el-option>
          </el-select>
        </el-col>&nbsp;
        <el-col >
          <el-select
            v-model="productCategoryId"
            clearable
            placeholder="系列"
            @change="chooseProductCategory"
          >
            <el-option
              v-for="category in productCategoryList"
              :key="category.productCategoryId"
              :value="category.productCategoryId"
              :label="category.productCategory"
            ></el-option>
          </el-select>
        </el-col>&nbsp;
        <el-col >
          <el-select v-model="model" clearable placeholder="Model">
            <el-option
              v-for="product in productDetailList"
              :key="product.productModelNumber"
              :value="product.productModelNumber"
              :label="product.productModelNumber"
            ></el-option>
          </el-select>
        </el-col>&nbsp;
        <el-col :span="1">
          <el-button @click="searchProduct" type="primary">查找</el-button>
        </el-col>
      </el-row>
    </el-form>
  </div>
</template>

<script>
export default {
  name: "SearchBar",
  data() {
    return {
      searchfield: "",
      fieldValue: "",
      BU: "",
      model: "",
      productCategoryId: "",
      product: {
        brandId: 0,
        businessUnitId: 0,
        cTime: null,
        productCategoryId: 0,
        productCertification: "",
        productDescriptionChs: "",
        productDescriptionEn: "",
        productGrossweight: 0.0,
        productHeight: 0.0,
        productId: 0,
        productLong: 0.0,
        productMaterial: "",
        productModelNumber: "",
        productNetweight: 0.0,
        productPackageContains: "",
        productWidth: 0.0,
        userId: 0
      },
      productCategoryList: [],
      productDetailList: [],
      BUList: []
    };
  },
  mounted() {
    this.init();
  },
  methods: {
    init() {
      this.initBU();
    },
    initBU() {
      this.$ajax
        .get(this.URL_ROOT + this.URL_PREFIX +"/businessUnit/findAllBU", {})
        .then(res => {
          if (res.data.code == "200") {
            var data = res.data.data;
            this.BUList = data;
            this.$emit("sendBUList", this.BUList);
          }
        });
    },
    searchProduct() {
      this.productCategoryList = [];

      var searchfield = this.searchfield;
      var fieldValue = this.fieldValue;
      var url = "";

      if (fieldValue == null || fieldValue === "") {
        url = "/findProduct/findProductByModelNumber/" + this.model;
      } else if (searchfield === "model") {
        console.log(searchfield);
        url = "/findProduct/findProductByModelNumber/" + fieldValue;
      } else if (searchfield === "sku") {
        url = "/findProduct/findProductBySku/" + fieldValue;
        console.log(searchfield);
      } else if (searchfield == "asin") {
        url = "/findProduct/findProductByAsin/" + fieldValue;
        console.log(searchfield);
      }

      this.$ajax
        .get(this.URL_ROOT + this.URL_PREFIX + url, {})
        .then(result => {
          if (result.data.code == "200") {
            var productDetails = result.data.data.productDetails;
            if (productDetails == null) {
              this.$message.warning("查询产品结果为空!");
              return;
            }

            this.$emit("sendSearchResult", result.data.data);
          } else if (result.data.code == "500") {
            this.$message.error("后台报错 " + result.data.msg);
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    open(mgs) {
      this.$message(mgs);
    },
    chooseBU() {
      var url =
        this.URL_ROOT + this.URL_PREFIX + "/product/findByBusiness/" + this.BU;

      this.$ajax
        .get(url, {})
        .then(res => {
          if (res.data.code == "200") {
            var data = res.data.data;
            console.log(res.data.data.productCategoryList);
            this.productCategoryList = data.productCategoryList;
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    chooseProduct() {
      //先清空
      this.productDetails = [];

      var url =
        this.URL_ROOT + this.URL_PREFIX + "/product/findByBusiness/" + this.BU;
      this.$ajax
        .get(url, {})
        .then(res => {
          if (res.data.code == "200") {
            var data = res.data.data;
            console.log(res.data.data.productCategoryList);
            this.productCategoryList = data.productCategoryList;
            console.log(this.productCategoryList[0].productCategoryId);
            console.log(this.productCategoryList[0].productCategory);
          }
        })
        .catch(error => {
          console.log(error);
        });
    },
    chooseProductCategory() {
      var url =
        this.URL_ROOT +
        this.URL_PREFIX +
        "/product/findByCategory/" +
        this.productCategoryId;
      this.$ajax
        .get(url, {})
        .then(res => {
          if (res.data.code == "200") {
            var data = res.data.data;
            console.log(res.data.data.productDetails);
            this.productDetailList = data.productDetails;
            // console.log(this.productDetails[0].productModelNumber)
            // console.log(this.productDetailList[0].productId)
          }
        })
        .catch(error => {
          console.log(error);
        });
    }
  }
};
</script>

<style lang="stylus">
  .SearchBar-product-warp{
    .el-row{
      padding-bottom 15px; 
    }
    .el-col-24{
      display: inline-block;
      width auto;
    }
    .el-button{
      
    }
  }
</style>

