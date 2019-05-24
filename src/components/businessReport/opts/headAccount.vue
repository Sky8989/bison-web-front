<template>
  <div class="businessReport-headAccount-warp">
    <el-button type="primary" icon="el-icon-tickets" @click="_findAccountDataStatusBy">账号数据状态</el-button>
    <div class="show-headAccount">
      <el-table :data="findCurrencyExchange" border :header-cell-style="getRowClass">
        <el-table-column prop="currencyName" label="外币" width="80"></el-table-column>
        <el-table-column prop="exchange" label="汇率" width="80"></el-table-column>
      </el-table>
    </div>
    <el-dialog title="账号数据状态" :visible.sync="dialogTableVisible">
      <el-table :data="findAccountDataStatusBy" border :header-cell-style="getRowClass" height="500">
        <el-table-column property="recordDate" label="日期">
          <template slot-scope="scope">{{scope.row.recordDate | formatDate}}</template>
        </el-table-column>
        <el-table-column
          property="countryName"
          label="国家"
          column-key="date"
          :filters="[{text: 'DE', value: 'DE'}, 
                    {text: 'UK', value: 'UK'}, 
                    {text: 'FR', value: 'FR'}, 
                    {text: 'IT', value: 'IT'}, 
                    {text: 'GB', value: 'GB'}, 
                    {text: 'ES', value: 'ES'}]"
          :filter-method="filterHandler"
        ></el-table-column>
        <el-table-column property="syncwire" label="syncwire">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Syncwire === 0,'red':scope.row.Syncwire === ''}">{{scope.row.Syncwire | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="SyncwireUK" label="syncwireuk">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.SyncwireUK === 0,'red':scope.row.SyncwireUK === ''}">{{scope.row.SyncwireUK | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="Atumtek" label="atumtek">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Atumtek === 0,'red':scope.row.Atumtek === ''}">{{scope.row.Atumtek | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="Addsfit" label="Addsfit">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Addsfit === 0,'red':scope.row.Addsfit === ''}">{{scope.row.Addsfit | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="Gomum" label="gomum">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Gomum === 0,'red':scope.row.Gomum === ''}">{{scope.row.Gomum | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="Fansful" label="fansful">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Fansful === 0,'red':scope.row.Fansful === ''}">{{scope.row.Fansful | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="Aracase" label="aracase">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Aracase === 0,'red':scope.row.Aracase === ''}">{{scope.row.aracase | formatText}}</span>
          </template>
        </el-table-column>
        <el-table-column property="Rosesy" label="rosesy">
          <template slot-scope="scope">
            <span :class="{'yellow':scope.row.Rosesy === 0,'red':scope.row.Rosesy === ''}">{{scope.row.rosesy | formatText}}</span>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>
 <script>
import { formatDate } from "../../../common/js/date";
export default {
  data() {
    return {
      dialogTableVisible: false,
      findCurrencyExchange: [],
      findAccountDataStatusBy: []
    };
  },
  created() {
    this._findCurrencyExchange();
  },
  filters: {
    // 时间过滤
    formatDate(time) {
      let date = new Date(time);
      return formatDate(date, "yyyy-MM-dd");
    },
    // 数据过滤
    formatText(val){
      if(val === ''){
        return '无数据'
      }else if(val === 0){
        return '正常但销售0'
      }else if(val === undefined){
        return ''
      }else{
        return '正常'
      }
    }
  },
  methods: {
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    _findCurrencyExchange() {
      this.$ajax
        .get("http://192.168.1.179:10028/exchange/findCurrencyExchange")
        .then(res => {
          this.findCurrencyExchange = res.data.data;
        });
    },
    _findAccountDataStatusBy() {
      this.dialogTableVisible = true;
      this.$ajax
        .get(
          "http://192.168.1.179:10028/accountDataStatus/findAccountDataStatusByTime"
        )
        .then(res => {
          this.findAccountDataStatusBy = res.data.data;
        });
    },
    filterHandler(value, row, column) {
      const property = column["property"];
      return row[property] === value;
    }
  }
};
</script>
<style lang="stylus" scoped>
.businessReport-headAccount-warp {
  position: absolute;
  right: 0;
  top: 0;

  .show-headAccount {
    float: right;
  }

  .el-button--primary {
    margin-right: 20px;
    float: left;
  }

  .el-table {
    border: 1px solid #EBEEF5;
  }
  .yellow{
    color #ffc107
  }
  .red{
    color #f44336
  }
}
</style>
<style>
.businessReport-headAccount-warp .el-dialog {
  width: 1100px;
}
.businessReport-headAccount-warp .show-headAccount .el-table td {
  padding: 3px 0;
  text-align: center;
}
.businessReport-headAccount-warp .show-headAccount .el-table th {
  padding: 6px 0;
  text-align: center;
}
</style>

   