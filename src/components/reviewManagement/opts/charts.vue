<template>
  <div class="bg-purple-light">
      <ve-line :data="chartData" height="360px" :extend="chartExtend"></ve-line>
  </div>
</template>

<script>
  export default {
    props: {
      reviewByTime: Array
    },
    data: function () {
      return {
        chartExtend: {
          series: {
            center: [-50, -50]
          },
          legend: {
            top: 20,
            bottom: 20,
            textStyle: {
              color: '#000',
              fontSize: 12
            }
          },
        },
        chartData: {
          columns: ['日期', '总数', '五星', '四星','三星' ,'二星','一星'],
          rows: []
        }
      }
    },
    watch:{
      reviewByTime: {
    　　handler(newName, oldName) {
      　　this.chartData.rows = this.reviewByTime.map(item => {
            return {'日期':item.reviewDate.slice(0 ,10),'总数':item.totalReview,'五星':item.five,'四星':item.four,'三星':item.three,'二星':item.two,'一星':item.one}
          })
    　　},
    　　immediate: true
    }
    }
  }
</script>
<style lang="stylus" scoped>
.bg-purple-light{
    background #ffffff
    height 319px
}
</style>
