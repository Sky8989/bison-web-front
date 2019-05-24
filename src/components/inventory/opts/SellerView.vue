<template>

  <div name="ModelNumberView">
    <el-table name="showTable" border="border" height="250px" style="width: 100%" :data="userChargeList">
      <el-table-column prop="businessUnit" label="BU" ></el-table-column>

      <el-table-column prop="productCategory" label="产品系列"  ></el-table-column>

      <el-table-column prop="countryName" label="国家"  >
      </el-table-column>

      <el-table-column prop="userName" label="负责人" ></el-table-column>

      <el-table-column prop="departmentName" label="运营组别" ></el-table-column>
      <el-table-column prop="productModelNumber" label="产品型号" ></el-table-column>
      <el-table-column prop="asin" label="ASIN" ></el-table-column>
    </el-table>
  </div>



</template>

<script>
    export default {
        name: "sellerView",
        data(){
          return{
            userChargeList:[{businessUnit:0,productCategory:'sw',countryName:'uk',userName:'123',departmentName:'A',productModelNumber:'product_a',asin:'asin'}]
          }
        },
      methods:{
          init(){
            console.log("init---")
          }
      }
    }
</script>

<style scoped>

</style>
