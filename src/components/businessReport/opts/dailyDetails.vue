<template>
  <div class="dailyDetails-businessReport-warp">
    <el-switch v-model="showLine" active-text="显示图表"></el-switch>
    <div class="navControl" v-show="showLine">
      <ul>
        <li>
          <el-radio v-model="businessReport" label="findBusinessReport" @change="businessReports">天</el-radio>
        </li>
        <li>
          <el-radio v-model="businessReport" label="findByWeek" @change="businessReports">周</el-radio>
        </li>
        <li>
          <el-radio v-model="businessReport" label="findByMonth" @change="businessReports">月</el-radio>
        </li>
      </ul>
    </div>
    <div class="line" v-show="showLine" v-loading="loading">
      <v-line :lineData="tableData"></v-line>
    </div>
    <el-table
      :data="tableData.concat(summary)"
      show-summary
      sum-text="汇总"
      border
      row-key="id"
      align="left"
      v-loading="loading"
    >
      <el-table-column
        v-for="(item, index) in col"
        :key="`col_${index}`"
        :prop="dropCol[index].prop"
        :label="item.label"
      ></el-table-column>
    </el-table>
  </div>
</template>
<script>
import Sortable from "sortablejs";
import { formatDate } from "../../../common/js/date";
export default {
  data() {
    return {
      loading: true,
      businessReport: "findBusinessReport",
      tableData: [],
      summary: [],
      showLine: true,
      col: [
        {
          label: "日期",
          prop: "recordDate"
        },
        {
          label: "buyBoxPercentage",
          prop: "buyBoxPercentage"
        },
        {
          label: "orderedProductSales",
          prop: "orderedProductSales"
        },
        {
          label: "pageViews",
          prop: "pageViews"
        },
        {
          label: "pageViewsPercentage",
          prop: "pageViewsPercentage"
        },
        {
          label: "priceAvg",
          prop: "priceAvg"
        },
        {
          label: "sessionPercentage",
          prop: "sessionPercentage"
        },
        {
          label: "sessions",
          prop: "sessions"
        },
        {
          label: "totalOrderItems",
          prop: "totalOrderItems"
        },
        {
          label: "unitSessionPercentage",
          prop: "unitSessionPercentage"
        },
        {
          label: "unitsOrdered",
          prop: "unitsOrdered"
        }
      ],
      dropCol: [
        {
          label: "日期",
          prop: "recordDate"
        },
        {
          label: "buyBoxPercentage",
          prop: "buyBoxPercentage"
        },
        {
          label: "orderedProductSales",
          prop: "orderedProductSales"
        },
        {
          label: "pageViews",
          prop: "pageViews"
        },
        {
          label: "pageViewsPercentage",
          prop: "pageViewsPercentage"
        },
        {
          label: "priceAvg",
          prop: "priceAvg"
        },
        {
          label: "sessionPercentage",
          prop: "sessionPercentage"
        },
        {
          label: "sessions",
          prop: "sessions"
        },
        {
          label: "totalOrderItems",
          prop: "totalOrderItems"
        },
        {
          label: "unitSessionPercentage",
          prop: "unitSessionPercentage"
        },
        {
          label: "unitsOrdered",
          prop: "unitsOrdered"
        }
      ]
    };
  },
  mounted() {
    this.columnDrop();
    this.businessReports();
  },
  created() {},
  methods: {
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    // 按天周月查询businessReport数据
    businessReports() {
      this.loading = true;
      this.$ajax({
        method: "post",
        url: "http://192.168.1.179:10028/business/" + this.businessReport,
        data: this.$store.state.businessReportData
      }).then(res => {
        this.loading = false;
        if (res.data.data) {
          let data = res.data.data;
          this._arrSortTimeData(data.datas);
          this._arrData(data);
        } else {
          this.summary = [];
          this.tableData = [];
        }
      });
    },
    // 过滤时间
    _arrSortTimeData(val) {
      let data = val;
      for (let i in data) {
        for (let e in data[i]) {
          if(e !== 'recordDate' && data[i][e]){
            data[i][e] = data[i][e].toFixed(2);
          }
        }
        if (this.businessReport === 'findBusinessReport') {
          let date = new Date(data[i].recordDate);
          data[i].recordDate = formatDate(date, "yyyy-MM-dd");
        }
      }
      let clock = setInterval(() => {
        this.tableData = data;
        clearInterval(clock);
      }, 200);
    },
    // 添加日均
    _arrData(data) {
      let item = "";
      if (data.日均) {
        item = data.日均;
        item.recordDate = "日均";
      } else if (data.周均) {
        item = data.周均;
        item.recordDate = "日均";
      } else {
        item = data.月均;
        item.recordDate = "月均";
      }
      this.summary = item;
    },
    //列拖拽
    columnDrop() {
      const wrapperTr = document.querySelector(".el-table__header-wrapper tr");
      this.sortable = Sortable.create(wrapperTr, {
        animation: 180,
        delay: 0,
        onEnd: evt => {
          const oldItem = this.dropCol[evt.oldIndex];
          this.dropCol.splice(evt.oldIndex, 1);
          this.dropCol.splice(evt.newIndex, 0, oldItem);
        }
      });
    }
  },
  components: {
    "v-line": resolve =>
      require(["components/businessReport/opts/line.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.dailyDetails-businessReport-warp {
  padding-top: 20px;
  .el-table--border{
    margin-top 20px
  }
  .line {
    padding: 0 10px;
  }

  .navControl {
    padding: 20px 0;

    ul {
      li {
        display: inline-block;
      }
    }
  }
}
</style>

