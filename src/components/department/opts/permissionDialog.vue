<template>
  <el-dialog :visible.sync="status" :width="'699px'" :title="userDisplayName">
    <el-table
            :data="permissionList"
            style="width: 100%">
      <el-table-column width="280" >
        <template slot-scope="scope">
          <i class="el-icon-view"></i>
          <span style="margin-left: 10px">{{ scope.row.permissionTitle }}</span>
        </template>
      </el-table-column>

      <el-table-column>
        <template slot-scope="scope" width="580">
          <el-radio-group v-model="scope.row.accessId" @change="handleChangeRaio(scope.row)" >
            <el-radio :label="3">无</el-radio>
            <el-radio :label="1">可读</el-radio>
            <el-radio :label="2">可读/可编辑</el-radio>
          </el-radio-group>
        </template>
      </el-table-column>

    </el-table>



    <div slot="footer" class="dialog-footer">
      <el-button type="primary" @click="_submitEditRole">保 存</el-button>
    </div>
  </el-dialog>


</template>
<script>
const ERR_OK = 200;

export default {
  props: [],
  data() {
    return {
      status: false,
      rules: {
        roleName: [
          { required: true, message: "请填写职位名称", trigger: "blur" },
        ]
      },
      userDisplayName:'',
      permissionList:[],
      theUserId:0,
      theUserName:'',
      saveList:[],
    };
  },

  methods: {
    _show() {
      this.status = this.status ? false : true;
    },
    // 获取下属
    getUserPermission() {

      this.userDisplayName = this.$parent.theUserName;
      this.theUserId = this.$parent.theUserId;
      if(undefined == this.theUserId  )return;

      let _url = "";

      _url = "/login-service/userPermission/getTheUserPermission/" + this.theUserId;

      let listData = [];
      let booleans = false;
      this.$ajax.get(this.URL_ROOT + _url).then(res => {

        if (res.data.code == ERR_OK) {
          listData = res.data.data;

          this.permissionList = listData;
          if (this.permissionList.length > 0) {
            booleans = false;
          } else {
            booleans = true;
          }
        }
      });
    },
    _submitEditRole(){
      this._show();
      let booleanFlag = true;
      if(this.saveList.length<1)return;
      for(let oneitem of this.saveList){
        this.$ajax({
          method: "post",
          url: this.URL_ROOT + "/login-service/userPermissionRels/updateRel",
          data: oneitem
        }).then(res => {

          if (res.data.code == ERR_OK) {

          } else {
            booleanFlag = false;
          }
        });
      }
      if(booleanFlag){
        this.$emit("success");
        this.$message.success("修改成功");
        this.status = false;
      }else{
        this.$message.error("修改失败");
      }


    },

    handleChangeRaio(items){

      let _param = {
        "accesssId": items.accessId,
        "permissionId": items.permissionId,
        "userId": this.theUserId
      }
      this.saveList.push(_param);

    }
  },
  watch: {

  }
};
</script>
