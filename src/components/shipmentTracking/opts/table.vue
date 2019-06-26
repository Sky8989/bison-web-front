 <template>
  <div>
    <pagination :length="totalNum" :pagination="pagination" @currpage="getShipmentByParam" float="right"></pagination>
    <el-table
      :data="tableData"
      :header-cell-style="getRowClass"
      :row-class-name="tableRowClassName"
      v-loading="loading"
      border
      style="width: 100%"
    >
      <el-table-column prop="brandName" label="账号" width="100px"></el-table-column>
      <el-table-column prop="countryName" label="国家" width="80px"></el-table-column>
      <el-table-column label="货件名">
        <template slot-scope="scope">
          <div
            @click="findItemByShipmentId(scope.row)"
            class="shipmentTitle"
          >{{scope.row.shipingName}}</div>
        </template>
      </el-table-column>
      <el-table-column prop="shipmentId" width="170" label="货件编号"></el-table-column>
      <el-table-column prop="ctime" label="创建时间" width="100px">
        <template slot-scope="scope">{{scope.row.ctime | formatDate}}</template>
      </el-table-column>
      <el-table-column prop="amzShipmentStatus" label="状态" width="120px"></el-table-column>
      <el-table-column prop="asin" v-if="!perUnit" label="ASIN" width="150px"></el-table-column>
      <el-table-column prop="sellerSku" v-if="!perUnit" label="SKU" width="150px"></el-table-column>
      <el-table-column prop="totalQuantity" label="发货数量" width="90px"></el-table-column>
      <el-table-column prop="receivedQuantity" label="已接收数量" width="100px"></el-table-column>
      <el-table-column prop="notArriveQuantity" label="待接收数量" width="100px"></el-table-column>
      <el-table-column prop="trackingId" label="物流单号" width="170px"></el-table-column>
      <el-table-column prop="trackingProgress" label="物流进展"></el-table-column>
    </el-table>
    <el-dialog title="货件清单" :visible.sync="dialogTableVisible">
      <el-table border :row-class-name="tableRowClassName" :data="findItemByShipment">
        <el-table-column property="sellerSku" label="SKU"></el-table-column>
        <el-table-column property="quantityShipped" label="已发送数量"></el-table-column>
        <el-table-column property="quantityReceived" label="已接收数量"></el-table-column>
        <el-table-column property="quantityNotArrived" label="待接收数量"></el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
const ERR_OK = 200;
let pagesiz = 20;
let pageNum = 1
import { formatDate } from "../../../common/js/date";
import pagination from "components/common/pagination.vue";
export default {
  props: ["ruleForm"],
  data() {
    return {
      dialogTableVisible: false,
      item: {},
      tableData: [],
      loading: true,
      findItemByShipment: [],
      perUnit: true,
      pagination: {
        pagesize: 20,
        currpage: 1
      },
      totalNum: 0
    };
  },
  filters: {
    formatDate(time) {
      let date = new Date(time);
      return formatDate(date, "yyyy-MM-dd");
    }
  },
  mounted() {
    this.getShipmentByParam();
  },
  methods: {
    // 获取表格数据
    getShipmentByParam() {
      this.loading = true;
      this.tableData = [];
      let data = {
        pagesiz: this.pagination.pagesize,
        pageNum: this.pagination.currpage
      };
      if (this.ruleForm.brandIds) {
        data = {
          brandIds: this.ruleForm.brandIds.join(),
          countryIds: this.ruleForm.countryIds.join(),
          endDate: this.ruleForm.endDate,
          perUnit: this.ruleForm.perUnit,
          sellerSkuIds: this.ruleForm.sellerSkuIds.join(),
          shipmentStatusIds: this.ruleForm.shipmentStatusIds.join(),
          startDate: this.ruleForm.startDate,
          shipmentIds: this.ruleForm.shipmentIds,
          pagesiz: this.pagination.pagesize,
          pageNum: this.pagination.currpage
        };
        this.perUnit = this.ruleForm.perUnit;
      }
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/queryShipmentMsg/getShipmentByParam",
        data: data
      }).then(res => {
        console.log(res);
        if (res.data.code === ERR_OK) {
          this.tableData = res.data.data;
          this.totalNum = res.data.totalNum
        }
        this.loading = false;
      });
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    tableRowClassName({ row, rowIndex }) {
      if (row.isAlarm) {
        return "warning-row";
      }
      return "";
    },
    // 查看列表详情
    findItemByShipmentId(item) {
      this.dialogTableVisible = true;
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/queryShipmentMsg/findItemByShipmentId",
        data: {
          amzShipmentStatus: item.amzShipmentStatus,
          sellerId: item.sellerId,
          shipmentId: item.shipmentId
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.findItemByShipment = res.data.data;
        }
      });
    }
  },
  watch: {
    ruleForm() {
      this.pagination.currpage = 1;
      this.getShipmentByParam();
    }
  },
  components: {
    pagination
  }
};
</script>
<style lang="stylus" scoped>
.shipmentTitle {
  cursor: pointer;
  color: #409EFF;
  text-decoration: underline;
}
</style>
<style>
.el-table .warning-row {
  background: #fef0f0;
}
</style>