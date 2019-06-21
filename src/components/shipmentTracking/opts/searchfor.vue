<template>
  <el-form
    :model="ruleForm"
    ref="ruleForm"
    label-width="80px"
    class="shipmentTracking-searchfor-warp"
  >
    <el-form-item prop="daterange" label-width="0">
      <el-date-picker
        v-model="ruleForm.daterange"
        type="daterange"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        unlink-panels
        value-format="yyyy-MM-dd"
        :picker-options="pickerOptions"
        @change="daterange"
      ></el-date-picker>
    </el-form-item>
    <el-form-item label="账号" prop="brandIds">
      <el-select v-model="ruleForm.brandIds" multiple collapse-tags placeholder="请选择账号">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findAllAccount"
          selectFormId="brandIds"
          selectArrayId="brandId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findAllAccount"
          :key="item.brandId"
          :label="item.brandName"
          :value="item.brandId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="国家" prop="countryIds">
      <el-select v-model="ruleForm.countryIds" multiple collapse-tags placeholder="请选择国家">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findAllCountry"
          selectFormId="countryIds"
          selectArrayId="countryId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findAllCountry"
          :key="item.countryId"
          :label="item.countryName"
          :value="item.countryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="状态" prop="shipmentStatusIds">
      <el-select v-model="ruleForm.shipmentStatusIds" multiple collapse-tags placeholder="请选择状态">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findAllShipmentStatus"
          selectFormId="shipmentStatusIds"
          selectArrayId="amzShipmentStatusId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findAllShipmentStatus"
          :key="item.amzShipmentStatusId"
          :label="item.amzShipmentStatus"
          :value="item.amzShipmentStatusId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="货件编号" prop="shipmentIds">
      <el-input v-model="ruleForm.shipmentIds" placeholder="请输入货件编号"></el-input>
    </el-form-item>
    <br>
    <el-form-item label="BU" prop="BusinessUnit">
      <el-select
        v-model="ruleForm.BusinessUnit"
        multiple
        collapse-tags
        @change="ProductByCategoryParamAsinSKU"
        placeholder="请选择BU"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findAllBusinessUnit"
          selectFormId="BusinessUnit"
          selectArrayId="businessUnitId"
          size="mini"
          @selectAll="ProductByCategoryParamAsinSKU"
          @selectDel="ProductByCategoryParamAsinSKU"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findAllBusinessUnit"
          :key="item.businessUnitId"
          :label="item.businessUnit"
          :value="item.businessUnitId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品系列" prop="productCategoryId">
      <el-select
        v-model="ruleForm.productCategoryId"
        multiple
        collapse-tags
        @change="ProductByParamAsinSKU"
        placeholder="请选择产品系列"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.ProductCategoryByBuIds"
          selectFormId="productCategoryId"
          selectArrayId="productCategoryId"
          size="mini"
          @selectAll="ProductByParamAsinSKU"
          @selectDel="ProductByParamAsinSKU"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.ProductCategoryByBuIds"
          :key="item.productCategoryId"
          :label="item.productCategory"
          :value="item.productCategoryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品型号" prop="ProductByParam">
      <el-select
        v-model="ruleForm.ProductByParam"
        multiple
        collapse-tags
        filterable
        @change="ProductByParam"
        placeholder="请选择产品型号"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.ProductByParam"
          selectFormId="ProductByParam"
          selectArrayId="productId"
          size="mini"
          @selectAll="ProductByParam(true)"
          @selectDel="ProductByParam(false)"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.ProductByParam"
          :key="item.productId"
          :label="item.productModelNumber"
          :value="item.productId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="ASIN" prop="AsinByParam">
      <el-select
        v-model="ruleForm.AsinByParam"
        multiple
        collapse-tags
        filterable
        @change="AsinByParam"
        placeholder="请选择ASIN"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.AsinByParam"
          selectFormId="AsinByParam"
          selectArrayId="asinId"
          size="mini"
          @selectAll="AsinByParam(true)"
          @selectDel="AsinByParam(false)"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.AsinByParam"
          :key="item.asinId"
          :label="item.asin"
          :value="item.asinId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="SKU" prop="sellerSkuIds">
      <el-select
        v-model="ruleForm.sellerSkuIds"
        multiple
        collapse-tags
        filterable
        @change="sellerSkuIds"
        placeholder="请选择SKU"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.SellerSkuByParam"
          selectFormId="sellerSkuIds"
          selectArrayId="sellerSkuId"
          size="mini"
          @selectAll="sellerSkuIds(true)"
          @selectDel="sellerSkuIds(false)"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.SellerSkuByParam"
          :key="item.sellerSkuId"
          :label="item.sellerSku"
          :value="item.sellerSkuId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label-width="20px" style="width: auto;">
      <el-button type="primary" @click="_submitForm" icon="el-icon-search">搜索</el-button>
    </el-form-item>
    <el-form-item label-width="20px" style="width: auto;">
      <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close">清空</el-button>
    </el-form-item>
    <el-form-item label-width="20px" style="width: auto;">
      <Upload @uploadXlsx="_submitForm"></Upload>
    </el-form-item>
    <el-form-item label-width="40px" style="width: auto;">
      <el-checkbox v-model="ruleForm.perUnit" @change="_submitForm()">显示汇总数据</el-checkbox>
    </el-form-item>
  </el-form>
</template> 
 <script>
const ERR_OK = 200;
import Upload from "components/shipmentTracking/opts/Upload.vue";
export default {
  data() {
    return {
      pickerOptions: {
        shortcuts: [
          {
            text: "本月",
            onClick(picker) {
              picker.$emit("pick", [new Date(), new Date()]);
            }
          },
          {
            text: "今年至今",
            onClick(picker) {
              const end = new Date();
              const start = new Date(new Date().getFullYear(), 0);
              picker.$emit("pick", [start, end]);
            }
          },
          {
            text: "最近六个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setMonth(start.getMonth() - 6);
              picker.$emit("pick", [start, end]);
            }
          }
        ]
      },
      ruleForm: {
        daterange: [],
        BusinessUnit: [],
        productCategoryId: [],
        AsinByParam: [],
        ProductByParam: [],
        brandIds: [],
        countryIds: [],
        endDate: "",
        perUnit: true,
        sellerSkuIds: [],
        shipmentStatusIds: [],
        startDate: "",
        shipmentIds: ""
      },
      arrData: {
        findAllAccount: [],
        findAllCountry: [],
        findAllShipmentStatus: [],
        ProductCategoryByBuIds: [],
        ProductByParam: [],
        AsinByParam: [],
        SellerSkuByParam: []
      }
    };
  },
  created() {
    this.getFindAllAccount();
    this.getFindAllCountry();
    this.getFindAllShipmentStatus();
    this.getFindAllBusinessUnit();
    this.getProductByParam();
    this.getAsinByParam();
    this.getSellerSkuByParam();
  },
  methods: {
    // 获取账号
    getFindAllAccount() {
      this.$ajax
        .get(
          this.URL_ROOT +
            this.ORDERANDOVERSEA_SERVICE +
            "/queryBasisData/findAllAccount"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findAllAccount = res.data.data;
          }
        });
    },
    // 获取国家
    getFindAllCountry() {
      this.$ajax
        .get(
          this.URL_ROOT +
            this.ORDERANDOVERSEA_SERVICE +
            "/queryBasisData/findAllCountry"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findAllCountry = res.data.data;
          }
        });
    },
    // 获取状态
    getFindAllShipmentStatus() {
      this.$ajax
        .get(
          this.URL_ROOT +
            this.ORDERANDOVERSEA_SERVICE +
            "/queryBasisData/findAllShipmentStatus"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findAllShipmentStatus = res.data.data;
          }
        });
    },
    // 获取BU
    getFindAllBusinessUnit() {
      this.$ajax
        .get(
          this.URL_ROOT +
            this.ORDERANDOVERSEA_SERVICE +
            "/queryBasisData/findAllBusinessUnit"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findAllBusinessUnit = res.data.data;
          }
        });
    },
    // 获取产品系列
    getProductCategoryByBuIds() {
      this.ruleForm.productCategoryId = [];
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/queryBasisData/getProductCategoryByBuIds",
        data: {
          businessUnitIdStr: this.ruleForm.BusinessUnit.join()
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrData.ProductCategoryByBuIds = res.data.data;
        }
      });
    },
    // 获取产品型号
    getProductByParam() {
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/queryTrackingBaseData/getProductByParam",
        data: {
          businessUnitIdListStr: this.ruleForm.BusinessUnit.join(),
          asinIdListStr: this.ruleForm.AsinByParam.join(),
          productCategoryIdListStr: this.ruleForm.productCategoryId.join(),
          sellerSkuListStr: this.ruleForm.sellerSkuIds.join()
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          if (
            (this.ruleForm.sellerSkuIds &&
              this.ruleForm.sellerSkuIds.length > 0) ||
            (this.ruleForm.AsinByParam && this.ruleForm.AsinByParam.length > 0)
          ) {
            this.ruleForm.ProductByParam = res.data.data.map(
              item => item.productId
            );
          } else {
            this.arrData.ProductByParam = res.data.data;
          }
        }
      });
    },
    // 获取ASIN
    getAsinByParam() {
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/queryTrackingBaseData/getAsinByParam",
        data: {
          businessUnitIdListStr: this.ruleForm.BusinessUnit.join(),
          productCategoryIdListStr: this.ruleForm.productCategoryId.join(),
          productListStr: this.ruleForm.ProductByParam.join(),
          sellerSkuListStr: this.ruleForm.sellerSkuIds.join()
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          if (
            (this.ruleForm.sellerSkuIds &&
              this.ruleForm.sellerSkuIds.length > 0) ||
            (this.ruleForm.ProductByParam &&
              this.ruleForm.ProductByParam.length > 0)
          ) {
            this.ruleForm.AsinByParam = res.data.data.map(item => item.asinId);
          } else {
            this.arrData.AsinByParam = res.data.data;
          }
        }
      });
    },
    // 获取SKU
    getSellerSkuByParam() {
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/queryTrackingBaseData/getSellerSkuByParam",
        data: {
          businessUnitIdListStr: this.ruleForm.BusinessUnit.join(),
          productCategoryIdListStr: this.ruleForm.productCategoryId.join(),
          productListStr: this.ruleForm.ProductByParam.join(),
          asinIdListStr: this.ruleForm.AsinByParam.join()
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          if (
            (this.ruleForm.AsinByParam &&
              this.ruleForm.AsinByParam.length > 0) ||
            (this.ruleForm.ProductByParam &&
              this.ruleForm.ProductByParam.length > 0)
          ) {
            this.ruleForm.sellerSkuIds = res.data.data.map(
              item => item.sellerSkuId
            );
          } else {
            this.arrData.SellerSkuByParam = res.data.data;
          }
        }
      });
    },
    // 日期选择
    daterange(time) {
      if (time) {
        this.ruleForm.endDate = time[1];
        this.ruleForm.startDate = time[0];
      }
    },

    sellerSkuIds(val) {
      if (val.length > 0 || val === true) {
        this.getAsinByParam();
        this.getProductByParam();
      } else {
        this.ruleForm.AsinByParam = [];
        this.ruleForm.ProductByParam = [];
      }
    },
    AsinByParam(val) {
      if (val.length > 0 || val === true) {
        this.getSellerSkuByParam();
        this.getProductByParam();
      } else {
        this.ruleForm.sellerSkuIds = [];
        this.ruleForm.ProductByParam = [];
      }
    },
    ProductByParam(val) {
      if (val.length > 0 || val === true) {
        this.getSellerSkuByParam();
        this.getAsinByParam();
      } else {
        this.ruleForm.sellerSkuIds = [];
        this.ruleForm.AsinByParam = [];
      }
    },
    ProductByCategoryParamAsinSKU() {
      this.ProductByParamAsinSKU();
      this.getProductCategoryByBuIds();
    },
    ProductByParamAsinSKU() {
      this.ruleForm.sellerSkuIds = [];
      this.ruleForm.ProductByParam = [];
      this.ruleForm.AsinByParam = [];
      this.getProductByParam();
      this.getAsinByParam();
      this.getSellerSkuByParam();
    },
    // 提交查询
    _submitForm() {
      this.$emit("submitForm", this.ruleForm);
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  components: {
    Upload,
    allAddDelSelect: resolve =>
      require(["components/common/allAddDelSelect.vue"], resolve)
  }
};
</script>
 <style lang="stylus" scoped>
 .el-form-item {
   display: inline-block;
 }

 .shipmentTracking-searchfor-warp {
   .el-date-editor--daterange.el-input__inner {
     width: 280px;
   }

   .el-form-item {
     width: 280px;
   }
 }
</style>
