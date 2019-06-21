<template>
  <div class="productCode-dataSave-wrap">
    <el-button type="warning" icon="el-icon-setting" @click="dataSave">数据列设置</el-button>
    <el-dialog title="数据列设置" :visible.sync="dialogTableVisible" width="500px">
      <el-checkbox
        v-model="findDataSave.productImgUrl"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productImgUrl !== 3"
      >图片</el-checkbox>
      <el-checkbox
        v-model="findDataSave.businessUnit"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.businessUnit !== 3"
      >BU</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productCategory"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productCategory !== 3"
      >产品系列</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productModelNumber"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productModelNumber !== 3"
      >产品型号</el-checkbox>
      <el-checkbox
        v-model="findDataSave.upc"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.upc !== 3"
      >UPC</el-checkbox>
      <el-checkbox
        v-model="findDataSave.sku"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.sku !== 3"
      >SKU</el-checkbox>
      <el-checkbox
        v-model="findDataSave.fnsku"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.fnsku !== 3"
      >FNSKU</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productSupplierProductionCosts"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productSupplierProductionCosts !== 3"
      >采购成本价</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productLong"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productLong !== 3"
      >长</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productWidth"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productWidth !== 3"
      >宽</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productHeight"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productHeight !== 3"
      >高</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productVolume"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productVolume !== 3"
      >体积</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productGrossweight"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productGrossweight !== 3"
      >毛重</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productNetweight"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productNetweight !== 3"
      >净重</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productMaterial"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productMaterial !== 3"
      >材质</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productCertification"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productCertification !== 3"
      >认证</el-checkbox>

      <el-checkbox
        v-model="findDataSave.productPackageContains"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productPackageContains !== 3"
      >包装内含物</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productDescriptionChs"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productDescriptionChs !== 3"
      >描述(中)</el-checkbox>
      <el-checkbox
        v-model="findDataSave.productDescriptionEn"
        :true-label="1"
        :false-label="2"
        v-if="findDataSave.productDescriptionEn !== 3"
      >描述(英)</el-checkbox>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="_findDataSave()">保 存</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
const ERR_OK = 200;
export default {
  props: ["dataColum"],
  data() {
    return {
      dialogTableVisible: false,
      findDataSave: {}
    };
  },
  methods: {
    _findDataSave() {
        this.findDataSave.userId = this.$store.state.LoginedUser.userId
      this.$ajax({
          method: "post",
          url:this.URL_ROOT+this.CODINGINFORMATIONMANAGEMENT_SERVICE+'/userDataColumn/findData/' + this.$store.state.LoginedUser.userId,
          data: this.findDataSave
      }).then(res => {
          if(res.data.code === ERR_OK){
              this.$emit('update', res.data.data)
              this.dialogTableVisible = false;
          }
      })
    },
    dataSave() {
      this.dialogTableVisible = true;
      this.findDataSave = JSON.parse(JSON.stringify(this.dataColum));
      console.log(this.findDataSave)
    }
  }
};
</script>
<style lang="stylus">
.productCode-dataSave-wrap {
  display: inline-block;
   .el-dialog__body{
       padding: 10px;
   }
  .el-checkbox {
    margin: 8px;
    width: 139px;
  }
}
</style>
