<template>
  <div name="SellerView">


    <!--设置-->
    <el-dialog
      :title="'设置 '+ setModelNumber "
      :visible.sync="dialogVisible"
      width="60%"
      :before-close="handleClose">

      <el-form :model="formInfo" label-width="148px">
        <el-form-item label="亚马逊安全库存天数" :rules="[{required: true, message: '亚马逊安全库存天数不能为空'}]">

          <input hidden :model="formInfo.productId"/>

          <el-input-number :step="1" :max="1000" :min="0" size="mini"
                           v-model="formInfo.amzSafetyDay"
                           controls-position="right"></el-input-number>
          天

        </el-form-item>

        <el-form-item label="总安全库存天数" :rules="[{required: true, message: '总安全库存天数不能为空'}]">

          <el-input-number :step="1" :max="1000" :min="0" size="mini"
                           v-model="formInfo.totalSafetyDay"
                           controls-position="right"></el-input-number>
          天
        </el-form-item>

        <el-form-item label="备货日均" :rules="[{required: true, message: '备货日均不能为空'}]">
          = (历史日均比率 * 历史日均) + (预测日均比率 * 预测日均) <span style="color:red"> 注意: 历史日均比率 + 预测日均比率 = 1 </span>
          <br/>
          <el-input-number :step="0.1" :precision="2" :max="1.0" :min="0.0" size="mini"
                           v-model="formInfo.lastUnitsAvgDayRatio" controls-position="right"></el-input-number>
          历史日均比率
          　
          <el-input-number :step="0.1" :precision="2" :max="1.0" :min="0.0" size="mini"
                           v-model="formInfo.estUnitsAvgDayRatio" controls-position="right"></el-input-number>
          预测日均比率
        </el-form-item>

        <el-form-item label="亚马逊发货数量">

          (亚马逊安全天数库存天数-亚马逊库存天数) *　备货日均

        </el-form-item>

        <el-form-item label="采购补货数量">

          (总安全库存天数-总库存天数) *　备货日均

        </el-form-item>

        <el-form-item label="提醒设置一" :rules="[{required: true, message: '提醒设置一不能为空'}]">

          近
          <el-input-number :step="1" :max="1000" :min="0" size="mini" v-model="formInfo.bigLastUnitsAvgDay"
                           controls-position="right"></el-input-number>
          天日均 >=

          <el-select size="mini" v-model="formInfo.bigItemKeyId">
            <el-option v-for="itemKey in estItemKeyList" :key="itemKey.itemKeyId" :value="itemKey.itemKeyId"
                       :label="itemKey.itemKey+ itemKeyNameEst"></el-option>
          </el-select>
          <el-input-number :step="0.1" :precision="2" :max="1.0" :min="0.0" size="mini" placeholder="填写比率"
                           v-model="formInfo.bigEstUnitisAvgDayRatio" controls-position="right"></el-input-number>
          预测数量

        </el-form-item>

        <el-form-item label="提醒设置二" :rules="[{required: true, message: '提醒设置二不能为空'}]">

          近
          <el-input-number :step="1" :max="1000" :min="0" size="mini" v-model="formInfo.samllLastUnitsAvgDay"
                           controls-position="right"></el-input-number>
          天日均 <=
          <el-select size="mini" v-model="formInfo.samllItemKeyId">
            <el-option v-for="itemKey in estItemKeyList" :key="itemKey.itemKeyId" :value="itemKey.itemKeyId"
                       :label="itemKey.itemKey+ itemKeyNameEst"></el-option>
          </el-select>
          <el-input-number :step="0.1" :precision="2" :max="1.0" :min="0.0" size="mini" placeholder="填写比率"
                           v-model="formInfo.samllEstUnitsAvgDayRatio" controls-position="right"></el-input-number>
          预测数量

        </el-form-item>


      </el-form>


      <div slot="footer" class="dialog-footer">
        <!--<el-button type="primary"  size="mini" >修 改</el-button>-->
        <el-button type="primary" size="mini" @click="saveFromInfo"
                   v-if="formInfo.productId != null && formInfo.productId != 0">保 存
        </el-button>

        <p v-if="formInfo.productId == null || formInfo.productId == 0">
          <span style="color:#ff4532;font-size:12px;">* 修改所有产品 </span>
          <el-button type="primary" size="mini" @click="saveFromInfo">保 存</el-button>
        </p>

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
        <template  slot-scope="scope">
          <el-button type="primary" @click="addOrUpdateISetting(scope.row)" size="mini">设置</el-button>
        </template>
      </el-table-column>
      <el-table-column prop="brandName" label="账号" ></el-table-column>

      <el-table-column prop="countryName" label="国家" ></el-table-column>

      <el-table-column prop="productCategory" label="系列"  ></el-table-column>

      <el-table-column prop="productModelNumber" label="型号" ></el-table-column>

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
       <!-- <el-table-column prop="amzInventoryVO.afnUnsellableQuantity" label="不可卖"  ></el-table-column>-->
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
        <el-table-column prop="supplierInventoryVO.supplierName" label="供应商"  ></el-table-column>
       <!-- <el-table-column  label="最小包"  ></el-table-column>-->
        <el-table-column prop="supplierInventoryVO.iTaxUnitPrice" label="采购含税单价"  ></el-table-column>
       <!-- <el-table-column  label="可发数量"  ></el-table-column>-->
        <el-table-column prop="supplierInventoryVO.unclearedQuantity" label="未清订单"  ></el-table-column>
        <el-table-column  prop="supplierInventoryVO.unclearedQuantity" label="供应商总库存"  ></el-table-column>
      </el-table-column>


      <!--总库存-->
      <el-table-column  label="总库存" >
        <el-table-column prop="totalInventory" label="总库存"  ></el-table-column>
        <el-table-column prop="totalInventoryDay" label="总库存天数"  ></el-table-column>
      </el-table-column>

      <el-table-column prop="totalSafetyDay" label="总安全库存天数"  ></el-table-column>


      <!--补货需求-->
      <el-table-column  label="补货需求" >
        <el-table-column prop="replenishmentDay" label="补货天数"  ></el-table-column>
        <el-table-column  prop="replenishmentQuantity" label="补货数量"  ></el-table-column>
      </el-table-column>

      <el-table-column  label="运营备注"  >
        <template slot-scope="scope">
          <span v-if="scope.row.salesRemark == null || salesRemark == '' ">
            <RemarkDialog ref="remarkDialog" :id="scope.row.productId" :title="salesRemark"  :search="search"> </RemarkDialog>
          </span>
          <span v-if="scope.row.salesRemark != null && salesRemark != '' ">
            <el-popover trigger="hover" placement="top" >
              <p >{{scope.row.salesRemark}}</p>
              <div slot="reference" class="name-wrapper">
                <el-tag size="mini">查看备注</el-tag>
                 <RemarkDialog ref="remarkDialog" :id="scope.row.productId" :title="salesRemark"  :search="search"> </RemarkDialog>
              </div>
            </el-popover>
          </span>
        </template>
      </el-table-column>
      <el-table-column  label="采购备注"  >
        <template slot-scope="scope">
          <span v-if="scope.row.purchaseRemark == null || purchaseRemark == '' ">
            <RemarkDialog ref="remarkDialog" :id="scope.row.productId" :title="purchaseRemark"  :search="search"> </RemarkDialog>
          </span>
          <span v-if="scope.row.purchaseRemark != null && purchaseRemark != '' ">

            <el-popover trigger="hover" placement="top" >
              <p > {{scope.row.purchaseRemark}}</p>
              <div slot="reference" class="name-wrapper">
                <el-tag size="mini">查看备注</el-tag>
                 <RemarkDialog ref="remarkDialog" :id="scope.row.productId" :title="purchaseRemark"  :search="search"> </RemarkDialog>
              </div>
            </el-popover>
          </span>
        </template>
      </el-table-column>


    </el-table>
  </div>



</template>

<script>
    export default {
        name: "sellerView",
        components: {
          RemarkDialog: resolve =>
            require(['../opts/RemarkDialog.vue'], resolve),

        },
        data(){
          return{
            dialogVisible:false,
            salesRemark:'运营备注',
            purchaseRemark:'采购备注',
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
            InventoryList:[],
            setModelNumber: '',  //对话框的标题名 显示对应修改的modelNumber

            //提交表单
            formInfo: {
              productId: 0,
              amzSafetyDay: 0,
              totalSafetyDay: 0,

              //加权历史日均占比 和加权预测日均占比
              lastUnitsAvgDayRatio: 0.0,
              estUnitsAvgDayRatio: 0.0,

              //大于方向
              bigLastUnitsAvgDay: 0,
              bigItemKeyId: 0,
              bigEstUnitisAvgDayRatio: 0.0,

              //小于方向
              samllLastUnitsAvgDay: 0,
              samllItemKeyId: 0,
              samllEstUnitsAvgDayRatio: 0.0,

              userId: 0
            },
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
            this.search()

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
          var url =this.URL_ROOT + this.PREFIX_INVENTORY + "/itemKeyHandler/findEstItemKeyListByUserId/" + this.userId
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
          var url =this.URL_ROOT + this.PREFIX_INVENTORY + "/brandHandler/findBrandList"
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
            var url =this.URL_ROOT + this.PREFIX_INVENTORY  + "/inventoryByModelNumberHandler/findModelNumberByproductCategoryIdAndBusinessUnitId/" +productCategoryId +"/"+ businessUnitId
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
            var url =this.URL_ROOT + this.PREFIX_INVENTORY  + "/inventoryBySellerHandler/findModelNumberByBrandId/" +brandId
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
            var url =this.URL_ROOT + this.PREFIX_INVENTORY  + "/inventoryBySellerHandler/findModelNumberByBrandIdAndCountryId/" +brandId +"/"+ countryId
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
          var url  =this.URL_ROOT + this.PREFIX_INVENTORY +"/inventoryBySellerHandler/findSellerInventoryList"

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

             // this.$message.success(res.data.msg)
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
        },
        addOrUpdateISetting(row) {
          console.log("addOrUpdateISetting")
          console.log(row.productId)

          this.formInfo.productId = row.productId
          this.setModelNumber = row.productModelNumber
          //查询预测相关自定义列
          this.getItemKeyList(row.productId)
          this.fillFormInfo(row.productId)

          //显示
          this.dialogVisible = true
         // this.search()
        },
        saveFromInfo() {
          console.log("saveFromInfo")
          console.log(this.formInfo)

          if (this.checkFormInfo()) {
            return
          }

          if (this.formInfo.productId == null || this.formInfo.productId == "" || this.formInfo.productId == 0) {
            //全部保存
            this.$confirm("确定修改所有产品", '提示', {
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              this.saveALlProductInventory()
            })

          } else {
            //保存一行
            this.saveOneRowProductInventory()
          }


          this.dialogVisible = false
          this.search()

        },
        handleClose() {
          //关闭对话框 清空表单
          this.setModelNumber = ''
          this.clearFormInfo()
          this.dialogVisible = false

        },
        clearFormInfo() {
          //清除 表单设置的数据
          this.formInfo = {
            productId: 0,
            amzSafetyDay: 0,
            totalSafetyDay: 0,
            lastUnitsAvgDayRatio: 0,
            estUnitsAvgDayRatio: 0,
            bigLastUnitsAvgDay: 0,
            bigItemKeyId: 0,
            bigEstUnitisAvgDayRatio: 0.0,
            samllLastUnitsAvgDay: 0,
            samllItemKeyId: 0,
            samllEstUnitsAvgDayRatio: 0,
            userId: 0,
          }
        },
        getItemKeyList(productId) {
          var url =this.URL_ROOT + this.PREFIX_INVENTORY + "/itemKeyHandler/findItemKeyByProductId/" + productId
          this.$ajax.get(url, {}).then(res => {
            if (res.data.code == 200) {
              console.log(res.data.data)
              this.estItemKeyList = res.data.data
              //    this.$message.success(res.data.msg)
            } else if (res.data.code == 500) {
              this.$message.error(res.data.msg)
            }
          })
        },
        fillFormInfo(productId) {
          //当前产品存在数据 填充数据
          var url =this.URL_ROOT + this.PREFIX_INVENTORY + "/inventoryByModelNumberHandler/findProductInventoryInfo/" + productId
          this.$ajax.get(url, {}).then(res => {
            if (res.data.code == 200) {
              console.log(res.data.data)
              //this.estItemKeyList = res.data.data
              this.formInfo = res.data.data
              //   this.$message.success(res.data.msg)
            } else if (res.data.code == 500) {
              this.$message.error(res.data.msg)
            }
          })
        },
        checkFormInfo() {
          var flag = false
          var product = this.formInfo.productId
          if(product == null || product == 0){
             flag = true
            this.$message.error("产品id为空请先关闭窗口重新打开")
            return flag
          }

          var totalSafetyDay = this.formInfo.totalSafetyDay
          if (totalSafetyDay == null || totalSafetyDay == 0) {
            flag = true
            this.$message.error("总安全天数不能为空和0")
            return flag
          }
          var amzSafetyDay = this.formInfo.amzSafetyDay
          if (amzSafetyDay == null || amzSafetyDay == 0) {
            flag = true
            this.$message.error("亚马逊安全库存天数不能为空和0")
            return flag
          }

          var lastUnitsAvgDayRatio = this.formInfo.lastUnitsAvgDayRatio
          var estUnitsAvgDayRatio = this.formInfo.estUnitsAvgDayRatio
          if (lastUnitsAvgDayRatio == null || lastUnitsAvgDayRatio == 0 || estUnitsAvgDayRatio == null || estUnitsAvgDayRatio == 0) {
            flag = true
            this.$message.error("加权历史日均占比 和加权预测日均占比 不能为空")
            return flag
          }
          if (lastUnitsAvgDayRatio + estUnitsAvgDayRatio != 1) {
            flag = true
            this.$message.error("加权历史日均占比 + 加权预测日均占比 != 1")
            return flag
          }

          var bigLastUnitsAvgDay = this.formInfo.bigLastUnitsAvgDay
          var bigItemKeyId = this.formInfo.bigItemKeyId
          var bigEstUnitisAvgDayRatio = this.formInfo.bigEstUnitisAvgDayRatio

          if (bigLastUnitsAvgDay == null || bigLastUnitsAvgDay == 0 || bigItemKeyId == null || bigItemKeyId == 0 || bigEstUnitisAvgDayRatio == null || bigEstUnitisAvgDayRatio == 0.0) {
            flag = true
            this.$message.error("提醒设置一  近** 天日均 >= 天预测日均 百分之** 不能为空 ")
            return flag
          }


          var samllLastUnitsAvgDay = this.formInfo.samllLastUnitsAvgDay
          var samllItemKeyId = this.formInfo.samllItemKeyId
          var samllEstUnitsAvgDayRatio = this.formInfo.samllEstUnitsAvgDayRatio

          if (samllLastUnitsAvgDay == null || samllLastUnitsAvgDay == 0 || samllItemKeyId == null || samllItemKeyId == 0 || samllEstUnitsAvgDayRatio == null || samllEstUnitsAvgDayRatio == 0.0) {
            flag = true
            this.$message.error("提醒设置二 近**天日均 <= 天预测日均百分之**不能为空 ")
            return flag
          }

          return flag

        },
        saveOneRowProductInventory() {

          var url =this.URL_ROOT + this.PREFIX_INVENTORY + "/inventoryByModelNumberHandler/saveProductInventoryInfo"
          this.$ajax({
            method: 'post',
            url: url,
            data: this.formInfo

          }).then(res => {
            if (res.data.code == 200) {
              console.log(res.data.data)
              this.$message.success(res.data.msg)
            } else if (res.data.code == 500) {
              this.$message.error(res.data.msg)
            }


          })
          this.clearFormInfo()
        },
        
      },



    }
</script>

<style scoped>
  .el-table .red_warning-row {
    background: #d6363c;
    color: white;
  }


  .el-table .blue_warning-row {
    background: #9bf995;
  }

  .el-table .hover-row {
    color: black;
  }
</style>
