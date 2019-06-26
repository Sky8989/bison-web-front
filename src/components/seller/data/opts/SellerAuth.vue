<template>
 <div name="sellerAuth">
    账号授权

   <!--MWS接口设置-->
   <el-dialog
     title="MWS接口设置"
     :visible.sync="mwsInterfaceDialog"
     width="70%"
     :before-close="mwsInterfaceDialogClose" >

     <el-form :model="mwsInterfaceForm"  label-width="180px" class="demo-dynamic" style="width: 80%">

       <input v-model="mwsInterfaceForm.mwsId" hidden/>

       <el-form-item label="应用名称">
         <el-input v-model="mwsInterfaceForm.mwsAppName" />
       </el-form-item>

       <el-form-item label="DeveloperID">
         <el-input v-model="mwsInterfaceForm.developerId" />
       </el-form-item>

       <el-form-item label="亚马逊卖家标志 Merchant Token">
         <el-input v-model="mwsInterfaceForm.amzSellerId" />
       </el-form-item>

       <el-form-item label="MWS Auth Token">
         <el-input v-model="mwsInterfaceForm.mwsAuthToken" />
       </el-form-item>


       <el-form-item label="Secret Key">
         <el-input v-model="mwsInterfaceForm.secretKey" />
       </el-form-item>

       <el-form-item label="AWS Access Key ID">
         <el-input v-model="mwsInterfaceForm.accessKeyId" />
       </el-form-item>

     </el-form>
     <div slot="footer" class="dialog-footer">
       <el-link type="primary" >如何获得</el-link>
       <el-button type="primary" @click="saveSellerMws" size="mini">保存</el-button>
       <el-button type="primary"  size="mini" @click="mwsInterfaceDialog = false">取消</el-button>
     </div>

   </el-dialog>

   <!--MWS接口授权-->
   <el-dialog
     title="MWS接口授权"
     :visible.sync="mwsAuthDialog"
     width="70%"
     :before-close="mwsAuthDialogClose" >

     <el-form :model="mwsAuthForm"  label-width="150px" class="demo-dynamic" style="width: 80%">

       <input v-model="mwsAuthForm.mwsId" hidden/>


       <el-form-item label="应用名称">
         <el-input v-model="mwsAuthForm.mwsAppName" />
       </el-form-item>

       <el-form-item label="DeveloperID">
         <el-input v-model="mwsAuthForm.developerId" />
       </el-form-item>

       <el-form-item label="亚马逊卖家标志 Merchant Token">
         <el-input v-model="mwsAuthForm.amzSellerId" />
       </el-form-item>

       <el-form-item label="MWS Auth Token">
         <el-input v-model="mwsAuthForm.mwsAuthToken" />
       </el-form-item>



     </el-form>
     <div slot="footer" class="dialog-footer">
       <el-link type="primary" >如何获得</el-link>
       <el-button type="primary" @click="saveMwsAuth" size="mini">保存</el-button>
       <el-button type="primary" @click="mwsAuthDialog = false" size="mini">取消</el-button>
     </div>

   </el-dialog>

   <!--MWS子账号设置-->
   <el-dialog
     title="子账号设置"
     :visible.sync="subAccountDialog"
     width="70%"
     :before-close="subAccountDialogClose" >

     <el-form :model="subAccountForm"  label-width="150px" class="demo-dynamic" style="width: 80%">

       <input v-model="subAccountForm.accountId" hidden/>

       <el-form-item label="账号名">
         <el-input v-model="subAccountForm.accountName" />
       </el-form-item>

       <el-form-item label="密码">
         <el-input v-model="subAccountForm.accountPassword" />
       </el-form-item>

       <el-form-item label="二部验证源码">
         <el-input v-model="subAccountForm.twoStepCode" />
       </el-form-item>

       <el-form-item label="服务器">
         <el-input v-model="subAccountForm.remoteServer" />  <el-button type="primary" size="mini" @click="defaultPost">高级</el-button>
       </el-form-item>


       <el-form-item label="控制端口">
         <el-input v-model="subAccountForm.remoteBrowserPort" />
       </el-form-item>

       <el-form-item label="传输端口">
         <el-input v-model="subAccountForm.remoteFilePort" />
       </el-form-item>

     </el-form>

     <div slot="footer" class="dialog-footer">
        <el-link type="primary" >如何获得</el-link>
       <el-button type="primary" @click="saveSubAccount" size="mini">保存</el-button>
       <el-button type="primary"  size="mini" @click=" subAccountDialog = false ">取消</el-button>
     </div>

   </el-dialog>


   <el-table  :data="sellerVOList">
     <el-table-column prop="amzRegionCode" label="区域" >

     </el-table-column>
     <el-table-column prop="mwsStatus" label="MWS接口设置" >
       <template  slot-scope="scope">

         <div v-if="scope.row.mwsStatus == 0 && brandId != '' ">
          <el-button  type="danger" @click="mwsInterface(scope.row)" size="mini">未设置</el-button>
         </div>
         <div v-if="scope.row.mwsStatus == 1 && brandId != ''">
            <el-button type="success" @click="mwsInterface(scope.row)" size="mini">已设置</el-button>
         </div>
       </template>
     </el-table-column>
     <el-table-column prop="easybisonMwsStatus" label="MWS接口授权"  >
       <template  slot-scope="scope">

         <div v-if="scope.row.easybisonMwsStatus == 0 && brandId != ''">
           <el-button type="danger"  @click="mwsAuth(scope.row)" size="mini">未设置</el-button>
         </div>
         <div v-if="scope.row.easybisonMwsStatus == 1 && brandId != ''">
            <el-button type="success" @click="mwsAuth(scope.row)" size="mini">已设置</el-button>
         </div>

       </template>
     </el-table-column>
     <el-table-column prop="subAccountStatus" label="子账号设置"  >
       <template  slot-scope="scope">
         <div v-if="scope.row.subAccountStatus == 0 && brandId != ''">
           <el-button  type="danger" @click="subAccount(scope.row)" size="mini">未设置</el-button>
         </div>
         <div v-if="scope.row.subAccountStatus == 1 && brandId != ''">
           <el-button type="success" @click="subAccount(scope.row)" size="mini">已设置</el-button>
         </div>
       </template>
     </el-table-column>
   </el-table>

 </div>
</template>

<script>
    export default {
        name: "sellerAuth",
        props: {
          parentBrandId:
            {
              type:Number,
              required:true
            },
        },
     data(){
          return {
            sellerVOList:[
              {
                amzRegionCode:'',
                mwsStatus:'',
                easybisonMwsStatus:'',
                subAccountStatus:'',
              }
            ],

            mwsInterfaceDialog:false, // MWS接口窗口
            mwsInterfaceForm: {       //MWS接口设置
                mwsId:'',
                mwsAppName:'',
                developerId:'',
                sellerId:'',
                amzSellerId:'',
                mwsAuthToken:'',
                secretKey:'',
                accessKeyId:'',
              },

            mwsAuthDialog:false,      //MWS接口窗口
            mwsAuthForm: {            //MWS接口授权
              mwsId:'',
              mwsAppName:'',
              developerId:'',
              amzSellerId:'',
              mwsAuthToken:'',
            },

            subAccountDialog:false,   //子账号窗口
            subAccountForm: {
              accountId:0,
              accountName:'',
              accountPassword:'',
              twoStepCode:'',
              remoteServer:'',
              remoteBrowserPort:'',
              remoteFilePort:'',
            },

            form:{
              sellerId:'',
              regionId:'',
            },
            brandId:'', //存父组件传来的 parentBrandId

          }
     },
      methods:{
          init(){
            console.log("init")
          },
        mwsInterfaceDialogClose(){
          this.mwsInterfaceDialog = false;

          //清空
          this.mwsInterfaceForm =  {       //MWS接口设置
            mwsId:'',
              mwsAppName:'',
              developerId:'',
              amzSellerId:'',
              mwsAuthToken:'',
              secretKey:'',
              accessKeyId:'',
          }
        },
        saveSellerMws(){
          //保存MWS接口设置
          this.mwsInterfaceDialog = false;
          console.log(this.form)

          var url = this.HOST + "/sellerAuthHandler/saveSellerMws"
          this.$ajax({
            method: 'post',
            url : url,
            data:this.mwsInterfaceForm
            }

          ).then(res => {
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              this.search(this.brandId)

            }
            if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          }).catch(err => {
            console.log(err)
          })
        },

        mwsAuthDialogClose(){
          this.mwsAuthDialog = false;

          this.mwsAuthForm =  {            //MWS接口授权
              mwsId:'',
              mwsAppName:'',
              developerId:'',
              amzSellerId:'',
              mwsAuthToken:''
          }
        },
        saveMwsAuth(){
          this.mwsAuthDialog = false;

          var url = this.HOST + "/sellerAuthHandler/saveSellerMwsAuth"
          this.$ajax({
              method: 'post',
              url : url,
              data:this.mwsAuthForm
            }

          ).then(res => {
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              this.search(this.brandId)
            }
            if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          }).catch(err => {
            console.log(err)
          })
        },
        subAccountDialogClose(){
          this.subAccountDialog = false;

          this.subAccountForm = {
              accountId:0,
              accountName:'',
              accountPassword:'',
              twoStepCode:'',
              remoteServer:'',
              remoteBrowserPort:'',
              remoteFilePort:'',
          }
        },
        saveSubAccount(){
          this.subAccountDialog = false;
          console.log(this.form)
          var url = this.HOST + "/sellerAuthHandler/saveSellerAccount"
          this.$ajax({
              method: 'post',
              url : url,
              data:this.subAccountForm
            }

          ).then(res => {
            if(res.data.code == 200){
              this.$message.success(res.data.msg)
              this.search(this.brandId)
            }
            if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          }).catch(err => {
            console.log(err)
          })
        },
        search(id){
          console.log('search')

          //赋值
          this.brandId = id;

          var brandId = id;
          console.log("=== " + brandId)
          if(brandId != null && brandId != '' && brandId != 0){
            var url = this.HOST + "/sellerAuthHandler/findSellerList/" + brandId
            this.$ajax.get(url).then(res => {
                if(res.data.code == 200){
                  this.sellerVOList = res.data.data;
                }
                if(res.data.code == 500){
                  this.$message.error(res.data.msg)
                }
              }).catch(err => {
              console.log(err)
            })
          }
        },
        mwsInterface(row){
       //   var sellerId = this.form.sellerId
          var sellerId = row.sellerId

          console.log("form")
          console.log(this.form)

          console.log("sellerId")
          console.log(sellerId)


          if(sellerId != '' && sellerId != 0){
            var url = this.HOST + "/sellerAuthHandler/findSellerMwsBySellerId/" + sellerId
            this.$ajax.get(url).then(res => {
              if(res.data.code == 200){
                console.log("data")
                console.log(res.data.data)
                if(res.data.data != null){
                  this.mwsInterfaceForm = res.data.data;
                }else if(res.data.data == null){
                  this.mwsInterfaceForm.sellerId = sellerId
                }
              }
              if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }
            }).catch(err => {
              console.log(err)
            })
          }
          this.mwsInterfaceDialog = true
        },
        mwsAuth(row){
          this.mwsAuthDialog = true

          this.form.sellerId = row.sellerId
          this.form.regionId = row.regionId

          var sellerId = row.sellerId

          console.log("form")
          console.log(this.form)

          console.log("sellerId")
          console.log(sellerId)


          if(sellerId != '' && sellerId != 0){
            var url = this.HOST + "/sellerAuthHandler/findSellerMwsBySellerId/" + sellerId
            this.$ajax.get(url).then(res => {
              if(res.data.code == 200){
                console.log("data")
                console.log(res.data.data)
                this.mwsAuthForm = res.data.data;
              }
              if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }
            }).catch(err => {
              console.log(err)
            })
          }
        },
        subAccount(row){
          this.subAccountDialog = true

          this.form.sellerId = row.sellerId
          this.form.regionId = row.regionId

          var sellerId = row.sellerId

          console.log("form")
          console.log(this.form)

          console.log("sellerId")
          console.log(sellerId)


          if(sellerId != '' && sellerId != 0){
            var url = this.HOST + "/sellerAuthHandler/findAmzSellerAccountBySellerId/" + sellerId
            this.$ajax.get(url).then(res => {
              if(res.data.code == 200){
                console.log("data")
                console.log(res.data.data)
                this.subAccountForm = res.data.data;
              }
              if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }
            }).catch(err => {
              console.log(err)
            })
          }
        },

        defaultPost(){

          this.subAccountForm.remoteBrowserPort = 4440
          this.subAccountForm.remoteFilePort = 4444

          },
      },
    }
</script>

<style scoped>

</style>
