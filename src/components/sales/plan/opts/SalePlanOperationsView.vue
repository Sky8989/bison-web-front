<template>
  <div>
    <!--添加安全天数 对话框-->
    <el-dialog
      title="添加安全天数"
      :visible.sync="totalSafetyDayDialog"
      width="20%"
      :before-close="totalSafetyDayDialogClose" >

      <el-form :model="safetyDayForm"   label-width="100px" class="demo-dynamic" style="width: 80%">

        <input v-model="safetyDayForm.salePlanItemId" hidden/>

        <el-form-item label="设置安全天数">
          <el-input-number  v-model="safetyDayForm.totalSafetyDay" controls-position="right"
                            :step="1"  :max="10000"
                            size="mini"></el-input-number>
        </el-form-item>
      </el-form>


      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="addTotalSafetyDay" size="mini">添 加</el-button>
      </div>

    </el-dialog>

    <!--添加反馈 备注-->
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



    <el-table name="showTable" border="border" height="350px" style="width: 100%" :data="salePlanItemList"
              @selection-change="selectionChangeId"  :show-summary="showSummary" :summary-method="getSum">
      <el-table-column type="selection"   width="40 " >  </el-table-column>

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

      <el-table-column prop="amzProductNumberSum"  label="亚马逊总数" width="100px"></el-table-column>
      <el-table-column prop="localProductNumberSum" label="深圳仓" width="90px"></el-table-column>
      <el-table-column prop="supplierProductNumberSum" label="供应商总数" width="100px"></el-table-column>

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

      <el-table-column  prop="estUnitsAvgDay" label="加权预测日均" ></el-table-column>
      <el-table-column  prop="estUnitsPromotion" label="活动预测量" width="120px"></el-table-column>


      <el-table-column prop="totalSafetyDay" label="安全天数" >
        <template slot-scope="scope">
          <div>
            <span>{{scope.row.totalSafetyDay}}</span>
            <div>
              <el-button type="primary" size="mini" @click="openTotalSafetyDayDialog(scope.row)" width="120px">设置</el-button>
            </div>
          </div>
        </template>

      </el-table-column>

      <el-table-column   label="状态" width="180px">
        <template  slot-scope="scope">

          <div v-if="scope.row.status == 3">
            <span>
              未处理
              <div>
                 <el-button type="primary" size="mini"  @click="updateStatus(scope.row.salePlanItemId,5)" >接纳</el-button>
                 <el-button type="primary" size="mini"  @click="openRemarkDialog(scope.row)" >反馈</el-button>
              </div>

            </span>
          </div>

          <div v-if="scope.row.status == 5">
            <span>
              已接纳
              <div>
                <el-button type="primary" size="mini"  @click="openRemarkDialog(scope.row)" >反馈</el-button>
                <el-button type="primary" size="mini"  @click="updateStatus(scope.row.salePlanItemId,3)" >取消</el-button>
              </div>
            </span>
          </div>

          <div v-if="scope.row.status == 6">
            <span>
              已反馈
              <div>
                <el-button type="primary" size="mini">反馈</el-button>
              </div>
            </span>
          </div>

        </template>


      </el-table-column>

      <el-table-column  prop="remark" label="备注" width="120px">
        <template  slot-scope="scope">
          <el-popover trigger="hover" placement="top" v-if="scope.row.remark != null && scope.row.remark != '' ">
            <p v-for="rowRemark in scope.row.showRemark">{{rowRemark}}</p>
            <div slot="reference" class="name-wrapper">
              <el-tag size="mini">查看备注</el-tag>
            </div>
          </el-popover>

          <span  v-if="scope.row.remark == null || scope.row.remark == '' " ></span>
        </template>

      </el-table-column>
    </el-table>

    <div>
      <el-button type="primary" size="mini" @click="batchUpdateStatus(5)">批量接纳</el-button>
     <!-- <el-button type="primary">批量补货</el-button>-->
    </div>


  </div>
</template>

<script>
    export default {
        name: "SalePlanOperationsView",
      data(){
        return{
          showSummary:true,
          itemKeyNameLast : '天历史日均',
          itemKeyNameEst : '天预测日均',
          time:{
            startTimeAndEndTime:''
          },
          userId:this.$store.state.LoginedUser.userId,
          //userId:1,
          countryList:[],
          itemKeyList:[],
          productList:[],
          salePlanItemList:[],
          tableHeadUserList:[],
          tableHeadModelNumberList:[],
          tableHeadCountryList:[],
          tableHeadStatusList:[],

          //批量操作的id
          batchUpdateStatuIdList:[],

          //添加 总安全天数
          totalSafetyDayDialog:false,
          safetyDayForm:{salePlanItemId:0,totalSafetyDay:0},

          //添加反馈
          remarkDialog:false,
          remarkForm:{salePlanItemId:0,remark:"",userId:0},


        }
      },
    /*  mounted() {
        this.init()
      },*/
      methods:{
        init(){

          //
          this.initSearchInfo()

          this.initCountryList()
          this.initProductList()
          this.initItemKeyList()
          this.searchSalePlanItemList()
        },
        initSearchInfo(){
          this.tableHeadCountryList = []
            this.tableHeadModelNumberList = []
        },
        searchSalePlanItemList(){
          // console.log"searchSalePlanItemList")
          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN +"/salesOperationsViewHandler/findSalePlanItemList"

          var data = {
            countryIdList:this.tableHeadCountryList,
            productIdList:this.tableHeadModelNumberList,
            userId:this.userId,
          }

          this.$ajax({
            method:'post',
            url:url,
            data:data

          }).then(res => {
            if(res.data.code == 200){
              // console.logres.data.data)
              this.salePlanItemList = res.data.data

              //数据转换一维
              this.dataToOneDimensional(this.salePlanItemList)

            }
            else if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }

          }).catch(error => {
            // console.logerror)
          })
        },
        dataToOneDimensional(salePlanItemList){

          if(salePlanItemList != null && salePlanItemList.length > 0){
            var exportData = salePlanItemList


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
          }

        },

        search(){
          this.searchSalePlanItemList()
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
            // console.logerror)
          })
        },
        initProductList(){
          var url = this.URL_ROOT + this.URL_PREFIX + "/findProduct/findAll"
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

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN +"/salesPalnSalesViewHandler/findItemKeyAll/"  + this.userId
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

        chooseCountry(){
          // console.log"chooseCountry")
          this.search()
        },
        chooseModelNumber(){
          // console.log"chooseModelNumber")
          this.search()
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

            //符合条件的
            if(status == 3){
              this.batchUpdateStatuIdList.push(salePlanItemId)
            }
          }

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
          // console.log"批量接纳")
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
        totalSafetyDayDialogClose(){

          //清理
          this.safetyDayForm= {salePlanItemId:0, totalSafetyDay:0},
          this.totalSafetyDayDialog = false;
        },
        openTotalSafetyDayDialog(row){
          //赋值,隐藏
          this.safetyDayForm.salePlanItemId = row.salePlanItemId
          this.totalSafetyDayDialog = true;
        },
        addTotalSafetyDay(){
          var data = this.safetyDayForm

          if(data == null){
            this.$message.error("提交数据为空,保存失败")
            return
          }
          if(data.salePlanItemId == null || data.salePlanItemId == 0 ){
            this.$message.error("销售计划itemId为空,保存失败")
            return
          }
          if(data.totalSafetyDay == null || data.totalSafetyDay == 0 ){
            this.$message.error("请填写安全天数,保存失败")
            return
          }

          var url = this.URL_ROOT + this.PREFIX_SALES_PLAN + "/salesOperationsViewHandler/addTotalSafetyDay"

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
          this.totalSafetyDayDialog = false
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

          map.set("安全天数","totalSafetyDay");
          map.set("亚马逊总数","amzProductNumberSum");
          map.set("深圳仓","localProductNumberSum");
          map.set("供应商总数","supplierProductNumberSum");

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
