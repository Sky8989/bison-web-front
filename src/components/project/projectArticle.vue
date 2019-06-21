<template>
	<div id="projectArticle" class="content-wrapper">
		<div class="container">
			<div v-if="!isReadOnly" class="row text-right">
					<button :disabled="inEdit" class="btn btn-sm btn-default" @click="activeEdit"><i class="fa fa-edit"></i> 编辑</button>
					<button class="btn btn-sm btn-danger" @click="deleteArticle"><i class="fa fa-trash-o"></i> 删除</button>
			</div>
			<div class="row header-bottom-line mt-3">
				<div v-if="!inEdit" class="col-md-12 text-center">
					{{articleTitle}}
				</div>
				<div v-if="inEdit" class="col-md-12 text-center">
					<input type="text" class="form-control text-center" v-model="articleTitle" />
				</div>
				<div class="col-md-12 text-right">
					{{articleUser}}
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-right">
					{{articleTime}}
				</div>
			</div>
			
			
			
			<div v-show="!isReadOnly && inEdit" class="row">
				<div class="col-md-12">
					<quill-editor v-model="articleContext"
						ref="myQuillEditor"
						@blur="onEditorBlur($event)"
						@focus="onEditorFocus($event)"
						@ready="onEditorReady($event)"
						>
					</quill-editor>	
				</div>
				<div class="col-md-12 text-right mt-3">
					<button class="btn btn-primary" @click="saveEditingContext">保存</button>
					<button class="btn btn-default" @click="dropEditingContext">取消</button>
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-12" v-html="articleContext">
				</div>
			</div>			
		</div>
	</div>
</template>

<script>
	import axios from 'axios';
	import $ from "jquery"
	import Vue from 'vue';
	import 'quill/dist/quill.core.css';
	import 'quill/dist/quill.snow.css';
	import 'quill/dist/quill.bubble.css';
	
	import { quillEditor } from 'vue-quill-editor'
	export default{
		components:{
			quillEditor
		},
		data(){
			return {
				articleId:0,
				articleTitle:"",
				articleUser:"",
				articleTime:"",
				articleContext:"",
				backUpContext:"",
				isReadOnly:false,
				inEdit:false,
				projectId:0,
			}
		},
		mounted(){
			//获取传递的参数
			this.articleId = this.$route.query.articleId;
			this.init();
		},
		methods:
		{
			init(){
				this.timattServerUrl = this.$root.timattHandlers;
				this.initParameter();
			},
			initParameter(){
				//判断和当前登录的用户ID是否一致,如果一致,则可以编辑
				this.isReadOnly=false;
				let that = this;
				
				if(undefined == that.articleId || 0 == that.articleId)return;
				axios.get(that.timattServerUrl + 'projectArticles/getArticlesBykey/'+ that.articleId )
					.then((res) => {
						if(res.data.code == 200){
							let result = res.data.data;
							that.articleTitle= result.articleTitle;
							that.articleUser= result.userName;
							let temDate = that.dateFormat(result.createTime);
							that.articleTime=temDate;
							that.articleContext=result.articleText;
							that.projectId = result.projectId;
						}else{
							
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
			},
			deleteArticle(){
				let that = this;
				if(undefined == that.articleId || 0 == that.articleId)return;
				axios.delete(that.timattServerUrl + 'projectArticles/deleteArticle/'+ that.articleId )
					.then((res) => {
						if(res.data.code == 200){
							alert("Delete Success");
						}else{
							
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
			},
			saveEditingContext(){
				let that = this;
				this.inEdit=false;
				let param = {
					projectId : that.projectId,
					projectArticleId : that.articleId,
					articleTitle : that.articleTitle,
					articleText : that.articleContext,
				};
				axios.put(that.timattServerUrl + 'projectArticles/updateArticles/'+ that.articleId , param,{
						headers: {
							"Access-Token": that.token
						}
					})
					.then((res) => {
						if(res.data.code == 200){
							let result = res.data.data;
						}else{
							
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
			},
			dropEditingContext(){
				//还原文章内容
				this.articleContext=this.backUpContext;
				this.inEdit=false;
			},
			activeEdit(){
				//保存当前文章内容
				this.backUpContext=this.articleContext;
				this.inEdit=true;
			},
			onEditorBlur(quill) {
				console.log('editor blur!', quill)
		    },
		    onEditorFocus(quill) {
		    	console.log('editor focus!', quill)
		    },
		    onEditorReady(quill) {
		    	console.log('editor ready!', quill)
			},
		    onEditorChange({ quill, html, text }) {
				console.log('editor change!', quill, html, text)
		    },
		    dateFormat(time) {
				if(time=="---")return '---';
			    var date=new Date(time);
			    var year=date.getFullYear();
			    /* 在日期格式中，月份是从0开始的，因此要加0
			     * 使用三元表达式在小于10的前面加0，以达到格式统一  如 09:11:05
			     * */
			    var month= date.getMonth()+1<10 ? "0"+(date.getMonth()+1) : date.getMonth()+1;
			    var day=date.getDate()<10 ? "0"+date.getDate() : date.getDate();
			    var hours=date.getHours()<10 ? "0"+date.getHours() : date.getHours();
			    var minutes=date.getMinutes()<10 ? "0"+date.getMinutes() : date.getMinutes();
			    var seconds=date.getSeconds()<10 ? "0"+date.getSeconds() : date.getSeconds();
			    // 拼接
			    return year+"-"+month+"-"+day+" "+hours+":"+minutes+":"+seconds;
			},
		}
	}
</script>

<style>
</style>