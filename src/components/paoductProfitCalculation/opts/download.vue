<template>
  <el-button type="primary" icon="el-icon-download" @click="_downloadXlsx">下载</el-button>
</template>
<script>

export default {
  props: ["tableData", "dataColum"],
  methods: {
    _downloadXlsx() {
      let filterhegiht = [
        "buinessUnit",
        "productCategory",
        "productModelNumber",
        "productDescriptionChs",
        "asin",
        "userName",
        "countryName",
        "status",
        "sellingPrice",
        "commission",
        "fbaCost",
        "vat",
        "realIncomeLocalCurrency",
        "sinkLoss",
        "realIncomeRmb",
        "procurementCosts",
        "logisticsExpense",
        "targetDailyAverage",
        "targetSales",
        "marketingExpense",
        "ratioOfMarketing",
        "profitRate",
        "profit",
        "rossprofit"
      ];
      let HeaderTitle = [
        "BU",
        "产品系列",
        "产品型号",
        "描述(中)",
        "ASIN",
        "负责人",
        "国家",
        "产品状态",
        "售价",
        "佣金",
        "FBA费用",
        "VAT(%)",
        "实收(当地货币)",
        "汇损",
        "实收(RMB)",
        "采购成本(RMB)",
        "物流费用(RMB)",
        "目标日均",
        "目标销售额",
        "营销费用",
        "营销占比(%)",
        "利润率",
        "利润",
        "总利润"
      ];
      this.filterVal = []
      this.tHeader = []
      for (let i in filterhegiht) {
        if(filterhegiht[i] === 'buinessUnit' && this.dataColum.businessUnit === 1){
            this.filterVal.push(filterhegiht[i])
            this.tHeader.push(HeaderTitle[i])
        }
        if(filterhegiht[i] === 'userName' && this.dataColum.user === 1){
            this.filterVal.push(filterhegiht[i])
            this.tHeader.push(HeaderTitle[i])
        }
        if(filterhegiht[i] === 'countryName' && this.dataColum.country === 1){
            this.filterVal.push(filterhegiht[i])
            this.tHeader.push(HeaderTitle[i])
        }
        if(filterhegiht[i] === 'status' && this.dataColum.productStatus === 1){
            this.filterVal.push(filterhegiht[i])
            this.tHeader.push(HeaderTitle[i])
        }
        if(this.dataColum[filterhegiht[i]] === 1){
            this.filterVal.push(filterhegiht[i])
            this.tHeader.push(HeaderTitle[i])
        }
      }
      this.export2Excel();
    },
    // 导出表格
    export2Excel() {
        
      var that = this;
      require.ensure([], () => {
        const { export2Excel } = require("../../../excel/export2Excelimg"); //这里必须使用绝对路径
        const tHeader = that.tHeader; // 导出的表头名
        const filterVal = that.filterVal; // 导出的表头字段名
        const list = this.tableData;
        const data = that.formatJson(filterVal, list);
        export2Excel(tHeader, data, '产品编码信息')
      });
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]));
    }
  }
};
</script>
