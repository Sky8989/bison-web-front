<template>
  <div class="star" :class="starType">
    <span
      class="star-item"
      v-for="(itemClass,index) in itemClassess"
      :class="itemClass"
      :key="index"
      track-by="$index"
    ></span>
  </div>
</template>

<script>
const LENGTH = 5; //星星个数
const CLS_ON = "on"; //满星状态
const CLS_HALF = "half"; //半星状态
const CLS_OFF = "off"; //无星状态

export default {
  props: {
    size: {
      type: Number //参数：尺寸
    },
    score: {
      type: Number //参数：评分
    }
  },
  computed: {
    starType() {
      //设置星星尺寸
      return "star-" + this.size;
    },
    itemClassess() {
      let result = []; //记录状态的数组
      let score = Math.floor(this.score * 100) / 100;
      let hasDecimal = false
      let integer = Math.floor(score); //向下取整
      let Interval = (score - integer).toFixed(2) 
      if(Interval > 0.25 && Interval <= 0.75){
          hasDecimal = true
      }else if (Interval > 0.75){
        integer = integer+1
      }
      //全星
      for (let i = 0; i < integer; i++) {
        result.push(CLS_ON);
      }
      //半星
      if (hasDecimal) {
        result.push(CLS_HALF);
      }
      //无星
      for (let i = 0; result.length < LENGTH; i++) {
        result.push(CLS_OFF);
      }
      return result;
    }
  }
};
</script>
<style lang="stylus" scoped>
.star {
  display: flex;
}

.star-48 .star-item {
  width: 20px;
  height: 20px;
  margin-right: 5px;
  background-repeat: no-repeat;
  background-size: 20px 20px;
}

.star-48 .star-item:last-child {
  margin-right: 0px;
}

.star-48 .star-item.on {
  background-image: url('./on.png');
}

.star-48 .star-item.half {
  background-image: url('./half.png');
}

.star-48 .star-item.off {
  background-image: url('./off.png');
}

.star-36 .star-item {
  width: 15px;
  height: 15px;
  margin-right: 6px;
  background-repeat: no-repeat;
  background-size: 15px 15px;
}

.star-36 .star-item:last-child {
  margin-right: 0px;
}

.star-36 .star-item:last-child {
  margin-right: 0px;
}

.star-36 .star-item.on {
  background-image: url('./on.png');
}

.star-36 .star-item.half {
  background-image: url('./half.png');
}

.star-36 .star-item.off {
  background-image: url('./off.png');
}
</style>