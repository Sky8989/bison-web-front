<template>
  <div class="productCode-dataSave-wrap">
    <el-button type="warning" icon="el-icon-setting" @click="_clickdataSetting">数据列设置</el-button>
    <el-dialog title="数据列设置" :visible.sync="dialogTableVisible" width="605px">
      <el-checkbox
        v-model="findDataSave.buyBoxPercentage"
        :true-label="1"
        :false-label="2"
      >buyBoxPercentage</el-checkbox>
      <el-checkbox
        v-model="findDataSave.orderedProductSales"
        :true-label="1"
        :false-label="2"
      >orderedProductSales</el-checkbox>
      <el-checkbox v-model="findDataSave.pageViews" :true-label="1" :false-label="2">pageViews</el-checkbox>
      <el-checkbox
        v-model="findDataSave.pageViewsPercentage"
        :true-label="1"
        :false-label="2"
      >pageViewsPercentage</el-checkbox>
      <el-checkbox v-model="findDataSave.recordDate" :true-label="1" :false-label="2">recordDate</el-checkbox>
      <el-checkbox
        v-model="findDataSave.sessionPercentage"
        :true-label="1"
        :false-label="2"
      >sessionPercentage</el-checkbox>
      <el-checkbox v-model="findDataSave.sessions" :true-label="1" :false-label="2">sessions</el-checkbox>
      <el-checkbox
        v-model="findDataSave.totalOrderItems"
        :true-label="1"
        :false-label="2"
      >totalOrderItems</el-checkbox>
      <el-checkbox
        v-model="findDataSave.unitSessionPercentage"
        :true-label="1"
        :false-label="2"
      >unitSessionPercentage</el-checkbox>
      <el-checkbox v-model="findDataSave.unitsOrdered" :true-label="1" :false-label="2">unitsOrdered</el-checkbox>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="_findDataSave()">保 存</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  props: ["dataColum"],
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
          this.URL_ROOT +
          this.BUSINESSREPORT_SERVICE +
          "/dataColumn/updateUserDataColumn",
        data: this.findDataSave
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.dialogTableVisible = false;
          this.$store.commit(
            "_businessReportDataCloumnSetting",
            this.findDataSave
          );
          this.$emit("upDataCloumnSetting");
        }
      });
    },
    _clickdataSetting() {
      this.dialogTableVisible = true;
      this.findDataSave = JSON.parse(
        JSON.stringify(this.$store.state.businessReportDataCloumnSetting)
      );
      console.log(this.$store.state.businessReportDataCloumnSetting);
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
