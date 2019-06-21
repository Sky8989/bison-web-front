<template>
  <el-form :model="ruleForm" ref="ruleForm" :rules="rules" label-width="80px" class="orderNumber-searchfor-warp">
    <el-form-item label="国家" prop="countryIds">
      <el-select v-model="ruleForm.countryIds" multiple collapse-tags placeholder="请选择国家">
        <div class="customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.findAllCountry,'countryIds')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('countryIds')">全部删除</el-button>
        </div>
        <div class="customize-select-height"></div>
        <el-option
          v-for="item in arrData.findAllCountry"
          :key="item.countryId"
          :label="item.countryName" 
          :value="item.countryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="品牌" prop="businessUnitId">
      <el-select v-model="ruleForm.businessUnitId" multiple collapse-tags @change="_getProductCategoryAsinProductByParam" placeholder="请选择品牌">
        <div class="customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.findAllBusinessUnit,'businessUnitId')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('businessUnitId')">全部删除</el-button>
        </div>
        <div class="customize-select-height"></div>
        <el-option
          v-for="item in arrData.findAllBusinessUnit"
          :key="item.businessUnitId"
          :label="item.businessUnit"
          :value="item.businessUnitId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品系列" prop="productCategoryId">
      <el-select v-model="ruleForm.productCategoryId" @change="_getAsinProductByParam" multiple collapse-tags placeholder="请选择产品系列">
        <div class="customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.productCategory,'productCategoryId')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('productCategoryId')">全部删除</el-button>
        </div>
        <div class="customize-select-height"></div>
        <el-option
          v-for="item in arrData.productCategory"
          :key="item.productCategoryId"
          :label="item.productCategory"
          :value="item.productCategoryId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="产品型号" prop="productIds">
      <el-select v-model="ruleForm.productIds" filterable multiple collapse-tags @change="_getAsinByParam" placeholder="请选择产品型号">
        <div class="customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.productByParam,'productIds')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('productIds')">全部删除</el-button>
        </div>
        <div class="customize-select-height"></div>
        <el-option
          v-for="item in arrData.productByParam"
          :key="item.productId"
          :label="item.productModelNumber"
          :value="item.productId"
        ></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="ASIN" prop="asinIds">
      <el-select
        v-model="ruleForm.asinIds" filterable multiple collapse-tags @change="_getProductByParam"
      >
        <div class="customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.asinByParam,'asinIds')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('asinIds')">全部删除</el-button>
        </div>
        <div class="customize-select-height"></div>
        <el-option
          v-for="item in arrData.asinByParam"
          :key="item.asinId"
          :label="item.asin"
          :value="item.asinId"
        ></el-option>
      </el-select> 
    </el-form-item>
    <el-form-item label-width="20px">
      <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close">清空</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    var validatePass = (rule, value, callback) => {
        if (this.ruleForm.asinIds.length === 0 && this.ruleForm.productIds.length === 0) {
          callback(new Error('请选择产品型号或ASIN'));
        } else {
          if (this.ruleForm.checkPass !== '') {
            this.$refs.ruleForm.validateField('checkPass');
          }
          callback();
        }
      };
    return {
      ruleForm: {
        asinIds: [],
        countryIds: [],
        productIds: [],
        businessUnitId:[],
        productCategoryId:[],
      },
      arrData: {
        findAllBusinessUnit: [],
        findAllCountry:[],
        allCountry: [],
        productCategory:[],
        productByParam:[],
        asinByParam:[]
      },
      rules: {
          countryIds: [
            { required: true, message: '请选择国家', trigger: 'change' }
          ],
          productIds: [
            { validator: validatePass, trigger: 'change' }
          ],
          asinIds: [
            { validator: validatePass, trigger: 'change' }
          ],
      }
    };
  },
  created() {
    this._findAllBusinessUnit();
    this._findAllCountry();
    this._getProductByParam();
    this._getAsinByParam()
  },
  methods: {
    // 获取国家
    _findAllCountry() {
      this.$ajax
        .get(this.URL_ROOT+this.ORDERANDOVERSEA_SERVICE + "/queryBasisData/findAllCountry")
        .then(res => {
          if (res.data.code === ERR_OK) {
            this.arrData.findAllCountry = res.data.data;
          }
        });
    },
    // 获取品牌
    _findAllBusinessUnit(){
      this.$ajax.get(this.URL_ROOT+this.ORDERANDOVERSEA_SERVICE +'/queryBasisData/findAllBusinessUnit').then(res => {
        if(res.data.code === ERR_OK){
          this.arrData.findAllBusinessUnit = res.data.data
        }
      })
    },
    // 获取产品系列
    _getProductCategoryByBuIds(){
      this.$ajax({
        method: 'post',
        url: this.URL_ROOT+this.ORDERANDOVERSEA_SERVICE +'/queryBasisData/getProductCategoryByBuIds',
        data: {businessUnitIdStr:this.ruleForm.businessUnitId.join()}
      }).then(res => {
        if(res.data.code === ERR_OK){
          this.arrData.productCategory = res.data.data
        }
      })
    },
    // 获取产品型号
    _getProductByParam(){
      this.$ajax({
        method: 'post',
        url: this.URL_ROOT+this.ORDERANDOVERSEA_SERVICE +'/queryBasisData/getProductByParam',
        data:{
          asinIdStr: this.ruleForm.asinIds.join(),
          businessUnitIdStr: this.ruleForm.businessUnitId.join(),
          productCategoryIdStr: this.ruleForm.productCategoryId.join(),
        }
      }).then(res => {
        if(res.data.code === ERR_OK){
          if(this.ruleForm.asinIds && this.ruleForm.asinIds.length>0){
              let temProductId = [];
              for(let item of res.data.data){
                temProductId.push(item.productId);
              }
              this.ruleForm.productIds = temProductId;
          }else{
            this.arrData.productByParam = res.data.data;
          }
        }
      })
    },
    // 获取ASIN
    _getAsinByParam(){
      this.$ajax({
        method: 'post',
        url: this.URL_ROOT+this.ORDERANDOVERSEA_SERVICE +'/queryBasisData/getAsinByParam',
        data:{
          productIdStr: this.ruleForm.productIds.join(),
          businessUnitIdStr: this.ruleForm.businessUnitId.join(),
          productCategoryIdStr: this.ruleForm.productCategoryId.join(),
        }
      }).then(res => {
        if(res.data.code === ERR_OK){
          if(this.ruleForm.productIds && this.ruleForm.productIds.length>0){
            let asinIds = [];
              for(let item of res.data.data){
                asinIds.push(item.asinId);
              }
              this.ruleForm.asinIds = asinIds;
          }else{
            this.arrData.asinByParam = res.data.data
          }
        }
      })
    },
    // 选择系列更新型号和ASIN
    _getAsinProductByParam(){
      this.ruleForm.asinIds = []
      this.ruleForm.productIds = []
      this._getProductByParam()
      this._getAsinByParam()
    },
    // 选择品牌更新系列型号和ASIN
    _getProductCategoryAsinProductByParam(){
      this.ruleForm.productCategoryId = []
      this._getProductCategoryByBuIds()
      this._getAsinProductByParam()
    },
    // 全部选中
    selectAll(val, id) {
      let allValues = [];
      for (let i in val) {
        if (id == "countryIds") {
          allValues.push(val[i].countryId);
        } else if (id == "businessUnitId") {
          allValues.push(val[i].businessUnitId);
        } else if (id == "productCategoryId") {
          allValues.push(val[i].productCategoryId);
        } else if (id == "productIds") {
          allValues.push(val[i].productId);
        } else if (id == "asinIds") {
          allValues.push(val[i].asinId);
        }
      }
      for (var i in this.ruleForm) {
        if (i == id) {
          this.ruleForm[i] = allValues;
        }
      }
      this.addAjax(id);
    },
    // 全部删除
    selectDel(id) {
      for (var i in this.ruleForm) {
        if (i == id) {
          this.ruleForm[i] = [];
        }
      }
      this.addAjax(id);
    },
    addAjax(id) {
      if (id == "businessUnitId") {
        this._getProductCategoryAsinProductByParam();
      } else if (id == "productCategoryId") {
        this._getAsinProductByParam();
      } else if(id == 'productIds'){
        this.ruleForm.asinIds = []
        this._getAsinByParam()
      }else if(id == 'asinIds'){
        this.ruleForm.productIds = []
        this._getProductByParam()
      }
    },
    // 提交查询
    _submitForm() {
      this.$refs['ruleForm'].validate((valid) => {
          if (valid) {
            this.$parent.formData = this.ruleForm
          } else {
            return false;
          }
        });
    }, 
    resetForm(formName) {
      this.$refs[formName].resetFields();
      this.arrData.productCategory = []
    }
  }
}; 
</script>
<style lang="stylus" scoped>
.customize-select-btn-group {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  padding: 10px;
  background: #ffffff;
  z-index: 9;

  .el-button {
    margin: 0 3px;
  }
}

.customize-select-height {
  height: 48px;
}

.el-form-item {
  display: inline-block;
}
</style>