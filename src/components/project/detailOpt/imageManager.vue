<template>
    <div id = 'imageManagerDiv'>

        <el-button type="primary" size="mini" @click="showImportImageModel">上传</el-button>
        <el-button type="primary" size="mini" @click="refreshInitPicture">刷新图片</el-button>
        <div style="height: 500px;overflow: auto;" id = "imageManagerDivId">
            <img style="max-height: 180px;" v-for="(item,index) in projectPictureList" :key="index" :src="item.url" @click="imageView(index)">
        </div>
        <el-dialog
                :visible.sync="status"
                :width="'600px'"
                :title="theTitle"
                :close-on-click-modal="false">

                <file-upload
                        class="btn btn-sm btn-primary"
                        v-bind:post-action="actionUrl"
                        extensions="gif,jpg,jpeg,png"
                        accept="image/png,image/gif,image/jpeg"
                        :multiple="true"
                        :size="1024 * 1024 * 10"
                        v-model="files"
                        @input-filter="inputFilter"
                        @input-file="inputFile"
                        ref="upload">
                    <div style="background-color:#409EFF; width: 101px; height: 43px; border-radius: 6px; ">
                        <div style="font-family: 'auto';color:white; padding-top: 10px;font-size: 15px">选择图片</div>
                    </div>

                </file-upload>
                <div style="text-align: center;">
                    <span class = 'ml-5'>{{theImageNameStr}}</span>
                </div>


                <div slot="footer" class="dialog-footer">
                    <el-button type="primary"  v-if="!$refs.upload || !$refs.upload.active" @click.prevent="$refs.upload.active = true">开始上传</el-button>
                    <el-button type="primary"  v-else @click.prevent="$refs.upload.active = false">终止上传</el-button>
                    <el-button @click="hideModel">关闭</el-button>
                </div>
        </el-dialog>
    </div>

</template>

<script>
    import axios from 'axios';
    import FileUpload from 'vue-upload-component';
    import imageViewer from "vue-image-viewer";	//项目图片预览组件
    import Vue from 'vue';


    Vue.use(imageViewer);
    export default{
        name: "imageManager.vue",
        components:{
            FileUpload,
        },
        data() {
            return {
                files: [],
                timattServerUrl:'',
                actionUrl:'',
                theImageNameStr:'',
                theImageList:[],
                status:false,
                theTitle:'',
                projectPictureList:[],
                projectId:"",
            }
        },
        mounted: function() {
            this.projectId = this.$parent.$route.query.projectId;
            this.refreshInitPicture();
            this.init();
        },
        activated(){
            this.projectId = this.$parent.$route.query.projectId;
            this.init();
            this.refreshInitPicture();
        },
        watch:{

        },
        methods: {
            init(){
                this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
                let proId = this.$parent.$route.query.projectId;
                this.actionUrl = this.timattServerUrl+'projectFile/upload/'+proId;

                this.initPicture();
            },
            fileSuccess (rootFile, file, message, chunk) {
                console.log('complete', rootFile, file, message, chunk);
            },
            hideModel(){
                this.status = false;
            },
            addImage(){

            },
            inputFilter(newFile, oldFile, prevent) {

                if (newFile && !oldFile) {
                    // Before adding a file
                    // 添加文件前
                    // Filter system files or hide files
                    // 过滤系统文件 和隐藏文件
                    if (/(\/|^)(Thumbs\.db|desktop\.ini|\..+)$/.test(newFile.name)) {
                        return prevent()
                    }
                    // Filter php html js file
                    // 过滤 php html js 文件
                    if (/\.(php5?|html?|jsx?)$/i.test(newFile.name)) {
                        return prevent()
                    }
                }
            },
            inputFile(newFile, oldFile) {
                let that = this;
                that.theImageNameStr = '';

                if (newFile && !oldFile) {
                    // add
                    if(!that.theImageList.includes(newFile.name))that.theImageList.push(newFile.name);
                    that.theImageNameStr = that.theImageList.join('          ,');

                }
                if (newFile && oldFile) {
                    // update
                    // 上传成功
                    if (newFile.success !== oldFile.success) {
                        that.status = false;
                        that.initPicture();
                    }
                    // 上传错误
                    if (newFile.error !== oldFile.error) {

                    }
                }
                if (!newFile && oldFile) {
                }

            },
            refreshInitPicture(){
                this.init();
            },
            initPicture(){
                let that = this;
                this.projectPictureList = [];
                if(undefined == that.projectId || 0 ==that.projectId)return;
                axios.get(that.timattServerUrl + 'projectPictures/getProjectPictureByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){

                            let result = res.data.data;
                            let thePicList = [];
                            if(result.length<1){
                                // document.getElementById("imageManagerDivId").innerHTML = "";
                                return;
                            }

                            for(let oneImage of result){
                                let item = {
                                    pictureId:oneImage.projectPictureId,
                                    name:oneImage.pictureUrl,
                                    url:that.timattServerUrl + 'image/' + that.projectId + '/' + oneImage.pictureUrl,
                                };
                                thePicList.push(item);
                            }
                            that.projectPictureList = thePicList;
                            //初始化图片预览控件,把图片列表传入
                            that.$imageViewer.images(that.projectPictureList);
                        }else{

                        }
                    }).catch(err => {

                    that.$root.requestError(err);
                });
            },
            showImportImageModel(){
                let that = this;
                that.status = true;
            },
            //图片预览事件
            imageView(index) {
                this.$imageViewer.index(index);
                this.$imageViewer.show();
            },
        }
    }
</script>

<style lang="stylus">
    #imageManagerDiv{
        .el-button{
            margin-bottom: 10px;
        }
        #imageManagerDivId{
            font-size 0
            img{
                display inline-block
                margin 0 10px 10px 0;
            }
        }
    }
</style>
