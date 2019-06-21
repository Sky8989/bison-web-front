<template>
  <div class="productCode-searchfor-wrap">
    <el-form :model="searchfor" ref="searchfor">
      <el-form-item prop="businessUnitId">
        <el-select
          v-model="searchfor.businessUnitId"
          multiple
          collapse-tags
          placeholder="请选择UB"
          @change="_findByBu"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.findBu,'businessUnitId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('businessUnitId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.findBu"
            :key="item.businessUnitId"
            :label="item.businessUnit"
            :value="item.businessUnitId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="productCategoryId">
        <el-select
          v-model="searchfor.productCategoryId"
          multiple
          collapse-tags
          placeholder="请选择产品系列"
          @change="_findByBuAndCategory"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.findProductsByBu,'productCategoryId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('productCategoryId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.findProductsByBu"
            :key="item.productCategoryId"
            :label="item.productCategory"
            :value="item.productCategoryId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="productModelNumber">
        <el-select
          v-model="searchfor.productModelNumber"
          multiple
          collapse-tags
          placeholder="请选择产品型号"
          @change="_findByBuAndCategoryAndModelNumber"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.productCategory,'productModelNumber')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('productModelNumber')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="(item,index) in arrSearchData.productCategory"
            :key="index"
            :label="item"
            :value="item"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="asinId">
        <el-select v-model="searchfor.asinId" multiple collapse-tags placeholder="请选择ASIN">
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrSearchData.productModelNumber,'asinId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('asinId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrSearchData.productModelNumber"
            :key="item.asinId"
            :label="item.asin"
            :value="item.asinId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm" icon="el-icon-search">查询</el-button>
      </el-form-item>
      <el-form-item>
        <el-button @click="resetForm('searchfor')" icon="el-icon-circle-close-outline">重置</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      searchfor: {
        asinId: [],
        businessUnitId: [],
        productCategoryId: [],
        productModelNumber: [],
        userId: this.$store.state.LoginedUser.userId
      },
      arrSearchData: {
        findBu: [],
        findProductsByBu: [],
        productCategory: [],
        productModelNumber: []
      }
    };
  },
  created() {
    this._findBu();
  },
  methods: {
    // 查询BU列表
    _findBu() {
      this.$ajax.get(this.URL_ROOT+this.CODINGINFORMATIONMANAGEMENT_SERVICE+"/search/findBu").then(res => {
        if (res.data.code === ERR_OK) {
          this.arrSearchData.findBu = res.data.data;
        }
      });
    },
    // 查询系列数据和对应的ASIN
    _findByBu() {
      this.arrSearchData.productCategory = []
      this.searchfor.productCategoryId = []
      this.searchfor.productModelNumber = []
      this.searchfor.asinId = []
      this.$ajax({
        method: "post",
        url: this.URL_ROOT+this.CODINGINFORMATIONMANAGEMENT_SERVICE+"/search/findByBu",
        data: this.searchfor
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrSearchData.findProductsByBu = res.data.data.category;
          this.arrSearchData.productModelNumber = res.data.data.asin;
        }
      });
    },
    //查询系列数据和对应的ASIN
    _findByBuAndCategory() {
      this.searchfor.productModelNumber = []
      this.searchfor.asinId = []
      this.$ajax({
        method: "post",
        url: this.URL_ROOT+this.CODINGINFORMATIONMANAGEMENT_SERVICE+"/search/findByBuAndCategory",
        data: this.searchfor
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrSearchData.productCategory = res.data.data.modelNumber;
          this.arrSearchData.productModelNumber = res.data.data.asin;
        }
      });
    },
    //查询ASIN
    _findByBuAndCategoryAndModelNumber() {
      this.searchfor.asinId = []
      this.$ajax({
        method: "post",
        url: this.URL_ROOT+this.CODINGINFORMATIONMANAGEMENT_SERVICE+"/search/findByBuAndCategoryAndModelNumber",
        data: this.searchfor
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrSearchData.productModelNumber = res.data.data;
        }
      });
    },
    // 全部选中
    selectAll(val, id) {
      let allValues = [];
      for (let i in val) {
        if (id == "businessUnitId") {
          allValues.push(val[i].businessUnitId);
        } else if (id == "productCategoryId") {
          allValues.push(val[i].productCategoryId);
        } else if (id == "productModelNumber") {
          allValues.push(val[i]);
        } else if (id == "asinId") {
          allValues.push(val[i].asinId);
        }
      }
      for (var i in this.searchfor) {
        if (i == id) {
          this.searchfor[i] = allValues;
        }
      }
      this.addAjax(id);
    },
    // 全部删除
    selectDel(id) {
      for (var i in this.searchfor) {
        if (i == id) {
          this.searchfor[i] = [];
        }
      }
      this.addAjax(id);
    },
    addAjax(id) {
        if (id == "businessUnitId") {
          this._findByBu();
        } else if (id == "productCategoryId") {
          this._findByBuAndCategory();
        } else if (id == "productModelNumber") {
          this._findByBuAndCategoryAndModelNumber();
        }
    },
    // 提交搜索
    submitForm() {
      this.$emit("submitForm", this.searchfor);
    },
    // 重置条件
    resetForm(formName) {
      this.$refs[formName].resetFields();
      this.arrSearchData.findProductsByBu = []
      this.arrSearchData.productCategory = []
      this.arrSearchData.productModelNumber = []
    }
  }
};
</script>

<style lang="stylus">
.businessReport-customize-select-btn-group {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  padding: 10px;
  background: #ffffff;
  z-index: 9;
}

.businessReport-customize-select-height {
  height: 48px;
}

.productCode-searchfor-wrap {
  .el-form-item {
    display: inline-block;
    margin: 0 10px 10px 0;
  }
}
</style>
