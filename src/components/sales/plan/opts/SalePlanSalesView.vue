<template>
  <div >

    <!--创建销售计划-->
    <el-dialog
      title="创建销售计划"
      :visible.sync="dialogVisible"
      width="20%"
      :before-close="handleClose" >

      <el-date-picker
        v-model="salePlanTime"
        type="month"
        placeholder="选择日期">
      </el-date-picker>


      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="createSalePlan" size="mini">创 建</el-button>
      </div>

    </el-dialog>

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

    <form method="post" target="upload" action enctype="multipart/form-data">
    <el-row style="padding: 0px 0px 6px">
      <el-col :span="5">
        <el-select v-model="salePlanId" clearable  placeholder="请选择销售计划" style="width: 220px" @change="chooseSalePlanId" size="mini">
          <el-option v-for="salePlan in salePlanList" :key="salePlan.salePlanId" :value="salePlan.salePlanId" :label="salePlan.showSalePlan" ></el-option>
        </el-select>
      </el-col>

      <el-col :span="4">
        <el-button type="primary" @click="dialogVisible=true" size="mini">创建销售计划</el-button>
      </el-col>
    </el-row>

    <el-row style="padding: 0px 0px 6px">
      <el-col :span="5">
        <download  :tHeader="tHeader" :tableData="tableData"  :excelName="excelName"  :filterVal="filterVal"></download>
      </el-col>

      <el-col :span="4">
        <el-upload
          ref="upload"
          class="upload-demo"
          name="uplaodSalePlanFile"
          :action="uplaodSalePlanFileAction"
          :data="params"
          :on-preview="handlePreview"
          :on-exceed="handleExceed"
          :on-success="onSuccess"
          :before-upload="beforeUpload"
          :on-error="uploadError"
          :show-file-list="showFilteList"
          >
          <el-button  type="primary" size="mini">上传模块</el-button>
          <div slot="tip" class="el-upload__tip">只能上传excel文件</div>
        </el-upload>
      </el-col>
    </el-row>
    </form>


    <el-table name="showTable" border="border" height="350px" style="width: 100%" :data="salePlanItemList"
              @selection-change="selectionChangeId"  :show-summary="showSummary" @cell-click="clickitemKeyCol" :summary-method="getSum">
      <el-table-column type="selection"   width="40" >  </el-table-column>

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
          <span v-for="item in scope.row.itemValVOList" v-if="item.itemKeyId == v.itemKeyId" >{{item.itemVal}}</span>
        </template>
      </el-table-column>

      <el-table-column  prop="lastUnitsAvgDay" label="加权历史日均" width="120px"></el-table-column>

      <el-table-column  v-for="v in itemKeyList"  :key="v.itemKeyId" :label="v.itemKey+itemKeyNameEst" v-if="v.type == 2" width="80px">
        <template  slot-scope="scope">

          <!--可编辑 存在id-->
          <div v-if="scope.row.salePlanItemId != null && scope.row.salePlanItemId != 0" v-for="item in scope.row.itemValVOList">

            <el-input v-if="item.itemKeyId == v.itemKeyId && item.disabled == false"
                      v-model="itemValIdLsit[item.itemValId]=item.itemVal" ></el-input>

            <el-input v-if="item.itemKeyId == v.itemKeyId && item.disabled == true"  :disabled="item.disabled"
                      v-model="itemValIdLsit[item.itemValId]=item.itemVal"></el-input>
          </div>

          <div v-if="scope.row.salePlanItemId == null && scope.row.salePlanItemId == 0" v-for="item in scope.row.itemValVOList">
            <!--不可编辑 不存在id-->
            <span v-if="item.itemKeyId == v.itemKeyId"  >{{item.itemVal}}</span>
          </div>


        </template>
      </el-table-column>

      <el-table-column  prop="estUnitsAvgDay" label="加权预测日均" width="110px"></el-table-column>
      <el-table-column  prop="estUnitsPromotion" label="活动预测量" width="110px"></el-table-column>
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
            {{obj.name}} &nbsp;
            <span v-if="obj.i == 1 || obj.i == 4"> <el-button type="primary" size="mini" @click="updateStatus(scope.row.salePlanItemId,2)">提交</el-button>  </span>
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
                <el-tag size="mini" v-if=" scope.row.salePlanItemId != null && scope.row.salePlanItemId != 0"
                        @click="openRemarkDialog(scope.row)">添加备注</el-tag>
              </div>
            </el-popover>
          </div>

          <div v-if="scope.row.remark == null || scope.row.remark == '' ">
            <span v-if=" scope.row.salePlanItemId != null && scope.row.salePlanItemId != 0 ">
            <el-button type="primary" size="mini" @click="openRemarkDialog(scope.row)">添加备注</el-button>
          </span>
          </div>


        </template>

      </el-table-column>

     <!-- <el-table-column  label="操作" width="80px">
        <template  slot-scope="scope">
          <el-button  type="primary" size="mini" @click="saveRuleAndItemVal(scope.row)">保存</el-button>
        </template>
      </el-table-column>-->
    </el-table>

    <div>
      <el-button type="primary" size="mini" @click="batchUpdateStatus(2)">批量提交销量计划</el-button>
      <el-button type="primary" size="mini" @click="batchSaveSalePlan">批量保存销量计划</el-button>
    </div>

  </div>
</template>

<script>
    export default {
        name: "SalePlanSalesView",
      components: {
        download: resolve =>
          require(["components/common/download-xlsx.vue"], resolve)
      },
      data(){
          return{
            showFilteList:false,
            showSummary:true,

            //下载相关参数
            tableData:[],
            tHeader:[],
            filterVal: [],
            excelName:'销量计划模板',


            statusList:[{i:1,name:"未提交"},{i:2,name:"待审核"},{i:3,name:"主管通过"},{i:4,name:"主管驳回"},{i:5,name:"采购接纳"},{i:6,name:"采购反馈"}],
            dialogVisible:false,
            itemKeyNameLast : '天历史日均',
            itemKeyNameEst : '天预测日均',
            salePlanTime:"",
            salePlanId: 0,
            salePlanList:[],
            salePlanItemList:[],
            countryList:[],
            itemKeyList:[],
            productList:[],
            tableHeadModelNumberList:[],
            tableHeadCountryList:[],
            tableHeadStatus:"",
            userId:this.$store.state.LoginedUser.userId,
            //userId:1,

            //上传相关参数
            params:{userId:0,salePlanId:0},
            uplaodSalePlanFileAction:this.URL_ROOT + this.PREFIX_SALES_PLAN + "/salesPalnSalesViewHandler/uplaodSalePlanFile",

            //批量操作的id
            batchUpdateStatuIdList:[],

            //添加反馈
            remarkDialog:false,
            remarkForm:{salePlanItemId:0,remark:"",userId:0},

            //用来修改自定义对应的值 索引: itemValId 值:itemVal
            itemValIdLsit:[]

          }
      },

      mounted() {
          this.init()
      },
      methods:{
          init(){

            //初始化查询参数
            this.initSearchInfo()
           // console.logthis.$store.state.LoginedUser)
            this.initCountryList()
            this.initProductList()
            this.initItemKeyList()
            this.initSalePlanList()
          },
          initSalePlanList(){
            var userId = this.userId
           // console.log"initSalePlanList")
           // console.loguserId)
            var url = this.URL_ROOT + this.PREFIX_SALES_PLAN +"/salesPalnSalesViewHandler/findSalesPlanByUserId/" + userId

            this.$ajax.get(url,{
            }).then(res => {
              if(res.data.code == "200"){
               // console.logres.data.data)
                this.salePlanList = res.data.data
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
          var url = this.URL_ROOT +  this.URL_PREFIX + "/findProduct/findAll"
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

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN +"/salesPalnSalesViewHandler/findItemKeyAll/" + this.userId
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
        chooseCountry(){
           // console.log"chooseCountry")
          this.search()
        },
        chooseModelNumber(){
           // console.log"chooseModelNumber")
          this.search()
        },
        chooseStatus(){
         // console.log"chooseStatus")
          this.search()
        },
        chooseSalePlanId(){
          // console.log"chooseSalePlanId")
          // console.logthis.salePlanId)
           this.search();

        },
        handleClose(done){
          this.$confirm('确认关闭？')
            .then(_ => {
              done();
            })
            .catch(_ => {});
        },
        checkParams(data){
            var flag = true;
            // if(data.salePlanId == null){
            //   this.$message("请先选择销售计划")
            //   flag = false;
            // }
            return flag;
        },
        initSearchInfo(){
            this.salePlanId = 0
            this.tableHeadCountryList = []
            this.tableHeadModelNumberList = []
            this.tableHeadStatus = 0

        },
        search(){
            var data = {
              salePlanId:this.salePlanId,
              countryIdList:this.tableHeadCountryList,
              productIdList:this.tableHeadModelNumberList,
              status:this.tableHeadStatus,
              userId:this.userId
            };
            if(!this.checkParams(data)){
              return
            }

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN +"/salesPalnSalesViewHandler/findSalePlanItemList"
          this.$ajax({
            method: "post",
            url: url,
            data: data
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
        //表头中文名
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
              var exportData = this.salePlanItemList
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
                  if(name == "countryName"){
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

                       // console.log"itemKeyObj.itemKey =" +itemKeyObj.itemKey)
                       // console.log"itemKeyNameLast ="  + this.itemKeyNameLast)

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

              //获得excelName

              var excelName = "销售计划"


              if(this.salePlanId != null && this.salePlanId != 0){
                const salePlanList = this.salePlanList;
                salePlanList.forEach((salePlanObj,index) => {
                  if(salePlanObj.salePlanId == this.salePlanId){
                    excelName = salePlanObj.showSalePlan
                  }
                })
              }

             // console.log"excel名称")
             // console.logexcelName)



              this.tableData = exportData
              this.tHeader = headArray
              this.filterVal = headFiledArray
              this.excelName = excelName
             // }
            }

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
            for(var i = 0; i < headFiledArray.length; i++){
              if(headFiledArray[i] == "estUnitsAvgDay"){
                return i
                break
              }
            }
          }
          return 0

        },
        createSalePlan(){
          var salePlanTime = this.salePlanTime;
         // console.logsalePlanTime)

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN + "/salesPalnSalesViewHandler/addSalesPlan"

            var data = {
              userId:this.userId,
              planDate:salePlanTime
            }

            this.$ajax({
              method: "post",
              url:url,
              data:data
            }).then(res => {
              if(res.data.code == "200"){
               // console.logres.data.data)
                this.salePlanList = res.data.data
                this.$message.success(res.data.msg)
              }else if(res.data.code == "500"){
                this.$message.error(res.data.msg)
              }

            }).catch(err => {
             // console.logerr)
            })

          //关闭
          this.dialogVisible = false
          this.clearSalePlanTime();

        },
        clearSalePlanTime(){
            this.salePlanTime = ""
        },
        selectionChangeId(salePlanItemList){
           // console.log"selectionChangeId")
           // console.logsalePlanItemList)

          //先初始化
          this.batchUpdateStatuIdList = []

          //保存选中的id
          for(var i = 0; i < salePlanItemList.length; i++){
            var salePlanItemId = salePlanItemList[i].salePlanItemId
            var status = salePlanItemList[i].status

            //符合条件的 未提交的和 主管驳回
            if(status == 1 || status == 4){
              this.batchUpdateStatuIdList.push(salePlanItemId)
            }
          }

        },
        handlePreview(file) {
         // console.log"handlePreview");
         // console.logthis.params);
        },
        handleExceed(files, fileList) {
          this.$message.warning(`当前限制选择 3 个文件，本次选择了 ${files.length} 个文件，共选择了 ${files.length + fileList.length} 个文件`);
        },
        onSuccess: function(res, file, fileList) {
         // console.log"文档上传成功后，后台返回文档的路径");
         // console.logres);
          if(res.code == 200){
            this.$message.success(res.msg)
            this.search()
          }else if(res.code == 500){
            this.$message.error(res.msg)
          }
          this.search()

        },
        uploadError(err, file, fileList) {
          this.$message.error("上传出错,请重新上传" + err);
        },
        beforeUpload(){
           // console.log"beforeUpload")
           // console.log)
          if(this.userId == null || this.userId == 0){
            this.$message.error("不存在用户请重新登录！")
            return
          }
          if(this.salePlanId == null || this.salePlanId == 0 || this.salePlanId == ""){
            this.$message.error("请先选中销售计划")
            return
          }
          this.params.userId = this.userId
          this.params.salePlanId = this.salePlanId
        },
        updateStatus(id,status){

            if(id == null || id == "" || id == 0){
              this.$message.error("销售计划子项id不能为空")
              return
            }

            var url = this.URL_ROOT + this.PREFIX_SALES_PLAN + "/salesPalnSalesViewHandler/updateStatusBySalePlanItemId/" +id +"/" + status

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

        },
        batchUpdateStatus(status){
         // console.log"批量提交")
         // console.logstatus)

          if(this.batchUpdateStatuIdList == null || this.batchUpdateStatuIdList.length == 0){
            this.$message.error("请先选择销售计划!")
            return
          }
          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN + "/salesPalnSalesViewHandler/batchUpdateStatusBySalePlanItemIdList"
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
            console.log(err)
          })

        },
        clearRemarkForm(){
          this.remarkForm = {salePlanItemId:0,remark:""}
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
         // console.log"userId = " + data.userId + "--- salePlanItemId = " + data.salePlanItemId)
          if(data.userId == 0 || data.salePlanItemId == 0 ){
            this.$message.error("用户id为空,保存失败")
            return
          } if(data.salePlanItemId == null || data.salePlanItemId == 0 ){
            this.$message.error("销售计划itemId为空,保存失败")
            return
          }

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN + "/salesOperationsViewHandler/addRemark"
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
        saveRuleAndItemVal(row){
         // console.log"保存一行")
          var arr =  this.itemValIdLsit
         // console.logarr)
          var itemValIdAndItemValList = this.qs.stringify(arr).toString().split('&');
         // console.logitemValIdAndItemValList)

          //循环 变成不可选
          for(var j = 0; j < row.itemValVOList.length; j++){
            var itemValObj = row.itemValVOList[j]
            var type = itemValObj.type
            if(type == 2){
              itemValObj.disabled = true
            }
          }
        },
        clickitemKeyCol(row,cell){
         // console.log"===clickUserCharge====")
         // console.logcell.label)
          row.disabled = false

          //拿列名
          for(var i = 0; i < this.itemKeyList.length; i++){
            var itemKeyObj = this.itemKeyList[i]
            var itemKey = itemKeyObj.itemKey
            if(itemKeyObj.type == 1){
              itemKey += this.itemKeyNameLast
            }else{
              itemKey += this.itemKeyNameEst
            }
            //确定列名
            if(cell.label == itemKey){
              //可编辑
              for(var j = 0; j < row.itemValVOList.length; j++){
                var itemValObj = row.itemValVOList[j]
                var type = itemValObj.type
                var itemKey1 = itemValObj.itemKey

                if(type == 1){
                  itemKey1 += this.itemKeyNameLast
                }else{
                  itemKey1 += this.itemKeyNameEst
                }
                //找到对应的值  可编辑
                if(cell.label == itemKey1){
                  itemValObj.disabled = false
                  break
                }
              }
            }
          }
        },
        batchSaveSalePlan(){
            //批量保存销售计划数据
         // console.log"batchSaveSalePlan")
          var arr =  this.itemValIdLsit
         console.log(arr)
          if(this.itemValIdLsit == null || this.itemValIdLsit.length == 0){
            this.$message.error("请先修改数据!")
            return
          }

          var itemValIdAndItemValList = this.qs.stringify(arr).toString().split('&');

          if(itemValIdAndItemValList == null || itemValIdAndItemValList.length == 0){
            this.$message.error("上传参数为空!")
            return
          }

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN + "/itemKeyHandler/batchItemValue"
          var data = {
            itemValIdAndItemValList:itemValIdAndItemValList
          }

          this.$ajax({
            method:'post',
            url:url,
            data:data
          }).then(res => {
            if(res.data.code == 200){
             // console.logres.data.code)
              this.$message.success(res.data.msg)
              this.search()
            }else if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }

            //清理
            this.itemValIdLsit = []
          }).catch(err => {
            console.log(err)
          })

        },
        getHeadFiledMap(){
          var map = new Map()
          map.set("提交人","userName");
          map.set("国家","countryName");
          map.set("ASIN","asin");
          map.set("加权历史日均","lastUnitsAvgDay");
          map.set("加权预测日均","estUnitsAvgDay");
          map.set("活动预测量","estUnitsPromotion");
        //  map.set("合理性","rationality");
        //  map.set("状态","status");
      //    map.set("备注","remark");

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
              sums[index] = '总和';
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
