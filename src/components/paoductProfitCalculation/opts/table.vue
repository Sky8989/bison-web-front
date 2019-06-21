<template>
  <div class="paoductProfitCalculation-table-warp">
    <download :tableData="tableData" :dataColum="dataColumn"></download>
    <dataColumSetting style="display: inline-block;" :dataColumn="dataColumn"></dataColumSetting>
    <el-table
      :data="tableData"
      border
      fixed
      :header-cell-style="getRowClass"
      style="width: 100%;width: auto;position: absolute; left: 20px; right: 20px;bottom: 0;top: 180px;height: auto;"
      height="auto"
      v-loading="loading"
    >
      <el-table-column prop="buinessUnit" label="BU" v-if="dataColumn.businessUnit === 1"></el-table-column>
      <el-table-column prop="productCategory" label="产品系列" v-if="dataColumn.productCategory === 1"></el-table-column>
      <el-table-column
        prop="productModelNumber"
        label="产品型号"
        v-if="dataColumn.productModelNumber === 1"
      ></el-table-column>
      <el-table-column
        prop="productDescriptionChs"
        label="描述(中)"
        v-if="dataColumn.productDescriptionChs === 1"
      ></el-table-column>
      <el-table-column prop="asin" label="ASIN" v-if="dataColumn.asin === 1"></el-table-column>
      <el-table-column prop="userName" label="负责人" v-if="dataColumn.user === 1"></el-table-column>
      <el-table-column prop="countryName" label="国家" v-if="dataColumn.country === 1"></el-table-column>
      <el-table-column label="产品状态" width="120px" v-if="dataColumn.productStatus === 1">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.status | filtersText}}</span>
          <el-select v-model="scope.row.status" collapse-tags v-if="scope.row.edit" size="mini">
            <el-option label="待立项" :value="2"></el-option>
            <el-option label="已上线" :value="1"></el-option>
            <el-option label="待上线" :value="3"></el-option>
            <el-option label="已下架" :value="-2"></el-option>
            <el-option label="取消项目" :value="-3"></el-option>
          </el-select>
        </template>
      </el-table-column>
      <el-table-column prop="sellingPrice" label="售价" v-if="dataColumn.sellingPrice === 1"></el-table-column>
      <el-table-column prop="commission" label="佣金" v-if="dataColumn.commission === 1"></el-table-column>
      <el-table-column prop="fbaCost" label="FBA费用" v-if="dataColumn.fbaCost === 1"></el-table-column>
      <el-table-column prop="vat" label="VAT" v-if="dataColumn.vat === 1" :width="100">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.vat}}</span>
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.vat"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column
        prop="realIncomeLocalCurrency"
        label="实收(当地货币)"
        v-if="dataColumn.realIncomeLocalCurrency === 1"
        :width="120"
      ></el-table-column>
      <el-table-column label="汇损" v-if="dataColumn.sinkLoss === 1" :width="100">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.sinkLoss}}</span>
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.sinkLoss"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column
        prop="realIncomeRmb"
        label="实收(RMB)"
        :width="90"
        v-if="dataColumn.realIncomeRmb === 1"
      ></el-table-column>
      <el-table-column label="采购成本(RMB)" :width="120" v-if="dataColumn.procurementCosts === 1">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.procurementCosts}}</span>
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.procurementCosts"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column label="物流费用(RMB)" :width="120" v-if="dataColumn.logisticsExpense === 1">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.logisticsExpense}}</span>
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.logisticsExpense"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column
        prop="targetDailyAverage"
        label="目标日均"
        v-if="dataColumn.targetDailyAverage === 1"
        :width="100"
      >
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.targetDailyAverage}}</span>
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.targetDailyAverage"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column
        prop="targetSales"
        label="目标销售额"
        :width="100"
        v-if="dataColumn.targetSales === 1"
      ></el-table-column>
      <el-table-column
        prop="marketingExpense"
        label="营销费用"
        v-if="dataColumn.marketingExpense === 1"
      ></el-table-column>
      <el-table-column label="营销占比(%)" :width="100" v-if="dataColumn.ratioOfMarketing === 1">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit">{{scope.row.ratioOfMarketing}}</span>
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.ratioOfMarketing"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
      </el-table-column>
      <el-table-column prop="profitRate" label="利润率" v-if="dataColumn.profitRate === 1"></el-table-column>
      <el-table-column prop="profit" label="利润" v-if="dataColumn.profit === 1"></el-table-column>
      <el-table-column prop="grossProfit" label="总利润" v-if="dataColumn.grossProfit === 1"></el-table-column>
      <el-table-column label="编辑" fixed="right" v-if="permission">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="editItem(scope.row)"
            :type="scope.row.edit?'primary':''"
          >{{scope.row.edit?"保存":"编辑"}}</el-button>
        </template>
      </el-table-column>
      <el-table-column label="比价器" fixed="right" v-if="permission">
        <template slot-scope="scope">
          <el-button type="primary" size="mini" @click="_calculator(scope.row)">比价</el-button>
        </template>
      </el-table-column>
    </el-table>
    <calculator ref="calculator"></calculator>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  props: {
    submitFormData: ""
  },
  data() {
    return {
      item: [],
      tableData: [],
      dataColumn: [],
      permission: false,
      calculator: {},
      updateItem: {},
      loading: true
    };
  },
  filters: {
    filtersText(text) {
      if (text == "2") {
        return "待立项";
      } else if (text == "1") {
        return "已上线";
      } else if (text == "3") {
        return "待上线";
      } else if (text == "-2") {
        return "已下架";
      } else if (text == "-3") {
        return "已上线";
      } else {
        return text;
      }
    }
  },
  created() {
    this.dataFind();
  },
  methods: {
    // 获取数据列表
    dataFind() {
      this.loading = true;
      let _url = "";
      for (let i in this.submitFormData) {
        if (this.submitFormData[i].length > 0) {
          _url += "&" + i + "=" + this.submitFormData[i].join();
        }
      }
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.PROFITMEASUREMENT_SERVICE +
          "/search/find?userId=" +
          this.$store.state.LoginedUser.userId +
          _url
      }).then(res => {
        if (res.data.code === ERR_OK) {
          if (res.data.data.permission == 1) {
            let tableData = res.data.data.data;
            this.permission = true;
            for (let i in tableData) {
              tableData[i].edit = false;
            }
            this.tableData = tableData;
          } else {
            this.tableData = res.data.data.data;
          }
          this.dataColumn = res.data.data.dataColumn;
        }
        this.loading = false;
      });
    },
    // 更新列表数据Item
    update(item) {
      item.userId = this.$store.state.LoginedUser.userId;
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.PROFITMEASUREMENT_SERVICE +
          "/updateProfit/update",
        data: item
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.updateItem = res.data.data.data[0];
          this.$message.success("编辑成功");
        } else {
          this.$message.error("编辑失败");
        }
      });
    },
    // 编辑
    editItem(item) {
      item.edit = item.edit ? false : true;
      if (item.edit === false) {
        this.update(item);
      }
    },
    // 比价器
    _calculator(item) {
      this.calculator = item;
      this.$refs.calculator.calculatorShow();
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    }
  },
  watch: {
    submitFormData() {
      this.dataFind();
    },
    updateItem(item) {
      for (let i in this.tableData) {
        if (
          this.tableData[i].amzProductProfitMeasurementId ===
          item.amzProductProfitMeasurementId
        ) {
          this.tableData[i].commission = item.commission;
          this.tableData[i].grossProfit = item.grossProfit;
          this.tableData[i].marketingExpense = item.marketingExpense;
          this.tableData[i].profit = item.profit;
          this.tableData[i].profitRate = item.profitRate;
          this.tableData[i].realIncomeLocalCurrency =
            item.realIncomeLocalCurrency;
          this.tableData[i].realIncomeRmb = item.realIncomeRmb;
          this.tableData[i].targetSales = item.targetSales;
          this.tableData[i].status = item.status;
        }
      }
    }
  },
  components: {
    dataColumSetting: resolve =>
      require([
        "components/paoductProfitCalculation/opts/dataColumSetting.vue"
      ], resolve),
    download: resolve =>
      require([
        "components/paoductProfitCalculation/opts/download.vue"
      ], resolve),
    calculator: resolve =>
      require([
        "components/paoductProfitCalculation/opts/calculator.vue"
      ], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.paoductProfitCalculation-table-warp {
  .el-table {
    margin-top: 15px;
  }
}
</style>
<style lang="stylus">
.paoductProfitCalculation-table-warp {
  .el-input-number.is-controls-right .el-input__inner {
    padding-left: 5px;
    padding-right: 35px;
  }

  .el-input-number--mini {
    width: 80px;
  }
}
</style>
