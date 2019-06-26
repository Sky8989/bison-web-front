<template>
  <el-button type="warning" icon="el-icon-download" @click="export2Excel">下载列表</el-button>
</template>
<script>
export default {
  props: ["tableData"],
  data() {
    return {
      tHeader: [
        "Orader ID",
        "渠道",
        "客户姓名",
        "地址",
        "城市",
        "邮编",
        "国家",
        "SKU",
        "数量",
        "是否3月内",
        "创建人",
        "创建时间",
        "状态"
      ], //导出的表头名
      excelName: "退款列表", //导出excel名称
      filterVal: [
        "fulfillmentOrderId",
        "channel",
        "name",
        "addressLine1",
        "city",
        "postalCode",
        "countryCode",
        "sellerSku",
        "quantity",
        "within3months",
        "creater",
        "createTime",
        "status"
      ] //导出的表头字段名
    };
  },
  methods: {
    export2Excel() {
      let that = this;
      let tableData = JSON.parse(JSON.stringify(that.tableData));
      if (tableData == null || tableData.length == 0) {
        this.$message.error("下载的内容为空,请先选择需要下载的内容!!");
        return;
      }
      tableData.forEach(el => {
        el.status = this.status(el.status);
      });
      require.ensure([], () => {
        const { export_json_to_excel } = require("../../../excel/Export2Excel"); //这里必须使用绝对路径
        const tHeader = that.tHeader; // 导出的表头名
        const filterVal = that.filterVal; // 导出的表头字段名
        const list = tableData;
        const data = that.formatJson(filterVal, list);
        export_json_to_excel(tHeader, data, that.excelName); // 导出的表格名称，根据需要自己命名
      });
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]));
    },
    status(status) {
      return status == "ready"
        ? "待提交"
        : status == "submited"
        ? "已提交"
        : "已取消";
    }
  }
};
</script>

