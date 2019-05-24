<template>
  <el-button type="primary" icon="el-icon-download" @click="export2Excel" size="mini">下载</el-button>
</template>
<script>
export default {
  props: {
    tableData: Array,  //导出表数据
    tHeader: Array,   //导出的表头名
    excelName: '',    //导出excel名称
    filterVal:Array,  //导出的表头字段名
  },
  data() {
    return {

    };
  },
  methods: {
    // 导出表格
    export2Excel() {
      var that = this;

      if(that.tableData == null || that.tableData.length == 0){
        this.$message.error("下载的内容为空,请先选择需要下载的内容!!")
        return
      }
      require.ensure([], () => {
        const { export_json_to_excel } = require("../../excel/Export2Excel"); //这里必须使用绝对路径
        const tHeader = that.tHeader; // 导出的表头名
        const filterVal = that.filterVal; // 导出的表头字段名
        const list = that.tableData;
        const data = that.formatJson(filterVal, list);
        export_json_to_excel(tHeader, data, that.excelName); // 导出的表格名称，根据需要自己命名
      });
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]));
    }
  }
};
</script>
