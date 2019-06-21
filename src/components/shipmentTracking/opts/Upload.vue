<template>
    <div class="xlsxtable"><vue-xlsx-table @on-select-file="handleSelectedFile" class="el-icon-upload2">上传快递单号</vue-xlsx-table></div>
</template>
<script>
const ERR_OK = 200;
  export default {
    methods: {
      handleSelectedFile (convertedData) {
        let data = convertedData.body.map(item => {
          return {'trackingId':item.trackingId,'shipmentId':item.ShipmentID,'trackingType':item.trackingType}
        })
        this.$ajax({
          method: 'post',
          url:this.URL_ROOT + this.ORDERANDOVERSEA_SERVICE +'/importShipment/importTracking',
          data: {
            param: data
          }
        }).then(res => {
          if(res.data.code === ERR_OK){
            this.$emit('uploadXlsx')
            this.$message.success('上传成功');
          }
        })
     },
    }, 
  }
</script>
<style lang="stylus" scoped>
.xlsxtable{
    display inline-block
    padding: 0px 10px;
    background: #20a0ff;
    border-radius: 5px;
    .el-icon-upload2{
      background: #20a0ff;
      color #ffffff
    }
}
</style>

