<template>
  <span type="text" @click="_deletebutton">{{name}}</span>
</template>
<script>
export default {
  props: ["roleItem"],
  data() {
    return {
      name: "删除角色"
    };
  },
  methods: {
    // 删除组
    _deletebutton() {
      this.$confirm("此操作将永久删除角色, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.$ajax({
            method: "delete",
            url: this.URL_ROOT + "/login-service/roles/"+ this.roleItem.roleId,
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
