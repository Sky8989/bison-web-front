<template>
  <div>
    <div class = 'm_top_div'>
      <el-table
              :data="permissionList"
              style="width: 100%">
        <el-table-column width="280">
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

    </div>
  </div>
</template>
<script>
const ERR_OK = 200;

export default {
  props: ["roleId"],
  data() {
    return {
      permissionList: [],
      disRoleName:'',
      allRolelList: [],
      theSaveList:[],
    };
  },
  activated() {

    this.getRolePermission();
    this.findAllRolelList();
  },
  created() {

    this.getRolePermission();
    this.findAllRolelList();
  },
  methods: {
    // 获取下属
    getRolePermission() {

      let _url = "";

      if(!this.roleId)return;
      _url = "/login-service/rolePermissionRels/" + this.roleId;

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
          this.$emit("deleteRole", booleans);
        }
      });
    },
    saveThePermissions(){
      let booleanFlag = true;

      if(this.theSaveList.length<1)return;
      for(let oneItem of this.theSaveList){
        this.$ajax({
          method: "put",
          url: this.URL_ROOT + "/login-service/rolePermissionRels/updatePerRel",
          data: oneItem
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
      this.theSaveList = [];
      this.theSaveList.length = 0;
    },
    handleChangeRaio(the_row){

      let _param = {
        "accesssId": the_row.accessId,
        "permissionId": the_row.permissionId,
        "roleId": this.roleId
      }
      this.theSaveList.push(_param);

    },

    findAllRolelList() {
      this.$ajax.get(this.URL_ROOT + "/login-service/roles/findAllRole").then(res => {
        if (res.data.code == ERR_OK) {
          this.allRolelList = res.data.data;

        }
      });
    },
    // // 编辑人员
    // _editpermission(val) {
    //   this.$emit("success", val);
    // },
    // // 删除人员
    // _deletebutton(val) {
    //   this.$confirm("此操作将永久删除该人员, 是否继续?", "提示", {
    //     confirmButtonText: "确定",
    //     cancelButtonText: "取消",
    //     type: "warning"
    //   })
    //     .then(() => {
    //       this.$ajax
    //         .delete(this.URL_ROOT + "/login-service/users/+" + val.userId)
    //         .then(res => {
    //           if (res.data.code == ERR_OK) {
    //             this.$message({
    //               type: "success",
    //               message: "删除成功!"
    //             });
    //             this.permission();
    //           }
    //         });
    //     })
    //     .catch(() => {
    //       this.$message({
    //         type: "info",
    //         message: "已取消删除"
    //       });
    //     });
    // }
  },
  watch: {
    roleId() {
      this.getRolePermission();
      if(this.allRolelList && this.allRolelList.length > 0){
        for(let oneRole of this.allRolelList){
          if(this.roleId == oneRole.roleId){
            this.disRoleName = oneRole.roleName;
          }
        }
      }

    }
  }
};
</script>
<style lang="stylus">
  .hi_title{
    text-align:center;
    font-size:25px;
  }
  .radiogroup{
    font-size:25px;
  }
  .m_top_div{
    margin-top : -40px;
  }
</style>