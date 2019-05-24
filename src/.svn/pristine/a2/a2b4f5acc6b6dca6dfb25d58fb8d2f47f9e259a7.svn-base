<template>
  <el-dialog :visible.sync="status" :width="'400px'">
    <el-form :model="formedit" :rules="rules" ref="editPersonnel" :label-width="'100px'">
      <el-form-item label="选择部门">
        <el-cascader
            expand-trigger="hover"
            :options="departmentArray"
            :props="defaultProps"
            v-model="parentDeptId"
            :change-on-select="true"
            :show-all-levels="false"
            @change="handleChange">
                </el-cascader>
      </el-form-item>
      <el-form-item label="请选择职位">
        <el-select v-model="formedit.roleId" placeholder="请选择">
          <el-option
            v-for="item in personnelList"
            :key="item.roleId"
            :label="item.roleName"
            :value="item.roleId"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="账号">
        <el-input v-model="formedit.userName" autocomplete="off" :disabled="true"></el-input>
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
      <el-button type="primary" @click="_addpersonnel('editPersonnel')">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
const ERR_OK = 200;

export default {
  props: ["personnelList", "personnelItem",'departmentArray'],
  data() {
    return {
      status: false,
      formedit: {
        userName: "",
        userPassword: "",
        userDisplayName: "",
        userId: "",
        roleId: ""
      },
      parentDeptId:[],
      defaultProps: {
          children: "childern",
          label: "departmentName",
          value: 'id'
      },
      rules: {
        userPassword: [
          { required: true, message: "请输入密码", trigger: "blur" }
        ],
        userDisplayName: [
          { required: true, message: "请输入姓名", trigger: "blur" }
        ]
      }
    };
  },
  created() {},
  methods: {
    _show() {
      this.status = this.status ? false : true;
    },
    // 获取人员信息
    _personnellist() {
      this.formedit= this.personnelItem
      this.formedit.userPassword = this.personnelItem.userPassword;
      this.formedit.userDisplayName = this.personnelItem.userDisplayName;
      this.formedit.userId = this.personnelItem.userId;
      this.formedit.roleId = this.personnelItem.roleId;
      this.parentDeptId = this.personnelItem.deptIdList
    },
    // 修改人员信息提交
    _addpersonnel(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$ajax({
            method: "post",
            url:
              "http://192.168.1.224:10025/users/updateUserBaseMassage/" +
              this.personnelItem.userId,
            data: this.formedit
          }).then(res => {
            if (res.data.code == ERR_OK) {
              this.$emit("success");
              this.$message.success("修改成功");
              this.status = false;
            } else {
              this.$message.error("修改失败");
            }
          });
        }
      });
    },
    // 拿到最后一个部门ID
    handleChange(items){
        this.formedit.departmentId = items[items.length-1]
    }
  },
  watch: {
    personnelItem() {
      this.$nextTick(() => {
        this._personnellist();
      });
    }
  }
};
</script>
