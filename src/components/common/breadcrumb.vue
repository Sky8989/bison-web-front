<template>
  <div class="breadcrumb-wrap">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item
        v-for="(item,index) in breadlist"
        :key="index"
        :to="{ path: item.path }"
      >{{item.name}}</el-breadcrumb-item>
    </el-breadcrumb>
  </div>
</template>
<script>
export default {
  created() {
    this.getBreadcrumb();
  },
  data() {
    return {
      breadlist: ""
    };
  },
  methods: {
    getBreadcrumb() {
      let breadListState = [{ name: "首页", path: "/" }];
      breadListState = breadListState.concat(this.$route.matched);
      this.breadlist = breadListState;
    }
  },
  watch: {
    $route() {
      this.getBreadcrumb();
    }
  }
};
</script>
<style lang="stylus">
.breadcrumb-wrap {
  .el-breadcrumb {
    padding: 15px;
    background: #ebeef5;
    margin-bottom: 20px;
  }
}
</style>
 