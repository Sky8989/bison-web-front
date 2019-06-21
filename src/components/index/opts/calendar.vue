<template>
  <div >
    <div class="calendar-warp">
      <el-link type="primary" href="#/index" class="el-icon-close"></el-link>
      <el-calendar style="width:100%">
        <template slot="dateCell" slot-scope="{date, data}">
          <div :class="data.isSelected ? 'is-selected' : ''">
            <div class="time">{{ data.day.split('-').slice(2).join('-') }}</div>
            <div
              v-html="$options.filters.festival(data.day)"
              class="festival"
            ></div>
          </div>
        </template>
      </el-calendar>
    </div>
    <div class="back"></div>
  </div>
</template>
<script>
let worldFestival = [];
worldFestival["2019-05-20"] = {
  world: "圣诞节",
  platform: "双十一",
  company: "旅游"
};
worldFestival["2019-05-28"] = {
  world: "圣诞节",
  platform: "双十一",
  company: "旅游"
};
worldFestival["2019-06-28"] = {
  world: "圣诞节",
  platform: "双十一",
  company: "旅游"
};
export default {
  data() {
    return {
      calendarShow:false
    };
  },
  filters: {
    festival(time) {
      let html = "";
      if (worldFestival[time]) {
        html =
          "<p>" +
          worldFestival[time].world +
          "</p><p>" +
          worldFestival[time].platform +
          "</p><p>" +
          worldFestival[time].company +
          "</p>";
        return html;
      }
    }
  },
  methods: {
  }
}; 
</script> 
<style lang="stylus" scoped>
.calendar-warp {
  position: fixed;
  left: 50px;
  right: 50px;
  top: 50px;
  bottom 50px;
  z-index 10
  padding 20px;
  overflow auto
  background #ffffff;
  .time{
    font-size 22px;
  }
  .festival{
    font-size 12px;
    line-height 18px;
  }
  .el-icon-close{
    position absolute
    right 10px;
    top 10px;
    font-size 20px;
    cursor pointer
  }
}
.back{
  position fixed;
  left 0;
  top 0
  right 0
  bottom 0;
  background rgba(0,0,0,0.1)
  z-index 9
}
</style>
<style lang="stylus">
.calendar-warp{
  .el-calendar-table .el-calendar-day{
    min-height: 95px;
    height auto 
  }
  .el-calendar__body{
      padding 0
    }
}
</style>

