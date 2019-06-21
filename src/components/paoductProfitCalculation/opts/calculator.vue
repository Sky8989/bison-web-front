<template>
  <div class="calculator-wrap">
    <el-dialog title="比价器" :visible.sync="dialogTableVisible" width="950px">
      <el-row :gutter="20">
        <el-col :span="7">
          <div class="grid-content bg-purple">
            <div class="title">目标</div>
            <div class="input-suffix">
              <span class="name">定价</span>
              <el-input v-model="aimsItem.sellingPrice" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">佣金</span>
              <el-input :value="aimsItemCommissionTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">营销占比</span>
              <el-input v-model="aimsItem.ratioOfMarketing" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">营销费用</span>
              <el-input :value="aimsItemMarketingExpenseTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">利润率</span>
              <el-input :value="aimsItemProfitRateTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">利润</span>
              <el-input :value="aimsItemProfitTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">目标日均</span>
              <el-input v-model="aimsItem.targetDailyAverage" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">目标销售额</span>
              <el-input :value="aimsItemTargetSalesTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">总利润</span>
              <el-input :value="aimsItemGrossProfitTxt" disabled size="mini"></el-input>
            </div>
          </div>
        </el-col>
        <el-col :span="1">
          <div class="grid-content">-</div>
        </el-col>
        <el-col :span="7">
          <div class="grid-content bg-purple">
            <div class="title">当前</div>
            <div class="input-suffix">
              <span class="name">定价</span>
              <el-input v-model="currentItem.sellingPrice" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">佣金</span>
              <el-input :value="currentItemCommissionTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">营销占比</span>
              <el-input v-model="currentItem.ratioOfMarketing" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">营销费用</span>
              <el-input :value="currentItemMarketingExpenseTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">利润率</span>
              <el-input :value="currentItemProfitRateTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">利润</span>
              <el-input :value="currentItemProfitTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">目标日均</span>
              <el-input v-model="currentItem.targetDailyAverage" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">目标销售额</span>
              <el-input :value="currentItemTargetSalesTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">总利润</span>
              <el-input :value="currentItemGrossProfitTxt" disabled size="mini"></el-input>
            </div>
          </div>
        </el-col>
        <el-col :span="1">
          <div class="grid-content">=</div>
        </el-col>
        <el-col :span="7">
          <div class="grid-content bg-purple">
            <div class="title">差值</div>
            <div class="input-suffix">
              <span class="name">定价</span>
              <el-input :value="aimsItem.sellingPrice-currentItem.sellingPrice" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">佣金</span>
              <el-input
                :value="aimsItemCommissionTxt-currentItemCommissionTxt"
                disabled
                size="mini"
              ></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">营销占比</span>
              <el-input :value="aimsItem.ratioOfMarketing-currentItem.ratioOfMarketing" size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">营销费用</span>
              <el-input
                :value="aimsItemMarketingExpenseTxt-currentItemMarketingExpenseTxt"
                disabled
                size="mini"
              ></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">利润率</span>
              <el-input
                :value="aimsItemProfitRateTxt-currentItemProfitRateTxt"
                disabled
                size="mini"
              ></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">利润</span>
              <el-input :value="aimsItemProfitTxt-currentItemProfitTxt" disabled size="mini"></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">目标日均</span>
              <el-input
                :value="aimsItem.targetDailyAverage-currentItem.targetDailyAverage"
                size="mini"
              ></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">目标销售额</span>
              <el-input
                :value="aimsItemTargetSalesTxt-currentItemTargetSalesTxt"
                disabled
                size="mini"
              ></el-input>
            </div>
            <div class="input-suffix">
              <span class="name">总利润</span>
              <el-input
                :value="aimsItemGrossProfitTxt-currentItemGrossProfitTxt"
                disabled
                size="mini"
              ></el-input>
            </div>
          </div>
        </el-col>
      </el-row>
    </el-dialog>
  </div>
</template>
<script>
export default {
  data() {
    return {
      dialogTableVisible: false,
      input2: "",
      aimsItem: {},
      currentItem: {},
      differenceItem: {}
    };
  },
  computed: {
    // ********************目标开始********************
    //   目标佣金
    aimsItemCommissionTxt() {
      return this.aimsItemCommission();
    },
    //   目标营销费用
    aimsItemMarketingExpenseTxt() {
      return this.aimsItemMarketingExpense();
    },
    //   目标利润
    aimsItemProfitTxt() {
      return this.aimsItemProfit();
    },
    //   目标利润率
    aimsItemProfitRateTxt() {
      return (
        this.aimsItemProfit() /
        (this.aimsItem.sellingPrice * this.aimsItemExchangeRate())
      ).toFixed(2);
    },
    // 目标销售额
    aimsItemTargetSalesTxt() {
      return (
        this.aimsItem.targetDailyAverage *
        30 *
        this.aimsItem.sellingPrice *
        this.aimsItemExchangeRate()
      ).toFixed(2);
    },
    // 目标总利润
    aimsItemGrossProfitTxt() {
      return (
        this.aimsItemProfit() *
        this.aimsItem.targetDailyAverage *
        30
      ).toFixed(2);
    },
    // ********************当前开始********************
    //   当前佣金
    currentItemCommissionTxt() {
      return this.currentItemCommission();
    },
    //   当前营销费用
    currentItemMarketingExpenseTxt() {
      return this.currentItemMarketingExpense();
    },
    //   当前利润
    currentItemProfitTxt() {
      return this.currentItemProfit();
    },
    //   当前利润率
    currentItemProfitRateTxt() {
      return (
        this.currentItemProfit() /
        (this.currentItem.sellingPrice * this.currentItemExchangeRate())
      ).toFixed(2);
    },
    // 当前销售额
    currentItemTargetSalesTxt() {
      return (
        this.currentItem.targetDailyAverage *
        30 *
        this.currentItem.sellingPrice *
        this.currentItemExchangeRate()
      ).toFixed(2);
    },
    // 当前总利润
    currentItemGrossProfitTxt() {
      return (
        this.currentItemProfit() *
        this.currentItem.targetDailyAverage *
        30
      ).toFixed(2);
    }
    // ********************当前结束********************
  },
  methods: {
    calculatorShow() {
      this.aimsItem = JSON.parse(JSON.stringify(this.$parent.calculator));
      this.currentItem = JSON.parse(JSON.stringify(this.$parent.calculator));
      this.dialogTableVisible = true;
    },
    // ********************目标开始********************
    //   目标佣金
    aimsItemCommission() {
      return (
        this.aimsItem.sellingPrice *
        (this.aimsItem.commission / this.aimsItem.sellingPrice)
      ).toFixed(2);
    },
    //   目标营销费用
    aimsItemMarketingExpense() {
      return (
        (this.aimsItem.ratioOfMarketing / 100) *
        this.aimsItem.sellingPrice *
        this.aimsItemExchangeRate()
      ).toFixed(2);
    },
    //   目标汇率
    aimsItemExchangeRate() {
      return (
        this.aimsItem.realIncomeRmb /
        (this.aimsItem.realIncomeLocalCurrency - this.aimsItem.sinkLoss)
      ).toFixed(2);
    },
    // 目标实收（RMB）
    aimsItemRealIncomeRmb() {
      return (
        (this.aimsItemRealIncomeLocalCurrency() - this.aimsItem.sinkLoss) *
        this.aimsItemExchangeRate()
      ).toFixed(2);
    },
    // 实收（当地货币）
    aimsItemRealIncomeLocalCurrency() {
      return (
        this.aimsItem.sellingPrice -
        this.aimsItemCommission() -
        this.aimsItem.fbaCost -
        this.aimsItem.vat
      ).toFixed(2);
    },
    //   目标利润
    aimsItemProfit() {
      return (
        this.aimsItemRealIncomeRmb() -
        this.aimsItem.procurementCosts -
        this.aimsItem.logisticsExpense -
        this.aimsItem.marketingExpense
      ).toFixed(2);
    },
    // ********************目标结束********************
    // ********************当前开始********************
    //   目标佣金
    currentItemCommission() {
      return (
        this.currentItem.sellingPrice *
        (this.currentItem.commission / this.currentItem.sellingPrice)
      ).toFixed(2);
    },
    //   目标营销费用
    currentItemMarketingExpense() {
      return (
        (this.currentItem.ratioOfMarketing / 100) *
        this.currentItem.sellingPrice *
        this.currentItemExchangeRate()
      ).toFixed(2);
    },
    //   目标汇率
    currentItemExchangeRate() {
      return (
        this.currentItem.realIncomeRmb /
        (this.currentItem.realIncomeLocalCurrency - this.currentItem.sinkLoss)
      ).toFixed(2);
    },
    // 目标实收（RMB）
    currentItemRealIncomeRmb() {
      return (
        (this.currentItemRealIncomeLocalCurrency() -
          this.currentItem.sinkLoss) *
        this.currentItemExchangeRate()
      ).toFixed(2);
    },
    // 实收（当地货币）
    currentItemRealIncomeLocalCurrency() {
      return (
        this.currentItem.sellingPrice -
        this.currentItemCommission() -
        this.currentItem.fbaCost -
        this.currentItem.vat
      ).toFixed(2);
    },
    //   目标利润
    currentItemProfit() {
      return (
        this.currentItemRealIncomeRmb() -
        this.currentItem.procurementCosts -
        this.currentItem.logisticsExpense -
        this.currentItem.marketingExpense
      ).toFixed(2);
    }
    // ********************当前结束********************
  }
};
</script>

<style lang="stylus" scoped>
.calculator-wrap {
  .el-row {
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    justify-content: center;

    &:last-child {
      margin-bottom: 0;
    }

    .grid-content {
      padding: 20px 0;
      text-align: center;
    }

    .el-col {
      border-radius: 4px;
    }

    .bg-purple {
      background: #ebeef5;
    }

    .grid-content {
      border-radius: 4px;

      .title {
        font-size: 18px;
        color: #333333;
        text-align: center;
      }
    }

    .input-suffix {
      margin-top: 20px;
      padding: 0 10px;

      .name {
        display: inline-block;
        line-height: 28px;
        float: left;
        text-align: right;
        font-size: 15px;
        width: 110px;
      }

      .el-input {
        padding-left: 120px;
        width: 100px;
        display: block;
      }
    }
  }
}
</style>
<style lang="stylus">
.calculator-wrap {
  .el-input.is-disabled .el-input__inner {
    color: #000000;
  }
}
</style>
