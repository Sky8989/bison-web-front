<template>
  <el-dialog title="创建退款" :visible.sync="dialogFormVisible" width="450px">
    <el-form :model="saveRefund" ref="saveRefund" :rules="rules" label-width="80px">
      <el-form-item label="账号">
        <el-select v-model="saveRefund.sellerId" placeholder="请选择账号">
          <el-option
            v-for="item in findAccount"
            :key="item.sellerId"
            :label="item.sellerName"
            :value="item.sellerId"
            disabled="disabled"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="国家">
        <el-select v-model="saveRefund.countryId" placeholder="请选择国家">
          <el-option
            v-for="item in findCountry"
            :key="item.countryId"
            :label="item.countryName"
            :value="item.countryId"
            disabled="disabled"
          ></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="订单号" prop="amzOrderId">
        <el-input
          v-model="saveRefund.amzOrderId"
          @change="getfindRefund"
          placeholder="请输入订单号"
          style="width: 200px;"
        ></el-input>
      </el-form-item>
      <div v-for="(item,index) in findRefund" :key="index">
        产品：{{item.productModelNumber}}
        <el-form-item label="退款金额" style="display: inline-block;">
          <el-input-number
            v-model="item.amzRefundAmount"
            :precision="2"
            :step="0.1"
            controls-position="right"
            size="small"
            :max="item.maxRefund"
          ></el-input-number>
        </el-form-item>
        金额：{{item.maxRefund}}
      </div>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="getSaveRefund('saveRefund')">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
const ERR_OK = 200;
export default {
  props: {
    itemSaveRefund: {}
  },
  data() {
    var validatePass = (rule, value, callback) => {
      if (this.saveRefund.amzOrderId === "") {
        callback(new Error("请输入订单号"));
      } else {
        if (this.findRefund.length > 0) {
          callback();
          return;
        }
        callback(new Error("请输入准确订单号"));
      }
    };
    return {
      dialogFormVisible: false,
      findCountry: [],
      findAccount: [],
      findRefund: [],
      saveRefund: {
        amzOrderId: ""
      },
      rules: {
        amzOrderId: [{ validator: validatePass, trigger: "blur" }]
      }
    };
  },
  methods: {
    //获取账号
    getfindAccount() {
      this.$ajax
        .post(this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/tracking/findAccount")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findAccount = res.data.data.data;
          }
        });
    },
    //获取国家
    getFindCountry() {
      this.$ajax
        .post(this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findCountry")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findCountry = res.data.data.data;
          }
        });
    },
    //获取订单号信息
    getfindRefund() {
      this.findRefund = []
      this.$ajax
        .post(
          this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/tracking/findRefund?orderId=" +
            this.saveRefund.amzOrderId
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            if (!res.data.data.error) {
              if (res.data.data.data.length > 0) {
                this.findRefund = res.data.data.data;
                this.saveRefund.sellerId = this.findRefund[0].sellerId;
                this.saveRefund.countryId = this.findRefund[0].countryId;
                this.$refs['saveRefund'].validate(valid => true)
              }
            }
          }
          this.getFindCountry();
          this.getfindAccount();
        });
    },
    // 提交退款
    getSaveRefund(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          let dataArr = [];
          this.findRefund.forEach(el => {
            dataArr.push({
              amzOrderId: this.saveRefund.amzOrderId,
              amzRefundAmount: el.amzRefundAmount,
              asinId: el.asinId,
              countryId: el.countryId,
              sellerId: el.sellerId
            });
          });
          this.$ajax({
            method: "post",
            url:
              this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/tracking/saveRefund?userId=" +
              this.$store.state.LoginedUser.userId,
            data: dataArr
          }).then(res => {
            if (res.data.code === ERR_OK) {
              this.dialogFormVisible = false;
              this.$message.success(res.data.data.data);
            }
          });
        } else {
          return false;
        }
      });
    },
    _show() {
      this.dialogFormVisible = true;
      this.saveRefund.amzOrderId = this.itemSaveRefund.amzOrderId;
      this.getfindRefund();
    }
  }
};
</script>

