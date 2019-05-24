<template>
  <div name="ModelNumberView">

    <el-button @click="dialogVisible = true" size="mini">设置</el-button>

    <!--设置-->
    <el-dialog
      title="设置"
      :visible.sync="dialogVisible"
      width="60%"
      :before-close="handleClose" >

      <el-form  :model="formInfo" label-width="140px">
        <el-form-item label="亚马逊安全库存天数">

          <input hidden :model="formInfo.productId"/>

          <el-input-number :step="1"  :max="1000"  size="mini"
                           v-model="formInfo.amzSafetyDay"
                           controls-position="right"></el-input-number> 天

          <!--<el-input-number :step="0.1" :precision="2" :max="1.0"  placeholder="合理性" size="mini"  v-if=""
                           v-model=""
                           controls-position="right">天</el-input-number>-->

        </el-form-item>

        <el-form-item label="总安全库存天数">

          <el-input-number :step="1"  :max="1000"  size="mini"
                           v-model="formInfo.amzTotalSafetyDay"
                           controls-position="right"></el-input-number> 天
        </el-form-item>

        <el-form-item label="备货日均">

          <el-input-number  :step="0.1" :precision="2" :max="1.0"  size="mini"
                           v-model="formInfo.lastUnitsAvgDay" controls-position="right"></el-input-number> 历史日均
          　+　
          <el-input-number  :step="0.1" :precision="2" :max="1.0"  size="mini"
                           v-model="formInfo.estUnitsAvgDay" controls-position="right"></el-input-number> 预测日均
        </el-form-item>

        <el-form-item label="亚马逊发货数量">

          (亚马逊安全天数库存天数-亚马逊库存天数) *　备货日均

        </el-form-item>

        <el-form-item label="采购补货数量">

          (总安全库存天数-总库存天数) *　备货日均

        </el-form-item>

        <el-form-item label="提醒设置">

          近 <el-input-number :step="1"  :max="1000"  size="mini" v-model="formInfo.unitsAvg" controls-position="right"></el-input-number> 天日均 >=
          <el-input-number  :step="0.1" :precision="2" :max="1.0"  size="mini"  placeholder="填写比率" v-model="formInfo.ratio" controls-position="right"></el-input-number>
            <el-input-number :step="1"  :max="1000"  size="mini" v-model="formInfo.unitsAvg" controls-position="right"></el-input-number> 预测日均

        </el-form-item>

        <el-form-item label="提醒设置">

          近 <el-input-number :step="1"  :max="1000"  size="mini" v-model="formInfo.unitsAvg" controls-position="right"></el-input-number> 天日均 <=
          <el-input-number  :step="0.1" :precision="2" :max="1.0"  size="mini"  placeholder="填写比率" v-model="formInfo.lastUnitsAvgDay" controls-position="right"></el-input-number>
          <el-select size="mini" >
              <el-option>14天预测日均</el-option>
              <el-option>30天预测日均</el-option>
              <el-option>45天预测日均</el-option>
          </el-select> 预测日均

        </el-form-item>



      </el-form>


      <div slot="footer" class="dialog-footer">
        <el-button type="primary"  size="mini" >修 改</el-button>
        <el-button type="primary"  size="mini" @click="dialogVisible = false">保 存</el-button>
      </div>

    </el-dialog>



    <!--表单-->
    <el-form :model="searchInfo"  method="post"   encType="multipart/form-data">
      <el-form-item style="float: left">
        <el-row :gutter="10">

          <el-col :span="3">
            <el-select placeholder="BU"  filterable clearable  v-model="searchInfo.businessUnitId"  @change="chooseBU" size="mini">
              <el-option v-for="bu in BUList" :key="bu.businessUnitId" :value="bu.businessUnitId" :label="bu.businessUnit"></el-option>
            </el-select>
          </el-col>

          <el-col :span="3">
            <el-select placeholder="产品系列"  filterable clearable  v-model="searchInfo.productCategory"  @change="chooseProductCategory" size="mini">
              <el-option v-for="productCategory in productCategoryList" :key="productCategory.productCategoryId" :value="productCategory.productCategoryId" :label="productCategory.productCategory"></el-option>

            </el-select>
          </el-col>

          <el-col :span="4">
            <el-select placeholder="产品型号"  filterable clearable  v-model="searchInfo.productModelNumber"  size="mini">
              <el-option v-for="product in productList" :key="product.productModelNumber" :value="product.productModelNumber" :label="product.productModelNumber"></el-option>
            </el-select>
          </el-col>

          <el-col :span="2">
            <el-button @click="search" size="mini">搜索</el-button>
          </el-col>

        </el-row >
      </el-form-item>

    </el-form>

    <!--表格-->
    <el-table name="showTable" border="border" height="250px" style="width: 100%" :data="userChargeList">
      <el-table-column prop="businessUnit" label="型号" ></el-table-column>

      <el-table-column prop="productCategory" label="系列"  ></el-table-column>


      <el-table-column label="日均">

        <el-table-column  label="加权历史日均"  ></el-table-column>
        <el-table-column  label="加权预测日均"  ></el-table-column>
        <el-table-column  label="备货日均"  ></el-table-column>

      </el-table-column>


      <el-table-column  label="活动预测量"  ></el-table-column>

      <!--亚马逊模块-->

      <el-table-column  label="亚马逊" >

        <el-table-column  label="可售"  ></el-table-column>
        <el-table-column  label="不可卖"  ></el-table-column>
        <el-table-column  label="在途"  ></el-table-column>
        <el-table-column  label="亚马逊总库存"  ></el-table-column>
        <el-table-column  label="总可售天数"  ></el-table-column>

      </el-table-column>

      <el-table-column label="亚马逊安全库存天数" ></el-table-column>

      <el-table-column  label="亚马逊需补发数量" >
        <el-table-column  label="补货天数"  ></el-table-column>
        <el-table-column  label="补货数量"  ></el-table-column>
      </el-table-column>

      <!--深圳仓模块-->

      <el-table-column  label="深圳仓" >
        <el-table-column  label="FN库存"  ></el-table-column>
        <el-table-column  label="UPC库存"  ></el-table-column>
        <el-table-column  label="深圳仓总库存"  ></el-table-column>
      </el-table-column>


      <!--供应商模块-->
      <el-table-column  label="供应商" >
        <el-table-column  label="供应商"  ></el-table-column>
        <el-table-column  label="最小包"  ></el-table-column>
        <el-table-column  label="采购含税单价"  ></el-table-column>
        <el-table-column  label="可发数量"  ></el-table-column>
        <el-table-column  label="未清订单"  ></el-table-column>
        <el-table-column  label="供应商总库存"  ></el-table-column>
      </el-table-column>


      <!--总库存-->
      <el-table-column  label="总库存" >
        <el-table-column  label="总库存"  ></el-table-column>
        <el-table-column  label="总库存天数"  ></el-table-column>
      </el-table-column>

      <el-table-column  label="总安全库存天数"  ></el-table-column>


      <!--补货需求-->
      <el-table-column  label="补货需求" >
        <el-table-column  label="补货天数"  ></el-table-column>
        <el-table-column  label="补货数量"  ></el-table-column>
      </el-table-column>

      <el-table-column  label="运营备注"  ></el-table-column>
      <el-table-column  label="采购备注"  ></el-table-column>


    </el-table>
  </div>
</template>

<script>
    export default {
        name: "modelNumberView",
        data(){
          return{
            userId:this.$store.state.LoginedUser.userId,
            dialogVisible:false,
            userChargeList:[{businessUnit:0,productCategory:'sw',countryName:'uk',userName:'123',departmentName:'A',productModelNumber:'product_a',asin:'asin'}],
            //搜索表单信息
            searchInfo:{
              productId:0,
              businessUnitId:'',
              productCategory:'',
              productModelNumber:'',
            },

            BUList:[],
            productCategoryList:[],
            productList:[],

            //搜索表单
            formInfo:{
              amzSafetyDay:0,
              amzTotalSafetyDay:0,
              lastUnitsAvgDay:0,
              estUnitsAvgDay:0,
              unitsAvg:0,
            }

          }
        },
      methods:{
          init(){
            console.log("init---")


            this.initBU()
            this.initProductCategory()
            this.initModelNumber()

            this.checkBu()
          },
        checkBu(){
          var url = this.URL_ROOT + this.PREFIX_INVENTORY  + "/businessUnitHandler/findByUserId/" + this.userId
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == 200){
              var data = res.data.data
              if(data == null || data.length ==0){
                this.searchInfo.businessUnitId = this.BUList[0]
              }else{
                this.searchInfo.businessUnitId = data.businessUnitId
              }
            }else if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          })

        },
        initBU(){ //所有BU
          this.$ajax.get(this.URL_ROOT + this.URL_PREFIX + "/businessUnit/findAllBU",{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.BUList = data
            }
          })
        },
        initProductCategory(){ //所有产品系列
          var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findProductCategoryAll"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.productCategoryList = data
            }
          })
        },
        initModelNumber(){ //所有产品型号
          var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findModelNumberAll"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.productList = data
            }
          })
        },
        chooseBU(){
          var buId = this.searchInfo.businessUnitId
          //清空系列
          var url1 = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findProductCategoryByBuId/" + buId

          this.$ajax.get(url1,{
          }).then(res => {
            if(res.data.code == "200"){
              console.log("productCategoryList")
              this.productCategoryList = []
              this.productCategoryList = res.data.data


            }
          }).then(error => {
            console.log(error)
          })
        },
        chooseProductCategory(){
          var productCategoryId =  this.searchInfo.productCategory

          //清空 产品型号
          var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findModelNumberByproductCategoryId/" + productCategoryId
          console.log(url)
          //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findUserChargeByDeptId/" + deptId
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
              console.log(res.data)
              //清空负责人
              this.productList = []
              this.productList = res.data.data
            }
          }).then(error => {
            console.log(error)
          })
        },
        search(){},
        handleClose(){},

      }
    }
</script>

<style scoped>

</style>
