<template>
  <div class="shippingRefund">
    <v-nav :nav="nav"></v-nav>
    <div class="box">
      <keep-alive>
        <router-view></router-view>
      </keep-alive> 
    </div> 
  </div> 
</template>  
<script>
import nav from "components/common/nav.vue";
export default {
  data() {
    return {
      nav: [
        {
          router: "/shippingRefund/ship",
          name: "发货"
        },
        {
          router: "/shippingRefund/refund",
          name: "退款"
        }
      ]
    };
  },
  created(){
  },
  components: {
    "v-nav": nav,
  }
};
</script>

<style lang="stylus" scoped>
.shippingRefund {
  .box {
    border: 1px solid #e6e6e6;
    padding: 20px;
  }
}
</style>
