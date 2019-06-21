<template>
    <div id = 'projectMemberEditId'>
        <el-button type="primary" size="mini" @click="showMemberModel">项目成员</el-button>

        <el-dialog
                :visible.sync="status"
                :width="'600px'"
                :title="theTitle"
                :close-on-click-modal="false">
            <el-form :model="formedit":label-width="'100px'">
                <el-col :span="16">
                    <el-form-item label="项目名称">
                        <el-input v-model="modelProjectName" placeholder="项目名称"></el-input>
                    </el-form-item>
                </el-col>
                <el-col :span="22">
                    <el-form-item label="描述">
                        <el-input v-model="projectDiscription" disabled placeholder="描述"></el-input>
                    </el-form-item>
                </el-col>
                <el-transfer
                        filterable
                        :filter-method="filterMethod"
                        filter-placeholder="请输入人名"
                        :titles="['未选择', '已选择']"
                        :button-texts="['移除', '选入']"
                        v-model="selectedUserList"
                        :data="allUserList">
                </el-transfer>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="_show">取 消</el-button>
                <el-button type="primary" @click="confirmUpdateUserRel">保存</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import axios from 'axios';
    import $ from "jquery"
    import Vue from 'vue';
    export default {
        name: "projectMemberEdit",
        props: ["projectName","projectDiscription"],
        data(){
            return{
                allUserList:[],
                selectedUserList:[],
                projectId:0,
                status:false,
                theTitle:'项目成员',
                formedit:{},
                modelProjectName:"",

            }
        },
        mounted(){
            this.projectId = this.$parent.$route.query.projectId;
            this.modelProjectName = this.projectName;
            this.init();
        },
        activated(){
            this.projectId = this.$parent.$route.query.projectId;
            this.modelProjectName = this.projectName;
            this.init();
        },
        methods: {
            init(){
                //初始化变量
                this.loginUrl = this.URL_ROOT + "/login-service/";
                this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
                this.projectId = this.$parent.$route.query.projectId;
                this.userId = this.$store.state.LoginedUser.userId;
                this.initUserList();
            },
            initUserList(){
                let that = this;
                let theProductId = that.$parent.$route.query.projectId;
                that.projectId = theProductId;
                if(undefined == theProductId || 0 == theProductId)return;

                axios.get(that.timattServerUrl + 'project/getProjectMembers/'+ theProductId )
                    .then((res) => {
                        if(res.data.code == 200){
                            let theResult = res.data.data;
                            that.allUserList = [];
                            that.selectedUserList = [];
                            let tempAllUserList= [];
                            let tempSelectedUserList = [];
                            if(theResult.theotherUsers ){
                                for(let item of theResult.theotherUsers){
                                    let formatIt = {
                                        'label': item.userName,
                                        'key': item.userId,
                                    }
                                    tempAllUserList.push(formatIt);
                                }
                            }

                            if(theResult.relUsers){
                                for(let item of theResult.relUsers){
                                    let formatIt = {
                                        'label': item.userName,
                                        'key': item.userId,
                                    }
                                    tempAllUserList.push(formatIt);
                                    tempSelectedUserList.push(item.userId);
                                }
                            }

                            that.allUserList = tempAllUserList;
                            that.selectedUserList = tempSelectedUserList;

                        }else{

                        }
                    }).catch(err => {
                });
            },

            filterMethod(query, item) {
                return item.label.indexOf(query) > -1;
            },
            showMemberModel(){
                this.status = true;
            },
            confirmUpdateUserRel(){
                let that = this;

                if(undefined == that.projectId || 0 == that.projectId
                    || undefined == that.selectedUserList || that.selectedUserList.length<1 )return;

                let param ={
                    projectId : that.projectId ,
                    userIds : that.selectedUserList.join(','),
                };
                axios.post(that.timattServerUrl + 'setUpProjectMsg/updateProjectMembers',param)
                    .then((res) => {
                        if(res.data.code == 200){
                            that.initMemberList();
                        }else{
                            alert(res.data.msg);
                        }
                    }).catch(err => {
                    that.$root.requestError(err);
                });
                if(that.modelProjectName && ""!=that.modelProjectName){
                    let proParam={
                        projectName : that.modelProjectName,
                        projectId : that.projectId,
                        projectMilestoneId : 0,
                    };
                    axios.post(that.timattServerUrl + 'projectMilestones/updateStoneAndPName/',proParam).then((res) => {
                        if(res.data.code == 200){
                            that.initProjectMsg();
                        }else{
                        }

                    }).catch(err => {

                    });
                }
                that.status = false;
            },
            initMemberList(){
                this.$emit("memberSuccess");
            },
            initProjectMsg(){
                this.$emit("preInitProjectMsg");
            },
            // addUser(index){
            //     let tempUser=this.allUserList[index];
            //     this.selectedUserList.push(tempUser);
            //     this.allUserList.splice(index,1);
            // },
            // removeUser(index){
            //     let tempUser=this.selectedUserList[index];
            //     this.allUserList.push(tempUser);
            //     this.selectedUserList.splice(index,1);
            // },
            _show(){
                this.status = false;
            },
        },
        //
        watch:{
            modelProjectName:function(value){
                let that = this;

            },
        },
    }
</script>

<style scoped>

</style>