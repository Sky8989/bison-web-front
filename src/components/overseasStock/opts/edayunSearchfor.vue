<template>
  <el-form :model="ruleForm" ref="ruleForm" label-width="80px">
    <el-form-item label="日期" prop="time">
      <el-date-picker
        v-model="time"
        type="date"
        format="yyyy 年 MM 月 dd 日"
        value-format="yyyy-MM-dd HH:mm:ss"
        placeholder="选择日期"
        :picker-options="pickerOptions"
        :clearable="false"
        @change="getTimePoints"
      ></el-date-picker>
    </el-form-item>
    <el-form-item label="时间" prop="timestamp">
      <el-select v-model="ruleForm.timestamp" placeholder="请选择时间点">
        <el-option
          v-for="(item,index) in arrData.findByTime"
          :key="index"
          :label="item | formatDate"
          :value="item | formatDate"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="国家" prop="countryIds">
      <el-select
        v-model="ruleForm.countryIds"
        multiple
        collapse-tags
        placeholder="请选择国家"
        @change="getFindWarehouse"
      >
        <div class="businessReport-customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.allCountry,'countryIds')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('countryIds')">全部删除</el-button>
        </div>
        <div class="businessReport-customize-select-height"></div>
        <el-option
          v-for="item in arrData.allCountry"
          :key="item.countryId"
          :label="item.countryName"
          :value="item.countryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="仓库" prop="warehouseIds">
      <el-select v-model="ruleForm.warehouseIds" multiple collapse-tags placeholder="请选择仓库">
        <div class="businessReport-customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.findWarehouse,'warehouseIds')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('warehouseIds')">全部删除</el-button>
        </div>
        <div class="businessReport-customize-select-height"></div>
        <el-option
          v-for="item in arrData.findWarehouse"
          :key="item.warehouseId"
          :label="item.warehouseName"
          :value="item.warehouseId"
        ></el-option>
      </el-select>
    </el-form-item>
    <div>
      <el-form-item label="品牌" prop="buIds">
        <el-select
          v-model="ruleForm.buIds"
          multiple
          collapse-tags
          @change="getFindCategorys"
          placeholder="请选择品牌"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.findBu,'buIds')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('buIds')">全部删除</el-button>
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
      <el-form-item label="产品系列" prop="categoryIds">
        <el-select
          v-model="ruleForm.categoryIds"
          multiple
          collapse-tags
          @change="getFindProductModel"
          placeholder="请选择产品系列"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.findCategorys,'categoryIds')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('categoryIds')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrData.findCategorys"
            :key="item.productCategoryId"
            :label="item.productCategory"
            :value="item.productCategoryId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="产品型号" prop="productIds">
        <el-select
          v-model="ruleForm.productIds"
          multiple
          collapse-tags
          filterable
          placeholder="请选择产品型号"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button size="mini" @click="selectAll(arrData.FindProductModel,'productIds')">全部选中</el-button>
            <el-button size="mini" @click="selectDel('productIds')">全部删除</el-button>
          </div>
          <div class="businessReport-customize-select-height"></div>
          <el-option
            v-for="item in arrData.FindProductModel"
            :key="item.productId"
            :label="item.productModelNumber"
            :value="item.productId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-button type="primary" @click="submitForm" icon="el-icon-search">搜索</el-button>
      <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close">清空</el-button>
      <download :downloadForm="downloadForm" url="edaSearch" :tHeader="tHeader" :filterVal="filterVal"></download>
    </div>
  </el-form>
</template> 
<script>
const ERR_OK = 200;
import { formatDate } from "../../../common/js/date";
export default {
  data() {
    return {
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
        shortcuts: [
          {
            text: "今天",
            onClick(picker) {
              picker.$emit("pick", new Date());
            }
          },
          {
            text: "昨天",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24);
              picker.$emit("pick", date);
            }
          },
          {
            text: "一周前",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", date);
            }
          }
        ]
      },
      time: "",
      ruleForm: {
        buIds: [],
        categoryIds: [],
        countryIds: [],
        productIds: [],
        timestamp: "",
        warehouseIds: []
      },
      arrData: {
        findByTime: [],
        allCountry: [],
        findWarehouse: [],
        findBu: [],
        findCategorys: [],
        FindProductModel: []
      },
      downloadForm: [],
      tHeader: [
        "产品型号",
        "国家",
        "仓库",
        "实际仓库",
        "可售库存",
        "待出库存",
        "在途库存",
        "SKU",
        "月出库存",
        "补货数量"
      ],
      filterVal: [
        "productModelNumber",
        "countryName",
        "warehouseName",
        "totalInventory",
        "qty",
        "forOutboundInventory",
        "transportationInventory",
        "sku",
        "monthlyOutputQuantity",
        "quantityOfReplenishment"
      ]
    };
  },
  filters: {
    formatDate(time) {
      let date = new Date(time);
      return formatDate(date, "yyyy-MM-dd hh:mm:ss");
    }
  },
  created() {
    this.getFindCountry();
    this.getFindBu();
  },
  methods: {
    // 获取时间
    getTimePoints(time) {
      this.ruleForm.timestamp = "";
      this.$ajax({
        method: "post",
        url: this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findByTime?timestamp=" + time
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.arrData.findByTime = res.data.data.data;
        }
      });
    },
    // 获取国家
    getFindCountry() {
      this.$ajax
        .post(this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findCountry")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.allCountry = res.data.data.data;
          }
        });
    },
    // 获取仓库
    getFindWarehouse() {
      let countryCode = this.ruleForm.countryIds.map(item => {
        let alpha = "";
        this.arrData.allCountry.map(item1 => {
          if (item1.countryId == item) {
            alpha += item1.alpha;
          }
        });
        return alpha;
      });
      this.$ajax
        .post(
          this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findWarehouseByCountry?countryCode=" +
            countryCode.join()
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findWarehouse = res.data.data.data;
            if (this.arrData.findWarehouse) {
              this.ruleForm.warehouseIds = this.ruleForm.warehouseIds.filter(
                item =>
                  !this.arrData.findWarehouse.every(
                    ele => ele.warehouseId !== item
                  )
              );
            } else {
              this.ruleForm.warehouseIds = [];
            }
          }
        });
    },
    // 获取品牌
    getFindBu() {
      this.$ajax
        .post(this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findBu")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findBu = res.data.data.data;
          }
        });
    },
    //获取产品系列
    getFindCategorys() {
      this.ruleForm.productIds = [];
      this.arrData.FindProductModel = [];
      this.arrData.findCategorys = [];
      this.$ajax
        .post(
          this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findByBu?bus=" +
            this.ruleForm.buIds.join()
        )
        .then(res => {
          if (res.data.code && res.data.data) {
            this.arrData.findCategorys = res.data.data.data;
            this.ruleForm.categoryIds = this.ruleForm.categoryIds.filter(
              item =>
                !this.arrData.findCategorys.every(
                  ele => ele.productCategoryId !== item
                )
            );
          } else {
            this.ruleForm.categoryIds = [];
          }
        });
    },
    //获取产品型号
    getFindProductModel() {
      this.arrData.FindProductModel = [];
      this.$ajax
        .post(
          this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findByCategory?categorys=" +
            this.ruleForm.categoryIds.join()
        )
        .then(res => {
          if (res.data.code === ERR_OK && res.data.data) {
            this.arrData.FindProductModel = res.data.data.data;
            this.ruleForm.productIds = this.ruleForm.productIds.filter(
              item =>
                !this.arrData.FindProductModel.every(
                  ele => ele.productId !== item
                )
            );
          } else {
            this.ruleForm.productIds = [];
          }
        });
    },
    // 全部选中
    selectAll(val, id) {
      let allValues = [];
      for (let i in val) {
        if (id == "countryIds") {
          allValues.push(val[i].countryId);
        } else if (id == "warehouseIds") {
          allValues.push(val[i].warehouseId);
        } else if (id == "buIds") {
          allValues.push(val[i].businessUnitId);
        } else if (id == "categoryIds") {
          allValues.push(val[i].productCategoryId);
        } else if (id == "productIds") {
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
      if (id == "countryIds") {
        this.getFindWarehouse();
      } else if (id == "buIds") {
        this.getFindCategorys();
      } else if (id == "categoryIds") {
        this.getFindProductModel();
      }
    },
    // 提交查询
    submitForm() {
      this.$emit("submitForm", this.ruleForm);
      this.downloadForm = JSON.parse(JSON.stringify(this.ruleForm));
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  components: {
    download: resolve =>
      require(["components/overseasStock/opts/download.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.businessReport-customize-select-btn-group {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  padding: 10px;
  background: #ffffff;
  z-index: 9;

  .el-button {
    margin: 0 3px;
  }
}

.businessReport-customize-select-height {
  height: 48px;
}

.el-form-item {
  display: inline-block;
}

.el-button {
  margin-left: 10px;
}

.el-form-item {
  .el-date-editor.el-input, .el-date-editor.el-input__inner {
    max-width: 200px;
  }
}
</style>
