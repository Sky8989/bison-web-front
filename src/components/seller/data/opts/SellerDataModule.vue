<template>

  <div name="sellerDataModule">
    数据模块

    <el-table  :data="dataModuleList" border="border">
      <el-table-column prop="moduleName" label="模块" >
      </el-table-column>

        <el-table-column   v-for="amzRegion in amzRegionVOList" :key="amzRegion.amzRegionId" :label="amzRegion.amzRegionCode" >
        <template slot="header" slot-scope="scope">
        {{amzRegion.amzRegionCode}}
        {{amzRegion.amzRegionId}}
        </template>

        <template  slot-scope="scope">
              <div v-for="(moduleSubscribeVO,index) in scope.row.moduleSubscribeVOList" :key="moduleSubscribeVO.subscribeId">
                <div  v-if="moduleSubscribeVO.amzRegionId == amzRegion.amzRegionId">
                  {{moduleSubscribeVO.amzRegionId}}
                  <span>{{moduleSubscribeVO.lastExecuteTime}}</span> &nbsp;&nbsp;
                  <span v-for="moduleExcuteStatus in moduleExcuteStatusList"
                        v-if="moduleSubscribeVO.lastExecuteStatusId == moduleExcuteStatus.excuteStatusId"> {{moduleExcuteStatus.statusComment}} </span> &nbsp;&nbsp;
                  <el-button type="primary" size="mini"
                             v-if="moduleSubscribeVO.subscribeStatus == 0" @click="updateSubscribeStatus(moduleSubscribeVO.subscribeId,1)"> 启动 </el-button>
                  <el-button type="danger" size="mini"
                             v-if="moduleSubscribeVO.subscribeStatus == 1" @click="updateSubscribeStatus(moduleSubscribeVO.subscribeId,0)"> 停止 </el-button>
                </div>

                <div >

                </div>


              </div>
        </template>

      </el-table-column>


    </el-table>
  </div>

</template>

<script>
    export default {
        name: "sellerDataModule",
      props: {
        parentBrandId: '',
      },
        data(){
          return{
            dataModuleList:[],      //数据模块列表
            amzRegionVOList:[],      //地区列表
            moduleSubscribeVOList:[],      //账号和执行模块的状态关系 列表

            moduleExcuteStatusList:[],  //模块状态列表

            brandId:'', //存父组件传来的 parentBrandId

          }
        },
     /* watch: {
        datas(amzRegionid,moduleSubscribeVOid,index){
          console.log(mzRegionid,moduleSubscribeVOid,index)
        }
      },*/
      methods:{
          init(){
            console.log("init")
            this.initAmzRegionVOList();
            this.initModuleExcuteStatusListList();
          },
          initAmzRegionVOList(){
            var url = this.HOST + "/dataModuleHandler/getAmzRegionVOList"
            this.$ajax.get(url).then(res => {
              if(res.data.code == 200){
                console.log("data")
                console.log(res.data.data)
                this.amzRegionVOList = res.data.data;
              }
              if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }
            }).catch(err => {
              console.log(err)
            })

          },
        initModuleExcuteStatusListList(){
          var url = this.HOST + "/dataModuleHandler/getModuleExcuteStatusList"
          this.$ajax.get(url).then(res => {
            if(res.data.code == 200){
              console.log("data")
              console.log(res.data.data)
              this.moduleExcuteStatusList = res.data.data;
            }
            if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          }).catch(err => {
            console.log(err)
          })

        },

        search(id){
          console.log("111search")

          this.brandId = id
          var brandId = id


          console.log(brandId)

            var url = this.HOST + "/dataModuleHandler/findDataModuleList/" + brandId
            this.$ajax.get(url).then(res => {
              if(res.data.code == 200){
                console.log("data")
                console.log(res.data.data)
                this.dataModuleList = res.data.data;
              }
              if(res.data.code == 500){
                this.$message.error(res.data.msg)
              }
            }).catch(err => {
              console.log(err)
            })
          },

        updateSubscribeStatus(subscribeId,status){
            console.log("updateSubscribeStatus")
            console.log("subscribeId = " + subscribeId)
            console.log("status = " + status)


          var url = this.HOST + "/dataModuleHandler/updateSubscribeStatus?subscribeId=" + subscribeId + '&status=' + status
          this.$ajax.put(url).then(res => {
            if(res.data.code == 200){
              console.log("data")
              console.log(res.data.data)
              this.search(this.brandId)
            }
            if(res.data.code == 500){
              this.$message.error(res.data.msg)
            }
          }).catch(err => {
            console.log(err)
          })
        },
      }
    }
</script>

<style scoped>

</style>
