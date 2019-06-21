<template>

  <div>
    账号授权

    <el-table  :data="sellerAuthList">
      <el-table-column prop="moduleName" label="模块" >


      </el-table-column>

      <el-table-column prop="EU" label="EU" >
        <template  slot-scope="scope">

        </template>

      </el-table-column>

      <el-table-column prop="NA" label="NA" >
        <template  slot-scope="scope">


        </template>

      </el-table-column>



    </el-table>
  </div>

</template>

<script>
    export default {
        name: "SellerDataModule",
        props: {
          brandId: '',
        },
        data(){
          return{
            sellerAuthList:[],
          }
        }
    }
</script>

<style scoped>

</style>
