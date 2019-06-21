<template>
  <div class="productCode-dataSave-wrap">
    <el-button type="warning" icon="el-icon-setting" @click="_clickdataSetting">数据列设置</el-button>
    <el-dialog title="数据列设置" :visible.sync="dialogTableVisible" width="605px">
      <el-checkbox
        v-model="findDataSave.businessUnit"
        :true-label="1"
        :false-label="2"
      >BU</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productCategory"
        :true-label="1"
        :false-label="2"
      >产品系列</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productModelNumber"
        :true-label="1"
        :false-label="2"
      >productModelNumber</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productDescriptionChs"
        :true-label="1"
        :false-label="2"
      >描述(中)</el-checkbox>
      <el-checkbox
        v-model="findDataSave.asin"
        :true-label="1"
        :false-label="2"
      >ASIN</el-checkbox>
      <el-checkbox
        v-model="findDataSave.user"
        :true-label="1"
        :false-label="2"
      >负责人</el-checkbox>
      <el-checkbox
        v-model="findDataSave.country"
        :true-label="1"
        :false-label="2"
      >国家</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productStatus"
        :true-label="1"
        :false-label="2"
      >产品状态</el-checkbox>
      <el-checkbox
        v-model="findDataSave.sellingPrice"
        :true-label="1"
        :false-label="2"
      >售价</el-checkbox>
      <el-checkbox
        v-model="findDataSave.commission"
        :true-label="1"
        :false-label="2"
      >佣金</el-checkbox>
      <el-checkbox
        v-model="findDataSave.fbaCost"
        :true-label="1"
        :false-label="2"
      >FBA费用</el-checkbox>
      <el-checkbox
        v-model="findDataSave.vat"
        :true-label="1"
        :false-label="2"
      >VAT</el-checkbox>
      <el-checkbox
        v-model="findDataSave.realIncomeLocalCurrency"
        :true-label="1"
        :false-label="2"
      >实收(当地货币)</el-checkbox>
      <el-checkbox
        v-model="findDataSave.sinkLoss"
        :true-label="1"
        :false-label="2"
      >汇损</el-checkbox>
      <el-checkbox
        v-model="findDataSave.realIncomeRmb"
        :true-label="1"
        :false-label="2"
      >实收(RMB)</el-checkbox>
      <el-checkbox
        v-model="findDataSave.procurementCosts"
        :true-label="1"
        :false-label="2"
      >采购成本(RMB)</el-checkbox>
      <el-checkbox
        v-model="findDataSave.logisticsExpense"
        :true-label="1"
        :false-label="2"
      >物流费用(RMB)</el-checkbox><el-checkbox
        v-model="findDataSave.targetDailyAverage"
        :true-label="1"
        :false-label="2"
      >目标日均</el-checkbox>
      <el-checkbox
        v-model="findDataSave.targetSales"
        :true-label="1"
        :false-label="2"
      >目标销售额</el-checkbox>
      <el-checkbox
        v-model="findDataSave.marketingExpense"
        :true-label="1"
        :false-label="2"
      >营销费用</el-checkbox>
      <el-checkbox
        v-model="findDataSave.ratioOfMarketing"
        :true-label="1"
        :false-label="2"
      >营销占比(%)</el-checkbox>
      <el-checkbox
        v-model="findDataSave.profitRate"
        :true-label="1"
        :false-label="2"
      >利润率</el-checkbox>
      <el-checkbox
        v-model="findDataSave.profit"
        :true-label="1"
        :false-label="2"
      >利润</el-checkbox>
      <el-checkbox
        v-model="findDataSave.grossProfit"
        :true-label="1"
        :false-label="2"
      >总利润</el-checkbox>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="_findDataSave()">保 存</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  props: ["dataColumn"],
  data() {
    return {
      dialogTableVisible: false,
      findDataSave: {}
    };
  },
  methods: {
    _findDataSave() {
      this.findDataSave.userId = this.$store.state.LoginedUser.userId;
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT+this.PROFITMEASUREMENT_SERVICE+"/dataColumn/update",
        data: this.findDataSave
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.dialogTableVisible = false;
          this.$parent.dataColumn = this.findDataSave
        }
      });
    },
    _clickdataSetting() {
      this.dialogTableVisible = true;
      this.findDataSave = JSON.parse(JSON.stringify(this.dataColumn));
    }
  }
};
</script>
<style lang="stylus">
.productCode-dataSave-wrap {
  display: inline-block;

  .el-dialog__body {
    padding: 10px;
  }

  .el-checkbox {
    margin: 8px;
    width: 175px;
  }
}
</style>
