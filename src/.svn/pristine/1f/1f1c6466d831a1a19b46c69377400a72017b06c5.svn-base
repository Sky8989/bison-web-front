<template>
  <el-dialog :visible.sync="status" :width="'400px'"  v-if="departmentItem.parentPath" :title="departmentItem.parentPath.substring(0,departmentItem.parentPath.length-1)">
    <el-form :model="formedit" :rules="rules" ref="departmentName">
      <el-form-item label="部门名称" prop="departmentName" :label-width="'80px'">
        <el-input v-model="formedit.departmentName" autocomplete="off"></el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="_show">取 消</el-button>
      <el-button type="primary" @click="_modifyname('departmentName')">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
const ERR_OK = 200;

export default {
  props: ["departmentItem"],
  data() {
    return {
      status: false,
      formedit: {
        departmentName: ""
      },
      rules: {
        departmentName: [
          { required: true, message: "请输入名称", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    _show() {
      this.status = this.status ? false : true;
      this.formedit.departmentName = this.departmentItem.departmentName
    },
    _modifyname(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$ajax({
            method: "post",
            url: this.URL_ROOT + "/login-service/departments/" + this.departmentItem.id,
            data: this.formedit
          }).then(res => {
            if ((res.data.code = ERR_OK)) {
              this.$message.success("修改成功");
              this.$emit("success", this.formedit.departmentName);
              this.status = false;
            } else {
              this.$message.error("修改失败");
            }
          });
        } else {
          return false;
        }
      });
    }
  }
};
</script>

