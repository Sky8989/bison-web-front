<template>
  <span type="text" @click="_deletebutton">{{name}}</span>
</template>
<script>
export default {
  props: ["departmentItem"],
  data() {
    return {
      name: "删除组"
    };
  },
  methods: {
    // 删除组
    _deletebutton() {
      let deteleData = {
        departmentName: this.departmentItem.departmentName,
        id: this.departmentItem.id
      };
      this.$confirm("此操作将永久删除该组, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.$ajax({
            method: "post",
            url: this.URL_ROOT + "/login-service/departments/deleteDepartment/",
            data: deteleData
          }).then(res => {
            this.$message.success("删除成功");
            this.$emit("success");
          });
        })
        .catch(() => {
          this.$message.info("已取消删除");
        });
    },
    _delete() {}
  }
};
</script>
