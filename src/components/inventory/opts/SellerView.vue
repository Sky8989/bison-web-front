<template>
  <div name="SellerView">

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
            <el-select placeholder="产品系列"  filterable clearable  v-model="searchInfo.productCategoryId"  @change="chooseProductCategory" size="mini">
              <el-option v-for="productCategory in productCategoryList" :key="productCategory.productCategoryId" :value="productCategory.productCategoryId" :label="productCategory.productCategory"></el-option>

            </el-select>
          </el-col>

          <el-col :span="3">
            <el-select placeholder="账号"  filterable clearable  v-model="searchInfo.brandId"  size="mini" @change="chooseBrandId">
              <el-option v-for="brand in brandList" :key="brand.brandId" :value="brand.brandId" :label="brand.brandName"></el-option>

            </el-select>
          </el-col>

          <el-col :span="3">
            <el-select placeholder="国家"  filterable clearable  v-model="searchInfo.countryId"  @change="chooseCountry" size="mini">
              <el-option v-for="country in countryList"  :key="country.countryId" :value="country.countryId" :label="country.countryName"></el-option>
            </el-select>
          </el-col>



          <el-col :span="4">
            <el-select placeholder="产品型号"  filterable clearable  v-model="searchInfo.productId"  size="mini">
              <el-option v-for="product in productList" :key="product.productId" :value="product.productId" :label="product.productModelNumber"></el-option>
            </el-select>
          </el-col>




          <el-col :span="2">
            <el-button type="primary" @click="search" size="mini">搜索</el-button>
          </el-col>

        </el-row >
      </el-form-item>

    </el-form>

    <!--表格-->
    <el-table name="showTable" border="border" height="350px" style="width: 100%" :data="InventoryList" :row-class-name="tableRowClassName">

      <el-table-column  label="操作" >
      <!--  <template  slot-scope="scope">
          <el-button @click="addOrUpdateISetting(scope.row)" size="mini">设置</el-button>
        </template>-->
      </el-table-column>
      <el-table-column prop="brandName" label="账号" ></el-table-column>

      <el-table-column prop="countryName" label="国家" ></el-table-column>

      <el-table-column prop="productModelNumber" label="型号" ></el-table-column>

      <el-table-column prop="productCategory" label="系列"  ></el-table-column>

      <el-table-column label="日均">

        <el-table-column prop="lastUnitsAvgDay" label="加权历史日均"  >
          <template slot-scope="scope">
            <el-popover trigger="hover" placement="top">
              <p>
                <span v-for="(itemKeyObj,index) in scope.row.lastItemKeyList" :key="itemKeyObj.itemKeyId" >
                  {{itemKeyObj.itemKey}}{{itemKeyNameLast}} <span v-if="index < scope.row.lastItemKeyList.length-1 ">+</span></span>
              </p>

              <div slot="reference" class="name-wrapper">
                <span>{{ scope.row.lastUnitsAvgDay}}</span>
              </div>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="estUnitsAvgDay" label="加权预测日均"  >
          <template slot-scope="scope">
            <el-popover trigger="hover" placement="top">
              <p>
                <span v-for="(itemKeyObj,index) in scope.row.estItemKeyList" :key="itemKeyObj.itemKeyId" >
                  {{itemKeyObj.itemKey}}{{itemKeyNameEst}} <span v-if="index < scope.row.estItemKeyList.length-1 ">+</span></span>
              </p>

              <div slot="reference" class="name-wrapper">
                <span>{{ scope.row.estUnitsAvgDay}}</span>
              </div>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="stockingAvgDay"  label="备货日均"  >
          <template slot-scope="scope">
            <el-popover trigger="hover" placement="top">
              <p>
                加权历史日均 + 加权预测日均
              </p>

              <div slot="reference" class="name-wrapper">
                <span>{{ scope.row.stockingAvgDay}}</span>
              </div>
            </el-popover>
          </template>
        </el-table-column>

      </el-table-column>

      <el-table-column prop="estUnitsPromotion" label="活动预测量"  ></el-table-column>

      <!--亚马逊模块-->

      <el-table-column   label="亚马逊" >

        <el-table-column prop="amzInventoryVO.afnFulfillableQuantity"  label="可售"  ></el-table-column>
        <el-table-column prop="amzInventoryVO.afnUnsellableQuantity" label="不可卖"  ></el-table-column>
        <el-table-column prop="amzInventoryVO.shippedAndReceivingQuantity" label="在途"  ></el-table-column>
        <el-table-column prop="amzInventoryVO.amzTotalInventoryQuantity" label="亚马逊总库存"  ></el-table-column>
        <el-table-column prop="amzInventoryVO.amzFulfillableQuantityDay"  label="总可售天数"  ></el-table-column>

      </el-table-column>

      <el-table-column prop="amzSafetyDay" label="亚马逊安全库存天数" ></el-table-column>

      <el-table-column  label="亚马逊需补发数量" >
        <el-table-column prop="amzInventoryVO.amzReplenishmentDay" label="补货天数"  ></el-table-column>
        <el-table-column prop="amzInventoryVO.replenishmentQuantity" label="补货数量"  ></el-table-column>
      </el-table-column>

      <!--深圳仓模块-->

      <el-table-column  label="深圳仓" >
        <el-table-column prop="localInventoryVO.fnInventoryQuantity" label="FN库存"  ></el-table-column>
        <el-table-column prop="localInventoryVO.upcInventoryQuantity"  label="UPC库存"  ></el-table-column>
        <el-table-column prop="localInventoryVO.localInventoryTotalQuantity"  label="深圳仓总库存"  ></el-table-column>
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

      <el-table-column prop="totalSafetyDay" label="总安全库存天数"  ></el-table-column>


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
        name: "sellerView",
        data(){
          return{
            itemKeyNameLast : '天历史日均',
            itemKeyNameEst : '天预测日均',
            userId:this.$store.state.LoginedUser.userId,

            //搜索表单信息
            searchInfo:{
              businessUnitId:'',
              productCategoryId:'',
              productId:'',
              brandId:'',
              countryId:'',
            },

            //搜索下拉列表
            BUList:[],
            productCategoryList:[],
            productList:[],
            countryList:[],
            brandList:[], //账号list


            //自定义列 预测列
            estItemKeyList:[],

            //表格 lsit
            InventoryList:[]
          }
        },
      methods:{
          init(){

            this.initBU()
            this.initProductCategory()
            this.initModelNumber()
            this.initEstItemKeyList()
            this.initCountryList()
            this.initBrandList()

          },
        initBU(){ //所有BU
          this.$ajax.get(this.URL_ROOT + this.URL_PREFIX + "/businessUnit/findAllBU",{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.BUList = data
              console.log("buList = ")
              console.log(this.BUList)
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
        initEstItemKeyList(){
          var url = this.HOST + "/itemKeyHandler/findEstItemKeyListByUserId/" + this.userId
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.estItemKeyList = data
            }
          })
        },
        initCountryList(){
          var url = this.URL_ROOT + this.URL_PREFIX +"/findProductCharge/findCountry"
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
              this.countryList = res.data.data
            }

          }).catch(error => {
            // console.logerror)
          })
        },
        initBrandList(){
          var url = this.HOST + "/brandHandler/findBrandList"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.brandList = data
            }
          })
        },
        chooseBU(){
          var buId = this.searchInfo.businessUnitId
          //清空系列
          var url1 = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findProductCategoryByBuId/" + buId

          if(buId != null && buId != '' && buId != 0){
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
          }


        },
        chooseProductCategory(){
          var productCategoryId =  this.searchInfo.productCategoryId
          var bu = this.searchInfo.businessUnitId

          console.log("productCategoryId =" + productCategoryId)
          console.log("businessUnitId =" + businessUnitId)

          if((buId != null && buId != '' && buId != 0) && (productCategoryId != null && productCategoryId != '' && productCategoryId != 0)){
            //清空 产品型号
            var url = this.HOST  + "/inventoryByModelNumberHandler/findModelNumberByproductCategoryIdAndBusinessUnitId/" +productCategoryId +"/"+ businessUnitId
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
          }


        },
        chooseBrandId(){
          var brandId =  this.searchInfo.brandId
          if(brandId != null &&  brandId != 0 && buId != ''){
            //清空 产品型号
            var url = this.HOST  + "/inventoryBySellerHandler/findModelNumberByBrandId/" +brandId
            console.log(url)
            //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findUserChargeByDeptId/" + deptId
            this.$ajax.get(url,{
            }).then(res => {
              if(res.data.code == "200"){
                console.log(res.data)

                this.productList = []
                this.productList = res.data.data
              }
            }).then(error => {
              console.log(error)
            })
          }
          },
        chooseCountry(){

          var brandId =  this.searchInfo.brandId
          var countryId = this.searchInfo.countryId

          console.log("productCategoryId =" + productCategoryId)
          console.log("businessUnitId =" + businessUnitId)

          if(brandId != null && brandId != 0 && brandId != '' && countryId != null && countryId != 0 && countryId != ''){
            //清空 产品型号
            var url = this.HOST  + "/inventoryBySellerHandler/findModelNumberByBrandIdAndCountryId/" +brandId +"/"+ countryId
            console.log(url)
            //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findUserChargeByDeptId/" + deptId
            this.$ajax.get(url,{
            }).then(res => {
              if(res.data.code == "200"){
                console.log(res.data)

                this.productList = []
                this.productList = res.data.data
              }
            }).then(error => {
              console.log(error)
            })
          }

        },
        search(){
          var url  = this.HOST +"/inventoryBySellerHandler/findSellerInventoryList"

          var data = {
            businessUnitId: this.searchInfo.businessUnitId,
            productCategoryId:  this.searchInfo.productCategoryId,
            productId: this.searchInfo.productId,
            countryId: this.searchInfo.countryId,
            brandId: this.searchInfo.brandId,
          }

          this.$ajax({
            method: 'post',
            url: url,
            data: data,

          }).then(res => {
            if(res.data.code == 200){

              this.$message.success(res.data.msg)
              console.log("data ")
              console.log(res.data.data)
              this.InventoryList = res.data.data

            }else if(res.data.code == 500){

              this.$message.error(res.data.msg)
            }
          }).catch(err => {
            console.log(err)
          })
        },
        tableRowClassName({row, rowIndex}) {
          var red = row.redRemind;
          var blue = row.blueRemind;
          if (red) {
            //  console.log("red")
            return 'red_warning-row';
          } else if (blue) {
            //   console.log("blue")
            return 'blue_warning-row';
          }
          //  console.log("null")
          return '';
        }
        
      },



    }
</script>

<style scoped>

</style>
