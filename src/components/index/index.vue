<template>
  <div class="index-warp" ref="formData">
    <bulletinBoard></bulletinBoard>
    <!-- <countryTime style="padding-top:20px;width:100%;"></countryTime> -->
    <keep-alive>
      <router-view></router-view>
    </keep-alive>
    <div class="container-fluid">
      <div class="grid-stack">
        <div
          class="grid-stack-item"
          v-for="item in gridList"
          :key="item.id"
          :data-gs-id="item.id"
          :data-gs-x="item.x"
          :data-gs-y="item.y"
          :data-gs-width="item.w"
          :data-gs-height="item.h"
          v-if="item.show"
        >
          <div class="grid-stack-item-content-box">
            <div class="grid-stack-item-content">
              <div class="nav-title">
                <i class="el-icon-s-data"></i>
                {{item.name}}
              </div>
              <el-dropdown trigger="click" @command="handleCommand">
                <span class="el-dropdown-link">
                  <i class="el-icon-more"></i>
                </span>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item :command="{name:'refresh',id:item.id}"><i class="el-icon-refresh-right"></i>刷新</el-dropdown-item>
                  <el-dropdown-item :command="{name:'close',id:item.id}"><i class="el-icon-close"></i>移除</el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import "common/js/gridstack.min.js";
import "common/js/jquery-ui.js";
import "common/js/lodash.min.js";
import "common/js/gridstack.jQueryUI.js";
import { debuglog } from 'util';
export default {
  data() {
    return {
      gridList: [
        {
          name: "公司总目标",
          id: "1",
          x: "0",
          y: "0",
          w: "6",
          h: "4",
          show: true
        },
        {
          name: "销售情况",
          id: "2",
          x: "6",
          y: "0",
          w: "6",
          h: "4",
          show: true
        },
        {
          name: "消费比率",
          id: "3",
          x: "0",
          y: "4",
          w: "2",
          h: "2",
          show: true
        },
        {
          name: "销售仪表板",
          id: "4",
          x: "6",
          y: "4",
          w: "2",
          h: "4",
          show: true
        },
        {
          name: "日历",
          id: "5",
          x: "0",
          y: "8",
          w: "6",
          h: "4",
          show: true
        },
        {
          name: "时间",
          id: "10",
          x: "6",
          y: "8",
          w: "6",
          h: "4",
          show: true
        }
      ]
    };
  },
  mounted() {
    // 初始化gridstack
    $(".grid-stack").gridstack();
    let that = this;
    // 移动重新获取位置
    var serializeWidgetMap = function(items) {
      for (let i in items) {
        for (let j in that.gridList) {
          if (that.gridList[j].id === items[i].id) {
            that.gridList[j].x = items[i].x;
            that.gridList[j].y = items[i].y;
            that.gridList[j].w = items[i].width;
            that.gridList[j].h = items[i].height;
            break;
          }
        }
      }
    };
    $(".grid-stack").on("change", function(event, items) {
      console.log(event, items)
      serializeWidgetMap(items);
    });
  },
  methods: {
    handleCommand(command){
      if(command.name === 'close'){
        this._gridstackitemShow(command.id)
      }
    },
    // 移除板块 
    _gridstackitemShow(id){
      for(let i in this.gridList){
        if(this.gridList[i].id === id){
          this.gridList[i].show = false
        }
      }
    }
  },
  components: {
    bulletinBoard: resolve =>
      require(["components/index/opts/bulletinBoard.vue"], resolve),
    countryTime: resolve =>
      require(["components/index/opts/countryTime.vue"], resolve),
  }
};
</script>

<style lang="stylus" scoped>
@import '../../common/css/gridstack.min.css';
.container-fluid {
  padding: 20px 10px;
  border: 1px solid #ebeef5;

  .grid-stack-item-content-box {
    border: 1px solid #ebeef5;
    margin: 0;
    position: absolute;
    top: 0;
    left: 10px;
    right: 10px;
    bottom: 0;
    width: auto;
    z-index: 0;
    overflow-x: hidden;
    overflow-y: auto;

    .nav-title {
      padding: 13px 10px;
      background: #ebeef5;
      cursor: pointer;
    }
    .el-dropdown{
      position absolute
      right 5px;
      top 13px;
      .el-icon-more{
        transform: rotate(90deg);
        cursor pointer
      }
    }
  }
}
</style>
