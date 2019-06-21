<template>
    <div>
      <el-tabs @tab-click="_handleClick">
        <el-tab-pane label="总表" name="总表" >
          <TotalData ref="totalData"></TotalData>
        </el-tab-pane>
        <el-tab-pane label="人员对照表" name="人员对照表" >
          <UserData ref="userData"></UserData>
        </el-tab-pane>
        <el-tab-pane label="产品对照表" name="产品对照表" >

          <ProductData ref="productData"></ProductData>
        </el-tab-pane>
      </el-tabs>
    </div>
</template>

<script>

  export default {
    data() {
      return {

      }
    },
    created(){
    },
    methods: {
      _handleClick(tab, event) {
        var tabName  = tab.name;
        console.log(tabName)
        if(tabName == '总表'){
          this.$refs.totalData.init()
        }
        else if(tabName == "人员对照表"){
          this.$refs.userData.init()
        }
        else if(tabName == "产品对照表"){
          this.$refs.productData.init()
        }

      },
    },
    components: {
        'TotalData'  : resolve => require(['components/product/subscription/opts/TotalData.vue'], resolve),
        'UserData'  : resolve => require(['components/product/subscription/opts/UserData.vue'], resolve),
        'ProductData'  : resolve => require(['components/product/subscription/opts/ProductData.vue'], resolve),
    }
  }
</script>
<style  lang="stylus" scoped>
  .el-main{
    padding:0px;
  }
</style>
