
<template>
  <div id="developProcessId">

    <el-tabs v-model="activeName" @tab-click="handleClick" type="border-card" >
      <el-tab-pane label="事件支持" name="second">
        <createEvent ref="create_event" @initTable='initTable'></createEvent>
        <requireAsistance ref="require_asistance" @convertToEditProp='convertToEditProp' ></requireAsistance>
      </el-tab-pane>
     <!-- <el-tab-pane label="开发需求" name="first">
        <distributeDevelop ref="distribute_develop"></distributeDevelop>
      </el-tab-pane>-->
    </el-tabs>
  </div>
</template>

<script>
  import requireAsistance from 'components/requireAssistance/requireAssistance';
  import createEvent from 'components/requireAssistance/createEvent';
  import distributeDevelop from 'components/requireAssistance/distributeDevelop';

    export default {
      name: 'developProcess',
      components: {
        requireAsistance,
        createEvent,
        distributeDevelop,
      },
      props:{

      },
      data () {
        return {
          preUrl:'http://support.leaderment.com:10206/',
          activeName:'second',
        }
      },
      methods:{
        init(){
          document.title='事件支持';
        },
        handleClick(){

        },
        initTable(){
          this.$refs.require_asistance.initAllData();
        },
        convertToEditProp(therow){

          this.$refs.create_event.initEditDisplayData(therow);
        },

      },
      mounted:function(){
        this.init();
      },

    }
</script>

<style>

</style>
