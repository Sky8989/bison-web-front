<template>
    <div class="productData">
      <el-container>

        <el-aside name="left">
          <ProductLeftSelect ref="productLeftSelect"  @sendModelNumbers="getModelNumbers"></ProductLeftSelect>
        </el-aside>


        <el-main name="main">

          <pagination :pagination="pagination" :length="userChargeList.length"></pagination>


          <el-table name="showTable" border="border" height="250px" style="width: 100%" :data="
          userChargeList.slice((pagination.currpage - 1) * pagination.pagesize, pagination.currpage * pagination.pagesize )" @cell-click="clickUserCharge">
            <el-table-column type="index"></el-table-column>
            <el-table-column prop="businessUnit" label="BU" ></el-table-column>
            <el-table-column prop="productCategory" label="产品系列" ></el-table-column>
            <el-table-column prop="countryName" label="国家" ></el-table-column>
            <el-table-column prop="userName" label="负责人"  >
              <template slot-scope="scope"><!--=scope.row.userName-->

                <el-select v-if="scope.row.disabled == false" placeholder="请选择负责人" size="small"  filterable v-model="userChargeId[scope.row.unionId] = scope.row.userChargeId"
                           :disabled="scope.row.disabled"   @change="chooseUserCharge(scope.row)"   >
                  <el-option v-for="user in operationGroupUserList"  :key="user.userId" :value="user.userId"
                             :label="user.userName" ></el-option>
                </el-select>

                <el-input v-if="scope.row.disabled == true" :value="scope.row.userName" :disabled="scope.row.disabled" placeholder="点击开始编辑选择负责人" @click="updateDisabled(scope.row)"></el-input>
              </template>


            </el-table-column>
            <el-table-column prop="departmentName" label="运营组别" ></el-table-column>
            <el-table-column prop="productModelNumber" label="产品型号" ></el-table-column>
            <el-table-column prop="asin" label="ASIN" ></el-table-column>
            <el-table-column  label="操作" width="120px"><el-button>删除</el-button></el-table-column>
          </el-table>

          <br/>

          <div style="float: right">
            <el-button  type="primary" @click="saveUserCharge">保存</el-button>
          </div>
        </el-main>

      </el-container>

    </div>
</template>

<script>
  import pagination from "components/common/pagination.vue";
    export default {
        name: "ProductData",
      data(){
          return{
            pagination: {
              pagesize: 20,
              currpage: 1
            },
            selected:false,
            disabled:true,
            userChargeId:[],
            productModelNumber:'SW-01',
            userChargeList:[
             /* {businessUnit:"aaa",productCategory:"bbb",countryName:"Uk",userName:"1号负责人",departmentName:"A组",productModelNumber:"samgda",asin:"aaaa"},
              {businessUnit:"aaa",productCategory:"bbb",countryName:"Uk",userName:"1号负责人",departmentName:"A组",productModelNumber:"samgda",asin:"aaaa"},*/
            ],
            operationGroupUserList:[],
            unionIds:"",  //保存联合id,用来修改负责人 多个id用,分开
            unionIdList: [],  //保存 unionId  新增和修改负责人
            userChargeIdList: [],  //保存 userChargeId  新增和修改负责人

          }
      },
      components:{
        'ProductLeftSelect'  : resolve => require(['components/product/subscription/opts/ProductLeftSelect.vue'], resolve),
        pagination

      },
      methods:{
          init(){
            //初始化删除数组
            this.unionIds = ""
            this.unionIdList = []
            this.userChargeIdList = []


            this.search()
            this.getOperationGroupUserAll()
            this.$refs.productLeftSelect.init()
          },
        search(){

          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionProductRelHandler/findProductSubscriptionProductRelList"
          this.requerstSearch(url)
        },
        requerstSearch(url){

          this.userChargeList = []
          this.pagination.currpage = 1;

          var data = {
            productModelNumber:this.productModelNumber == "" ? 'SW-01' : this.productModelNumber,
          }


          this.$ajax({
            method:"post",
            url:url,
            data:data,
          }).then(res => {
            if(res.data.code == "200"){
              console.log("res")
              console.log(res.data.data)
              this.userChargeList = res.data.data
              //this.userChargeList[0].disabled = false
            }
          }).catch(error => {
            console.log(error)
          })
        },
        chooseUserCharge(row){
           //选择完负责人后不可操作
         // row.disabled = true
          //添加联合主主键 和对应新增修改的负责人
          console.log("chooseUserCharge")
          console.log(row.unionId)
          // console.log(this.userChargeId[row.unionId])
          // console.log(this.userChargeId[row.unionId].userChargeId)
          // console.log(typeof(this.userChargeId[row.unionId]))

          this.unionIdList.push(row.unionId)
          this.userChargeIdList.push(this.userChargeId[row.unionId].userChargeId)
          console.log(this.unionIdList)
          console.log(this.userChargeIdList)
          this.$message("点击保存后，才能完成相关操作的保存！！！")


        },
        getOperationGroupUserAll(){
          //获取所以运营人员 可以成为产品负责人
          var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscriptionProductRelHandler/getOperationGroupUserAll"
          console.log(url)
          //var url = this.URL_ROOT + this.URL_PREFIX + "productSubscription/findUserChargeByDeptId/" + deptId
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
              console.log("getOperationGroupUserAll")
              console.log(res.data)

              this.operationGroupUserList = res.data.data
            }
          }).then(error => {
            console.log(error)
          })
        },
        clickUserCharge(row,cell){

            console.log(cell.label)
            console.log(row.disabled)
          if(cell.label == "负责人"){
            row.disabled = false
            this.$message(" 请选择负责人")
          }

          if(cell.label == "操作"){
             console.log("============进入操作======")
            this.$confirm('确定删除负责人？', '提示', {
              confirmButtonText: '确定删除负责人',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(() => {
              row.userName = ""
              this.deleteUserCharge(row.unionId)
            });
          }
        },
        deleteUserCharge(id){
            if(id == null || id == ""){
              this.$message.error("联合Id为空不能删除")
              return
            }

          var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/deleteUserChargeByUnionId"
          //删除操作
          this.$ajax({
            method:"get",
            url:url,
            params:{
              unionIds:id
            }
          }).then(res => {
            if(res.data.code == "200"){
              console.log("删除成功")
              console.log(res.data.data)
              this.userChargeList = res.data.data
              this.$message.success("保存成功")
            }else if(res.data.code == "500"){
              this.$message.error(res.data.msg)
            }
          }).catch(error => {
            console.log(error)
          })

          this.unionIds = ""
        },
        _blur(){
          console.log("_blur")
          this.disabled = true
        },
        _click(){
          console.log("click")
          //data = false


        },
        getModelNumbers(data){
          console.log("getModelNumbers")
          console.log(data)
          this.productModelNumber = data
          this.search()
        },
        saveUserCharge(){
          console.log("saveUserCharge")
          console.log(this.unionIdList.toString())
          console.log(this.userChargeIdList.toString())



         var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionProductRelHandler/addOrUpdateUserCharge"
          var data ={
            unionIdList: this.unionIdList.toString(),
            userChargeIdList: this.userChargeIdList.toString()
          }

          this.$ajax({
            method:'post',
            url:url,
            data: this.qs.stringify(data),

          }).then(res => {
              if(res.data.code == "200"){
                console.log("新增返回的结果")
                console.log(res.data)
                this.userChargeList = res.data.data
                this.$message.success(res.data.msg)

              }else if(res.data.code == "500"){
                this.$message.error(res.data.msg)
              }

          }).catch(error => {
            this.$message.error(error)
          })

          //保存后所有 不可编辑
          for(userCharge in this.userChargeList){
            console.log(userCharge)
            userCharge.disabled = true;
          }


          this.unionIdList = []
          this.userChargeIdList = []
        },
        updateDisabled(row){
            row.disabled = false
        },

      }
    }
</script>

<style scoped>

</style>
