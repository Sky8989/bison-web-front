<template>
  <el-dialog :visible.sync="status" :width="'400px'" v-if="departmentItem.parentPath" :title="departmentItem.parentPath.substring(0,departmentItem.parentPath.length-1)">
    <el-form :model="formedit" :rules="rules" ref="department" label-width="100px">
      <el-form-item label="子部门名称" prop="departmentName">
        <el-input v-model="formedit.departmentName" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="新建BU" v-if="departmentItem.id == '2'">
        <el-checkbox v-model="formedit.isBu"></el-checkbox>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="_show">取 消</el-button>
      <el-button type="primary" @click="_addDepartment('department')">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
const ERR_OK = 200;

export default {
  props: ["groupId","departmentItem"],
  data() {
    return {
      status: false,
      formedit: {
        departmentName: "",
        parentId: "",
        isBu: false,
        businessUnitId:0,
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
      if (this.status == true) {
        // 获取parentId
        this.formedit.parentId = this.departmentItem.id;
        this.formedit.isBu = false;
        this.formedit.businessUnitId = this.departmentItem.businessUnitId;
        debugger;
      }
    },
    _addDepartment(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$ajax({
            method: "post",
            url: this.URL_ROOT + "/login-service/departments",
            data: this.formedit
          }).then(res => {
            if ((res.data.code = ERR_OK)) {
              this.$message.success("新增成功");
              this.$emit("success");
              this.status = false;
              this.formedit.departmentName = ''
            } else {
              this.$message.error("新增失败");
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

