<template>

  <div >

    <!-- 添加账号 -->
    <el-dialog
      title="添加账号"
      :visible.sync="addBrandDialog"
      width="40%"
      :before-close="BrandDialogClose" >

      <el-form :model="brandForm"  label-width="80px" class="demo-dynamic" style="width: 80%">

       <!-- <input v-model="BrandForm.parentBrandId" hidden/>-->

        <el-form-item label="名称:">
          <input v-model="brandForm.brandName" />
        </el-form-item>

      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-link type="primary" >如何获得</el-link>
        <el-button type="primary" @click="addBrand" size="mini">添加</el-button>
        <el-button type="primary" @click="addBrandDialog = false"  size="mini">取消</el-button>
      </div>
    </el-dialog>

    <el-select placeholder="账号"  v-model="parentBrandId" @change="chooseParentBrandId"  size="mini">
      <el-option v-for="brand in brandList" :key="brand.brandId" :value="brand.brandId"
                 :label="brand.brandName"></el-option>
    </el-select>

    <el-button size="mini">添加账号</el-button>

    <el-tabs @tab-click="_handleClick">

      <el-tab-pane label="数据模块" name="数据模块" >
        <SellerDataModule ref="sellerDataModule" :parentBrandId="parentBrandId"></SellerDataModule>
      </el-tab-pane>

      <el-tab-pane label="账号授权" name="账号授权" >
        <SellerAuth ref="sellerAuth" :parentBrandId="parentBrandId"></SellerAuth>
      </el-tab-pane>

    </el-tabs>


  </div>

</template>

<script>
  import SellerAuth from "../data/opts/SellerAuth.vue"
  import SellerDataModule from "../data/opts/SellerDataModule.vue"
    export default {
        name: "SellerData",

      components: {
        SellerAuth,
        SellerDataModule
      },
      data(){
          return {
            moduleName:'', //模块名称 用来存 数据模块 账号授权
            parentBrandId:'',
            brandList:[],
            addBrandDialog:false,
            brandForm:{
              brandName:''
            },
          }
      },
      mounted() {
        this.init()
      },
      methods:{
        init(){
          this.getBrandList();
        },
        getBrandList(){
          var url = this.HOST + "/brandHandler/findBrandList"
          this.$ajax.get(url)
            .then(res => {
              if(res.data.code == 200){
                this.brandList = res.data.data;
              }
            }).catch(err => {
              console.log(err)
          })
        },

        chooseParentBrandId(id){
          console.log("id =---------------------------- " + id)
          //赋值
          this.parentBrandId  = id


          var parentBrandId = id
          console.log("parentBrandId = " + parentBrandId)
          console.log("moduleName = " + this.moduleName)

          if(parentBrandId != null && parentBrandId != '' && parentBrandId != 0){

            if(this.moduleName == '数据模块'){
              this.$refs.sellerDataModule.search(id)
            }
            else if(this.moduleName == "账号授权"){
              this.$refs.sellerAuth.search(id)
            }
          }

        },
        _handleClick(tab) {
          var tabName  = tab.name;
          console.log(tabName)
          this.moduleName = tabName

          if(tabName == '数据模块'){
           this.$refs.sellerDataModule.init()
          }
          else if(tabName == "账号授权"){
            this.$refs.sellerAuth.init()
          }
        },
        addBrand(){
          var url = this.HOST + "/brandHandler/addBrand"
          this.$ajax({
            method:'post',
            url:url,
            data:this.brandForm
            })
            .then(res => {
              if(res.data.code == 200){
                this.brandList = res.data.data;
              }
              if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }

            }).catch(err => {
            console.log(err)
          })

          this.addBrandDialog = false;
        },
        BrandDialogClose(){
          this.addBrandDialog = false;
        }
      }

    }
</script>

<style scoped>

</style>
