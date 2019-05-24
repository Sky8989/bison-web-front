<template>
  <el-button type="primary" icon="el-icon-download" @click="_downloadXlsx">下载</el-button>
</template>
<script>

export default {
  props: ["tableData", "dataColum"],
  methods: {
    _downloadXlsx() {
      let filterhegiht = [
        "productImgUrl",
        "businessUnit",
        "productCategory",
        "productModelNumber",
        "upc",
        "sku",
        "fnsku",
        "productSupplierProductionCosts",
        "productLong",
        "productWidth",
        "productHeight",
        "productVolume",
        "productGrossweight",
        "productNetweight",
        "productMaterial",
        "productCertification",
        "productPackageContains",
        "productDescriptionChs",
        "productDescriptionEn"
      ];
      let HeaderTitle = [
        "图片",
        "BU",
        "产品系列",
        "产品型号",
        "UPC",
        "SKU",
        "FNSKU",
        "采购成本价",
        "长",
        "宽",
        "高",
        "体积",
        "毛重",
        "净重",
        "材质",
        "认证",
        "包装内含物",
        "描述(中)",
        "描述(英)"
      ];
      this.filterVal = []
      this.tHeader = []
      for (let i in filterhegiht) {
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
