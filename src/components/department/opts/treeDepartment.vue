<template>
  <div>
    <el-tree
      :expand-on-click-node="false"
      :data="dataList"
      ref="tree"
      :props="defaultProps"
      @node-click="_handleNodeClick"
      highlight-current
      node-key="id"
      default-expand-all
    ></el-tree>
  </div>
</template>
<script>
const ERR_OK = 200;

export default {
  data() {
    return {
      departmentID: "0",
      dataList: [],
      Lists: [],
      defaultProps: {
        children: "childern",
        label: "departmentName"
      },
      once: true,
      item: ""
    };
  },
  created() {
    this.addDepartment();
  },
  activated() {
    this.addDepartment();
  },
  methods: {
    addDepartment() {
      let dataLists = [];
      let dataLists1 = [];
      this.$ajax
        .get(
          this.URL_ROOT +
            "/login-service/departments/getDepartmentByDepartmentId/" +
            this.$store.state.LoginedUser.departmentId
        )
        .then(res => {
          if (res.data.code == ERR_OK) {
            dataLists.push(
              {
                departmentName: "所有员工",
                parentPath: "所有员工/",
                childern: [],
                id: "0"
              },
              res.data.data
            );
            dataLists1.push(res.data.data);
            this.dataList = dataLists;
            this.Lists = this.getTreeData(dataLists1);
            this.$nextTick(function() {
              this.$refs.tree.setCurrentKey(this.departmentID);
            });
            if (this.once) {
              this._handleNodeClick(this.dataList[0]);
              this.once = false;
            }
          }
        });
    },
    // 去掉childern空值
    getTreeData(data) {
      for (let i in data) {
        if (data[i].childern.length < 1) {
          data[i].childern = undefined;
        } else {
          this.getTreeData(data[i].childern);
        }
      }
      return data;
    },
    _handleNodeClick(item) {
      // console.log(item)
      this.departmentID = item.id;
      this.$emit("tree", item, this.Lists);
    }
  }
};
</script>
