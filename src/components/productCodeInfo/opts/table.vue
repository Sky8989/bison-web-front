<template>
  <div class="productCode-table-wrap">
    <dataColumSetting :dataColum="dataColum" @dataColum="upDataColumSetting"></dataColumSetting>
    <download :tableData="tableData" :dataColum="dataColum"></download>
    <el-table
      :data="tableData"
      :header-cell-style="getRowClass"
      border
      v-loading="loading"
      style="width: 100%"
      :class="{'showImg':dataColum.productImgUrl !== 1}"
    >
      <el-table-column prop="productImgUrl" label="图片" class-name="img" >
        <template slot-scope="scope">
          <img-zoom
            :src="scope.row.productImgUrl"
            width="85"
            height="85"
            :bigsrc="scope.row.productImgUrl"
            v-if="scope.row.productImgUrl"
            :configs="configs"
          ></img-zoom>
        </template>
      </el-table-column>
      <el-table-column prop="businessUnit" label="BU" v-if="dataColum.businessUnit === 1"></el-table-column>
      <el-table-column prop="productCategory" label="产品系列" v-if="dataColum.productCategory === 1"></el-table-column>
      <el-table-column
        prop="productModelNumber"
        label="产品型号"
        v-if="dataColum.productModelNumber === 1"
      ></el-table-column>
      <el-table-column prop="upc" label="UPC" v-if="dataColum.upc === 1"></el-table-column>
      <el-table-column prop="sku" label="SKU" v-if="dataColum.sku === 1"></el-table-column>
      <el-table-column prop="fnsku" label="FNSKU" v-if="dataColum.fnsku === 1"></el-table-column>
      <el-table-column
        prop="productSupplierProductionCosts"
        label="采购成本价"
        v-if="dataColum.productSupplierProductionCosts === 1"
      ></el-table-column>
      <el-table-column prop="productLong" label="长" v-if="dataColum.productLong === 1"></el-table-column>
      <el-table-column prop="productWidth" label="宽" v-if="dataColum.productWidth === 1"></el-table-column>
      <el-table-column prop="productHeight" label="高" v-if="dataColum.productHeight === 1"></el-table-column>
      <el-table-column prop="productVolume" label="体积" v-if="dataColum.productVolume === 1"></el-table-column>
      <el-table-column
        prop="productGrossweight"
        label="毛重"
        v-if="dataColum.productGrossweight === 1"
      ></el-table-column>
      <el-table-column prop="productNetweight" label="净重" v-if="dataColum.productNetweight === 1"></el-table-column>
      <el-table-column prop="productMaterial" label="材质" v-if="dataColum.productMaterial === 1"></el-table-column>
      <el-table-column
        prop="productCertification"
        label="认证"
        v-if="dataColum.productCertification === 1"
      ></el-table-column>
      <el-table-column
        prop="productPackageContains"
        label="包装内含物"
        v-if="dataColum.productPackageContains === 1"
      ></el-table-column>
      <el-table-column
        prop="productDescriptionChs"
        label="描述(中)"
        v-if="dataColum.productDescriptionChs === 1"
      ></el-table-column>
      <el-table-column
        prop="productDescriptionEn"
        label="描述(英)"
        v-if="dataColum.productDescriptionEn === 1"
      ></el-table-column>
    </el-table>
  </div>
</template>
<script>
import imgZoom from "vue2.0-zoom"; //鼠标图片放大
const ERR_OK = 200;
export default {
  props: ["submitFormData"],
  data() {
    return {
      tableData: [],
      dataColum: {},
      loading: true,
      configs: {
        width: 650,
        height: 350,
        maskWidth: 20,
        maskHeight: 20,
        maskColor: "red",
        maskOpacity: 0.2
      }
    };
  },
  mounted() {
    this._findData();
  },
  methods: {
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    _findData(val) {
      this.tableData = [];
      this.loading = true;
      this.$ajax({
        method: "post",
        url: this.URL_ROOT+this.CODINGINFORMATIONMANAGEMENT_SERVICE+"/searchData/findData",
        data: this.submitFormData
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.tableData = res.data.data.dataList;
          this.dataColum = res.data.data.dataColum;
        }
        this.loading = false;
      });
    },
    upDataColumSetting(val) {
      this.dataColum = val;
    }
  },
  watch: {
    submitFormData() {
      this._findData();
    }
  },
  components: {
    dataColumSetting: resolve =>
      require(["components/productCodeInfo/opts/dataColumSetting.vue"], resolve),
    download: resolve =>
      require(["components/productCodeInfo/opts/download.vue"], resolve),
    imgZoom
  }
};
</script>
<style lang="stylus">
.productCode-table-wrap {
  .el-table {
    margin-top: 15px;
  }

  .showImg .img {
    display: none;
  }
}
</style>
<style>
</style>


