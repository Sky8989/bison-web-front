<template>
  <div class="businessReport-download-warp">
    <el-button type="success" icon="el-icon-download" @click="downloadshow()">下载</el-button>
    <el-dialog title="下载" :visible.sync="dialogTableVisible" width="465px">
      <el-form :model="formSubmit" :rules="rules" ref="formSubmit" label-width="80px">
        <div class="title">查询条件</div>
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
        <el-select
          v-model="ruleForm.productCategoryId"
          filterable
          multiple
          collapse-tags
          reserve-keyword
          placeholder="请选择系列"
        >
          <div class="businessReport-customize-select-btn-group">
            <el-button
              size="mini"
              @click="selectAll(arrData.productCategory,'productCategoryId')"
            >全部选中</el-button>
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
        <el-form-item prop="startTime">
          <el-date-picker
            v-model="formSubmit.startTime"
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
        <div class="title">汇总条件</div>
        <el-form-item prop="type">
          <el-checkbox-group v-model="formSubmit.type">
            <el-checkbox name="type" label="账号汇总"></el-checkbox>
            <el-checkbox name="type" label="产品汇总"></el-checkbox>
            <el-checkbox name="type" label="国家汇总"></el-checkbox>
            <el-checkbox name="type" label="日期汇总"></el-checkbox>
          </el-checkbox-group>
        </el-form-item>
        <el-form-item class="bottom">
          <el-button type="primary" @click="onSubmit('formSubmit')">下载</el-button>
          <el-button @click="downloadshow">取消</el-button>
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>
<script>
import { formatDate } from "../../../common/js/date";
const ERR_OK = 200;
export default {
  props: ["formData", "arrDatas", "startTimes"],
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
      dialogTableVisible: false,
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
      },
      formSubmit: {
        startTime: "",
        type: ["账号汇总"]
      },
      rules: {
        type: [
          {
            type: "array",
            required: true,
            message: "请至少选择一个活动性质",
            trigger: "change"
          }
        ],
        startTime: [
          {
            required: true,
            message: "请选择日期",
            trigger: "change"
          }
        ]
      },
      filterVal: [
        "recordDate",
        "buyBoxPercentage",
        "orderedProductSales",
        "pageViews",
        "pageViewsPercentage",
        "priceAvg",
        "sessionPercentage",
        "sessions",
        "totalOrderItems",
        "unitSessionPercentage",
        "unitsOrdered"
      ],
      tHeader: [
        "日期",
        "buyBoxPercentage",
        "orderedProductSales",
        "pageViews",
        "pageViewsPercentage",
        "priceAvg",
        "sessionPercentage",
        "sessions",
        "totalOrderItems",
        "unitSessionPercentage",
        "unitsOrdered"
      ]
    };
  },
  methods: {
    // 根据Bu查询国家和产品数据
    _findProductsByBu() {
      this.ruleForm.productCategoryId = [];
      this.ruleForm.countryId = [];
      this.ruleForm.productId = [];
      this.arrData.productCategory = [];
      this.$ajax
        .get(
          this.URL_ROOT +
            this.BUSINESSREPORT_SERVICE +
            "/search/findProductsByBu?businessUnitId=" +
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
          this.URL_ROOT +
            this.BUSINESSREPORT_SERVICE +
            "/search/findProductsByBuAndCountry?businessUnitId=" +
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
          this.URL_ROOT +
            this.BUSINESSREPORT_SERVICE +
            "/search/findProductsByBuAndCountryAndCategory?businessUnitId=" +
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
    downloadshow() {
      this.dialogTableVisible = this.dialogTableVisible ? false : true;
      this.ruleForm = JSON.parse(JSON.stringify(this.formData));
      this.arrData = JSON.parse(JSON.stringify(this.arrDatas));
      this.formSubmit.startTime = JSON.parse(JSON.stringify(this.startTimes));
    },
    // 获取时间戳
    _startTime(val) {
      this.ruleForm.startTime = val[0];
      this.ruleForm.endTime = val[1];
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
    },
    // 提交
    onSubmit(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let data = {
            byAccount: 0,
            byCountry: 0,
            byProduct: 0,
            byRecordDate: 0
          };
          for (let i in this.formSubmit.type) {
            if (this.formSubmit.type[i] === "账号汇总") {
              data.byAccount = 1;
            } else if (this.formSubmit.type[i] === "国家汇总") {
              data.byCountry = 1;
            } else if (this.formSubmit.type[i] === "产品汇总") {
              data.byProduct = 1;
            } else if (this.formSubmit.type[i] === "日期汇总") {
              data.byRecordDate = 1;
            }
          }
          this.$ajax({
            method: "post",
            url:
              this.URL_ROOT +
              this.BUSINESSREPORT_SERVICE +
              "/businessDownload/downloadByDay",
            data: $.extend(this.ruleForm, data)
          }).then(res => {
            if (res.data.code === ERR_OK) {
              if (res.data.data) {
                this.export2Excel(res.data.data);
                this.$message({
                  message: "下载成功",
                  type: "success"
                });
              } else {
                this.$message.warning("没有数据");
              }
            } else {
              this.$message.error("参数错误");
            }
          });
        }
      });
    },
    // 导出表格
    export2Excel(val) {
      var that = this;
      require.ensure([], () => {
        const { export_json_to_excel } = require("../../../excel/Export2Excel"); //这里必须使用绝对路径
        const tHeader = that.tHeader; // 导出的表头名
        const filterVal = that.filterVal; // 导出的表头字段名
        const list = val;
        const data = that.formatJson(filterVal, list);
        export_json_to_excel(tHeader, data, "业绩报告"); // 导出的表格名称，根据需要自己命名
      });
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]));
    }
  }
};
</script>

<style lang="stylus">
.businessReport-download-warp {
  margin-left: 10px;
  display: inline-block;

  .el-select {
    margin: 10px 5px;
  }

  .el-range-editor.el-input__inner {
    margin: 10px 5px;
    width: 411px;
  }

  .el-form-item__content {
    margin: 0 !important;
  }

  .bottom {
    margin: 20px 10px 10px 0;
  }
}
</style>
