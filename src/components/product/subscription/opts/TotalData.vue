<template>
  <div class="totalData">


    <el-form :model="searchInfo"  method="post"   encType="multipart/form-data">
      <el-form-item style="float: left">
        <el-row :gutter="10">

          <el-col :span="3">
            <el-select placeholder="BU"  filterable clearable  v-model="searchInfo.businessUnitId"  @change="chooseBU">
              <el-option v-for="bu in BUList" :key="bu.businessUnitId" :value="bu.businessUnitId" :label="bu.businessUnit"></el-option>

            </el-select>
          </el-col>


          <el-col :span="3">
            <el-select placeholder="运营组别" filterable clearable  v-model="searchInfo.operationGroup"  @change="chooseDept" :disabled="disabled">
              <el-option v-for="operationGroup in operationGroupList" :key="operationGroup.id" :value="operationGroup.id" :label="operationGroup.departmentName"></el-option>

            </el-select>
          </el-col>

          <el-col :span="3">
            <el-select placeholder="负责人" filterable  clearable   v-model="searchInfo.userChargeName" >
              <el-option v-for="user in userList"  :key="user.userId" :value="user.userId" :label="user.userName"></el-option>

            </el-select>
          </el-col>


        </el-row >

        <el-row :gutter="10" style="margin-top: 10px">
          <el-col :span="3">
            <el-select placeholder="产品系列"  filterable clearable  v-model="searchInfo.productCategory"  @change="chooseProductCategory">
              <el-option v-for="productCategory in productCategoryList" :key="productCategory.productCategoryId" :value="productCategory.productCategoryId" :label="productCategory.productCategory"></el-option>

            </el-select>
          </el-col>


          <el-col :span="4">
            <el-select placeholder="产品型号"  filterable clearable  v-model="searchInfo.productModelNumber" @change="chooseProductModelNumber">
              <el-option v-for="product in productList" :key="product.productModelNumber" :value="product.productModelNumber" :label="product.productModelNumber"></el-option>

            </el-select>
          </el-col>

          <el-col :span="4">
            <el-select placeholder="ASIN" clearable  filterable v-model="searchInfo.asinId" >
              <el-option v-for="asin in asinList"  :key="asin.asinId" :value="asin.asinId" :label="asin.asin"></el-option>

            </el-select>
          </el-col>


          <el-col :span="2">
            <el-button @click="search">查找</el-button>
          </el-col>
          <el-col :span="3">
            <el-button @click="clearSearchInfo">清空筛选条件</el-button>
          </el-col>

          <el-col :span="3">
            &nbsp;&nbsp;<!-- <el-button @click="download" >下载</el-button>-->
            <download  :tHeader="tHeader" :tableData="userChargeList" :excelName="excelName"  :filterVal="filterVal"></download>
          </el-col>

        </el-row>


      </el-form-item>

    </el-form>



    <el-table name="showTable" border="border" height="250px" style="width: 100%" :data="userChargeList">
      <el-table-column prop="businessUnit" label="BU" ></el-table-column>
      <el-table-column prop="productCategory" label="产品系列"  ></el-table-column>
      <!--  <el-table-column prop="countryName" label="国家" :filters="countryList" :filter-method="filterCountry" >-->
      <el-table-column prop="countryName" label="国家"  >
        <template slot="header" slot-scope="scope">
          <el-select placeholder="请选择国家" clearable  filterable  multiple v-model="tableHeadCountry" @change="chooseCountry"   >
            <el-option v-for="country in countryList"  :key="country.countryId" :value="country.countryId" :label="country.countryName"></el-option>
          </el-select>
        </template>

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
    name: "totalData",
    components: {
      download: resolve =>
        require(["components/xlsx/download.vue"], resolve)
    },
    data(){
      return{
        tableHeadCountry:"",
        disabled:true,
        searchInfo:{
          businessUnitId:'',
          operationGroup:'',
          userChargeName:'',
          productCategory:'',
          productModelNumber:'',
          asinId:'',
        },
        userChargeList:[
          /*{businessUnit:"aaa",productCategory:"bbb",countryName:"Uk",userName:"1号负责人",departmentName:"A组",productModelNumber:"samgda",asin:"aaaa"},
          {businessUnit:"aaa",productCategory:"bbb",countryName:"Uk",userName:"1号负责人",departmentName:"A组",productModelNumber:"samgda",asin:"aaaa"},
          {businessUnit:"aaa",productCategory:"bbb",countryName:"Uk",userName:"1号负责人",departmentName:"A组",productModelNumber:"samgda",asin:"aaaa"},
          {businessUnit:"aaa",productCategory:"bbb",countryName:"Uk",userName:"1号负责人",departmentName:"A组",productModelNumber:"samgda",asin:"aaaa"},*/

        ],
        BUList:[],
        operationGroupList:[],
        userList:[],
        productCategoryList:[],
        productList:[],
        asinList:[],
        countryList:[],   //表头过滤数据
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
        excelName: "产品订阅总表", //导出的excel名称
        userAllList:[],
      }
    },
    methods:{
      init(){
        this.clearSearchInfo()

        this.search()

        this.initBU()
        this.initProductCategory()
        this.initUserCharge()
        this.initModelNumber()
        this.initAsin()
        this.initCountryList()
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
      initUserCharge(){ //所有产品系列
        var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findUserChargeAll"
        this.$ajax.get( url,{
        }).then(res => {
          if(res.data.code == "200"){
            var data = res.data.data
            this.userList = data
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
      initAsin(){ //所有Asin
        var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findAsinAll"
        this.$ajax.get( url,{
        }).then(res => {
          if(res.data.code == "200"){

            this.asinList = []
            this.asinList = res.data.data
          }
        })
      },
      chooseBU(){
        //清空运营组
        this.disabled = false
        var buId = this.searchInfo.businessUnitId
        var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findOperationGroupByBuId/" + buId
        console.log(url)
        //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findOperationGroupByBuId/" + BuId
        this.$ajax.get(url,{
        }).then(res => {
          if(res.data.code == "200"){
            console.log(res.data)
            this.operationGroupList = []
            this.operationGroupList = res.data.data
          }
        }).then(error => {
          console.log(error)
        })

        //清空系列
        var url1 = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findProductCategoryByBuId/" + buId
        console.log(url1)
        //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findProductCategoryByBuId/" + BuId
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
      chooseDept(){

        var deptId = this.searchInfo.operationGroup

        var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findUserChargeByDeptId/" + deptId
        console.log(url)
        //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findUserChargeByDeptId/" + deptId
        this.$ajax.get(url,{
        }).then(res => {
          if(res.data.code == "200"){
            console.log(res.data)
            //清空负责人
            this.userList = res.data.data
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


        //清空 Asin
        var url1 = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findAsinByproductCategoryId/" + productCategoryId
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
        var productModelNumber =  this.searchInfo.productModelNumber
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
      chooseCountry(){
        var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findProductSubscriptionList"
        this.requerstSearch(url)
      },
      search(){
        var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/findProductSubscriptionList"
        this.requerstSearch(url)
      },
      requerstSearch(url){
        console.log("requerstSearch")
        console.log(this.tableHeadCountry)
        var data = {
          businessUnitId:this.searchInfo.businessUnitId ,
          operationGroup:this.searchInfo.operationGroup,
          userCharge:this.searchInfo.userChargeName,
          productCategory:this.searchInfo.productCategory,
          productModelNumber:this.searchInfo.productModelNumber,
          asinId:this.searchInfo.asinId,
          countryIds:this.tableHeadCountry,
        }

        this.$ajax({
          method:"post",
          url:url,
          data:data,
        }).then(res => {
          if(res.data.code == "200"){
            this.userChargeList = res.data.data
            this.userAllList = res.data.data.userAllList
          }
        }).catch(error => {
          console.log(error)
        })
      },
      clearSearchInfo(){

        this.searchInfo.businessUnitId = ''
        this.searchInfo.operationGroup = ''
        this.searchInfo.userChargeName = ''
        this.searchInfo.productCategory = ''
        this.searchInfo.productModelNumber = ''
        this.searchInfo.asinId = ''

      },
      initCountryList(){
        var url = this.URL_ROOT + this.URL_PREFIX +"/findProductCharge/findCountry"
        // var url = this.URL_ROOT + this.URL_PREFIX +"/productCoded/findCountryList"
        this.$ajax.get(url,{

        }).then(res => {
          if(res.data.code == "200"){
            console.log(res.data.data)
            this.countryList = res.data.data
          }

        }).catch(error => {
          console.log(error)
        })
      },
      /*filterCountry(value,row){
        console.log("value = " + value)
        return row.countryName == value
      },*/
      download(){
        this.$confirm('确定下载？', '提示', {
          confirmButtonText: '确定下载',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.goDownload();
        });
      },
      goDownload(){


        var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscription/downloadProductSubscriptionList"
        var data = {
          businessUnitId:this.searchInfo.businessUnitId ,
          operationGroup:this.searchInfo.operationGroup,
          userCharge:this.searchInfo.userChargeName,
          productCategory:this.searchInfo.productCategory,
          productModelNumber:this.searchInfo.productModelNumber,
          asinId:this.searchInfo.asinId,
        }

        this.$ajax({
          method:"get",
          url:url,
          data:data,
        }).then(res => {
          if(res.data.code == "200"){
            this.userChargeList = res.data.data
          }

          console.log("download")
          console.log(res)


        }).catch(error =>{
          console.log(error)

        })

      }
    }
  }
</script>

<style scoped>

</style>
