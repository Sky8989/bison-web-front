<template>
  <div>
    <el-container class="businessReport-warp">
      <el-header height="auto">
        <headSearchfor @submitForm="submitForm"></headSearchfor>
        <headAccount></headAccount>
      </el-header>
    </el-container> 
     <dailyDetails ref="dailyDls" ></dailyDetails>
  </div> 
</template>
<script>
import Sortable from 'sortablejs'
export default {
  methods: {
    // 按天周月查询数据
    submitForm() {
      this.$refs.dailyDls.businessReports();
    } 
  }, 
  components: {
    headSearchfor: resolve =>
      require(["components/businessReport/opts/headSearchfor.vue"], resolve),
    headAccount: resolve =>
      require(["components/businessReport/opts/headAccount.vue"], resolve),
    dailyDetails: resolve =>
      require(["components/businessReport/opts/dailyDetails.vue"], resolve)
  }
}; 
</script>
<style lang="stylus">
.businessReport-warp {
  position: relative;
 
  .el-header, .el-main {
    padding: 0;
  }
} 
</style>

  