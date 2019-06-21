<template>
  <div class="overseasStock">
    <v-nav :nav="nav"></v-nav>
    <div class="box">
      <keep-alive>
        <router-view v-if="$route.meta.keepAlive"></router-view>
      </keep-alive>
      <router-view v-if="!$route.meta.keepAlive"></router-view>
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
          router: "/overseasStock",
          name: "易达云"
        },
        {
          router: "/overseasStock/winit",
          name: "万邑通"
        }
      ]
    };
  },
  components: {
    "v-nav": nav
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
