<template>
    <div id="milestoneDivId" style="margin-top: 20px;">
        <vue-step :now-step="nowStep" :step-list="milestoneList" :active-color="stepColour"></vue-step>
    </div>
</template>

<script>
    import axios from 'axios';
    import Vue from 'vue';
    import vueStep from 'vue-step';   //里程碑步骤组件
    export default {
        name: "milestone.vue",
        data() {
            return {
                /*** 以下是数据相关 * */
                currentUserId:0,
                //里程碑配置
                milestoneList: [],  //里程碑步骤列表
                nowStep:0, //当前进度
                stepColour:"#9170E4", //里程碑颜色

            }
        },
        components: {
            vueStep,
        },
        mounted: function() {
            this.projectId = this.$parent.$route.query.projectId;
            this.currentUserId = this.$store.state.LoginedUser.userId;
            this.init();
        },
        activated(){
            this.projectId = this.$parent.$route.query.projectId;
            this.init();
        },
        watch:{

        },
        methods: {
            init(){
                this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
                this.refreshInitMilestone();
            },
            initMileStoneMessage(theParam){
                if(undefined == theParam || theParam.size<1)return;
                let that = this;
                let tem_milestone = [];
                //进度条

                for( let oneItem of theParam ){
                    let milestoneName= oneItem.projectMilestone +' ('+ oneItem.stoneDateStr +')';
                    tem_milestone.push(milestoneName);
                }
                that.initStoneNewStep();

                that.milestoneList = tem_milestone ;

            },
            initStoneNewStep(){

                let that = this;
                if(undefined == that.projectId || 0 == that.projectId)return 0;
                let result = 0;
                axios.get(that.timattServerUrl + 'taskNodes/getStoneStepByProId/'+that.projectId)
                    .then((res) => {

                        if(res.data.code == 200){
                            that.nowStep　= 0 ;
                            result= res.data.data;
                            if(result && 0 != result)that.nowStep = result;
                        }else{
                        }
                    }).catch(err => {

                });
            },
            refreshInitMilestone(){
                let that = this;
                if(undefined == that.projectId || 0 ==that.projectId)return;
                axios.get(that.timattServerUrl + 'projectMilestones/getMilestoneByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){

                            let result = res.data.data;
                            that.initMileStoneMessage(result);
                        }else{
                        }
                    }).catch(err => {
                    that.$root.requestError(err);
                });


            },
        },
    }
</script>

<style scoped>

</style>