<template>
  <div id="requireAsistanceId">
    <el-dialog title="http://support.leaderment" :visible.sync="dealWithDialogVisible">
      <el-form :model="dealWithForm">
        <el-form-item label="请输入密码" >
          <el-input v-model="dealWithForm.password" show-password></el-input>
        </el-form-item>
        <el-form-item label="处理人" >
          <el-select v-model="dealWithForm.dealPerson" placeholder="处理人">
            <el-option label="张妙辉" value="3"></el-option>
            <el-option label="刘峥" value="1"></el-option>
            <el-option label="张亚伟" value="2"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="状态" >
          <el-select v-model="dealWithForm.status" placeholder="状态">
            <el-option label="处理中" value="２"></el-option>
            <el-option label="已完成" value="３"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dealWithDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmDealWithFun">确 定</el-button>
      </div>
    </el-dialog>


    <el-dialog
      title="提示"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <span>确认要删除这条事件么？？？？</span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="confirmDelete">确 定</el-button>
      </span>
    </el-dialog>
    <el-table
      :data="tableData"
      style="width: 100%"
      :row-class-name="tableRowClassName">
      <el-table-column
        fixed
        prop="submitterName"
        label="提交者"
        width="160">
      </el-table-column>
      <el-table-column
        prop="departmentName"
        label="部门"
        width="150">
      </el-table-column>
      <!-- [硬件事件,软件事件,浏览网页事件,U8事件,WIFI事件] -->
      <el-table-column
        prop="eventTypeName"
        label="类型"
        width="180">
      </el-table-column>
      <el-table-column
        prop="eventTitle"
        label="标题"
        width="210">
      </el-table-column>
      <el-table-column
        prop="createTime"
        label="提交时间"
        sortable
        width="200">
      </el-table-column>
      <el-table-column
        prop="statusName"
        label="状态"
        :filters="filterStatusData"
        :filter-method="filterStatusName"
        width="150">
      </el-table-column>
      <el-table-column
        prop="developerName"
        label="处理人"
        :filters="[{ text: '刘峥', value: '1' }, { text: '张亚伟', value: '2' },{ text: '张妙辉', value: '3' } ]"
        :filter-method="filterDeveloperName"
        width="150">
      </el-table-column>
      <el-table-column
        prop="endTime"
        label="完成时间"
        sortable
        width="200">
      </el-table-column>
      <!--<el-table-column
        prop="developRating"
        label="处理评分"
        width="90">
      </el-table-column>-->
      <!--富文本框编辑,可贴图片,表格-->
      <el-table-column
        fixed="right"
        prop='content'
        label="操作"
        width="300">
        <template slot-scope="scope">
          <el-button @click="handleEditClick(scope.row)" type="text" >编辑</el-button>
          <el-button @click="handleDeleteClick(scope.row)" type="text" >删除</el-button>
          <el-button @click="dealWithElement(scope.row)" type="text" >处理</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
    import axios from 'axios';

    export default {
      name: "requireAsistance",
      data () {
        return {
          preUrl:'http://support.leaderment.com:10206/',
          // preUrl:'http://localhost:10206/',
          tableData:[],
          dialogVisible:false,
          temDeleteRow : {},
          dealWithForm:{
            password:'',
            dealPerson:'',
            status:'',
          },
          dealWithBaseData:{},
          dealWithDialogVisible:false,
          filterStatusData:[{ text: '未处理', value: '1' }, { text: '处理中', value: '2' } , { text:'处理完成' , value: '3'}],
        }
      },
      methods:{
        init(){

          this.initAllData();
        },
        handleEditClick(therow){
          this.$emit('convertToEditProp',therow);
        },

        handleClose(done) {
          let that = this;
          this.$confirm('确认关闭？')
            .then(_ => {
              done();

            })
            .catch(_ => {});
        },
        confirmDelete(){
          let that = this;
          that.dialogVisible = false;
          if(undefined ==  that.temDeleteRow.id)return;
          axios.delete(that.preUrl + 'applyEvents/'+that.temDeleteRow.id)
            .then((res) => {
              if(res.data.code == 200){
                that.initAllData();
              }else{

              }
            }).catch(err => {

          });
        },
        handleDeleteClick(therow){
          let that = this;
          that.temDeleteRow = {};
          that.temDeleteRow = therow;
          that.dialogVisible = true;
        },
        initAllData(){
          let that = this;

          axios.get(that.preUrl + 'applyEvents/')
                  .then((res) => {
                    if(res.data.code == 200){
                      let result = res.data.data;
                      that.tableData = result;

                    }else{

                    }
                  }).catch(err => {

          });

        },
        dealWithElement(rowData){
          let that = this;
          that.dealWithBaseData = {};
          that.dealWithForm.password='';
          that.dealWithForm.dealPerson='';
          that.dealWithForm.status='';
          that.dealWithBaseData = rowData;
          that.dealWithDialogVisible = true;

        },
        confirmDealWithFun(){
          let that = this;
          if(undefined == that.dealWithBaseData.id || undefined == that.dealWithForm.password)return;
          if( that.dealWithForm.password == 'system12345' ){
            that.dealWithDialogVisible = false;
            let dealPerson = that.dealWithForm.dealPerson;
            let param = that.dealWithBaseData;
            param.developPerson = that.dealWithForm.dealPerson;
            param.status = that.dealWithForm.status;
            axios.put(that.preUrl + 'applyEvents/'+param.id,param)
              .then((res) => {
                if(res.data.code == 200){

                  that.initAllData();
                }else{

                }
              }).catch(err => {

            });
          }else{
            that.dealWithDialogVisible = false;
            alert('密码无效');
          }

        },
        filterDeveloperName(value, row) {

          return row.developPerson == value;
        },
        filterStatusName(value, row){

          return row.status == value;
        },
        tableRowClassName({row, rowIndex}) {
          if (row.status == 1) {
            return 'warning-row';
          } else if (row.status == 3) {
            return 'success-row';
          }
          return '';
        }
      },
      mounted:function(){
        this.init();
      },
    }
</script>

<style>
  .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #f0f9eb;
  }
</style>

