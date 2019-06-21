<template>

  <div name="remarkDialog">
    <el-button type="primary" size="mini"  @click="openDialog" >备注</el-button>

    <el-dialog
      :title="title"
      :visible.sync="remarkDialog"
      width="20%"
      :before-close="remarkDialogClose" >

      <el-form :model="remarkForm"  label-width="100px" class="demo-dynamic" style="width: 80%">

        <input v-model="remarkForm.productId" hidden/>

        <el-form-item :label="title">
          <el-input type="textarea"  :rows="2"  v-model="remarkForm.remark" controls-position="right"
                    :step="1"  :max="10000"
                    size="mini"></el-input>
        </el-form-item>
      </el-form>


      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="addRemark" size="mini">添 加</el-button>
      </div>
    </el-dialog>
  </div>

</template>

<script>
    export default {
      name: "RemarkDialog",
      props: {
        title: '',        //对话框名称
        id: '',         //需要修改的id
        search:{
          type: Function
        }

      },
      data(){
          return{
            remarkTitle:'',
            remarkDialog:false,
            remarkForm:{
              productId:0,
              remark:''
            }

        }
      },
      methods:{
        openDialog(){
          this.remarkDialog = true;
          this.remarkForm.productId = this.id
          this.remarkTitle = this.title

          console.log("id")
          console.log(this.id)

          this.checkRemark();

        },
        checkRemark(){

          if(this.title != ''){
            var url =this.URL_ROOT + this.PREFIX_INVENTORY +"/inventoryByModelNumberHandler/"
            if(this.title == '运营备注'){
              url += 'getSalesRemarkByProductId/';
            }
            else if(this.title == '采购备注'){
              url += 'getPurchaseRemarkByProductId/';
            }

            url += this.remarkForm.productId

            this.$ajax.get(url,{}).then(res => {
              if(res.data.code == 200){

                this.remarkForm.remark = res.data.data
                //调用父类方法刷新
                this.search()
              }
            })

          }

        },
        remarkDialogClose(){
          this.remarkForm = {
            id:0,
            remark:''}

          this.remarkDialog = false;

        },
        addRemark(){
          //添加
          if(this.title != ''){

            var url =this.URL_ROOT + this.PREFIX_INVENTORY +"/inventoryByModelNumberHandler/addRemark"
            var data = {
              productId:this.remarkForm.productId,
              salesRemark:'',
              purchaseRemark:'',
            }
            if(this.title == '运营备注'){
              data.salesRemark = this.remarkForm.remark
            }
            else if(this.title == '采购备注'){
              data.purchaseRemark = this.remarkForm.remark
            }

            this.$ajax({
              method:'post',
              url:url,
              data:data
            }).then(res => {
              if(res.data.code == 200){
                this.$message.success( this.title+ res.data.msg)

              }
              else if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }

              //调用父类方法刷新
               this.search()

            })
          }

          this.remarkDialog = false;
          this.remarkDialogClose()

        }

      }
    }
</script>

<style scoped>

</style>
