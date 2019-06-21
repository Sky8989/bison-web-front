  <template>
  <el-table :data="tableData" :header-cell-style="getRowClass" v-loading="loading" border style="width: 100%">
    <el-table-column prop="productModelNumber" label="产品型号"></el-table-column>
    <el-table-column prop="countryName" label="国家"></el-table-column>
    <el-table-column prop="warehouseName" label="仓库"></el-table-column>
    <el-table-column prop="qtyAvailable" label="可用库存"></el-table-column>
    <el-table-column label="在途库存">
      <template slot-scope="scope">
        {{scope.row.edit?'':scope.row.pipelineInventory}}
          <el-input-number
            v-if="scope.row.edit"
            v-model="scope.row.pipelineInventory"
            size="mini"
            controls-position="right"
          ></el-input-number>
        </template>
    </el-table-column>
    <el-table-column prop="reservedInventory" label="待出库存"></el-table-column>
    <el-table-column prop="qtySellHisOut" label="历史销量"></el-table-column>
    <el-table-column prop="monthlyOutputQuantity" label="月出库数量"></el-table-column>
    <el-table-column prop="quantityOfReplenishment" label="补货数量"></el-table-column>
  </el-table>
</template>
<script>
const ERR_OK = 200;
export default {
  props: ['ruleForm'],
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
      let ruleForm = ''
      for(let i in this.ruleForm){
        if(this.ruleForm[i].length > 0){ 
          if(i === 'timestamp'){
            ruleForm += i + '='+ this.ruleForm[i]+'&'
          }else{
            ruleForm += i + '=' + this.ruleForm[i].join() + '&'
          } 
        }
      }
      this.loading = true
      this.$ajax({
        method: 'post',
        url: this.URL_ROOT + this.OVERSEASWAREHOUSESTORAGET_SERVICE + "/winitSearch/findDetails?"+ruleForm.substr(0,ruleForm.length-1),
      }).then(res => {
        if(res.data.code === ERR_OK){
            this.tableData = res.data.data.data
            console.log(this.tableData)
        }
        this.loading =false
      })
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
  },
  watch: {
    ruleForm() {
      this.getTindDetails()
    }
  },
};
</script>