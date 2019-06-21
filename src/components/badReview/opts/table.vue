<template>
  <div>
    <pagination :length="tableData.length" :pagination="pagination" float="right"></pagination>
    <el-table
      :data="tableData.slice((pagination.currpage - 1) * pagination.pagesize, pagination.currpage * pagination.pagesize)"
      border
      v-loading="loading"
      :header-cell-style="getRowClass"
      height="auto"
    >
      <el-table-column prop="countryName" label="国家" width="60"></el-table-column>
      <el-table-column prop="productModelNumber" label="产品型号" width="100"></el-table-column>
      <el-table-column prop="reviewerName" label="reviewer名字" width="140"></el-table-column>
      <el-table-column prop="starRate" label="评价分数" width="80"></el-table-column>
      <el-table-column label="评价日期" width="120">
        <template slot-scope="scope">{{scope.row.reviewDate.slice(0 ,10)}}</template>
      </el-table-column>
      <el-table-column prop="reviewTitle" label="评价标题" width="180">
        <template slot-scope="scope">
          <div style="font-size: 12px;line-height: 18px;">{{scope.row.reviewTitle}}</div>
        </template>
      </el-table-column>
      <el-table-column prop="content" label="评价内容" width="600">
        <template slot-scope="scope">
          <div style="font-size: 12px;line-height: 18px;">{{scope.row.content}}</div>
        </template>
      </el-table-column>
      <el-table-column label="评价附图" width="125">
        <template slot-scope="scope">
          <el-image
            style="width: 50px; height: 50px"
            :src="item"
            fit="fill"
            v-for="(item,index) in scope.row.reviewImages"
            :key="index"
          ></el-image>
        </template>
      </el-table-column>
      <el-table-column label="评价链接" width="150">
        <template slot-scope="scope">
          <el-link
            type="primary"
            :href="'http://'+scope.row.reviewUrl"
            target="view_window"
            :title="scope.row.reviewUrl"
          >{{scope.row.reviewUrl.slice(0 ,14)}}...</el-link>
        </template>
      </el-table-column>
      <el-table-column prop="reviewerUrl" label="reviewer主页" width="150">
        <template slot-scope="scope">
          <el-link
            type="primary"
            :href="'http://'+scope.row.reviewerUrl"
            target="view_window"
            :title="scope.row.reviewerUrl"
          >{{scope.row.reviewerUrl.slice(0 ,14)}}...</el-link>
        </template>
      </el-table-column>
      <el-table-column prop="amzOrderId" label="订单号" width="150"></el-table-column>
      <el-table-column label="跟进记录" width="100">
        <template slot-scope="scope">
          <el-popover trigger="hover" placement="top">
            <p v-for="(item,index) in scope.row.recordArr" :key="index">{{item}}</p>
            <div slot="reference" class="name-wrapper">{{ scope.row.record }}</div>
          </el-popover>
          <el-button type="primary" size="mini" @click="showRecord(scope.row)">添加</el-button>
        </template>
      </el-table-column>
      <el-table-column label="负责人" width="120">
        <template slot-scope="scope">
          <span v-if="!scope.row.edit" @click="editItem(scope.row)">
            {{scope.row.chargeMan}}
            <i class="el-icon-arrow-down"></i>
          </span>
          <el-input
            v-if="scope.row.edit"
            v-model="scope.row.chargeMan"
            size="mini"
            :autofocus="scope.row.edit"
            @blur="editItem(scope.row)"
          ></el-input>
        </template>
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="255">
        <template slot-scope="scope">
          <el-button type="success" size="mini">创建发货</el-button>
          <el-button type="danger" size="mini"  @click="showSaveRefund(scope.row)">退款</el-button>
          <el-button
            :type="scope.row.handleStatus !== 1?'':'primary'"
            size="mini"
            @click="handleStatus(scope.row)"
          >{{scope.row.handleStatus !== 1?'已完成':'待处理'}}</el-button>
        </template>
      </el-table-column>
    </el-table>
    <record ref="record" :itemRecord="item" @getRecord="update(item)"></record>
    <saveRefund ref="saveRefund" :itemSaveRefund="item"></saveRefund>
  </div>
</template>
<script>
const ERR_OK = 200;
import pagination from "components/common/pagination.vue";
export default {
  props: {
    ruleForm: {}
  },
  data() {
    return {
      tableData: [],
      pagination: {
        pagesize: 20,
        currpage: 1 
      },
      item: {},
      loading: true
    };
  },
  created() {
    this.getfindData();
  },
  methods: {
    getfindData() {
      this.pagination.currpage = 1;
      this.tableData = []
      this.loading = true;
      let URL_ERR = "?";
      for (let i in this.ruleForm) {
        if (this.ruleForm[i].length > 0) {
          URL_ERR += i + "=" + this.ruleForm[i].join() + "&";
        }
      }
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.REVIEWMONITORING_SERVICE +
          "/tracking/find" +
          URL_ERR.substr(0, URL_ERR.length - 1)
      }).then(res => {
        if (res.data.code === ERR_OK) {
          let tableData = res.data.data.data;
          if (tableData !== "没有数据") {
            for (let i in tableData) {
              tableData[i].edit = false;
              tableData[i].id = i;
              tableData[i].recordArr = tableData[i].record.split(
                /[/<br \/>/g]+/
              );
            }
            this.tableData = tableData;
          }else{
            this.tableData = [];
          }          
          this.loading = false;
        }
      });
    },
    // 编辑
    editItem(item) {
      item.edit = item.edit ? false : true;
      this.item = JSON.parse(JSON.stringify(item));
      if (item.edit === false) {
        this.update(item);
      }
    },
    // 更新列表数据Item
    update(item) {
      this.$ajax({
        method: "post",
        url: this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/tracking/update",
        data: {
          amzOrderId: item.amzOrderId,
          asinId: item.asinId,
          chargeMan: item.chargeMan,
          handleStatus: item.handleStatus,
          record: item.record,
          recordDate: item.recordDate,
          reviewId: item.reviewId
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.updateItem = res.data.data.data[0];
          this.$message.success("编辑成功");
          this.upitem();
          this.$emit("findChargeMan");
        } else {
          this.$message.error("编辑失败");
        }
      });
    },
    upitem() {
      for (let i in this.tableData) {
        if (this.tableData[i].id === this.item.id) {
          for (let e in this.item) {
            this.tableData[i][e] = this.item[e];
          }
          this.tableData[i].recordArr = this.item.record.split(/[/<br \/>/g]+/);
          return;
        }
      }
    },
    // 显示添加记录
    showRecord(item) {
      this.item = JSON.parse(JSON.stringify(item));
      this.$refs.record._show();
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    //显示创建退款
    showSaveRefund(item) {
      this.item = JSON.parse(JSON.stringify(item));
      this.$refs.saveRefund._show();
    },
    // 处理完成
    handleStatus(item) {
      if (item.handleStatus === 1) {
        this.$confirm("是否要确定已完成", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          item.handleStatus = 2;
          this.item = JSON.parse(JSON.stringify(item));
          this.update(item);
          this.$message({
            type: "success",
            message: "删除成功!"
          });
        });
      }
    }
  },
  watch: {
    ruleForm() {
      this.getfindData();
    }
  },
  components: {
    pagination,
    record: resolve =>
      require(["components/badReview/opts/record.vue"], resolve),
    saveRefund: resolve =>
      require(["components/badReview/opts/saveRefund.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.name-wrapper {
  max-width: 65px;
  line-height: 26px;
  text-overflow: ellipsis;
  white-space: nowrap;
  overflow: hidden;
  display: inline-block;
  vertical-align: top;
  font-size: 14px;
}
.el-table {
  width: 100%;
  position: absolute;
  left: 0;
  right: 0;
  top: 50px;
  bottom: 0;
}
</style>
