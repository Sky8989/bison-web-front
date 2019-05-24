<template>
  <div>



    <el-row style="padding: 0px 0px 6px">
      <el-col :span="14">
        <div class="block">
         <!-- <span class="demonstration">起始日期时刻为 12:00:00</span>-->
          <el-date-picker
            v-model="time.startTimeAndEndTime"
            type="datetimerange"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            format="yyyy-MM"
            value-format="yyyy-MM" size="mini"
            @change="chooseTime"
            >
          </el-date-picker>
          &nbsp;
          <el-button type="primary" size="mini" @click="search" >搜索</el-button>
        </div>
      </el-col>

    </el-row>
    <el-row >
      <el-col :span="4">
        <download  :tHeader="tHeader" :tableData="tableData"  :excelName="excelName"  :filterVal="filterVal"></download>
      </el-col>
    </el-row>
    <br>

    <el-table name="showTable" border="border" height="350px" style="width: 100%" :data="salePlanItemList"
              @selection-change="selectionChangeSalePlanItemId" :show-summary="showSummary" :summary-method="getSum">

      <el-table-column type="selection" width="40"> </el-table-column>


      <el-table-column   label="提交人" >
        <template slot="header" slot-scope="scope" >
          <el-select placeholder="请选择提交人" clearable  filterable  multiple v-model="tableHeadUserList"  size="mini" @change="chooseUser" >
            <el-option v-for="user in userList"  :key="user.userId" :value="user.userId" :label="user.userName"></el-option>
          </el-select>
        </template>
        <template  slot-scope="scope" >
          {{scope.row.userName}}
        </template>
      </el-table-column>

      <el-table-column   label="国家" >
        <template slot="header" slot-scope="scope" >
          <el-select placeholder="请选择国家" clearable  filterable  multiple v-model="tableHeadCountryList" @change="chooseCountry"  size="mini" >
            <el-option v-for="country in countryList"  :key="country.countryId" :value="country.countryId" :label="country.countryName"></el-option>
          </el-select>
        </template>

        <template slot-scope="scope">
          <span>{{scope.row.countryName}}</span>
        </template>

      </el-table-column>

      <el-table-column  label="modelNumber"  >
        <template slot="header" slot-scope="scope">
          <el-select placeholder="请选择 modelNumber" clearable  filterable  multiple v-model="tableHeadModelNumberList" @change="chooseModelNumber"  size="mini">
            <el-option v-for="product in productList"  :key="product.productId" :value="product.productId" :label="product.productModelNumber"></el-option>
          </el-select>
        </template>

        <template slot-scope="scope">
          <span>{{scope.row.productModelNumber}}</span>
        </template>
      </el-table-column>

      <el-table-column  prop="asin" label="ASIN" width="80px"></el-table-column>


      <el-table-column  v-for="v in itemKeyList"  :key="v.itemKeyId" :label="v.itemKey+itemKeyNameLast"  v-if="v.type == 1" width="80px">
        <template  slot-scope="scope">
          <!-- {{scope.row.itemValVOList}}-->
          <span v-for="item in scope.row.itemValVOList"  v-if="item.itemKeyId == v.itemKeyId"  >{{item.itemVal}}</span>
        </template>
      </el-table-column>

      <el-table-column  prop="lastUnitsAvgDay" label="加权历史日均" width="120px"></el-table-column>

      <el-table-column  v-for="v in itemKeyList"  :key="v.itemKeyId" :label="v.itemKey+itemKeyNameEst" v-if="v.type == 2" width="80px">
        <template  slot-scope="scope">
          <span v-for="item in scope.row.itemValVOList" v-if="item.itemKeyId == v.itemKeyId" >{{item.itemVal}}</span>
        </template>
      </el-table-column>

      <el-table-column  prop="estUnitsAvgDay" label="加权预测日均" width="120px"></el-table-column>
      <el-table-column  prop="estUnitsPromotion" label="活动预测量" width="120px"></el-table-column>
      <el-table-column  prop="rationality" label="合理性"  width="120px">
        <template  slot-scope="scope">
          <span v-if="scope.row.rationality > 0 ">合理</span>
          <span v-if="scope.row.rationality < 0 ">不合理</span>
        </template>
      </el-table-column>

      <el-table-column   label="状态" width="180px">
        <template slot="header" slot-scope="scope">
          <el-select placeholder="请选择 状态" clearable  filterable  v-model="tableHeadStatus" @change="chooseStatus" size="mini">
            <el-option v-for="obj in statusList" :key="obj.i" :value="obj.i" :label="obj.name"></el-option>
          </el-select>
        </template>

        <template  slot-scope="scope">
          <span v-for="obj in statusList"  v-if="scope.row.status == obj.i" :key="obj.i" >
            {{obj.name}}
            <span v-if="obj.i == 2">
              <el-button type="primary" size="mini"  @click="updateStatus(scope.row.salePlanItemId,3)" >通过</el-button>
            </span>
            <span v-if="obj.i == 3">
              <el-button type="primary" size="mini" @click="updateStatus(scope.row.salePlanItemId,4)" >驳回</el-button>
            </span>
          </span>
        </template>


      </el-table-column>

      <el-table-column  prop="remark" label="备注" width="120px">
        <template  slot-scope="scope">
          <div v-if="scope.row.remark != null && scope.row.remark != '' ">
            <el-popover trigger="hover" placement="top" >
              <p v-for="rowRemark in scope.row.showRemark">{{rowRemark}}</p>
              <div slot="reference" class="name-wrapper">
                <el-tag size="mini">查看备注</el-tag>
                <el-tag size="mini" @click="openRemarkDialog(scope.row)">添加备注</el-tag>
              </div>
            </el-popover>
          </div>

          <div v-if="scope.row.remark == null || scope.row.remark == '' ">
            <span>
            <el-button type="primary" size="mini" @click="openRemarkDialog(scope.row)">添加备注</el-button>
          </span>
          </div>


        </template>

      </el-table-column>

    </el-table>

    <!--添加 备注-->
    <el-dialog
      title="提交反馈"
      :visible.sync="remarkDialog"
      width="20%"
      :before-close="remarkDialogClose" >

      <el-form :model="remarkForm"  label-width="100px" class="demo-dynamic" style="width: 80%">

        <input v-model="remarkForm.salePlanItemId" hidden/>

        <el-form-item label="反馈内容">
          <el-input type="textarea"  :rows="2"  v-model="remarkForm.remark" controls-position="right"
                    :step="1"  :max="10000"
                    size="mini"></el-input>
        </el-form-item>
      </el-form>


      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="addRemark" size="mini">添 加</el-button>
      </div>
    </el-dialog>

    <div>
      <el-button type="primary" @click="batchUpdateStatus(3)">批量通过</el-button>
    </div>


  </div>

</template>

<script>
    export default {
        name: "SalePSalePlanSalesInChargeViewTable",
      components: {
        download: resolve =>
          require(["components/xlsx/download.vue"], resolve)
      },
      data(){
          return{
            showSummary:true,
            itemKeyNameLast : '天历史日均',
            itemKeyNameEst : '天预测日均',
            statusList:[{i:1,name:"未提交"},{i:2,name:"待审核"},{i:3,name:"主管通过"},{i:4,name:"主管驳回"},{i:5,name:"采购接纳"},{i:6,name:"采购反馈"}],
            time:{
              startTimeAndEndTime:''
            },
            userId:this.$store.state.LoginedUser.userId,
            //userId:1,
            itemKeyList:[],
            countryList:[],
            productList:[],
            userList:[],
            salePlanItemList:[],
            tableHeadUserList:[],
            tableHeadModelNumberList:[],
            tableHeadCountryList:[],
            tableHeadStatus:0,
            salePlanId:'',

            //下载
            tableData:[],
            tHeader:[],
            filterVal: [],
            excelName:'销量计划模板',

            //批量操作的id
            batchUpdateStatuIdList:[],

            //添加反馈
            remarkDialog:false,
            remarkForm:{salePlanItemId:0,remark:"",userId:0},



          }
      },
      mounted() {
        this.init()
      },
      methods:{
        init(){

          this.initSearchInfo()
          this.initCountryList()
          this.initProductList()
          this.initItemKeyList()
          this.initUserList()
         this.searchSalePlanItemList()
        },
        initUserList(){
         // console.log"initUserList")
          var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/salesPalnSalesChargeViewHandler/findUserList/"+ this.userId
          // var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/productCoded/findCountryList"
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
             // console.logres.data.data)
              this.userList = res.data.data
            }

          }).catch(error => {
            console.log(error)
          })

        },
        initSearchInfo(){
          this.salePlanId = 0
          this.tableHeadCountryList = []
          this.tableHeadModelNumberList = []
          this.tableHeadStatus = 0
          this.tableHeadUserList = []
          this.time = {startTimeAndEndTime:''}
        },
        searchSalePlanItemList(){
         // console.log"initSalePlanItemList")
          var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/salesPalnSalesChargeViewHandler/findSalePlanItemList"


          var startTime = ""
          var endTime = ""
          if(this.time.startTimeAndEndTime != null && this.time.startTimeAndEndTime.length == 2){
            startTime = this.time.startTimeAndEndTime[0]
            endTime = this.time.startTimeAndEndTime[1]
          }

          var data = {
            salePlanId:this.salePlanId,
            countryIdList:this.tableHeadCountryList,
            productIdList:this.tableHeadModelNumberList,
            status:this.tableHeadStatus,
            userId:this.userId,
            userIdList:this.tableHeadUserList,
            endPalnDate:endTime,
            startPalnDate:startTime,
          }

          this.$ajax({
            method:'post',
            url:url,
            data:data
          }).then(res => {
            if(res.data.code == "200"){
             // console.logres.data.data)
              this.salePlanItemList = res.data.data

              this.createExportData(this.salePlanItemList)
            }

          }).catch(error => {
            console.log(error)
          })
        },
        initCountryList(){
          var url = this.URL_ROOT + this.URL_PREFIX +"/findProductCharge/findCountry"
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
             // console.logres.data.data)
              this.countryList = res.data.data
            }

          }).catch(error => {
            console.log(error)
          })
        },
        initProductList(){
          var url = this.URL_ROOT + this.URL_PREFIX +"/findProduct/findAll"
          this.$ajax.get(url,{

          }).then(res => {
            if(res.data.code == "200"){
             // console.logres.data.data)
              this.productList = res.data.data
            }

          }).catch(error => {
            console.log(error)
          })
        },
        initItemKeyList(){
         // console.log"initItemKeyList")

          var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/salesPalnSalesViewHandler/findItemKeyAll/" + this.userId
          // var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/productCoded/findCountryList"
          this.$ajax.get(url,{


          }).then(res => {
            if(res.data.code == "200"){
             // console.logres.data.data)
              this.itemKeyList = res.data.data
            }

          }).catch(error => {
            console.log(error)
          })
        },
        handleClose(done){
          this.$confirm('确认关闭？')
            .then(_ => {
              done();
            })
            .catch(_ => {});
        },
        download(){

        },

        chooseUser(){
         // console.log"chooseUser")
          this.searchSalePlanItemList();
        },
        chooseCountry(){
         // console.log"chooseCountry")
          this.searchSalePlanItemList();
        },
        chooseModelNumber(){
         // console.log"chooseModelNumber")
          this.searchSalePlanItemList();
        },
        chooseStatus(){
         // console.log"chooseStatus")
          this.searchSalePlanItemList();
        },
        getLastUnitsAvgDayIndex(headFiledArray){
          if(headFiledArray != null && headFiledArray.length > 0){
            for(var i = 0; i < headFiledArray.length; i++){
              if(headFiledArray[i] == "lastUnitsAvgDay"){
                return i
                break
              }
            }
          }
          return 0

        },
        getEstUnitsAvgDayIndex(headFiledArray){
          if(headFiledArray != null && headFiledArray.length > 0){
            for(var i = 0; i < headFiledArray.length; i++) {
              if (headFiledArray[i] == "estUnitsAvgDay") {
                return i
                break
              }
            }
          }
          return 0
        },//表头中文名
        getheadArrayMap(){
          var map = new Map()
          map.set("userName","提交人");
          map.set("countryName","国家");
          map.set("asin","ASIN");
          map.set("lastUnitsAvgDay","加权历史日均");
          map.set("estUnitsAvgDay","加权预测日均");
          map.set("estUnitsPromotion","活动预测量");
          map.set("rationality","合理性");
          map.set("status","状态");
          map.set("remark","备注");

          return map

        },
        createExportData(salePlanItemList){

          if(salePlanItemList != null && salePlanItemList.length > 0){
            /**
             * 数据
             */
            var exportData = this.salePlanItemList
            var itemKeyList = this.itemKeyList
            /**
             * 表头字段数组
             * */
            var headFiledArray = new Array()

            /**
             * 获取不可变字段
             * */
            var salePlanItem = salePlanItemList[0]
            var array = Object.keys(salePlanItem);
            // console.log("array = ")
            // console.log(array)
            for(var j = 0; j < array.length; j++){
              var name = array[j]
              if(name == "userName"){
                var headFiledArray = array.slice(j,array.length-1)
                break
              }
            }


           // console.log"headFiledArray = ")
           // console.logheadFiledArray )

            /**
             * 获取可变字段
             * */

            var salePlanItem = salePlanItemList[0]
           // console.log"length = "+ this.itemKeyList.length)
            for(var k = 0; k < this.itemKeyList.length; k++){
              var itemKeyObj = this.itemKeyList[k]
             // console.log"itemKeyObj" + k)
             // console.logitemKeyObj)
              var type = itemKeyObj.type

              //存在itemVal 存在saleplanItemId
              if(salePlanItem.itemValVOList != null && salePlanItem.itemValVOList.length > 0){
                for(var j = 0; j < salePlanItem.itemValVOList.length; j++){
                  var itemValObj = salePlanItem.itemValVOList[j]
                 // console.log"itemKeyObj" + k)
                 // console.logitemKeyObj)
                  //同一个 itemKeyId
                  if(itemValObj.itemKeyId == itemKeyObj.itemKeyId){
                    if(type == 1){
                      var index =  this.getLastUnitsAvgDayIndex(headFiledArray);
                      //添加动态属性
                      headFiledArray.splice(index,0,itemKeyObj.itemKey + this.itemKeyNameLast)
                    }else if(type == 2){
                      var index =  this.getEstUnitsAvgDayIndex(headFiledArray);
                      //添加动态属性
                      headFiledArray.splice(index,0,itemKeyObj.itemKey + this.itemKeyNameEst)
                    }
                    break
                  }
                }
              }else{
                if(type == 1){
                  var index =  this.getLastUnitsAvgDayIndex(headFiledArray);
                  //添加动态属性
                  headFiledArray.splice(index,0,itemKeyObj.itemKey + this.itemKeyNameLast)
                }else if(type == 2){
                  var index =  this.getEstUnitsAvgDayIndex(headFiledArray);
                  //添加动态属性
                  headFiledArray.splice(index,0,itemKeyObj.itemKey + this.itemKeyNameEst)
                }
              }

            }


           // console.log"headFiledArray =2 ")
           // console.logheadFiledArray )

           // console.log"exportData =1 ")
           // console.logexportData )

            for(var i = 0; i < exportData.length; i++){
              var salePlanItem = exportData[i]
              var itemValList = salePlanItem.itemValVOList
             // console.log"itemValList")
             // console.logitemValList)
              if(itemValList != null && itemValList.length > 0){
                for(var j = 0; j < itemValList.length; j++){
                  var itemValObj = itemValList[j]
                  var value = itemValObj.itemVal;
                  var type = itemValObj.type;
                 // console.log'itemVal =' + value)
                  if(type == 1){
                   // console.log'type =' + type)
                    //给salePlanItem添加属性 以及值
                    var itemKey = itemValObj.itemKey + this.itemKeyNameLast
                    salePlanItem[itemKey] = value
                  }else if(type == 2){
                   // console.log'type =' + type)

                    var itemKey = itemValObj.itemKey + this.itemKeyNameEst
                    salePlanItem[itemKey] = value
                  }

                }
              }
            }
           // console.log"exportData =2 ")
           // console.logexportData )

            /**
             * 表头数组
             * */
            var headArray = new Array()

            var headMap = this.getheadArrayMap()
            for(var i = 0; i < headFiledArray.length; i++){
              var head = headFiledArray[i]
              var value = headMap.get(head)
             // console.log"value === " + value)
              if(value != null && value != ''){
                headArray.push(value)
              }else{
                headArray.push(head)
              }
            }

           // console.log"表头数组===")
           // console.logheadArray)

            this.tableData = exportData
            this.tHeader = headArray
            this.filterVal = headFiledArray
            this.excelName = "销售计划"
            // }
          }

        },
        selectionChangeSalePlanItemId(salePlanItemList){
         // console.log"selectionChangeSalePlanItemId")
         // console.logsalePlanItemList)

          //先初始化
          this.batchUpdateStatuIdList = []

          //保存选中的id
          for(var i = 0; i < salePlanItemList.length; i++){
            var salePlanItemId = salePlanItemList[i].salePlanItemId
            var status = salePlanItemList[i].status

            //符合条件的
            if(status == 2){
              this.batchUpdateStatuIdList.push(salePlanItemId)
            }
          }


        },
        chooseTime(){
         // console.log"chooseTime")
         // console.logthis.time.startTimeAndEndTime)
          if(this.time.startTimeAndEndTime != null && this.time.startTimeAndEndTime.length == 2){
            var startTime = this.time.startTimeAndEndTime[0]
            var endTime = this.time.startTimeAndEndTime[1]
          }


        },
        search(){
          this.searchSalePlanItemList();
        },
        updateStatus(id,status){

          if(id == null || id == "" || id == 0){
            this.$message.error("销售计划子项id不能为空")
            return
          }

          var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesPalnSalesViewHandler/updateStatusBySalePlanItemId/" +id +"/" + status

          this.$ajax.put(url,{}).then(res=>{
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              //刷新
              this.search()
            }else if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }

          }).catch(err => {
            console.log(err)
          })

        },batchUpdateStatus(status){
         // console.log"批量通过")
         // console.logstatus)

          if(this.batchUpdateStatuIdList == null || this.batchUpdateStatuIdList.length == 0){
            this.$message.error("请先选择销售计划!")
            return
          }
          var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesPalnSalesViewHandler/batchUpdateStatusBySalePlanItemIdList"
          var data = {
            status:status,
            salePlanItemIdList:this.batchUpdateStatuIdList
          }

          this.$ajax({
            method:'post',
            url:url,
            data:data
          }).then(res=>{
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              //刷新
              this.search()
            }else if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }

          }).catch(err => {
           // console.logerr)
          })
        },
        remarkDialogClose(){
          this.clearRemarkForm()
          this.remarkDialog = false
        },
        openRemarkDialog(row){
          //赋值,隐藏
          this.remarkForm.salePlanItemId = row.salePlanItemId
          this.remarkDialog = true;
        },
        addRemark(){
          this.remarkForm.userId = this.userId
          var data = this.remarkForm

          if(data == null){
            this.$message.error("提交数据为空,保存失败")
            return
          }
          if(data.userId == null || data.salePlanItemId == 0 ){
            this.$message.error("用户id为空,保存失败")
            return
          } if(data.salePlanItemId == null || data.salePlanItemId == 0 ){
            this.$message.error("销售计划itemId为空,保存失败")
            return
          }

          var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesOperationsViewHandler/addRemark"
          this.$ajax({
            method:"post",
            url:url,
            data:data
          }).then(res => {
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              this.search()
            }else if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          }).catch(err =>{
            console.log(err)

          })
          this.clearRemarkForm()
          this.remarkDialog = false

        },
        clearRemarkForm(){
          this.remarkForm = {salePlanItemId:0,remark:""}
        },
        getHeadFiledMap(){
          var map = new Map()
          map.set("提交人","userName");
          map.set("国家","countryName");
      //    map.set("ASIN","asin");
          map.set("加权历史日均","lastUnitsAvgDay");
          map.set("加权预测日均","estUnitsAvgDay");
          map.set("活动预测量","estUnitsPromotion");
     //     map.set("合理性","rationality");
      //    map.set("状态","status");
    //      map.set("备注","remark");

          return map

        },
        getSum(param) {
         // console.log"getSum")
         // console.logparam)
          //data [{}]
          const { columns, data } = param;
          const sums = [];
          columns.forEach((column, index) => {
           // console.log"index = " + index)
           // console.logcolumn.label)
            if (index === 0) {
              sums[index] = '总价';
              return;
            }

            var headFiledMap = this.getHeadFiledMap()


            //求合
            const values = data.map(item =>
              Number(item[headFiledMap.get(column.label) ==  undefined ? column.label : headFiledMap.get(column.label) ]));
           // console.log"values = ")
           // console.logvalues)
            if (!values.every(value => isNaN(value))) {
              sums[index] = values.reduce((prev, curr) => {
                const value = Number(curr);
                if (!isNaN(value)) {
                  return prev + curr;
                } else {
                  return prev;
                }
              }, 0);

              sums[index] += '';
            } else {
              sums[index] = 'N/A';
            }
          });

          return sums;
        },


      }

    }
</script>

<style scoped>

</style>
