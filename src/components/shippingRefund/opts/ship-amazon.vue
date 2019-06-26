<template>
  <el-form ref="form" :rules="rules" :model="form" label-width="110px" class="ship-amazon-warp">
    <el-row :gutter="20">
      <el-col :span="6">
        <el-input
          type="textarea"
          :autosize="{ minRows: 20, maxRows: 25}"
          placeholder="请输入内容"
          v-model="textarea"
        ></el-input>
      </el-col>
      <el-col :span="18">
        <el-row>
          <el-col :span="10">
            <el-form-item label="创建人" prop="creater">
              <el-input v-model="form.creater" size="medium" :disabled="true"></el-input>
            </el-form-item>
            <el-form-item label="Order ID" prop="fulfillmentOrderId">
              <el-input v-model="form.fulfillmentOrderId" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="发货Order ID" prop="displayableOrderId">
              <el-input v-model="form.displayableOrderId" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="下单时间" prop="displayableOrderDate">
              <el-date-picker
                v-model="form.displayableOrderDate"
                type="date"
                :picker-options="pickerOptions"
                placeholder="选择日期"
                format="yyyy 年 MM 月 dd 日"
                value-format="yyyy-MM-dd"
              ></el-date-picker>
            </el-form-item>
            <el-form-item label="留言" prop="displayableOrderComment">
              <el-input
                type="textarea"
                :autosize="{ minRows: 1, maxRows: 3}"
                placeholder="请输入内容"
                v-model="form.displayableOrderComment"
              ></el-input>
            </el-form-item>
            <el-form-item label="配送方式" prop="shippingSpeedCategory">
              <el-select v-model="form.shippingSpeedCategory" placeholder="请选择配送方式" size="medium">
                <el-option
                  :label="item"
                  :value="item"
                  :key="index"
                  v-for="(item,index) in shippingSpeedCategory"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="客户名称" prop="name">
              <el-input v-model="form.name" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="地址1" prop="addressLine1">
              <el-input v-model="form.addressLine1" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="地址2" prop="addressLine2">
              <el-input v-model="form.addressLine2" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="区/市" prop="city">
              <el-input v-model="form.city" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="州" prop="stateProvinceCode">
              <el-input v-model="form.stateProvinceCode" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="邮编" prop="postalCode">
              <el-input v-model="form.postalCode" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="国家" prop="countryCode">
              <el-select v-model="form.countryCode" placeholder="请选择" size="medium">
                <el-option
                  :label="item.countryName"
                  :value="item.alpha2"
                  :key="item.alpha2"
                  v-for="item in country"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="电话" prop="phoneNumber">
              <el-input v-model="form.phoneNumber" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="3月内订单" prop="within3months">
              <el-radio v-model="form.within3months" :label="true">是</el-radio>
              <el-radio v-model="form.within3months" :label="false">否</el-radio>
            </el-form-item>
          </el-col>
          <el-col :span="10" :offset="2">
            <el-form-item label="镭雕编码" prop="productCode">
              <el-input v-model="form.productCode" size="medium"></el-input>
            </el-form-item>
            <el-form-item label="品质问题" prop="returnReasonId">
              <el-select v-model="form.returnReasonId" placeholder="请选择品质问题" size="medium">
                <el-option label="无" value></el-option>
                <el-option
                  v-for="item in returnReasonList"
                  :label="item.reason"
                  :value="item.returnReasonId"
                  :key="item.returnReasonId"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="发货原因" prop="fulfillmentReasonId">
              <el-select v-model="form.fulfillmentReasonId" placeholder="请选择发货原因" size="medium">
                <el-option label="无" value></el-option>
                <el-option
                  v-for="item in fulfllmentReasonList"
                  :label="item.fulfillmentReason"
                  :value="item.fulfillmentReasonId"
                  :key="item.fulfillmentReasonId"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="账号" prop="sellerId">
              <el-select
                v-model="form.sellerId"
                @change="getamazonAsinSku"
                placeholder="请选择账号"
                size="medium"
              >
                <el-option
                  v-for="item in findAccount"
                  :key="item.sellerId"
                  :label="item.sellerName"
                  :value="item.sellerId"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="国家" prop="findCountryId">
              <el-select
                v-model="form.findCountryId"
                multiple
                collapse-tags
                placeholder="请选择国家"
                size="medium"
                @change="getamazonAsinSku"
              >
                <allAddDelSelect
                  :selectForm="form"
                  :selectArray="findCountry"
                  selectFormId="findCountryId"
                  selectArrayId="countryId"
                  @selectAll="getamazonAsinSku"
                  @selectDel="getamazonAsinSku"
                  size="mini"
                ></allAddDelSelect>
                <el-option
                  v-for="item in findCountry"
                  :label="item.countryName"
                  :value="item.countryId"
                  :key="item.countryId"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="BU" prop="businessUnitId">
              <el-select v-model="form.businessUnitId" placeholder="请选择BU" size="medium">
                <el-option
                  v-for="item in findAllBusinessUnit"
                  :label="item.businessUnit"
                  :value="item.businessUnitId"
                  :key="item.businessUnitId"
                ></el-option>
              </el-select>
            </el-form-item>
            <div class="form-item-box" v-if="amazonAsinSku.length > 0">
              <el-form-item label-width="0" v-for="(item,index) in amazonAsinSku" :key="index">
                <div class="ASIN">ASIN:{{item.ASIN}}</div>
                <div class="quantity">QTY:{{item.QTY}}</div>
                <div v-for="(items,indexs) in item.data" :key="indexs" class="items">
                  <el-radio
                    v-model="amazonAsinSkuID[index]"
                    :label="items.sellerSku"
                    @change="amazonAsinSkuIds"
                  >{{items.sellerSku}}</el-radio>
                  <div class="inventory">库存：{{items.inventory}}</div>
                </div>
              </el-form-item>
            </div>
          </el-col>
        </el-row>
        <el-form-item>
          <el-button
            type="primary"
            icon="el-icon-circle-plus-outline"
            size="medium"
            @click="submitForm('form')"
          >创建发货</el-button>
        </el-form-item>
      </el-col>
    </el-row>
  </el-form>
</template>
<script>
import { formatDate } from "../../../common/js/date";
const ERR_OK = 200;
export default {
  data() {
    return {
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() < Date.now() - 8.64e7;
        }
      },
      textarea: "",
      form: {
        addressLine1: "",
        addressLine2: "",
        businessUnitId: "",
        city: "",
        countryCode: "",
        creater: this.$store.state.LoginedUser.userName,
        displayableOrderComment: "",
        displayableOrderDate: formatDate(new Date(), "yyyy-MM-dd"),
        displayableOrderId: "",
        fulfillmentOrderId: "",
        fulfillmentReasonId: "",
        name: "",
        orderItemList: [],
        phoneNumber: "",
        postalCode: "",
        productCode: "",
        returnReasonId: "",
        sellerId: "",
        shippingSpeedCategory: "Standard",
        stateProvinceCode: "",
        within3months: true,
        findCountryId: []
      },
      country: [],
      fulfllmentReasonList: [],
      returnReasonList: [],
      findCountry: [],
      findAllBusinessUnit: [],
      shippingSpeedCategory: [
        "Standard",
        "Expedited",
        "Expedited",
        "ScheduledDelivery"
      ],
      findAccount: [],
      getamazonAsinSkuItem: {},
      amazonAsinSku: [],
      amazonAsinSkuID: [],
      rules: {
        creater: [{ required: true, message: "请填写创建人", trigger: "blur" }],
        fulfillmentOrderId: [
          { required: true, message: "请输入Order ID", trigger: "blur" }
        ],
        name: [{ required: true, message: "请输入客户名称", trigger: "blur" }],
        addressLine1: [
          { required: true, message: "请输入地址1", trigger: "blur" }
        ],
        city: [{ required: true, message: "请输入区/市", trigger: "blur" }],
        postalCode: [
          { required: true, message: "请输入邮编", trigger: "blur" }
        ],
        countryCode: [
          { required: true, message: "请输选择国家", trigger: "change" }
        ],
        findCountryId: [
          { required: true, message: "请选择国家", trigger: "change" }
        ],
        sellerId: [{ required: true, message: "请选择账号", trigger: "change" }]
      },
      SkuAndWarehouse: []
    };
  },
  created() {
    this.getfulfllmentReasonList();
    this.getReturnReasonList();
    this.getFindCountry();
    this.getfindAllBusinessUnit();
    this.getfindAccount();
    this.getcountry();
  },
  mounted() {},
  methods: {
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.form.orderItemList.length == 0) {
            this.$message.warning("ASIN无效");
            return;
          } else if (
            this.SkuAndWarehouse.indexOf(false) === -1 ? false : true
          ) {
            this.$message.warning("可用库存不能小于发货数量");
            return;
          } else {
            this.$ajax({
              method: "post",
              url:
                "http://192.168.1.224:8081/fulfillmentOrder/createAmzFulfillmentOrder",
              data: this.form
            }).then(res => {
              if (res.data.code === ERR_OK) {
                this.$message.success("创建成功");
                this.$router.push("/shippingRefund/ship?success=ok");
              } else {
                this.$message.error(res.data.msg);
              }
            });
          }
        } else {
          return false;
        }
      });
    },
    //获取发货原因
    getfulfllmentReasonList() {
      this.$ajax(
        "http://192.168.1.224:8081/fulfllmentReason/getfulfllmentReasonList"
      ).then(res => {
        if (res.data.code === ERR_OK) {
          this.fulfllmentReasonList = res.data.data;
        }
      });
    },
    //品质原因
    getReturnReasonList() {
      this.$ajax(
        "http://192.168.1.224:8081/fulfillmentReturnReason/getReturnReasonList"
      ).then(res => {
        if (res.data.code === ERR_OK) {
          this.returnReasonList = res.data.data;
        }
      });
    },
    //获取仓库国家
    getFindCountry() {
      this.$ajax
        .post(
          this.URL_ROOT +
            this.REVIEWMONITORING_SERVICE +
            "/reviewSearch/findCountry"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findCountry = res.data.data.data;
          }
        });
    },
    //获取国家地址
    getcountry() {
      this.$ajax("http://192.168.1.224:8081/country/findAll").then(res => {
        if (res.data.code === ERR_OK) {
          this.country = res.data.data;
        }
      });
    },
    // 获取BU
    getfindAllBusinessUnit() {
      this.$ajax
        .get(
          this.URL_ROOT +
            this.ORDERANDOVERSEA_SERVICE +
            "/queryBasisData/findAllBusinessUnit"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findAllBusinessUnit = res.data.data;
          }
        });
    },
    //获取账号
    getfindAccount() {
      this.$ajax
        .post(
          this.URL_ROOT +
            this.REVIEWMONITORING_SERVICE +
            "/tracking/findAccount"
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.findAccount = res.data.data.data;
          }
        });
    },
    //国家赋值
    taskCountry() {
      let countryID;
      if (this.customizeGB(this.form.countryCode)) {
        countryID = "GB";
      } else if (this.customizeUS(this.form.countryCode)) {
        countryID = "US";
      } else {
        for (var i = 0; i < this.country.length; i++) {
          if (this.country[i].countryName === this.form.countryCode) {
            countryID = this.country[i].alpha2;
            break;
          } else {
            countryID = "";
          }
        }
      }
      this.form.countryCode = countryID;
    },
    //自定义选择国家
    customizeGB(id) {
      let data = ["UK", "Uk", "England", "United Kingdom"];
      return data.indexOf(id) === -1 ? false : true;
    },
    customizeUS(id) {
      let data = ["USA", "United States"];
      return data.indexOf(id) === -1 ? false : true;
    },
    //asin国家账号查找sku
    getamazonAsinSku() {
      if (!this.form.sellerId || this.form.findCountryId.length === 0) {
        this.$message.warning("请选择账号和国家");
        return;
      }
      let asin;
      for (let i in this.getamazonAsinSkuItem.asin) {
        if (this.getamazonAsinSkuItem.asin[i]) {
          asin = this.getamazonAsinSkuItem.asin[i].replace('"', "");
        }
        this.$ajax
          .get(
            "http://192.168.1.224:8081/amzInventorySaleableByCountry/getSkuByAsin?asin=" +
              asin +
              "&sellerId=" +
              this.form.sellerId +
              "&countryIdList=" +
              this.form.findCountryId.join()
          )
          .then(res => {
            if (res.data.code === ERR_OK && res.data.data.length > 0) {
              this.amazonAsinSku.push({
                data: res.data.data,
                ASIN: this.getamazonAsinSkuItem.asin[i].replace('"', ""),
                QTY: this.getamazonAsinSkuItem.aty[i].replace('"', ""),
                fulfillmentOrderId: this.getamazonAsinSkuItem.id
              });
            } else {
              this.$message.warning("没找到SKU");
            }
          });
      }
    },
    // 给form.orderItemList赋值
    amazonAsinSkuIds() {
      this.form.orderItemList = [];
      this.SkuAndWarehouse = [];
      this.amazonAsinSkuID.forEach((item, index) => {
        if (this.amazonAsinSku[index]) {
          this.form.orderItemList.push({
            sellerSku: item,
            asin: this.amazonAsinSku[index].ASIN,
            quantity: this.amazonAsinSku[index].QTY,
            fulfillmentOrderId: this.amazonAsinSku[index].fulfillmentOrderId
          });
          this.SkuAndWarehouse = this.SkuAndWarehouse.concat(
            this.amazonAsinSku[index].data.map(
              items =>
                items.sellerSku == item &&
                items.inventory >= this.amazonAsinSku[index].QTY
            )
          );
        }
      });
    }
  },
  watch: {
    textarea(val) {
      this.amazonAsinSku = [];
      let item = val.trim().split("\t");
      if (item.length >= 5) {
        item[4].split("\n").forEach((el, i) => {
          if (el) {
            if (i === 0) {
              this.form.name = el.replace('"', ""); //客户名称
            } else if (i === 1) {
              this.form.addressLine1 = el; //地址1
            } else if (i === 2) {
              this.form.addressLine2 = el; //地址2
            } else if (i === 3) {
              this.form.city = el; //区/市
            } else if (i === 4) {
              this.form.stateProvinceCode = el; //州
            } else if (i === 5) {
              this.form.postalCode = el; //编码
            } else if (i === 6) {
              this.form.countryCode = el.replace('"', ""); //国家
            }
          }
        });
        this.form.fulfillmentOrderId = item[0]; //订单号
        this.form.productCode = item[2]; //镭射编码
        let items = {
          id: item[0],
          asin: item[1].split(/[(\r\n)\r\n]+/),
          aty: item[3].split(/[(\r\n)\r\n]+/)
        };
        this.getamazonAsinSkuItem = items;
        this.getamazonAsinSku();
        this.taskCountry();
      } else {
        this.$message.warning("粘贴姿势不对，请重新复制");
      }
    },
    //默认选中sku
    amazonAsinSku(val) {
      if (val.length > 0) {
        val.forEach((el, i) => {
          el.data.forEach((item, is) => {
            if (is === 0) {
              this.amazonAsinSkuID[i] = item.sellerSku;
            }
          });
        });
        this.amazonAsinSkuIds();
      }
    }
  },
  components: {
    allAddDelSelect: resolve =>
      require(["components/common/allAddDelSelect.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.form-item-box {
  margin: 15px 0 15px 15px;
  padding: 10px 15px;
  border: 1px solid #d2d5da;
  background: #ebeef5;

  .ASIN, .quantity {
    display: inline-block;
  }

  .quantity {
    padding-left: 20px;
  }

  .el-radio {
    margin: 0 10px 10px 0;
  }

  .items {
    height: 30px;
    line-height: 30px;
  }

  .inventory {
    float: right;
    width: 80px;
  }
}

.el-form-item {
  margin-bottom: 5px;
}

.el-button {
  float: right;
}

.el-date-editor.el-input, .el-date-editor.el-input__inner, .el-input, .el-select {
  max-width: 180px;
}
</style>
<style>
.ship-amazon-warp .el-form-item__error {
  position: relative;
}
</style>
