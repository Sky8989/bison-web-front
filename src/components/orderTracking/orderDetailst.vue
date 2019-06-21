<template>
  <div class="orderDetailst-warp">
    <div class="left">
      <el-form :model="ruleForm" ref="ruleForm" :rules="rules">
        <div class="name">订单号</div>
        <el-form-item prop="amzOrderId">
          <el-input
            type="textarea"
            :autosize="{ minRows: 10, maxRows: 15}"
            placeholder="请输入订单号"
            v-model="ruleForm.amzOrderId"
          ></el-input>
        </el-form-item>
        <el-button type="primary" @click="searchfor" icon="el-icon-search">搜索</el-button>
        <el-button @click="ruleForm.amzOrderId = ''" icon="el-icon-circle-close">清空</el-button>
      </el-form>
    </div>
    <div class="right">
      <div class="name" v-if="itemData.length !== 0">订单详情</div>
      <div v-loading="loading">
        <div v-if="itemData.length === 0" class="null">{{txt}}</div>
        <div class="content" v-for="(item,index) in itemData" :key="index">
          <p>账号：{{ item.brandName }}</p>
          <p>国家：{{ item.countryName }}</p>
          <p>订单号：{{ item.orderId }}</p>
          <p>购买日期：{{ item.cnFormatOrderDate}}</p>
          <p>买家姓名：{{ item.personName }}</p>
          <p class="title">订单产品</p>
          <p v-for="(item,index) in item.orderItems" :key="index">
            <span>SKU：{{item.productModelNumber}}</span>
            <span>ASIN：{{item.asin}}</span>
            <span>quantity：{{item.quantity}}</span>
            <span>Price：{{item.unitPriceStr}}</span>
          </p>
          <p>
            <span>订单总价：{{item.subtotalStr}}</span>
            <span>退款：{{item.returnTotal}}</span>
          </p>
          <p class="title">地址</p>
          <p>
            {{item.item}}<br v-if="item.item">
            {{item.city}}<br v-if="item.city">
            {{item.StateOrRegion}}{{item.postalCod}}<br v-if="item.StateOrRegion || item.postalCod">
            {{item.countryCode}}
          </p>
        </div>
      </div>
    </div>
  </div>
</template>     
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      txt: "没有更多数据",
      ruleForm: {
        amzOrderId: ""
      },
      loading: false,
      itemData: [],
      rules: {
        amzOrderId: [
          { required: true, message: "请输入订单号", trigger: "blur" }
        ]
      }
    };
  },
  methods: {
    searchfor() {
      this.$refs["ruleForm"].validate(valid => {
        if (valid) {
          this.txt = "正在加载";
          this.loading = true;
          this.itemData = [];
          setTimeout(() => {
            var amzOrderId = this.ruleForm.amzOrderId.split(/[(\r\n)\r\n]+/);
            for (let i in amzOrderId) {
              amzOrderId[i] = this.Trim(amzOrderId[i]);
            }
            this.$ajax({
              method: "post",
              url:
                this.URL_ROOT +
                this.ORDERANDOVERSEA_SERVICE +
                "/orderMsg/getOrderMsg",
              data: {
                amzOrderIds: amzOrderId.join()
              }
            }).then(res => {
              if (res.data.code === ERR_OK) {
                this.loading = false;
                this.itemData = res.data.data;
                if (this.itemData.length === 0) {
                  this.txt = "没有更多数据";
                }
              }
            });
          }, 200);
        }
      });
    },
    Trim(str) {
      return str.replace(/(^\s*)|(\s*$)/g, "");
    }
  }
};
</script>
<style lang="stylus">
.orderDetailst-warp {
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
.orderDetailst-warp {
  min-height: 400px;

  .name {
    font-size: 16px;
    color: #333;
  }

  .left {
    float: left;
    width: 200px;

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
    padding-left: 220px;

    .name {
      margin-bottom: 10px;
    }

    .null {
      padding: 50px;
      text-align: center;
      font-size: 16px;
      color: #606266;
    }

    .content {
      border: 1px solid #e6e6e6;
      padding: 20px;
      margin-bottom: 20px;
      background #f5f5f5

      p {
        padding: 3px 0;
        color: #606266;
        font-size: 14px;

        span {
          margin-right: 20px;
        }
      }

      p.title {
        padding: 5px 0;
        color: #333;
        font-weight: bold;
      }
    }
  }
}
</style>

                                      