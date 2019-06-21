<template>
  <el-button type="warning" icon="el-icon-download" @click="_downloadXlsx">下载</el-button>
</template>
<script>
const ERR_OK = 200
export default {
  props: ["downloadForm",'url','tHeader','filterVal'],
  data(){
      return{
          tableData:[],
      }
  },
  methods: {
    _downloadXlsx() {
      let downloadForm = "";
      for (let i in this.downloadForm) {
        if (this.downloadForm[i].length > 0) {
          if (i === "timestamp") {
            downloadForm += i + this.downloadForm[i] + "&";
          } else {
            downloadForm += i + "=" + this.downloadForm[i].join() + "&";
          }
        }
      }
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/"+this.url+"/findDetails?" +
          downloadForm.substr(0, downloadForm.length - 1)
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.tableData = res.data.data.data
          this.export2Excel()
        }
      });
    },
    // 导出表格
    export2Excel() {
      require.ensure([], () => {
        const { export2Excel } = require("../../../excel/export2Excelimg"); //这里必须使用绝对路径
        const tHeader = this.tHeader; // 导出的表头名
        const filterVal = this.filterVal; // 导出的表头字段名
        const list = this.tableData;
        const data = this.formatJson(filterVal, list);
        export2Excel(tHeader, data, '产品编码信息')
      });
    },
    formatJson(filterVal, jsonData) {
      return jsonData.map(v => filterVal.map(j => v[j]));
    }
  }
};
</script>
