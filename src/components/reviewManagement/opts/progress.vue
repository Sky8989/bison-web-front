<template>
  <div class="progress-warp">
    <div class="title">
      <span class="total">{{progress.totalReviews}}</span> customer reviews
    </div>
    <div class="totalAverage">
      <star :size="48" :score="progress.avgStart" style="float: left;"></star>
      <span class="totalTxt">{{progress.avgStart}} out of 5 stars</span>
    </div>
    <div class="progress">
      <span class="name">5 star</span>
      <el-progress
        :text-inside="true"
        :stroke-width="24"
        :title="'5星'+progress.fiveStarReviews+'个'"
        :percentage="(progress.fiveStarReviews/progress.totalReviews*100).toFixed(1)*1"
      ></el-progress>
    </div>
    <div class="progress">
      <span class="name">4 star</span>
      <el-progress
        :text-inside="true"
        :stroke-width="24"
        :title="'4星'+progress.fourStarReviews+'个'"
        :percentage="(progress.fourStarReviews/progress.totalReviews*100).toFixed(1)*1"
        color="#5faaf7"
      ></el-progress>
    </div>
    <div class="progress">
      <span class="name">3 star</span>
      <el-progress
        :text-inside="true"
        :stroke-width="22"
        :title="'3星'+progress.threeStarReviews+'个'"
        :percentage="(progress.threeStarReviews/progress.totalReviews*100).toFixed(1)*1"
        color="#7faddc"
      ></el-progress>
    </div>
    <div class="progress">
      <span class="name">2 star</span>
      <el-progress
        :text-inside="true"
        :stroke-width="20"
        :title="'2星'+progress.twoStarReviews+'个'"
        :percentage="(progress.twoStarReviews/progress.totalReviews*100).toFixed(1)*1"
        color="#95adc3"
      ></el-progress>
    </div>
    <div class="progress">
      <span class="name">1 star</span>
      <el-progress
        :text-inside="true"
        :stroke-width="20"
        :title="'1星'+progress.oneStarReviews+'个'"
        :percentage="(progress.oneStarReviews/progress.totalReviews*100).toFixed(1)*1"
        color="#9ea0a2"
      ></el-progress>
    </div>
  </div>
</template>
<script>
import star from "components/common/star/star.vue";
export default {
  props: {
    progress: {}
  },
  computed: {},
  components: {
    star
  }
};
</script>

<style lang="stylus" scoped>
.progress-warp {
  padding: 20px;
  background: #ffffff;

  .title {
    font-size: 30px;

    .total {
      color: #409EFF;
      font-weight: bold;
    }
  }

  .totalAverage {
    padding: 10px 0 25px 0;
    overflow: auto;

    .totalTxt {
      line-height: 24px;
      display: inline-block;
      padding-left: 10px;
    }
  }

  .progress {
    .name {
      display: block;
      float: left;
      font-size: 16px;
      color: #409eff;
    }

    .el-progress {
      padding-left: 50px;
      padding-bottom: 15px;
    }
  }
}
</style>

