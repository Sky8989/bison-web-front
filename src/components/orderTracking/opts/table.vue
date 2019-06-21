<template>
  <div class="table">
    <div class="left">
      <el-form :model="ruleForm" ref="ruleForm" :rules="rules">
        <div class="name">客户姓名</div>
        <el-form-item prop="personNames">
          <el-input
            type="textarea"
            :autosize="{ minRows: 10, maxRows: 15}"
            placeholder="请输入姓名"
            v-model="ruleForm.personNames"
          ></el-input>
        </el-form-item>
        <el-button type="primary" @click="searchfor" icon="el-icon-search">搜索</el-button>
        <el-button @click="ruleForm.personNames = ''" icon="el-icon-circle-close">清空</el-button>
      </el-form>
    </div>
    <div class="right">
      <el-table :data="tableData" border :header-cell-style="getRowClass" style="width: 100%;">
        <el-table-column prop="personName" label="客户姓名"></el-table-column>
        <el-table-column prop="seller" label="账号"></el-table-column>
        <el-table-column prop="countryCode" label="国家"></el-table-column>
        <el-table-column prop="productSku" label="产品型号"></el-table-column>
        <el-table-column prop="asin" label="ASIN"></el-table-column>
        <el-table-column label="订单号">
          <template slot-scope="scope">
            <el-popover
              trigger="click"
              placement="top-start"
              @show="triggerDetailst(scope.row.amzOrderId)"
            >
              <div v-loading="loading" class="orderIdDetailst-warp">
                <p class="title">订单详情</p>
                <p>账号：{{ orderIdDetailst.brandName }}</p>
                <p>国家：{{ orderIdDetailst.countryName }}</p>
                <p>订单号：{{ orderIdDetailst.orderId }}</p>
                <p>购买日期：{{ orderIdDetailst.cnFormatOrderDate}}</p>
                <p>买家姓名：{{ orderIdDetailst.personName }}</p>
                <p class="title">订单产品</p>
                <p v-for="(item,index) in orderIdDetailst.orderItems" :key="index">
                  <span>SKU：{{item.productModelNumber}}</span>
                  <span>ASIN：{{item.asin}}</span>
                  <span>quantity：{{item.quantity}}</span>
                  <span>Price：{{item.unitPriceStr}}</span>
                </p>
                <p>
                  <span>订单总价：{{orderIdDetailst.subtotalStr}}</span>
                  <span>退款：{{orderIdDetailst.returnTotal}}</span>
                </p>
                <p class="title">地址： </p>
                <p>{{orderIdDetailst.orderIdDetailst}}<br v-if="orderIdDetailst.orderIdDetailst">
                  {{orderIdDetailst.city}}<br v-if="orderIdDetailst.city">
                  {{orderIdDetailst.StateOrRegion}}{{orderIdDetailst.postalCod}}<br v-if="orderIdDetailst.StateOrRegion || orderIdDetailst.postalCod">
                  {{orderIdDetailst.countryCode}}
               </p>
              </div>
              <div slot="reference" class="triggerDetailst">
                <i class="el-icon-arrow-right"></i>
                {{ scope.row.amzOrderId }}
              </div>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column prop="orderDate" label="下单日期"></el-table-column>
      </el-table>
    </div>
  </div>
</template> 
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      ruleForm: {
        personNames: ""
      },
      loading: false,
      tableData: [],
      rules: {
        personNames: [
          { required: true, message: "请输入客户姓名", trigger: "blur" }
        ]
      },
      orderIdDetailst: {}
    };
  },
  methods: {
    searchfor() {
      var personNames = this.ruleForm.personNames.split(/[(\r\n)\r\n]+/);
      for(let i in personNames){
        personNames[i] = this.Trim(personNames[i])
      }
      this.$emit("searchfor");
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.$ajax({
            method: "post",
            url:
              this.URL_ROOT +
              this.ORDERANDOVERSEA_SERVICE +
              "/orderMsg/getOrderByParam",
            data: {
              asinIds: this.$parent.formData.asinIds.join(),
              countryIds: this.$parent.formData.countryIds.join(),
              personNames: personNames.join(),
              productIds: this.$parent.formData.productIds.join()
            }
          }).then(res => {
            if (res.data.code === ERR_OK) {
              this.tableData = res.data.data;
            }
          });
        } else {
          return false;
        }
      });
    },
    Trim(str) {
      return str.replace(/(^\s*)|(\s*$)/g, "");
    },
    // 标题背景颜色
    getRowClass({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0) {
        return "background: #EBEEF5 ";
      } else {
        return "";
      }
    },
    triggerDetailst(orderId) {
      this.loading = true;
      this.orderIdDetailst = {};
      this.$ajax({
        method: "post",
        url:
          this.URL_ROOT +
          this.ORDERANDOVERSEA_SERVICE +
          "/orderMsg/getOrderMsg",
        data: {
          amzOrderIds: orderId
        }
      }).then(res => {
        if (res.data.code === ERR_OK) {
          this.loading = false;
          this.orderIdDetailst = res.data.data[0];
        }
      });
    }
  }
};
</script>
<style lang="stylus">
.table {
  .left {
    .el-textarea {
      .el-textarea__inner {
        border-radius: 0;
        resize: none;
      }
    }
  }
}
</style>

<style lang="stylus" scoped>
.table {
  min-height: 400px;

  .left {
    float: left;
    width: 200px;

    .name {
      font-size: 16px;
      color: #333;
    }

    .el-textarea {
      margin: 10px 0;

      .el-textarea__inner {
        border-radius: 0;
      }
    }

    .el-button {
      width: 92px;
    }
  }

  .right {
    padding: 35px 0 0 220px;
  }

  .triggerDetailst {
    cursor: pointer;

    &:hover {
      color: #409eff;
    }
  }
}

.orderIdDetailst-warp {
  max-width: 300px;
}

.el-popover {
  p {
    padding: 3px 0;

    span {
      margin-right: 10px;
    }
  }

  p.title {
    padding: 10px 0;
    color: #333;
    font-weight: bold;
  }
}
</style>

