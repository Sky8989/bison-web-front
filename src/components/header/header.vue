<template>
  <div class="header-warp">
    <div class="login">
      <div class="name">{{name}}</div>
      <el-button @click="logout" size="mini">退出登录</el-button>
    </div>
    <el-menu :default-active="$route.path" mode="horizontal" text-color="#333">
      <el-menu-item index="1">
        <router-link to="/index">仪表板</router-link>
      </el-menu-item>
      <el-submenu index="2">
        <template slot="title">个人中心</template>
        <el-menu-item index="2-1">
          <router-link to="/user-password">个人密码</router-link>
        </el-menu-item>
        <el-menu-item index="2-3">
          <router-link to="/roleManager">角色管理</router-link>
        </el-menu-item>
        <el-menu-item index="2-4">
          <router-link to="/user-subscription">产品订阅</router-link>
        </el-menu-item>
        <el-menu-item index="2-5">
          <router-link to="/department">权限管理</router-link>
        </el-menu-item>
      </el-submenu>
      <el-submenu index="3">
        <template slot="title">产品中心</template>
        <el-menu-item index="3-1">
          <router-link to="/product">产品基础信息管理</router-link>
        </el-menu-item>
        <el-menu-item index="3-2">
          <router-link to="/productCodeInfo">产品编码信息管理</router-link>
        </el-menu-item>
        <el-menu-item index="3-3">
          <router-link to="/productSubscription">产品订阅</router-link>
        </el-menu-item>
        <el-menu-item index="3-4">
          <router-link to="/reviewManagement">产品评价管理</router-link>
        </el-menu-item>
      </el-submenu>
      <el-submenu index="4">
        <template slot="title">销售中心</template>
        <el-menu-item index="4-1">
          <router-link to="/businessReport">销售数据</router-link>
        </el-menu-item>
        <el-menu-item index="4-2">
          <router-link to="/salePlan">销售计划</router-link>
        </el-menu-item>
        <el-menu-item index="4-3">
          <router-link to="/paoductProfitCalculation">利润测算器</router-link>
        </el-menu-item>
      </el-submenu>
      <el-menu-item index="５">
        <router-link to="/businessReport">销售报告</router-link>
      </el-menu-item>
      <el-submenu index="5">
        <template slot="title">库存中心</template>
        <el-menu-item index="5-1">
          <router-link to="/inventory">库存管理</router-link>
        </el-menu-item>
        <el-menu-item index="5-2">亚马逊库存(未有)</el-menu-item>
        <el-menu-item index="5-3">
          <router-link to="/shipmentTracking">亚马逊货件追踪</router-link>
        </el-menu-item>
        <el-menu-item index="5-3">
          <router-link to="/overseasStock">海外仓库存</router-link>
        </el-menu-item>
      </el-submenu>
      <el-submenu index="6">
        <template slot="title">售后中心</template>
        <el-menu-item index="6-1">产品追踪(未有)</el-menu-item>
        <el-menu-item index="6-2">测评管理(未有)</el-menu-item>
        <el-menu-item index="6-3">
          <router-link to="/badReview">差评管理</router-link>
        </el-menu-item>
        <el-menu-item index="6-4">
          <router-link to="/orderTracking">订单查询</router-link>
        </el-menu-item>
        <el-menu-item index="6-4">
          <router-link to="/shippingRefund/ship">发货及退款</router-link>
        </el-menu-item>
        <el-menu-item index="6-5">UB-Warranty中心(未有)</el-menu-item>
        <el-menu-item index="6-6">SY-Warranty中心(未有)</el-menu-item>
      </el-submenu>
      <el-submenu index="7">
        <template slot="title">项目中心</template>
        <el-menu-item index="7-1">
          <router-link to="/project">项目管理</router-link>
        </el-menu-item>
      </el-submenu>
      <el-submenu index="8">
        <template slot="title">OA中心</template>
        <el-menu-item index="8-1">
          <router-link to="/requireAssistance">事件支持</router-link>
        </el-menu-item>
        <el-menu-item index="8-2">运营图片需求进度表(未有)</el-menu-item>
      </el-submenu>


      <el-menu-item index="9">
        <router-link to="/sellerData">卖家数据</router-link>
      </el-menu-item>
    </el-menu>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      name: this.$store.state.LoginedUser.roleName
    };
  },
  created() {},
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

</style>
<style lang="stylus" scoped>
.el-menu--horizontal {
  .active {
    color: #409EFF !important;
    text-direction: none !important;
  }

  a {
    display: block;
  }
}
.header-warp {
  .el-menu-item {
    margin: 0 20px;
    padding: 0;
  }

  button {
    margin: 10px;
    float: right;
  }

  .login {
    position: absolute;
    right: 10px;
    top: 5px;
    z-index 9
    .name{
      display inline-block
      margin-top 15px
      font-size 14px
      color #666
    }
  }
}
</style>
