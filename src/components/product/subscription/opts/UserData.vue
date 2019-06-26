<template>


  <el-container>
    <el-aside name="left">
      <UserLeftSelect ref="userLeftSelect" @sendUserIds="getUserIds"></UserLeftSelect>
    </el-aside>

    <el-main name="main">
      <el-row >
        <el-col :span="4">
          <el-button style="float: left" @click="addProductSub = true">新增产品</el-button>
        </el-col>
      </el-row>

      <el-dialog title="新增产品" :visible.sync="addProductSub" style="width: auto; height: auto;"  @open="initAddProductInfo" @close="clearAddProductInfo">

        <el-form label-width="100px" :model="form" :label-position="LabelPosition"  encType="multipart/form-data">

          <!-- <input v-model="form.sellerSkuId" hidden/>
           <input v-model="form.countryId" hidden/>
           <input v-model="form.sellerId" hidden/>
 -->


          <el-row>
            <el-col :span="6">
              <el-form-item label="国家">
                <el-select  placeholder="请选择国家" filterable v-model="form.countryId" @change="form_chooseCountry()">
                  <el-option v-for="country in formCountryList" :label="country.countryName" :key="country.countryId" :value="country.countryId"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>


          <el-row >
            <el-col :span="6">
              <el-form-item label="产品系列">
                <el-select  placeholder="请选择产品系列" filterable v-model="form.productCategory"  @change="form_chooseProductCategory()">
                  <el-option v-for="productCategory in formProductCategoryList" :key="productCategory.productCategoryId" :value="productCategory.productCategoryId" :label="productCategory.productCategory"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row >
            <el-col :span="7">
              <el-form-item label="产品型号">
                <el-select  placeholder="请选择产品型号"  filterable  clearable v-model="form.productModelNumber" @change="form_chooseProductModelNumber()">
                  <el-option v-for="product in formProductModelNumberList" :key="product.productId" :value="product.productModelNumber" :label="product.productModelNumber"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>

          <el-row >
            <el-col :span="7">
              <el-form-item label="ASIN">
                <el-select  placeholder="请选择ASIN" filterable clearable v-model="form.asinId" @change="form_chooseAsin()">
                  <el-option v-for="asin in formAsinList"  :key="asin.asinId" :value="asin.asinId" :label="asin.asin"></el-option>
                </el-select>
              </el-form-item>
            </el-col>
          </el-row>



        </el-form>

        <div slot="footer" class="dialog-footer">
          <el-button @click="addProductSub = false">取 消</el-button>
          <el-button type="primary" @click="submitProductSub">确 定</el-button>
        </div>

      </el-dialog>

      <!--搜索编码信息-->
      <el-form :model="searchInfo"  >
        <el-form-item style="float: left">
          <el-row :gutter="10">

            <el-col :span="4">
              <el-select placeholder="产品系列"  filterable clearable  v-model="searchInfo.productCategory"  @change="chooseProductCategory">
                <el-option v-for="productCategory in productCategoryList" :key="productCategory.productCategoryId" :value="productCategory.productCategoryId" :label="productCategory.productCategory"></el-option>

              </el-select>
            </el-col>


            <el-col :span="4">
              <el-select placeholder="产品型号" filterable clearable  v-model="searchInfo.productModelNumber"  @change="chooseProductModelNumber">
                <el-option v-for="product in productList" :key="product.productModelNumber" :value="product.productModelNumber" :label="product.productModelNumber"></el-option>

              </el-select>
            </el-col>

            <el-col :span="3">
              <el-select placeholder="ASIN" clearable  filterable v-model="searchInfo.asinId" >
                <el-option v-for="asin in asinList"  :key="asin.asinId" :value="asin.asinId" :label="asin.asin"></el-option>

              </el-select>
            </el-col>

            <el-col :span="3">
              <el-button @click="search">搜索</el-button>
            </el-col>

            <el-col :span="2">
              <download  :tHeader="tHeader" :tableData="userChargeList"  :excelName="excelName"  :filterVal="filterVal"></download>
            </el-col>


          </el-row>
        </el-form-item>

      </el-form>




      <el-table name="showTable" border="border" height="250px" style="width: 100%" :data="userChargeList" @cell-click="deleteUserCharge">
        <el-table-column prop="businessUnit" label="BU" width="160px" ></el-table-column>
        <el-table-column prop="productCategory" label="产品系列" width="160px"></el-table-column>
        <el-table-column prop="countryName" label="国家" width="260px" >
          <template slot="header" slot-scope="scope">
            <el-select placeholder="请选择国家" multiple clearable   filterable v-model="tableHeadCountry" @change="chooseCountry"   >
              <el-option v-for="country in countryList"  :key="country.countryId" :value="country.countryId" :label="country.countryName"></el-option>
            </el-select>
          </template>
        </el-table-column>
        <el-table-column prop="userName" label="负责人"  width="160px"></el-table-column>
        <el-table-column prop="departmentName" label="运营组别" ></el-table-column>
        <el-table-column prop="productModelNumber" label="产品型号" ></el-table-column>
        <el-table-column prop="asin" label="ASIN" ></el-table-column>
        <el-table-column  label="操作" width="120px">
          <template -scope="scope">
            <el-button>删除</el-button>
          </template>
        </el-table-column>

      </el-table>

    </el-main>
  </el-container>

    <!--<div class="userData">


    </div>-->
</template>

<script>
    export default {
      name: "UserData",
      components: {
        download: resolve =>
          require(["components/common/download-xlsx.vue"], resolve),
        UserLeftSelect:resolve =>
          require(['components/product/subscription/opts/UserLeftSelect.vue'], resolve),
      },
      data(){
          return{
            tableHeadCountry:"",
            form:{
              productCategory:"",
              productModelNumber:"",
              asinId:"",
              countryId:"",

            },
            searchInfo:{
              productCategory :"",
              productModelNumber :"",
              asinId :"",
              userCharge:1,

            },
            addProductSub:false,
            LabelPosition:"left",
            userChargeList:[],    //展示list
            productCategoryList:[],
            productList:[],
            asinList:[],
            tHeader: [ //导出excel表头
              "BU",
              "产品系列",
              "国家",
              "负责人",
              "运营组别",
              "产品型号",
              "ASIN",
            ],
            filterVal: [  //导出excel表头属性名
              "businessUnit",
              "productCategory",
              "countryName",
              "userName",
              "departmentName",
              "productModelNumber",
              "asin",
            ],
            excelName: "人员对照表", //导出的excel名称
            countryList:[],
            formCountryList:[],
            formProductCategoryList:[],
            formProductModelNumberList:[],
            formAsinList:[],


          }
      },
      methods:{
          init(){
              this.initProductCategorys()
              this.initModelNumber()
              this.initAsin()
              this.initCountry()

            this.$refs.userLeftSelect.init()
            this.search()
          },
        initProductCategorys(){
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findProductCategoryAll"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.productCategoryList = data
              console.log("this.productCategoryList")
              console.log(this.productCategoryList)
            }
          })
        },
        initModelNumber(){ //所有产品型号
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findModelNumberAll"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.productList = data
            }
          })
        },
        initAsin(){ //所有Asin
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findAsinAll"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){

              this.asinList = []
              this.asinList = res.data.data


            }
          })
        },
        initCountry(){ //所有Asin
          var url = this.URL_ROOT + this.URL_PREFIX + "/findProductCharge/findCountry"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){

              this.countryList = res.data.data
            }
          })
        },
        chooseProductCategory(){
          var productCategoryId = this.searchInfo.productCategory


          //清空 产品型号
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findModelNumberByproductCategoryId/" + productCategoryId
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

          //清空 Asin
          var url1 = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findAsinByproductCategoryId/" + productCategoryId
          console.log(url1)
          //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findUserChargeByDeptId/" + deptId
          this.$ajax.get(url1,{
          }).then(res => {
            if(res.data.code == "200"){
              console.log(res.data)
              //清空 Asin
              this.asinList = []
              this.asinList = res.data.data
            }
          }).then(error => {
            console.log(error)
          })

        },
        chooseProductModelNumber(){
          var productModelNumber = this.searchInfo.productModelNumber

          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findAsinByproductModelNumber/" + productModelNumber

          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
              console.log(res.data)
              //清空 Asin
              this.asinList = []
              this.asinList = res.data.data
            }
          }).then(error => {
            console.log(error)
          })
        },
        chooseAsin(){
          var asinId = this.searchInfo.asinId


          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findProductInByAsin/" + asinId

          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
              console.log(res.data.data)

              if(res.data.data != null){
                this.form = []
                this.form = res.data.data
              }
              //清空 Asin
             // this.asinList = []
             // this.asinList = res.data.data
            }
          }).then(error => {
            console.log(error)
          })

        },
        chooseCountry(){
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findProductSubscriptionList"
          this.requerstSearch(url)
        },
        search(){
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findProductSubscriptionList"

          //初始化 子组件 下拉列表的位置
       //   this.$refs.userLeftSelect.initInputSelectAndShowInput()

          this.requerstSearch(url)
        },
        requerstSearch(url){

          var data = {
            userCharge:this.searchInfo.userCharge,
            productCategory:this.searchInfo.productCategory,
            productModelNumber:this.searchInfo.productModelNumber,
            asinId:this.searchInfo.asinId,
            countryIds:this.tableHeadCountry,
          }

          console.log("data ==")
          console.log(data)

          this.$ajax({
            method:"post",
            url:url,
            data:data,
          }).then(res => {
            if(res.data.code == "200"){
              console.log("res")
              console.log(res.data.data)
              this.userChargeList = res.data.data
            }
          }).catch(error => {
            console.log(error)
          })
        },
        submitProductSub(){
            var userIds = this.searchInfo.userCharge
          if(userIds == null || userIds.length <= 0 ){
            this.$message.error("请先选中对应人员,在进行添加操作")
            return
          }


          if(this.form.countryId == null || this.form.countryId == ""){
            this.$message.error("请选择国家")
            return;
          }if(this.form.productCategory == null || this.form.productCategory == ""){
            this.$message.error("请选择产品系列")
            return;
          }
          if(this.form.productModelNumber == null || this.form.productModelNumber == ""){
            this.$message.error("请选择产品型号")
            return;
          }
          if(this.form.asinId == null || this.form.asinId == ""){
            this.$message.error("请选择asin")
            return;
          }

          var data = {
            productCategoryId:this.form.productCategory,
            productModelNumber:this.form.productModelNumber,
            asinId:this.form.asinId,
            countryId:this.form.countryId,
            userId:this.searchInfo.userCharge,
          }

          var url = this.URL_ROOT + this.URL_PREFIX   + "/productSubscriptionUserRel/addProductByUserCharge"

          this.$ajax({
            method:"post",
            url:url,
            data:data,

          }).then(res => {
            if(res.data.code == "200"){
              console.log("res")
              console.log(res.data.data)
              this.userChargeList = res.data.data
              //初始化 子组件 初始化
              this.$refs.userLeftSelect.init()
              this.$message(res.data.msg)
            }else if(res.data.code =="500"){
              this.$message(res.data.msg)
            }
          }).catch(error => {
            console.log(error)
          })

          //关闭弹窗
          this.addProductSub = false

        },
        deleteUserCharge(row,cell){
          console.log("===deleteUserCharge===")
          console.log(cell.label)
          console.log(row.unionId)

          if(cell.label === "操作"){

            this.$confirm('确定删除负责人？', '提示', {
              confirmButtonText: '确定删除负责人',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              var unionIds = row.unionId
              console.log(row.userName)
              var userCharge = row.userName
              if(userCharge == null || userCharge == ""){
                this.$message.error("不存在负责人,不能删除负责人!")
              }

              var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/deleteUserChargeByUnionId"
              //删除操作
              this.$ajax({
                method:"get",
                url:url,
                params:{
                  unionIds
                }
              }).then(res => {
                if(res.data.code == "200"){
                  console.log("删除成功")
                  console.log(res.data.data)
                  this.userChargeList = res.data.data
                }else if(res.data.code == "500"){
                  this.$message.error(res.data.msg)
                }
              }).catch(error => {
                console.log(error)
              })
            });
          }
        },
        //获取选中的用户id
        getUserIds(data){
          this.searchInfo.userCharge = data
          this.search()
        },
        getProductSubscriptionCountrys(){
            //获取产品订阅 相关的所有国家
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/getProductSubscriptionCountrys"
          this.$ajax.get(url).then(res => {
            if(res.data.code == "200"){
              console.log("getProductSubscriptionCountrys")
              console.log(res.data.data)
             this.formCountryList = res.data.data
            }
          }).catch(error => {
            console.log(error)
          })
        },
        getProductSubscriptionProductCategorys(){ //获取 user_product_amz_asin_rel 表下 所有产品系列
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/getProductSubscriptionProductCategorys"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.formProductCategoryList = data
            }
          })
        },
        getProductSubscriptionProductModelNumbers(){ //获取 user_product_amz_asin_rel 表下 所有产品型号
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/getProductSubscriptionProductModelNumbers"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.formProductModelNumberList = data
            }
          })
        },
        getProductSubscriptionAsins(){ //获取 user_product_amz_asin_rel 表下 所有Asin
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/getProductSubscriptionAsins"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.formAsinList = data
            }
          })
        },
        initAddProductInfo(){
          this.getProductSubscriptionCountrys();
          this.getProductSubscriptionProductCategorys();
          this.getProductSubscriptionProductModelNumbers();
          this.getProductSubscriptionAsins();
        },
        form_chooseCountry(){
          this.form.asinId = ''
          var countryId = this.form.countryId
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/getProductCategoryByCountryId/" + countryId
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.formProductCategoryList = data
            }
          })
        },
        form_chooseProductCategory(){
          this.form.asinId = ''
          var productCategory = this.form.productCategory
          var countryId = this.form.countryId
          if(countryId == null || countryId == ""){
            this.$message.error("请选择国家")
            return
          }
          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/getModelNumberByProductCategory/" + productCategory + "/" + countryId
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.formProductModelNumberList = data
            }
          })
        },
        form_chooseProductModelNumber(){
          this.form.asinId = ''
          var productModelNumber = this.form.productModelNumber
          var productCategory = this.form.productCategory
          var countryId = this.form.countryId
          if(countryId == null || countryId == ""){
            this.$message.error("请选择国家")
            return
          }
          if(productCategory == null || productCategory == ""){
            this.$message.error("请选择产品系列")
            return
          }
          var url = this.URL_ROOT + this.URL_PREFIX +    "/productSubscriptionUserRel/getAsinByProductModelNumber/" + productModelNumber +"/" + productCategory + "/" + countryId
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.formAsinList = data
            }
          })
        },
        form_chooseAsin(){
          var asinId = this.form.asinId

          var productModelNumber = this.form.productModelNumber
          var productCategory = this.form.productCategory
          var countryId = this.form.countryId
          if(countryId == null || countryId == ""){
            this.$message.error("请选择国家")
            return
          }
          if(productCategory == null || productCategory == ""){
            this.$message.error("请选择产品系列")
            return
          }
          if(productModelNumber == null || productModelNumber == ""){
            this.$message.error("请选择产品型号")
            return
          }

        },
        clearAddProductInfo(){

            this.form.productCategory = ""
            this.form.productModelNumber=""
            this.form.asinId=""
            this.form.countryId=""
        },
      }
    }
</script>

<style scoped>


</style>
