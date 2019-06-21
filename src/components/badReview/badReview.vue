<template>
  <el-container>
    <el-header height="auto">
      <searchfor @submitForm="submitForm" ref="searchfor"></searchfor>
    </el-header>
    <el-main>
      <v-Table :ruleForm="ruleForm" @findChargeMan="findChargeMan"></v-Table>
    </el-main>
  </el-container>
</template>
<script>
export default {
  data() {
    return {
      ruleForm: {}
    };
  },
  methods: {
    submitForm(val) {
      this.ruleForm = JSON.parse(JSON.stringify(val));
    },
    findChargeMan(){
      this.$refs.searchfor.getFindChargeMan()
    }
  },
  components: {
    searchfor: resolve =>
      require(["components/badReview/opts/searchfor.vue"], resolve),
    "v-Table": resolve =>
      require(["components/badReview/opts/table.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.el-container {
  position absolute;
  top 80px
  bottom 0
  display: flex;
  flex-flow: column;
  flex-wrap: wrap;
  .el-main{
    position: relative;
    flex: 1;
    width 100%
    padding 0
  }
  .el-header {
    width 100%
    padding 0
  }
}
</style>

