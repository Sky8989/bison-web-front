<template>
  <div class="header-warp">
    <el-menu
      :default-active="$route.path"
      mode="horizontal"
      text-color="#333"
    >
      <el-button @click="logout">退出账号</el-button>
      <el-menu-item index="1">仪表板</el-menu-item>
      <el-submenu index="2">
        <template slot="title">个人中心</template>
        <el-menu-item index="2-1">
          <router-link to="/user-password">个人密码</router-link>
        </el-menu-item>
        <el-menu-item index="2-2">
          <router-link to="/department">部门人员</router-link>
        </el-menu-item>
        <el-menu-item index="2-3">
          <router-link to="/user-subscription">产品订阅</router-link>
        </el-menu-item>
        <el-menu-item index="2-3">
          <router-link to="/roleManager">角色管理</router-link>
        </el-menu-item>
      </el-submenu>
      <el-submenu index="3">
        <template slot="title">产品管理</template>
        <el-menu-item index="3-1">
          <router-link to="/product">产品基础信息</router-link>
        </el-menu-item>
        <el-menu-item index="3-2">
          <router-link to="/productCodeInfo">产品编码信息</router-link>
        </el-menu-item>
      </el-submenu>
      <el-menu-item index="4"><router-link to="/productSubscription">产品订阅</router-link></el-menu-item>
      <el-menu-item index="５"><router-link to="/businessReport">销售报告</router-link></el-menu-item>
      <el-menu-item index="6"><router-link to="/salePlan">销售计划</router-link></el-menu-item>
      <el-menu-item index="7"><router-link to="/inventory">库存管理</router-link></el-menu-item>
    </el-menu>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
    };
  },
  created(){
  },
  computed: {
    _store() {
      return this.$store.state.LoginedUser.roleId;
    }
  },
  methods: {
    logout() {
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          "/login-service/login/logout?userId=" +
          this.$store.state.LoginedUser.userId
      }).then(res => {
        if (res.data.code == ERR_OK) {
          this.$store.commit("LOGOUT", "");
          this.$router.push({ path: "/login" });
        } else {
          this.$notify({
            title: "退出失败"
          });
        }
      });
    }
  }
};
</script>
<style lang="stylus" rel="stylesheet/stylus">
.el-menu--horizontal {
  .active {
    color: #409EFF !important;
    text-direction: none !important;
  }
  .el-menu-item {
    margin: 0 20px;
    padding 0
  }
  a {
    display: block;
  }
}
.header-warp {
  button {
    margin: 10px;
    float: right;
  }
}
</style>
