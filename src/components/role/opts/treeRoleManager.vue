<template>
  <div>
    <el-tree
      :expand-on-click-node="false"
      :data="dataList"
      ref="tree"
      :props="defaultProps"
      @node-click="_handleNodeClick"
      highlight-current
      node-key="roleId"
      default-expand-all
    ></el-tree>
  </div>
</template>
<script>
const ERR_OK = 200;

export default {
  data() {
    return {
      the_id: this.$store.state.LoginedUser.roleId,
      roleId: 0,
      dataList: [],
      Lists: [],
      defaultProps: {
        children: "children",
        label: "roleName"
      },
      item: ""
    };
  },
  created() {
    this.addRole();
  },
  activated() {
    this.addRole();
  },
  mounted() {},
  methods: {
    addRole() {
      this.$ajax
        .get(
          this.URL_ROOT +
            "/login-service/userPermission/getChildrenTreeByRoleId/" +
            this.$store.state.LoginedUser.roleId
        )
        .then(res => {
          this.dataList = [];
          if (res.data.code == ERR_OK) {
            if (res.data.data) {
              let dataLists1 = [];
              let temResult = res.data.data;
              if (temResult) {
                this.dataList.push(temResult);
                dataLists1.push(temResult);
              }
              this.Lists = this.getTreeData(dataLists1);
            }

            this.$nextTick(function() {
              this.$refs.tree.setCurrentKey(this.the_id);
            });
          }
        });
    },
    // 去掉childern空值
    getTreeData(data) {
      for (let i in data) {
        if (data[i].children && data[i].children.length < 1) {
          data[i].children = undefined;
        } else {
          this.getTreeData(data[i].children);
        }
      }
      return data;
    },
    _handleNodeClick(item) {
      console.log(item)
      this.the_id = item.roleId
      this.$emit("tree", item, this.Lists);
    }
  }
};
</script>
