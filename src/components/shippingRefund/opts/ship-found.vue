<template>
  <div>
    <el-dialog title="创建发货" :visible.sync="dialogTableVisible" @close="_close" width="1000px" top="30px" class="ship-found-wrap">
      <v-nav :nav="nav"></v-nav>
      <div class="box">
        <keep-alive>
          <router-view></router-view>
        </keep-alive>
      </div>
    </el-dialog>
  </div>
</template>
<script>
import nav from "components/common/nav.vue";
export default {
  data() { 
    return {
      dialogTableVisible: false,
      nav: [
        {
          router: "/shippingRefund/ship/edayun",
          name: "易达云"
        },
        {
          router: "/shippingRefund/ship/amazon",
          name: "亚马逊"
        }
      ]
    };
  },
  created() {
    if (this.$route.path === "/shippingRefund/ship/edayun" || this.$route.path === "/shippingRefund/ship/amazon") {
      this.dialogTableVisible = true;
    }
  },
  methods: {
    _close() {
      this.dialogTableVisible = false;
      this.$router.push("/shippingRefund/ship");
    },
    _show() {
      this.dialogTableVisible = true;
      this.$router.push("/shippingRefund/ship/edayun");
    }
  },
  components: {
    "v-nav": nav
  }
};
</script>
<style lang="stylus" scoped>
.box {
  border: 1px solid #e6e6e6;
  padding: 20px;
}
</style>
<style>
.ship-found-wrap .el-dialog__body{
  padding: 10px;
}
</style>
