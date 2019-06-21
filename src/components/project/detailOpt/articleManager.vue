<template>
    <div id="articleManagerDiv">
        <el-button type="primary" size="mini" @click="newAnArticle">新增文案</el-button>
        <el-table
                :data="projectArticleList"
                @row-click="clickArticle"
                border
                >
            <el-table-column
                    prop="articleTitle"
                    label="文章名"
                    >
            </el-table-column>
            <el-table-column
                    prop="userName"
                    label="作者"
                    >

            </el-table-column>
            <el-table-column
                    prop="createTime"
                    label="时间"
                   >
                <template slot-scope="scope" >
                    {{scope.row.createTime | formatDate}}
                </template>
            </el-table-column>
        </el-table>
        <el-dialog
                :visible.sync="status"
                :width="'600px'"
                :title="theTitle"
                :close-on-click-modal="false">
            <el-form :model="formedit":label-width="'100px'">

                <el-form-item label="文章标题">
                    <el-input v-model="articleTitle" placeholder="项目名称"></el-input>
                </el-form-item>
                <el-form-item label="内容">

                    <quill-editor v-model="articleContent"
                                  ref="myQuillEditor"
                                  @blur="onEditorBlur($event)"
                                  @focus="onEditorFocus($event)"
                                  @ready="onEditorReady($event)">
                    </quill-editor>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="hideNewFileModel">取 消</el-button>
                <el-button type="primary" @click="addOrEditArticle()">保存</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import axios from 'axios';
    import {formatDate} from "common/js/date.js"
    import Vue from 'vue';

    import VueQuillEditor  from 'vue-quill-editor'
    import 'quill/dist/quill.core.css'
    import 'quill/dist/quill.snow.css'
    import 'quill/dist/quill.bubble.css'

    Vue.use(VueQuillEditor);

    export default {
        name: "articleManager.vue",
        data() {
            return {
                theTitle:'创建文案',
                projectId:'',
                timattServerUrl:'',
                loginUrl:'',
                projectArticleList: [],
                articleTitle:'',
                articleContent:'',
                formedit:{},
                status:false,
                userId:'',
                rowArticleId:'',
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
            this.projectId = this.$parent.$route.query.projectId;
            this.userId = this.$store.state.LoginedUser.userId;
            this.initialize();

        },
        activated(){
            this.projectId = this.$parent.$route.query.projectId;

        },
        methods:{
            clickArticle(row, column, event){
                let that = this;
                that.rowArticleId = row.projectArticleId;
                that.articleTitle = row.articleTitle ;
                that.articleContent = row.articleText;
                that.showNewFileModel();

            },
            initialize(){
                this.initProjectArticleList();
            },
            initProjectArticleList(){
                let that = this;
                axios.get(that.timattServerUrl + 'projectArticles/getArticlesByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){
                            that.projectArticleList = res.data.data;
                        }else{

                        }
                    }).catch(err => {

                    that.$root.requestError(err);
                });
            },
            addOrEditArticle(){
                let that = this;
                if(that.articleTitle.length<0)return;
                if('' == that.rowArticleId){
                    let param = {
                        projectId : that.projectId,
                        articleTitle : that.articleTitle,
                        articleText : that.articleContent,
                        userId : that.userId,
                    };
                    axios.post(that.timattServerUrl + 'projectArticles/insertArticles',param)
                        .then((res) => {

                            if(res.data.code == 200){
                                that.initProjectArticleList();
                                that.hideNewFileModel();
                                that.clearData();
                            }else{

                            }
                        }).catch(err => {
                        that.$root.requestError(err);
                    });
                }else{
                    //走到这里证明是更新.
                    let param = {
                        projectArticleId : that.rowArticleId,
                        projectId : that.projectId,
                        articleTitle : that.articleTitle,
                        articleText : that.articleContent,
                        userId : that.userId,
                    };
                    axios.put(that.timattServerUrl + '/projectArticles/updateArticles/'+that.rowArticleId ,param)
                        .then((res) => {

                            if(res.data.code == 200){
                                that.initProjectArticleList();
                                that.hideNewFileModel();
                                that.clearData();
                            }else{

                            }
                        }).catch(err => {
                        that.$root.requestError(err);
                    });

                }


            },
            newAnArticle(){
                this.clearData();
                this.showNewFileModel();
            },
            showNewFileModel(){this.status = true;},
            hideNewFileModel(){this.status = false;},
            clearData(){
                let that = this;
                that.articleTitle='';
                that.articleContent='';
                that.rowArticleId = '';
            },
            onEditorBlur(quill) {
            },
            onEditorFocus(quill) {
            },
            onEditorReady(quill) {
            },
            onEditorChange({ quill, html, text }) {
                this.articleContent = html;
            },
        },
        watch:{
            projectId:function(value){
                let that = this;
                that.initProjectArticleList();
            },
        },
    }
</script>

<style lang="stylus"  scoped>
    .ql-container{
        min-height: 210px;
    }
    #articleManagerDiv{
        .el-button--mini{
            margin-bottom: 10px;
        }
        
    }
</style>