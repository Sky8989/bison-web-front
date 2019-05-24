<template>
    <div>
      <el-tabs @tab-click="_handleClick">

        <el-tab-pane label="产品型号汇总" name="产品型号汇总" >
          <ModelNumberView ref="modelNumberView"></ModelNumberView>
        </el-tab-pane>

        <el-tab-pane label="账号汇总" name="账号汇总" >
          <SellerView ref="sellerView"></SellerView>
        </el-tab-pane>

        <el-tab-pane label="SKU汇总" name="SKU汇总" >
          <SellerView ref="sellerView"></SellerView>
        </el-tab-pane>


      </el-tabs>
    </div>
</template>

<script>
    export default {
        name: "Inventory",

      components: {
        ModelNumberView: resolve =>
          require(['../inventory/opts/ModelNumberView.vue'], resolve),
        SellerView: resolve =>
          require(['../inventory/opts/SellerView.vue'], resolve),
        SkuView: resolve =>
          require(['../inventory/opts/SkuView.vue'], resolve),
      },
      data(){
          return{

          }
      },
      methods:{
        _handleClick(tab){
          var tabName = tab.name
          console.log(tabName)
         if(tabName == "产品型号汇总"){
            this.$refs.modelNumberView.init()
          }

        }
      }
    }
</script>

<style scoped>

</style>
