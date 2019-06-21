<template>
    <div id="allImageId">
        <el-button type="primary" size="mini" @click="openModel">图片管理</el-button>
        <el-dialog
                :visible.sync="status"
                :width="'600px'"
                :title="theTitle"
                :close-on-click-modal="false">
            <el-table
                    :data="imagesList"
                    width="600px">
                <el-table-column
                        prop="fileName"
                        label="图片名"
                        width="270">
                </el-table-column>

                <el-table-column
                        prop="operate"
                        label="操作"
                        width="100">
                    <template slot-scope="scope" >
                        <el-button
                                @click.native.prevent="deleteRow(scope.$index)"
                                type="text"
                                size="small">
                            移除
                        </el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-dialog>
    </div>
</template>

<script>
    import axios from 'axios';
    import {formatDate} from "common/js/date.js"
    import Vue from 'vue';


    export default {
        name: "allImage",
        data() {
            return {

                projectId:0,
                timattServerUrl:'',
                loginUrl:'',
                userId:'',
                theTitle:"文件管理",
                imagesList:[],
                status:false,
            }
        },
        filters:{
            formatDate(time) {
                let date = new Date(time);
                return formatDate(date, "yyyy-MM-dd");
            },
        },
        mounted() {
            this.loginUrl = this.URL_ROOT + "/login-service/";
            this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
            this.userId = this.$store.state.LoginedUser.userId;

        },
        activated(){

        },
        methods:{

            initialize(){
                this.projectId = this.$parent.$route.query.projectId;
                this.initParam();
            },
            initParam(){
                let that = this;
                if(undefined == that.projectId || 0 ==that.projectId)return;
                axios.get(that.timattServerUrl + 'taskFiles/getIMagesByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){
                            let result = res.data.data;
                            that.imagesList = res.data.data;
                            this.status = true;
                        }else{
                        }
                    }).catch(err => {

                });
            },
            openModel(){
                this.initialize();
                this.status = true;
            },
            deleteRow(rowIndex){
                let that = this;
                let theFile = that.imagesList[rowIndex];
                let fileId = theFile.fileId;
                if(undefined == fileId || 0 == fileId)return;

                this.$confirm('此操作将永久删除该图片, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    axios.delete(that.timattServerUrl + 'projectPictures/deletePic/'+ fileId)
                        .then((res) => {
                            if(res.data.code == 200){
                                that.initParam();
                            }
                        }).catch(err => {
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });




            },

        },
        watch:{

        },
    }
</script>

<style scoped>
    .ql-container{
        min-height: 210px;
    }
</style>