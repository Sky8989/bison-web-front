<template>
  <div class="bulletinBoard-warp" :class="onClass ? '': 'hidden'">
    <div class="title">
      <i class="el-icon-tickets"></i>信息公示栏：
    </div>
    <ul ref="con1" :class="{anim:animate==true}">
      <li v-for="item in items" @mouseover="clearTimer" @mouseout="startTimer">
        <a href>{{item.name}}</a>
        <i class="el-icon-arrow-down" :class="onClass ? 'el-icon-arrow-down': 'el-icon-arrow-up'" @click="_show"></i>
      </li>
    </ul>
    <el-link type="primary" href="#/index/calendar" class="el-icon-date"></el-link>
  </div>
</template> 
<script>
export default {
  data() {
    return {
      onClass: true,
      timer: "",
      animate: false,
      items: [
        //消息列表对应的数组
        { name: "不是被郭德纲发现的，也不是一开始就收为徒弟" },
        { name: "现在雅阁这个状态像极了新A4L上市那段日子。" },
        { name: "低配太寒碜，各种需要加装，中配定价过高，又没啥特色" },
        { name: "然后各种机油门、经销商造反什么的幺蛾子。" },
        { name: "看五月销量，建议参考A4，打8折吧" }
      ]
    };
  },
  created() {
    this.timer = setInterval(this.scroll, 4000);
  },
  beforeDestroy() {
    clearInterval(this.timer);
  },
  methods: {
    scroll() {
      let con1 = this.$refs.con1;
      con1.style.marginTop = "-40px";
      this.animate = !this.animate;
      var that = this;
      setTimeout(function() {
        that.items.push(that.items[0]);
        that.items.shift();
        con1.style.marginTop = "0px";
        that.animate = !that.animate;
      }, 1000);
      
    },
    clearTimer() {
      clearInterval(this.timer);
    },
    startTimer() {
      if(this.onClass){
        this.timer = setInterval(this.scroll, 6000);
      }
    },
    _show(){
        this.onClass = this.onClass?false:true
    },
  },
};
</script>
 
<style lang="stylus" scoped>
.bulletinBoard-warp {
  position relative
  height 40px;
  line-height: 40px;
  overflow: hidden;
  padding: 0 15px;
  transition: all 1s;
  font-size: 14px;
  background: #ebeef5;
  color: #333;
  z-index 9

  .title {
    display: inline-block;
    vertical-align: top;
    font-size: 15px;

    .el-icon-tickets {
      color: #409EFF;
      margin-right 5px;
    }
  }

  .anim {
    transition: all 1s;
  }

  ul {
    display: inline-block;
    vertical-align: top;
    background: #ebeef5;
    padding 0 10px;
    li {
      line-height: 40px;
      height: 40px;
      .el-icon-arrow-up{
        display none;
      }
      a{
        &:hover{
          color #409EFF
        }
      }
      &:first-child{
        .el-icon-arrow-up{
           display inline-block
        }
      }
    }
    
  }
  .el-icon-arrow-down{
      cursor pointer
  }
  &.hidden{
    height auto;
    overflow: inherit;
    ul{
      position absolute
      top 0;
      box-shadow: 0 5px 5px rgba(0,0,0,0.3);
      background #fff
    }
  }
  .el-icon-date{
    float right ;
    font-size 22px;
    margin 9px 0;
  }
}
</style>

