 <template>
  <div v-loading="loading">
    <el-row class="back" :gutter="20" v-if="findData.length > 0">
      <el-col :span="8">
        <v-progress :progress="progress"></v-progress>
      </el-col>
      <el-col :span="16">
        <v-charts :reviewByTime="reviewByTime"></v-charts>
      </el-col>
    </el-row>
    <div style="overflow: auto;margin-bottom: 10px;">
      <pagination :length="findData.length" :pagination="pagination" float="right"></pagination>
    </div>
    <el-table
      :data="findData.slice((pagination.currpage - 1) * pagination.pagesize, pagination.currpage * pagination.pagesize)"
      border
      :header-cell-style="getRowClass"
      style="width: 100%"
    >
      <el-table-column prop="countryName" label="国家" width="60px"></el-table-column>
      <el-table-column prop="productModelNumber" label="产品型号" width="100"></el-table-column>
      <el-table-column prop="reviewerName" label="reviewer名字" width="140px"></el-table-column>
      <el-table-column prop="starRate" label="评价分数" width="80px"></el-table-column>
      <el-table-column label="评价日期" width="120px">
        <template slot-scope="scope">{{scope.row.reviewDate.slice(0 ,10)}}</template>
      </el-table-column>
      <el-table-column prop="reviewTitle" label="评价标题" width="180px"></el-table-column>
      <el-table-column prop="content" label="评价内容"></el-table-column>
      <el-table-column label="评价附图" width="250px">
        <template slot-scope="scope">
          <el-image
            style="width: 75px; height: 75px"
            :src="item"
            fit="fill"
            v-for="(item,index) in scope.row.reviewImages"
            :key="index"
          ></el-image>
        </template>
      </el-table-column>
      <el-table-column label="评价链接" width="150px">
        <template slot-scope="scope">
          <el-link
            type="primary"
            :href="'http://'+scope.row.reviewUrl"
            target="view_window"
            :title="scope.row.reviewUrl"
          >{{scope.row.reviewUrl.slice(0 ,14)}}...</el-link>
        </template>
      </el-table-column>
      <el-table-column prop="reviewerUrl" label="reviewer主页" width="150px">
        <template slot-scope="scope">
          <el-link
            type="primary"
            :href="'http://'+scope.row.reviewerUrl"
            target="view_window"
            :title="scope.row.reviewerUrl"
          >{{scope.row.reviewerUrl.slice(0 ,14)}}...</el-link>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>
<script>
import progress from "components/reviewManagement/opts/progress.vue";
import charts from "components/reviewManagement/opts/charts.vue";
import pagination from "components/common/pagination.vue";
const ERR_OK = 200;
export default {
  props: {
    ruleForm: {}
  },
  data() {
    return {
      findData: {},
      reviewByTime: {},
      URL_ERR: "",
      loading: true,
      progress: {},
      pagination: {
        pagesize: 20,
        currpage: 1
      }
    };
  },
  created() {
    this.getfindData();
  },
  methods: {
    getfindData() {
      this.loading = true;
      this.findData = [];
      this.pagination.currpage = 1;
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.REVIEWMONITORING_SERVICE +
          "/reviewSearch/find" +
          this.URL_ERR.substr(0, this.URL_ERR.length - 1)
      }).then(res => {
        if (res.data.code === ERR_OK) {
          if (res.data.data.data !== "没有数据") {
            this.findData = res.data.data.data;
            this.progress = {
              avgStart: res.data.data.avgStart,
              fiveStarReviews: res.data.data.fiveStarReviews,
              fourStarReviews: res.data.data.fourStarReviews,
              oneStarReviews: res.data.data.oneStarReviews,
              threeStarReviews: res.data.data.threeStarReviews,
              totalReviews: res.data.data.totalReviews,
              twoStarReviews: res.data.data.twoStarReviews
            };
            this.reviewByTime = res.data.data.reviewByTime;
          } else {
            this.findData = [];
          }
          this.loading = false;
        }
      });
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    }
  },
  watch: {
    ruleForm() {
      this.URL_ERR = "?";
      for (let i in this.ruleForm) {
        if (this.ruleForm[i]) {
          if (this.ruleForm[i].length > 0) {
            if (i === "time") {
              this.URL_ERR +=
                "startTime" +
                "=" +
                this.ruleForm[i][0] +
                "&" +
                "endTime" +
                "=" +
                this.ruleForm[i][1] +
                "&";
            } else if (i === "countryIds" || i === "productIds") {
              this.URL_ERR += i + "=" + this.ruleForm[i].join() + "&";
            }
          }
        }
      }
      this.getfindData();
    }
  },
  components: {
    "v-progress": progress,
    "v-charts": charts,
    pagination
  }
};
</script>
<style lang="stylus" scoped>
.back {
  padding: 20px 15px;
  margin: 20px 0 !important;
  background: #ebeef5;
}
</style>
