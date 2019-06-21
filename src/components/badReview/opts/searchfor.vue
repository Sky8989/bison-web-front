<template>
  <el-form ref="ruleForm" :model="ruleForm" label-width="80px">
    <el-form-item label="BU" prop="findBuId" label-width="50px">
      <el-select
        v-model="ruleForm.findBuId"
        multiple
        collapse-tags
        @change="getFindByBu"
        placeholder="请选择UB"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findBu"
          selectFormId="findBuId"
          selectArrayId="businessUnitId"
          size="mini"
          @selectAll="getFindByBu"
          @selectDel="getFindByBu"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findBu"
          :key="item.businessUnitId"
          :label="item.businessUnit"
          :value="item.businessUnitId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品系列" prop="findByBuId">
      <el-select
        v-model="ruleForm.findByBuId"
        multiple
        collapse-tags
        @change="getFindByCategory"
        placeholder="请选择产品系列"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findByBu"
          selectFormId="findByBuId"
          selectArrayId="productCategoryId"
          size="mini"
          @selectAll="getFindByCategory"
          @selectDel="getFindByCategory"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findByBu"
          :key="item.productCategoryId"
          :label="item.productCategory"
          :value="item.productCategoryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品型号" prop="productIds">
      <el-select
        v-model="ruleForm.productIds"
        multiple
        collapse-tags
        @change="getFindAsin"
        placeholder="请选择产品型号"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findByCategory"
          selectFormId="productIds"
          selectArrayId="productId"
          size="mini"
          @selectAll="getFindAsin"
          @selectDel="getFindAsin"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findByCategory"
          :key="item.productId"
          :label="item.productModelNumber"
          :value="item.productId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="ASIN" prop="asinIds" label-width="50px">
      <el-select
        v-model="ruleForm.asinIds"
        multiple
        collapse-tags
        @change="getFindAsin"
        placeholder="请选择ASIN"
      >
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findAsin"
          selectFormId="asinIds"
          selectArrayId="asinId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findAsin"
          :key="item.asinId"
          :label="item.asin"
          :value="item.asinId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="国家" prop="countryIds" label-width="50px">
      <el-select v-model="ruleForm.countryIds" multiple collapse-tags placeholder="请选择国家">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findCountry"
          selectFormId="countryIds"
          selectArrayId="countryId"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="item in arrData.findCountry"
          :key="item.countryId"
          :label="item.countryName"
          :value="item.countryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="负责人" prop="chargeMans" label-width="65px">
      <el-select v-model="ruleForm.chargeMans" multiple collapse-tags placeholder="请选择国家">
        <allAddDelSelect
          :selectForm="ruleForm"
          :selectArray="arrData.findChargeMan"
          selectFormId="chargeMans"
          size="mini"
        ></allAddDelSelect>
        <el-option
          v-for="(item,index) in arrData.findChargeMan"
          :key="index"
          :label="item"
          :value="item"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label-width="0">
      <el-button type="primary" @click="submitForm('ruleForm')" icon="el-icon-search">搜索</el-button>
      <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close">清空</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      ruleForm: {
        findBuId: [],
        findByBuId: [],
        productIds: [],
        asinIds: [],
        countryIds: [],
        chargeMans: []
      },
      arrData: {
        findBu: [],
        findByBu: [],
        findByCategory: [],
        findAsin: [],
        findCountry: [],
        findChargeMan: []
      }
    };
  },
  created() {
    this.getFindBu();
    this.getFindCountry();
    this.getFindChargeMan();
  },
  methods: {
    //获取BU
    getFindBu() {
      this.$ajax
        .post(this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findBu")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findBu = res.data.data.data;
          }
        });
    },
    //获取系列
    getFindByBu() {
      this.arrData.findByCategory = [];
      this.ruleForm.productIds = [];
      this.arrData.findAsin = [];
      this.ruleForm.asinIds = [];
      if (this.ruleForm.findBuId.length !== 0) {
        this.$ajax
          .post(
            this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findByBu?bus=" +
              this.ruleForm.findBuId.join()
          )
          .then(res => {
            if (res.data.code === ERR_OK) {
              this.arrData.findByBu = res.data.data.data;
              this.ruleForm.findByBuId = this.ruleForm.findByBuId.filter(
                item =>
                  !this.arrData.findByBu.every(
                    ele => ele.productCategoryId !== item
                  )
              );
            }
          });
      } else {
        this.arrData.findByBu = [];
        this.ruleForm.findByBuId = [];
      }
    },
    //获取型号
    getFindByCategory() {
      this.arrData.findAsin = [];
      this.ruleForm.asinIds = [];
      if (this.ruleForm.findByBuId.length !== 0) {
        this.$ajax
          .post(
            this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findByCategory?categorys=" +
              this.ruleForm.findByBuId.join()
          )
          .then(res => {
            if (res.data.code === ERR_OK) {
              this.arrData.findByCategory = res.data.data.data;
              this.ruleForm.productIds = this.ruleForm.productIds.filter(
                item =>
                  !this.arrData.findByCategory.every(
                    ele => ele.productId !== item
                  )
              );
            }
          });
      } else {
        this.arrData.findByCategory = [];
        this.ruleForm.productIds = [];
      }
    },
    //获取asin
    getFindAsin() {
      if (this.ruleForm.productIds.length !== 0) {
        this.$ajax
          .post(
            this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findAsin?productIds=" +
              this.ruleForm.productIds.join()
          )
          .then(res => {
            if (res.data.code === ERR_OK) {
              this.arrData.findAsin = res.data.data.data;
              this.ruleForm.asinIds = this.ruleForm.asinIds.filter(
                item => !this.arrData.findAsin.every(ele => ele.asinId !== item)
              );
            }
          });
      } else {
        this.arrData.findAsin = [];
        this.ruleForm.asinIds = [];
      }
    },
    //获取国家
    getFindCountry() {
      this.$ajax
        .post(this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/reviewSearch/findCountry")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findCountry = res.data.data.data;
          }
        });
    },
    // 获取负责人
    getFindChargeMan() {
      this.$ajax
        .get(this.URL_ROOT + this.REVIEWMONITORING_SERVICE + "/tracking/findChargeMan")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findChargeMan = res.data.data.data;
            this.ruleForm.chargeMans = this.ruleForm.chargeMans.filter(
              item => !this.arrData.findChargeMan.every(ele => ele !== item)
            );
          }
        });
    },
    submitForm(formName) {
      this.$emit("submitForm", this.ruleForm);
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  },
  components: {
    allAddDelSelect: resolve =>
      require(["components/common/allAddDelSelect.vue"], resolve)
  }
};
</script>
<style lang="stylus" scoped>
.el-form-item {
  display: inline-block;
}

.el-button {
  margin-left: 10px;
}
</style>