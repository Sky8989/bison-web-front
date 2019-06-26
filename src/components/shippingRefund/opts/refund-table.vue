<template>
  <div>
    <saveRefund @getfindDeta="getfindDeta"></saveRefund>
    <el-button type="info" @click="updates" icon="el-icon-wallet">批量退款</el-button>
    <download style="margin:0" :tableData="tableData"></download>
    <pagination :length="tableData.length" :pagination="pagination" float="right"></pagination>
    <el-table
      :data="tableData.slice((pagination.currpage - 1) * pagination.pagesize, pagination.currpage * pagination.pagesize)"
      :header-cell-style="getRowClass"
      v-loading="loading"
      border
      @selection-change="handleSelectionChange"
      style="width: 100%"
    >
      <el-table-column type="selection" width="55" :selectable="handleDisable"></el-table-column>
      <el-table-column prop="sellerName" label="账号"></el-table-column>
      <el-table-column prop="countryName" label="国家" width="70"></el-table-column>
      <el-table-column prop="amzOrderId" label="Orader ID"></el-table-column>
      <el-table-column prop="productModelNumber" label="产品"></el-table-column>
      <el-table-column prop="amzRefundAmount" label="退款金额" width="100"></el-table-column>
      <el-table-column prop="cDate" label="创建时间"></el-table-column>
      <el-table-column prop="cUser" label="创建人"></el-table-column>
      <el-table-column label="状态" width="160">
        <template slot-scope="scope">
          <el-button
            :type="scope.row.status == 1?'info': scope.row.status == 2?'primary':''"
            size="mini"
            @click="update(scope.row)"
            :disabled="scope.row.status === 1"
          >{{scope.row.status |status}}</el-button>
          <el-button
            type="danger"
            size="mini"
            :disabled="scope.row.status !== 2"
            @click="deleteItem(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>
<script>
const ERR_OK = 200;
import pagination from "components/common/pagination.vue";
import saveRefund from "components/shippingRefund/opts/refund-saveRefund.vue";
import download from "components/shippingRefund/opts/refund-download.vue";
export default {
  props: ["ruleForm"],
  data() {
    return {
      loading: true,
      tableData: [],
      ERR_URL: "",
      pagination: {
        pagesize: 20,
        currpage: 1
      },
      multipleSelection: []
    };
  },
  filters: {
    status(string) {
      return string == 1 ? "已退款" : string == 2 ? "待处理" : "其他";
    }
  },
  created() {
    this.getfindDeta();
  },
  methods: {
    getfindDeta() {
      this.loading = true;
      this.tableData = [];
      this.$ajax
        .post(
          this.URL_ROOT +
            this.REVIEWMONITORING_SERVICE +
            "/refund/find" +
            this.ERR_URL
        )
        .then(res => {
          if (res.data.code) {
            if (res.data.data.data instanceof Array) {
              this.tableData = res.data.data.data;
            }
          }
          this.loading = false;
        });
    },
    // 全选
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    // 函数需要一个返回值,true为可选,false为不可选择
    handleDisable(row, index) {
      if (row.status === 2) {
        return true;
      } else {
        return false;
      }
    },
    //批量退款
    updates() {
      if (this.multipleSelection.length > 0) {
        this.$confirm("是否要批量提交退款", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
          .then(() => {
            let multipleSelection = JSON.parse(
              JSON.stringify(this.multipleSelection)
            );
            multipleSelection.forEach(item => {
              item.status = 1;
            });
            this.$ajax({
              method: "post",
              url:
                this.URL_ROOT +
                this.REVIEWMONITORING_SERVICE +
                "/refund/updates",
              data: multipleSelection
            }).then(res => {
              if (res.data.code === ERR_OK) {
                this.multipleSelection.forEach(item => {
                  item.status = 1;
                });
                this.$message.success("批量退款成功");
              } else {
                this.$message.error("批量退款失败");
              }
            });
          })
          .catch(() => {});
      } else {
        this.$message.warning("请选择退款订单");
      }
    },
    //待处理
    update(item) {
      if (item.status === 2) {
        this.$confirm("是否确定要提交退款", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
          .then(() => {
            let items = JSON.parse(JSON.stringify(item));
            items.status = 1;
            this.$ajax({
              method: "post",
              url:
                this.URL_ROOT +
                this.REVIEWMONITORING_SERVICE +
                "/refund/update",
              data: items
            }).then(res => {
              if (res.data.code === ERR_OK) {
                item.status = 1;
                this.$message.success("退款成功");
              } else {
                this.$message.error("退款失败");
              }
            });
          })
          .catch(() => {});
      }
    },
    //删除
    deleteItem(item) {
      this.$ajax
        .post(
          this.URL_ROOT +
            this.REVIEWMONITORING_SERVICE +
            "/refund/delete?amzRefundRecordId=" +
            item.amzRefundRecordId
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.tableData.splice(
              this.tableData.findIndex(
                items => items.amzRefundRecordId === item.amzRefundRecordId
              ),
              1
            );
            this.$message.success("删除成功");
          } else {
            this.$message.success("删除失败");
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
    ruleForm(val) {
      this.ERR_URL = "?";
      for (let item in val) {
        if (val[item].length > 0) {
          if (item === "time") {
            this.ERR_URL +=
              "startTime" +
              "=" +
              val[item][0] +
              "&" +
              "endTime" +
              "=" +
              val[item][1] +
              "&";
          } else {
            this.ERR_URL += item + "=" + this.ruleForm[item].join() + "&";
          }
        }
      }
      this.getfindDeta();
    }
  },
  components: {
    pagination,
    saveRefund,
    download
  }
};
</script>
<style lang="stylus" scoped>
.el-table {
  margin-top: 20px;
}
</style>
