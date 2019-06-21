  <template>
  <el-table
    :data="tableData"
    :header-cell-style="getRowClass"
    v-loading="loading"
    border
    style="width: 100%"
  >
    <el-table-column prop="productModelNumber" label="产品型号"></el-table-column>
    <el-table-column prop="countryName" label="国家"></el-table-column>
    <el-table-column prop="warehouseName" label="仓库"></el-table-column>
    <el-table-column prop="totalInventory" label="实际仓库"></el-table-column>
    <el-table-column prop="qty" label="可售库存"></el-table-column>
    <el-table-column prop="forOutboundInventory" label="待出库存"></el-table-column>
    <el-table-column label="在途库存">
      <template slot-scope="scope">
        {{scope.row.edit?'':scope.row.transportationInventory}}
        <el-input-number
          v-if="scope.row.edit"
          v-model="scope.row.transportationInventory"
          size="mini"
          controls-position="right"
        ></el-input-number>
      </template>
    </el-table-column>
    <el-table-column prop="sku" label="SKU"></el-table-column>
    <el-table-column prop="monthlyOutputQuantity" label="月出库存"></el-table-column>
    <el-table-column prop="quantityOfReplenishment" label="补货数量"></el-table-column>
    <el-table-column label="编辑" fixed="right" width="80">
      <template slot-scope="scope">
        <el-button
          size="mini"
          @click="editItem(scope.row)"
          :type="scope.row.edit?'primary':''"
        >{{scope.row.edit?"保存":"编辑"}}</el-button>
      </template>
    </el-table-column>
  </el-table>
</template>
<script>
const ERR_OK = 200;
export default {
  props: ["ruleForm"],
  data() {
    return {
      loading: true,
      tableData: []
    };
  },
  created() {
    this.getTindDetails();
  },
  methods: {
    getTindDetails() {
      let ruleForm = "";
      for (let i in this.ruleForm) {
        if (this.ruleForm[i].length > 0) {
          if (i === "timestamp") {
            ruleForm += i + '=' + this.ruleForm[i] + "&";
          } else {
            ruleForm += i + "=" + this.ruleForm[i].join() + "&";
          }
        }
      }
      this.loading = true;
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/findDetails?" +
          ruleForm.substr(0, ruleForm.length - 1)
      }).then(res => {
        if (res.data.code === ERR_OK) {
          let data = res.data.data.data;
          if (data) {
            data.forEach(item => {
              item.edit = false;
            }); 
          }
          this.tableData = data;
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
    // 编辑
    editItem(item) {
      item.edit = item.edit ? false : true;
      if (item.edit === false) {
        this.update(item);
      }
    },
    update(item) {
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/edaSearch/save?countryName=" +
          item.countryName +
          "&sku=" +
          item.sku +
          "&transportationInventory=" +
          item.transportationInventory +
          "&warehouseName=" +
          item.warehouseName
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.$message.success("编辑成功");
        } else {
          this.$message.error("编辑失败");
        }
      });
    }
  },
  watch: {
    ruleForm() {
      this.getTindDetails();
    }
  }
};
</script>