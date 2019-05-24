<template>
  <el-dialog :visible.sync="status" :width="'400px'" :title="roleItem.roleName">
    <el-form :model="formedit" :rules="rules" ref="addRoles" :label-width="'100px'">
      <el-form-item label="角色名称:" prop="roleName" placeholder="formedit.userDisplayName" >
        <el-input v-model="formedit.userDisplayName" autocomplete="off"></el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="_show">取 消</el-button>
      <el-button type="primary" @click="_submitEditRole">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
const ERR_OK = 200;

export default {
  props: ["roleItem"],
  data() {
    return {
      status: false,
      formedit: {
        userDisplayName: "",
      },
      parentDeptId:[],
      rules: {
        roleName: [
          { required: true, message: "请填写职位名称", trigger: "blur" },
        ]
      }
    };
  },
  mounted() {
    this.formedit.userDisplayName = this.roleItem.roleName;

  },
  activated() {
    this.formedit.userDisplayName = this.roleItem.roleName;
  },
  created() {
    this.formedit.userDisplayName = this.roleItem.roleName;
  },
  methods: {
    _show() {
      this.status = this.status ? false : true;
    },
    // 获取人员信息
    _roleList() {
      this.formedit.userDisplayName = roleItem.roleName;
    },
    // 修改人员信息提交
    _submitEditRole(formName) {
      if(!this.formedit.userDisplayName )return;
      let _param = {
        roleName : this.formedit.userDisplayName,
        roleId : this.roleItem.roleId,
        parentId : this.roleItem.parentId
      }

      this.$ajax({
        method: "put",
        url: this.URL_ROOT + "/login-service/roles/"+this.roleItem.roleId,
        data: _param
      }).then(res => {
        if (res.data.code == ERR_OK) {
          this.$emit("success");
          this.$message.success("修改成功");
          this.status = false;
        } else {
          this.$message.error("修改失败");
        }
      });

    },
    // 拿到最后一个部门ID
    handleChange(items){
        this.formedit.departmentId = items[items.length-1]
    }
  },
  watch: {

  }
};
</script>
