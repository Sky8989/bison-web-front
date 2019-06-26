<template>
  <el-form ref="form" :rules="rules" :model="form" label-width="110px" class="ship-edayun-warp">
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
            <el-form-item label="发货仓库" prop="warehouseId">
              <el-select
                v-model="form.warehouseId"
                @change="edaYunAsinSkuIds"
                placeholder="请选择发货仓库"
                size="medium"
              >
                <el-option
                  v-for="item in allEdaYunWarehouse"
                  :label="item.warehouseName"
                  :value="item.warehouseId"
                  :key="item.warehouseId"
                ></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="发货物流" prop="courierAccountId">
              <el-select v-model="form.courierAccountId" placeholder="请选择发货物流" size="medium">
                <el-option
                  v-for="item in allCourier"
                  :label="item.courierAccountName"
                  :value="item.courierAccountId"
                  :key="item.courierAccountId"
                ></el-option>
              </el-select>
            </el-form-item>
            <div class="form-item-box" v-if="edaYunAsinSku.length > 0">
              <el-form-item label-width="0" v-for="(item,index) in edaYunAsinSku" :key="index">
                <div class="ASIN">ASIN:{{item.ASIN}}</div>
                <div class="quantity">QTY:{{item.QTY}}</div>
                <div v-for="items in item.data" :key="items.edaYunSkuId" class="items">
                  <el-radio
                    v-model="edaYunAsinSkuID[index]"
                    :label="items.edaYunSku"
                    @change="edaYunAsinSkuIds"
                  >{{items.edaYunSku}}</el-radio>
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
const ERR_OK = 200;
export default {
  data() {
    return {
      textarea: "",
      form: {
        addressLine1: "",
        addressLine2: "",
        businessUnitId: "",
        city: "",
        countryCode: "",
        courierAccountId: "",
        creater: this.$store.state.LoginedUser.userName,
        fulfillmentOrderId: "",
        fulfillmentReasonId: "",
        name: "",
        orderItemList: [],
        phoneNumber: "",
        postalCode: "",
        productCode: "",
        returnReasonId: "",
        stateProvinceCode: "",
        warehouseId: "",
        within3months: true
      },
      country: [],
      fulfllmentReasonList: [],
      returnReasonList: [],
      findAllBusinessUnit: [],
      allCourier: [],
      allEdaYunWarehouse: [],
      edaYunAsinSku: [],
      edaYunAsinSkuID: [],
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
        warehouseId: [
          { required: true, message: "请输选择发货仓库", trigger: "change" }
        ],
        courierAccountId: [
          { required: true, message: "请输选择发货物流", trigger: "change" }
        ]
      },
      SkuAndWarehouse: []
    };
  },
  created() {
    this.getcountry();
    this.getfulfllmentReasonList();
    this.getReturnReasonList();
    this.getfindAllBusinessUnit();
    this.getAllCourier();
    this.getAllEdaYunWarehouse();
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
                "http://192.168.1.224:8081/fulfillmentOrder/createFulfillmentOrder",
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
    //获取国家
    getcountry() {
      this.$ajax("http://192.168.1.224:8081/country/findAll").then(res => {
        if (res.data.code === ERR_OK) {
          this.country = res.data.data;
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
    // 获取物流
    getAllCourier() {
      this.$ajax
        .get("http://192.168.1.224:8081/edaYunWarehouse/getAllCourier")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.allCourier = res.data.data;
          }
        });
    },
    // 获取仓库
    getAllEdaYunWarehouse() {
      this.$ajax
        .get("http://192.168.1.224:8081/edaYunWarehouse/getAllEdaYunWarehouse")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.allEdaYunWarehouse = res.data.data;
          }
        });
    },
    //asin查找sku
    getedaYunAsinSku(val) {
      let asin;
      for (let i in val.asin) {
        if (val.asin[i]) {
          asin = val.asin[i].replace('"', "");
        }
        this.$ajax
          .get(
            "http://192.168.1.224:8081/edaYunAsinSku/selectEdaYunSkuByAsin?asin=" +
              asin
          )
          .then(res => {
            if (res.data.code === ERR_OK && res.data.data.length > 0) {
              let data = res.data.data;
              data.forEach(item => {
                item.inventory = "";
              });
              this.edaYunAsinSku.push({
                data: data,
                ASIN: val.asin[i].replace('"', ""),
                QTY: val.aty[i].replace('"', ""),
                fulfillmentOrderId: val.id
              });
            } else {
              this.$message.warning("没找到SKU");
            }
          });
      }
    },
    // 给form.orderItemList赋值
    edaYunAsinSkuIds() {
      this.form.orderItemList = [];
      this.SkuAndWarehouse = [];
      this.edaYunAsinSkuID.forEach((item, index) => {
        if (this.edaYunAsinSku[index]) {
          this.form.orderItemList.push({
            sellerSku: item,
            asin: this.edaYunAsinSku[index].ASIN,
            quantity: this.edaYunAsinSku[index].QTY,
            fulfillmentOrderId: this.edaYunAsinSku[index].fulfillmentOrderId
          });
          this.getqueryInventoryBySkuAndWarehouseId(
            item,
            this.edaYunAsinSku[index].QTY,
            index
          );
        }
      });
    },
    //sku查看仓库库存
    getqueryInventoryBySkuAndWarehouseId(sku, QTY, index) {
      this.$ajax
        .get(
          "http://192.168.1.224:8081/fulfillmentOrder/queryInventoryBySkuAndWarehouseId?sku=" +
            sku +
            "&warehouseId=" +
            this.form.warehouseId
        )
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.edaYunAsinSku[index].data.forEach(items => {
              if (items.edaYunSku === sku) {
                items.inventory = res.data.data;
              }
            });
            this.SkuAndWarehouse.push(res.data.data < QTY ? false : true);
          }
        });
    }
  },
  watch: {
    textarea(val) {
      this.edaYunAsinSku = [];
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
        this.getedaYunAsinSku(items);
        this.taskCountry();
      } else {
        this.$message.warning("粘贴姿势不对，请重新复制");
      }
    },
    //默认选中sku
    edaYunAsinSku(val) {
      if (this.edaYunAsinSku.length > 0) {
        val.forEach((el, i) => {
          el.data.forEach((item, is) => {
            if (is === 0) {
              this.edaYunAsinSkuID[i] = item.edaYunSku;
            }
          });
        });
        this.edaYunAsinSkuIds();
      }
    },
    //国家变动自定义给仓库物流绑定值
    "form.countryCode"(val) {
      switch (val) {
        case "GB":
          this.form.warehouseId = 51;
          this.form.courierAccountId = 100;
          break;
        case "US":
          this.form.warehouseId = 7;
          this.form.courierAccountId = 80;
          break;
        case "DE":
          this.form.warehouseId = 34;
          this.form.courierAccountId = 105;
          break;
        case "FR":
          this.form.warehouseId = 34;
          this.form.courierAccountId = 102;
          break;
        case "IT":
          this.form.warehouseId = 34;
          this.form.courierAccountId = 102;
          break;
        case "ES":
          this.form.warehouseId = 34;
          this.form.courierAccountId = 102;
          break;
        default:
          this.form.warehouseId = "";
          this.form.courierAccountId = "";
      }
    }
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
</style>
<style>
.ship-edayun-warp .el-form-item__error {
  position: relative;
}
</style>
