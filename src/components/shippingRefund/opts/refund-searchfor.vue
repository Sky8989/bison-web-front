<template>
  <el-form :model="ruleForm" ref="ruleForm" label-width="50px">
    <el-form-item label="创建时间" prop="time" label-width="70px">
      <el-date-picker
        v-model="ruleForm.time"
        type="daterange"
        unlink-panels
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        :picker-options="pickerOptions"
        value-format="yyyy-MM-dd"
        format="yyyy 年 MM 月 dd 日"
      ></el-date-picker>
    </el-form-item>
    <el-form-item label="状态" prop="status">
      <el-select v-model="ruleForm.status" multiple collapse-tags placeholder="请选择状态">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="findStatus"
          selectFormId="status"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="(item,index) in findStatus"
          :key="index"
          :label="item | status"
          :value="item"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="账号" prop="sellerIds">
      <el-select v-model="ruleForm.sellerIds" multiple collapse-tags placeholder="请选择账号">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="findAccount"
          selectFormId="sellerIds"
          selectArrayId="sellerId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in findAccount"
          :key="item.sellerId"
          :label="item.sellerName"
          :value="item.sellerId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="国家" prop="countryIds">
      <el-select v-model="ruleForm.countryIds" multiple collapse-tags placeholder="请选择国家">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="findCountry"
          selectFormId="countryIds"
          selectArrayId="countryId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in findCountry"
          :key="item.countryId"
          :label="item.countryName"
          :value="item.countryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label-width="10px">
      <el-button type="primary" @click="submitForm" icon="el-icon-search">搜索</el-button>
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
        countryIds: [],
        sellerIds: [],
        status: [],
        time: []
      },
      findStatus: [],
      findAccount: [],
      findCountry: []
    };
  },
  filters: {
    status(string) {
      return string == 1 ? "已退款" : string == 2 ? "待处理" : "其他";
    }
  },
  created() {
    this.getfindStatus();
    this.getfindAccount();
    this.getfindCountry();
  },
  methods: {
    // 获取状态
    getfindStatus() {
      this.$ajax
        .post(
          this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/refund/findStatus"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findStatus = res.data.data.data;
          }
        });
    },
    // 获取账号
    getfindAccount() {
      this.$ajax
        .post(
          this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/refund/findAccount"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findAccount = res.data.data.data;
          }
        });
    },
    // 获取国家
    getfindCountry() {
      this.$ajax
        .post(
          this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/refund/findCountry"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findCountry = res.data.data.data;
          }
        });
    },
    // 提交查询
    submitForm() {
      this.$emit("submitForm", this.ruleForm);
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
</style>
