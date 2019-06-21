<template>
  <el-form ref="ruleForm" :rules="rules" :model="ruleForm" label-width="80px">
    <el-form-item label="时间" prop="time">
      <el-date-picker
        v-model="ruleForm.time"
        type="daterange"
        unlink-panels
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        format="yyyy 年 MM 月 dd 日"
        value-format="yyyy-MM-dd HH:mm:ss"
        :picker-options="pickerOptions"
      ></el-date-picker>
    </el-form-item>
    <el-form-item label="BU" prop="findBuId">
      <el-select
        v-model="ruleForm.findBuId"
        multiple
        collapse-tags
        @change="getFindByBu"
        placeholder="请选择UB"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findBu"
          selectFormId="findBuId"
          selectArrayId="businessUnitId"
          size="mini"
          @selectAll="getFindByBu"
          @selectDel="getFindByBu"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findBu"
          :key="item.businessUnitId"
          :label="item.businessUnit"
          :value="item.businessUnitId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品系列" prop="findByBuId">
      <el-select
        v-model="ruleForm.findByBuId"
        multiple
        collapse-tags
        @change="getFindByCategory"
        placeholder="请选择产品系列"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findByBu"
          selectFormId="findByBuId"
          selectArrayId="productCategoryId"
          size="mini"
          @selectAll="getFindByCategory"
          @selectDel="getFindByCategory"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findByBu"
          :key="item.productCategoryId"
          :label="item.productCategory"
          :value="item.productCategoryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品型号" prop="productIds">
      <el-select v-model="ruleForm.productIds" multiple collapse-tags placeholder="请选择产品型号">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findByCategory"
          selectFormId="productIds"
          selectArrayId="productId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findByCategory"
          :key="item.productId"
          :label="item.productModelNumber"
          :value="item.productId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="国家" prop="countryIds">
      <el-select v-model="ruleForm.countryIds" multiple collapse-tags placeholder="请选择国家">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findCountry"
          selectFormId="countryIds"
          selectArrayId="countryId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findCountry"
          :key="item.countryId"
          :label="item.countryName"
          :value="item.countryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label-width="0">
      <el-button type="primary" @click="submitForm('ruleForm')" icon="el-icon-search">搜索</el-button>
      <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close">清空</el-button>
    </el-form-item>
  </el-form>
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
      ruleForm: {
        time: [],
        findBuId: [],
        findByBuId: [],
        countryIds: [],
        productIds: []
      },
      arrData: {
        findBu: [],
        findByBu: [],
        findByCategory: [],
        findCountry: []
      },
      rules: {
        productIds: {
          required: true,
          message: "请选择产品型号",
          trigger: "change"
        }
      }
    };
  },
  created() {
    this.getFindBu();
    this.getFindCountry();
  },
  methods: {
    //获取BU
    getFindBu() {
      this.$ajax
        .post(
          this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findBu"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findBu = res.data.data.data;
          }
        });
    },
    //获取系列
    getFindByBu() {
      this.arrData.findByCategory = [];
      this.ruleForm.productIds = [];
      if (this.ruleForm.findBuId.length !== 0) {
        this.$ajax
          .post(
            this.URL_ROOT +
              this.REVIEWMONITORING_SERVICE +
              "/reviewSearch/findByBu?bus=" +
              this.ruleForm.findBuId.join()
          )
          .then(res => {
            if (res.data.code === ERR_OK) {
              this.arrData.findByBu = res.data.data.data;
              this.ruleForm.findByBuId = this.ruleForm.findByBuId.filter(
                item =>
                  !this.arrData.findByBu.every(
                    ele => ele.productCategoryId !== item
                  )
              );
            }
          });
      } else {
        this.arrData.findByBu = [];
        this.ruleForm.findByBuId = [];
      }
    },
    //获取型号
    getFindByCategory() {
      if (this.ruleForm.findByBuId.length !== 0) {
        this.$ajax
          .post(
            this.URL_ROOT +
              this.REVIEWMONITORING_SERVICE +
              "/reviewSearch/findByCategory?categorys=" +
              this.ruleForm.findByBuId.join()
          )
          .then(res => {
            if (res.data.code === ERR_OK) {
              this.arrData.findByCategory = res.data.data.data;
              this.ruleForm.productIds = this.ruleForm.productIds.filter(
                item =>
                  !this.arrData.findByCategory.every(
                    ele => ele.productId !== item
                  )
              );
            }
          });
      } else {
        this.arrData.findByCategory = [];
        this.ruleForm.productIds = [];
      }
    },
    //获取国家
    getFindCountry() {
      this.$ajax
        .post(
          this.URL_ROOT +
            this.REVIEWMONITORING_SERVICE +
            "/reviewSearch/findCountry"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findCountry = res.data.data.data;
          }
        });
    },
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$emit("submitForm", this.ruleForm);
        } else {
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  components: {
    allAddDelSelect: resolve =>
      require(["components/common/allAddDelSelect.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.el-form-item {
  display: inline-block;
}

.el-button {
  margin-left: 10px;
}
</style>