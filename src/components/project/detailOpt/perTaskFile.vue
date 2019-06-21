<template>
    <div id = "perTaskFileId" >

        <el-row :gutter="10">
            <el-col :span="1" >
                <el-button type="text" style="margin-left: 10px" @click="openImport">上传</el-button></el-col>
            <el-col :span="1" >
                <el-button type="text"  @click="refreshTable">刷新</el-button></el-col>
        </el-row>
        <el-row>
            <el-col :span="16" >
                <el-table :data="selectTaskFileList" border @row-click="clickTaskFileItem" width="400px">
                    <el-table-column prop="fileName" label="文章名"> </el-table-column>
                    <el-table-column prop="user" label="上传人"> </el-table-column>
                    <el-table-column prop="historyFile" label="历史文件" >
                        <template slot-scope="scope" > {{scope.row.historyFile}} </template>
                    </el-table-column>
                </el-table>
            </el-col>
        </el-row>
        <el-dialog
                :visible.sync="status"
                :width="'600px'"
                :title="theTitle">
            <el-upload
                    class="upload-demo"
                    ref="upload"
                    v-bind:action="fileActionUrl"
                    :on-preview="handlePreview"
                    :on-remove="handleRemove"
                    :file-list="fileList"
                    multiple
                    :auto-upload="false">
                <el-button slot="trigger" size="small" type="primary">选取文件</el-button>
                <el-button style="margin-left: 10px;" size="small" type="success" @click="startImport">上传到服务器</el-button>
                <!--<div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过500kb</div>-->
            </el-upload>
        </el-dialog>
        <el-dialog
                :visible.sync="historyStatus"
                :width="'600px'"
                :title="theHistoryTitle">
            <el-table :data="theOneHistory" @row-click="clickHistoryRow" width="400px">
                <el-table-column prop="filePath" label="文件路径" width="300px"> </el-table-column>
                <el-table-column prop="uploadTime" label="上传文件时间" width="200px">
                    <template slot-scope="scope" > {{scope.row.uploadTime | formatDate}} </template>
                </el-table-column>
            </el-table>
        </el-dialog>
    </div>
</template>

<script>
    import axios from 'axios';
    import Vue from 'vue';
    import {formatDate} from "common/js/date.js"

    export default{
        name: "perTaskFile",
        props: ["selectTask"],
        data() {
            return {
                timattServerUrl:'',
                status:false,
                historyStatus:false,
                projectId:"",
                selectTaskFileList:[],
                taskId:'',
                fileActionUrl:'',
                userId:0,
                fileList:[],
                theOneHistory:[],
                theTitle:"上传文件",
                theHistoryTitle:"历史文件",
            }
        },
        filters:{
            formatDate(time) {
                let date = new Date(time);
                return formatDate(date, "yyyy-MM-dd");
            },
        },
        mounted: function() {
            this.taskId = 0;
            this.init();
        },
        activated(){
            this.taskId = 0;
            this.init();
        },
        watch:{

        },
        methods: {
            initTaskId(theTaskId){
                this.taskId = theTaskId;
                this.init();
            },
            init(){
                this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
                this.userId = this.$store.state.LoginedUser.userId;
                this.fileActionUrl = this.timattServerUrl+'taskFileLoad/uploadFile/'+this.taskId +'/' + this.userId;
                this.initTaskFileList();
            },
            clickTaskFileItem(row, column, event){
                let that = this;
                that.theOneHistory = [];
                let fileId = row.fileId;
                if( undefined == fileId || 0 == fileId  )return;
                axios.get(that.timattServerUrl + 'taskFileSequences/getMessageByFileId/'+ fileId )
                    .then((res) => {
                        if(res.data.code == 200){
                            let result = res.data.data;
                            that.theOneHistory = result;
                            this.historyStatus = true;
                        }else{

                        }
                    }).catch(err => {
                    that.$root.requestError(err);
                });

            },
            clickHistoryRow(row, column, event){
                let that = this;
                if(undefined == row.filePath || undefined == that.timattServerUrl)return '' ;
                let theFormatFilePath = row.filePath.replace('\\','/')
                let the_url = that.timattServerUrl + row.filePath;
                // let result = '<a href="'+the_url+'" download="w3logo">下载</a>';
                window.open(the_url);
            },
            closeImport(){this.status = false;},
            openImport(){this.status = true;this.fileList=[]},
            startImport(){
                let that = this;
                if(!that.taskId || ""==that.taskId)return;
                that.$refs.upload.submit();

                window.setTimeout(function () {
                    that.status = false;
                    that.initTaskFileList();
                }, 800);
            },
            initTaskFileList(){
                let that = this;
                if( undefined == that.taskId || '' == that.taskId || 0 == that.taskId){
                    that.selectTaskFileList = [];
                    return;
                }
                //请求任务的相关文件
                axios.get(that.timattServerUrl + 'taskFiles/getFilesMessageByTaskId/'+ that.taskId).then((res) => {
                    if(res.data.code == 200){
                        that.selectTaskFileList = res.data.data;
                    }else{
                    }
                }).catch(err => {
                });

            },
            refreshTable(){
                this.initTaskFileList();
            },
            handleRemove(file, fileList) {
                // console.log(file, fileList);
            },
            handlePreview(file) {
                // console.log(file);
            }

        }
    }
</script>

<style scoped>

</style>