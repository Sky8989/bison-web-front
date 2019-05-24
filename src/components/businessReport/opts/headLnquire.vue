<template>
  <div class="businessReport-headLnquire-warp">
    <el-form :model="ruleForm" ref="ruleForm">
      <el-form-item prop="businessUnitId">
        <el-select
          v-model="ruleForm.businessUnitId"
          multiple
          collapse-tags
          placeholder="请选择UB"
          @change="_findProductsByBu"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.findBu,'businessUnitId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('businessUnitId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrData.findBu"
            :key="item.businessUnitId"
            :label="item.businessUnit"
            :value="item.businessUnitId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="countryId">
        <el-select
          v-model="ruleForm.countryId"
          multiple
          collapse-tags
          placeholder="请选择国家"
          @change="_findProductsByBuAndCountry"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.findProductsByBu,'countryId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('countryId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrData.findProductsByBu"
            :key="item.countryId"
            :label="item.countryName"
            :value="item.countryId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="productCategoryId">
        <el-select
          v-model="ruleForm.productCategoryId"
          filterable
          multiple
          collapse-tags
          reserve-keyword
          placeholder="请选择系列"
          @change="_findProductsByBuAndCountryAndCategory"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.productCategory,'productCategoryId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('productCategoryId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrData.productCategory"
            :key="item.productCategoryId"
            :label="item.productCategory"
            :value="item.productCategoryId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="productId">
        <el-select
          v-model="ruleForm.productId"
          filterable
          multiple
          collapse-tags
          reserve-keyword
          placeholder="请选择商品"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.productList,'productId')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('productId')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrData.productList"
            :key="item.productId"
            :label="item.productModelNumber"
            :value="item.productId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="startTime">
        <el-date-picker
          v-model="startTime"
          type="daterange"
          align="right"
          unlink-panels
          range-separator="至"
          start-placeholder="开始日期"
          end-placeholder="结束日期"
          :picker-options="pickerOptions"
          format="yyyy 年 MM 月 dd 日"
          value-format="timestamp"
          @change="_startTime"
        ></el-date-picker>
      </el-form-item>
      <el-form-item>
      </el-form-item>
      <el-button type="primary" @click="submitForm" icon="el-icon-search">查询</el-button>
      <el-form-item>
        <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close-outline">重置</el-button>
        <download
          :formData="ruleForm"
          :arrDatas="arrData"
          :startTimes='startTime'
        ></download>
      </el-form-item>
    </el-form>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      pickerOptions: {
        shortcuts: [
          {
            text: "最近一周",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", [start, end]);
            }
          },
          {
            text: "最近一个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
              picker.$emit("pick", [start, end]);
            }
          },
          {
            text: "最近三个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
              picker.$emit("pick", [start, end]);
            }
          }
        ]
      },
      startTime: "",
      ruleForm: {
        businessUnitId: [],
        countryId: [],
        productCategoryId: [],
        productId: []
      },
      arrData: {
        findBu: [],
        findProductsByBu: [],
        productCategory: [],
        productList: []
      }
    };
  },
  created() {
    this._findBu();
  },
  methods: {
    // 查询BU列表
    _findBu() {
      this.$ajax.get("http://192.168.1.179:10028/search/findBu").then(res => {
        if (res.data.code === ERR_OK) {
          this.arrData.findBu = res.data.data;
        }
      });
    },
    // 根据Bu查询国家和产品数据
    _findProductsByBu() {
      this.ruleForm.productCategoryId = [];
      this.ruleForm.countryId = [];
      this.ruleForm.productId = [];
      this.arrData.productCategory = [];
      this.$ajax
        .get(
          "http://192.168.1.179:10028/search/findProductsByBu?businessUnitId=" +
            this.ruleForm.businessUnitId.join(",")
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findProductsByBu = res.data.data.country;
            this.arrData.productList = res.data.data.product;
          }
        });
    },
    // Bu和国家id查询产品数据和系列数据
    _findProductsByBuAndCountry() {
      this.ruleForm.productCategoryId = [];
      this.$ajax
        .get(
          "http://192.168.1.179:10028/search/findProductsByBuAndCountry?businessUnitId=" +
            this.ruleForm.businessUnitId.join(",") +
            "&countryId=" +
            this.ruleForm.countryId.join(",")
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            if (res.data.data === "businessUnitIdORCountryId无数据") {
              this._findProductsByBu();
            } else {
              this.arrData.productCategory = res.data.data.productCategory;
              this.arrData.productList = res.data.data.product;
            }
          }
        });
    },
    // 根据Bu和国家id查询产品数据和系列数据
    _findProductsByBuAndCountryAndCategory() {
      this.ruleForm.productId = [];
      this.$ajax
        .get(
          "http://192.168.1.179:10028/search/findProductsByBuAndCountryAndCategory?businessUnitId=" +
            this.ruleForm.businessUnitId.join(",") +
            "&countryId=" +
            this.ruleForm.countryId.join(",") +
            "&productCategoryId=" +
            this.ruleForm.productCategoryId.join(",")
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            if (
              res.data.data ===
              "businessUnitIdORCountryIdOrProductCategoryId无数据"
            ) {
              this._findProductsByBuAndCountry();
            } else {
              this.arrData.productList = res.data.data.product;
            }
          }
        });
    },
    // 获取时间戳
    _startTime(val) {
      this.ruleForm.startTime = val[0];
      this.ruleForm.endTime = val[1];
    },
    // 提交查询
    submitForm() {
      this.$store.commit('businessReport',this.ruleForm);
      this.$emit("submitForm");
    },
    // 重置条件
    resetForm(formName) {
      this.$refs[formName].resetFields();
    },
    // 全部选中
    selectAll(val, id) {
      let allValues = [];
      for (let i in val) {
        if (id == "businessUnitId") {
          allValues.push(val[i].businessUnitId);
        } else if (id == "countryId") {
          allValues.push(val[i].countryId);
        } else if (id == "productCategoryId") {
          allValues.push(val[i].productCategoryId);
        } else if (id == "productId") {
          allValues.push(val[i].productId);
        }
      }
      for (var i in this.ruleForm) {
        if (i == id) {
          this.ruleForm[i] = allValues;
        }
      }
      this.addAjax(id);
    },
    // 全部删除
    selectDel(id) {
      for (var i in this.ruleForm) {
        if (i == id) {
          this.ruleForm[i] = [];
        }
      }
      this.addAjax(id);
    },
    addAjax(id) {
      if (id == "businessUnitId") {
        this._findProductsByBu();
      } else if (id == "countryId") {
        this._findProductsByBuAndCountry();
      } else if (id == "productCategoryId") {
        this._findProductsByBuAndCountryAndCategory();
      }
    }
  },
  components: {
    download: resolve =>
      require(["components/businessReport/opts/download.vue"], resolve)
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

.businessReport-headLnquire-warp {
  padding-right: 400px;

  .el-form-item {
    display: inline-block;
    margin: 0 10px 10px 0;
  }
}
</style>
