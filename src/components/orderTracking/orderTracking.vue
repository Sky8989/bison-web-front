<template>
  <div class="overseasStock">
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
          router: "/orderTracking",
          name: "找订单号"
        },
        {
          router: "/orderTracking/orderDetailst",
          name: "订单详情"
        }
      ]
    };
  },
  components: {
    "v-nav": nav,
  }
};
</script>

<style lang="stylus" scoped>
.overseasStock {
  .box {
    border: 1px solid #e6e6e6;
    padding: 20px;
  }
}
</style>
