<template>
  <el-dialog
    :visible.sync="status"
    :width="'400px'"
    :title="departmentItem.departmentName"
  >
    <el-form :model="formedit" :rules="rules" ref="addPersonnel" :label-width="'100px'">
      <el-form-item label="请选择部门" prop="department">
        <el-cascader
            expand-trigger="hover"
            :options="departmentArray"
            :props="defaultProps"
            v-model="parentDeptIds"
            :change-on-select="true"
            :show-all-levels="false"
            @change="handleChange">
                </el-cascader>
      </el-form-item>
      <el-form-item label="请选择职位" prop="roleId">
        <el-select v-model="formedit.roleId" placeholder="请选择职位">
          <el-option
            v-for="item in personnelList"
            :key="item.roleId"
            :label="item.roleName"
            :value="item.roleId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item v-if="formedit.roleId == 0"  label="" prop="roleName">
          <el-input v-model="formedit.roleName" placeholder="请填写部门名称"></el-input>
      </el-form-item>
      <el-form-item label="账号" prop="userName">
        <el-input v-model="formedit.userName" autocomplete="off" @keyup.enter="handleClick"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="userPassword">
        <el-input v-model="formedit.userPassword" autocomplete="off" show-password></el-input>
      </el-form-item>
      <el-form-item label="姓名" prop="userDisplayName">
        <el-input v-model="formedit.userDisplayName" autocomplete="off"></el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="_show">取 消</el-button>
      <el-button type="primary" @click="_addpersonnel('addPersonnel')">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
const ERR_OK = 200;
export default {
  props: ["groupId", "personnelList", "departmentItem","departmentArray"],
  data() {
    // 是否有中文
    var validatePass = (rule, value, callback) => {
      let reg = /[\u4E00-\u9FA5]/;
      if (reg.test(value)) {
        callback(new Error("账号不能有中文"));
      } else {
        callback();
      }
    };
    var validatePass1 = (rule, value, callback) => {
      if(this.formedit.departmentId == 0){
        callback(new Error("请选择部门"));
      }else{
        callback();
      }
    };
    return {
      status: false,
      roleId: this.$store.state.LoginedUser.roleId,
      parentDeptIds: [],
      formedit: {
        departmentId: "",
        userDisplayName: "",
        userName: "",
        userPassword: "",
        roleId: "",
        roleName: ''
      },
      defaultProps: {
          children: "childern",
          label: "departmentName",
          value: 'id'
      },
      rules: {
        userDisplayName: [
          { required: true, message: "请输入姓名", trigger: "blur" }
        ],
        department: [
          { validator: validatePass1, trigger: "blur" }
        ],
        userPassword: [
          { required: true, message: "请输入密码", trigger: "blur" }
        ],
        userName: [
          { required: true, message: "请输入账号", trigger: "blur" },
          { validator: validatePass, trigger: "blur" }
        ],
        roleId: [{ required: true, message: "请选择职位", trigger: "blur" }],
        roleName: [
            { required: true, message: "请填写职位名称", trigger: "blur" },
        ]
      }
    };
  },
  methods: {
    _show() {
      this.status = this.status ? false : true;
      if (this.status == true) {
        this.formedit.departmentId = this.departmentItem.id;
        this.formedit.roleId = this.personnelList[0].roleId;
        this.parentDeptIds = this.departmentItem.parentDeptIds
      }
    },
    // 添加人员
    _addpersonnel(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$ajax({
            method: "post",
            url: this.URL_ROOT + "/login-service/users/addUsers",
            data: this.formedit
          }).then(res => {
            if (res.data.code == ERR_OK) {
              this.$message.success("新增人员成功");
              this.$emit("success");
              this.status = false;
              this.formedit.userDisplayName = "";
              this.formedit.userName = "";
              this.formedit.userPassword = "";
            } else {
              this.$message.error(res.data.msg);
            }
          });
        } else {
          return false;
        }
      });
    },
    // 拿到最后一个部门ID
    handleChange(items){
        this.formedit.departmentId = items[items.length-1]
    }
  }
};
</script>


