<template>
  <div>
    <el-button type="success" icon="el-icon-upload2" @click="found">创建发货</el-button>
    <el-button type="primary" icon="el-icon-wallet" @click="batchSubmitFulfillmentOrder">批量提交</el-button>
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
      <el-table-column type="selection" width="40" :selectable="handleDisable"></el-table-column>
      <el-table-column prop="fulfillmentOrderId" label="Orader ID"></el-table-column>
      <el-table-column prop="channel" label="渠道" width="75"></el-table-column>
      <el-table-column prop="name" label="客户姓名" width="140"></el-table-column>
      <el-table-column prop="addressLine1" label="地址"></el-table-column>
      <el-table-column prop="city" label="城市"></el-table-column>
      <el-table-column prop="postalCode" label="邮编" width="90"></el-table-column>
      <el-table-column prop="countryCode" label="国家" width="60"></el-table-column>
      <el-table-column prop="sellerSku" label="SKU" width="130"></el-table-column>
      <el-table-column prop="quantity" label="数量" width="50"></el-table-column>
      <el-table-column prop="within3months" label="是否3月内" width="85">
        <template slot-scope="scope">{{scope.row.within3months?'是':'否'}}</template>
      </el-table-column>
      <el-table-column prop="creater" label="创建人" width="80"></el-table-column>
      <el-table-column prop="createTime" label="创建时间"></el-table-column>
      <el-table-column label="订单状态" width="90">
        <template slot-scope="scope">
          <el-popover
            placement="top-start"
            trigger="hover"
            :content="orderStatusId"
            @show="getOrderStatusById(scope.row)"
          >
            <el-tag type="primary" disable-transitions size="small" slot="reference">获取状态</el-tag>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column label="物流单号" width="90">
        <template slot-scope="scope">
          <el-popover
            placement="top-start"
            trigger="hover"
            :content="trackingNumberByBusinessNum"
            @show="getTrackingNumberByBusinessNum(scope.row)"
          >
            <el-tag type="primary" disable-transitions size="small" slot="reference">获取单号</el-tag>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column label="状态" width="160">
        <template slot-scope="scope">
          <el-button
            :type="scope.row.status == 'ready'?'primary': scope.row.status == 'submited'?'success':'info'"
            size="mini"
            @click="scope.row.status == 'submited'?cancelFulfillmentOrder(scope.row):oddSubmitFulfillmentOrder(scope.row)"
            :disabled="scope.row.status == 'invalid'"
          >{{scope.row.status == 'ready'?'待提交': scope.row.status == 'submited'?'已提交':'已取消'}}</el-button>
          <el-button
            type="danger"
            size="mini"
            :disabled="scope.row.status != 'ready'"
            @click="deleteOrderByOrderId(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <shipfound ref="shipfound"></shipfound>
  </div>
</template>
<script>
import pagination from "components/common/pagination.vue";
import download from "components/shippingRefund/opts/ship-download.vue";
const ERR_OK = 200;
export default {
  props: ["ruleForm"],
  data() {
    return {
      tableData: [],
      pagination: {
        pagesize: 20,
        currpage: 1
      },
      orderStatusId: "",
      trackingNumberByBusinessNum: "",
      loading: true,
      multipleSelection: []
    };
  },
  created() {
    this.getfindDeta();
  },
  methods: {
    // 获取列表
    getfindDeta() {
      this.loading = true;
      this.$ajax({
        method: "post",
        url: "http://192.168.1.224:8081/fulfillmentOrder/searchOrder",
        data: this.ruleForm
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.loading = false;
          this.tableData = res.data.data;
        }
      });
    },
    // 获取订单状态
    getOrderStatusById(item) {
      this.orderStatusId = " ";
      this.$ajax
        .get(
          "http://192.168.1.224:8081/fulfillmentOrder/getOrderStatusById?businessNum=" +
            item.businessNum
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.orderStatusId = res.data.data;
          }
        });
    },
    // 获取订单号
    getTrackingNumberByBusinessNum(item) {
      this.trackingNumberByBusinessNum = " ";
      this.$ajax
        .get(
          "http://192.168.1.224:8081/fulfillmentOrder/getTrackingNumberByBusinessNum?businessNum=" +
            item.businessNum
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.trackingNumberByBusinessNum = res.data.data;
          }
        });
    },
    //删除订单号
    deleteOrderByOrderId(item) {
      this.$confirm("是否确定删除订单", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.$ajax
            .get(
              "http://192.168.1.224:8081/fulfillmentOrder/deleteOrderByOrderId?fulfillmentOrderId=" +
                item.fulfillmentOrderId
            )
            .then(res => {
              if (res.data.code === ERR_OK) {
                this.tableData.splice(
                  this.tableData.findIndex(
                    items =>
                      items.fulfillmentOrderId === item.fulfillmentOrderId
                  ),
                  1
                );
                this.$message.success("删除成功");
              } else {
                this.$message.success("删除失败");
              }
            });
        })
        .catch(() => {});
    },
    //提交订单
    submitFulfillmentOrder(item, boolean) {
      let url =
        item.channel == "edayun"
          ? "submitEdayunFulfillmentOrder?edaOrderIdList=" +
            item.fulfillmentOrderId
          : "submitAmzFulfillmentOrder?amzOrderIdList=" +
            item.fulfillmentOrderId;
      this.$ajax
        .get("http://192.168.1.224:8081/fulfillmentOrder/" + url)
        .then(res => {
          if (res.data.code === ERR_OK) {
            if (boolean) {
              this.multipleSelection.forEach(item => {
                item.status = "submited";
              });
            } else {
              item.status = "submited";
            }
            this.$message.success("提交成功");
          } else {
            this.$message.success("提交失败");
          }
        });
    },
    // 取消订单
    cancelFulfillmentOrder(item) {
      this.$confirm("是否确定取消订单", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          let url =
            item.channel == "edayun"
              ? "cancelEdayunFulfillmentOrder?businessNum=" + item.businessNum
              : "cancelAmzFulfillmentOrder?sellerFulfillmentOrderId=" +
                item.fulfillmentOrderId +
                "&sellerId=" +
                item.sellerId;
          this.$ajax
            .get("http://192.168.1.224:8081/fulfillmentOrder/" + url)
            .then(res => {
              if (res.data.code === ERR_OK) {
                item.status = "invalid";
                this.$message.success("取消成功");
              } else {
                this.$message.success("取消失败");
              }
            });
        })
        .catch(() => {});
    },
    //单个提交订单
    oddSubmitFulfillmentOrder(item) {
      this.$confirm("是否确定提交订单", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          this.submitFulfillmentOrder(item);
        })
        .catch(() => {});
    },
    // 批量提交订单
    batchSubmitFulfillmentOrder() {
      if (this.multipleSelection.length > 0) {
        this.$confirm("是否确定批量提交订单", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        })
          .then(() => {
            let amz = {
                fulfillmentOrderId: "",
                channel: "amazon"
              },
              edayun = {
                fulfillmentOrderId: "",
                channel: "edayun"
              };
            for (let i in this.multipleSelection) {
              if (this.multipleSelection[i].channel == "edayun") {
                edayun.fulfillmentOrderId +=
                  this.multipleSelection[i].fulfillmentOrderId + ",";
              } else {
                amz.fulfillmentOrderId +=
                  this.multipleSelection[i].fulfillmentOrderId + ",";
              }
            }
            if (amz.fulfillmentOrderId) {
              amz.fulfillmentOrderId = amz.fulfillmentOrderId.substr(
                0,
                amz.fulfillmentOrderId.length - 1
              );
              this.submitFulfillmentOrder(amz, true);
            }
            if (edayun.fulfillmentOrderId) {
              edayun.fulfillmentOrderId = edayun.fulfillmentOrderId.substr(
                0,
                edayun.fulfillmentOrderId.length - 1
              );
              this.submitFulfillmentOrder(edayun, true);
            }
          })
          .catch(() => {});
      } else {
        this.$message.warning("请选择提交订单");
      }
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    // 全选
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },
    // 函数需要一个返回值,true为可选,false为不可选择
    handleDisable(row, index) {
      if (row.status === "ready") {
        return true;
      } else {
        return false;
      }
    },
    found() {
      this.$refs.shipfound._show();
    }
  },
  watch: {
    ruleForm(val) {
      delete this.ruleForm.time;
      this.getfindDeta();
    },
    //创建订单成功
    $route(to, from) {
      if (
        to.path === "/shippingRefund/ship" &&
        this.$route.query.success == "ok"
      ) {
        this.getfindDeta();
        this.$refs.shipfound._close();
      }
    }
  },
  components: {
    pagination,
    download,
    shipfound: resolve =>
      require(["components/shippingRefund/opts/ship-found.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.el-table {
  margin-top: 20px;
}

.el-tag {
  cursor: pointer;
}
</style>

