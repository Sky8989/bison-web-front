<template>
	<span id="projectFile">
		<a href="#" class="fa fa-files-o ml-2" data-toggle="modal" data-target="#projectFileModal"> 相关文件管理 </a>
		<div class="modal fade" id="projectFileModal" tabindex="-1" role="dialog" aria-labelledby="projectMemberModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <i class="fa fa-users"></i> Project File
		            </div>
		            <div class="modal-body">
		            	<table id="projectFileTable"></table>
		            </div>
		            <div class="modal-footer">
		            	<!--<button type="button" class="btn btn-danger" @click="deleteProject">Delete</button>-->
		                <button type="button" style="float: left;" class="btn btn-default" @click='initParam' >刷新</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		            </div>
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal -->
		</div>
	</span>
</template>

<script>
	import axios from 'axios';
	import $ from "jquery"
	import crypto from 'crypto';
	import Vue from 'vue';
	
	export default {
		data() {
			return {
				projectFileList:[],		  //项目所有文件列表
				projectId:0,
				currentUserId:0,
			}
		},
		methods: {
			initParam(){
				let that = this;
				that.projectId = that.$parent.$route.query.projectId;
				if(undefined == that.projectId || 0 ==that.projectId)return;
				axios.get(that.timattServerUrl + 'taskFiles/getFilesMessageByProjectId/'+ that.projectId )
					.then((res) => {
						if(res.data.code == 200){
							let result = res.data.data;
							that.projectFileList = res.data.data;
							that.initProjectFileTable(); 
						}else{
						}
					}).catch(err => {
						
						that.$root.requestError(err);
					});
			},
			initProjectFileTable()
			{
				let that = this;
				$('#projectFileTable').bootstrapTable('destroy');
				$('#projectFileTable').bootstrapTable({
							pagination: true,  
				    		pageSize: 10,  
				    		pageNumber:1,  
				    		pageList: [10, 20, 50, 100, 200, 500],  
							sidePagination:"client",
						    columns: [{
						        field: 'fileName',
						        title: '文件名',
							}, {
						        field: 'user',
						        title: '上传人'
						    }, {
						    	field: 'historyFile',
						        title: '历史文件'
						    }, {
						    	field: 'operate',
						        title: '操作',
						        formatter:function(value, row, index){
						        	let result = '';
						        	if(row.userId ==that.currentUserId){
						        		result = '<button class="btn btn-warning btn-sm deleteOne">delete</button>';
						        	}else{
						        		result = '<button class="btn btn-warning btn-sm deleteOne" disabled="disabled">delete</button>';
						        	}
							        return result;
							    },
							    events: {
			                      	'click .deleteOne': function(e, value, row, index) {
										that.deleteOneFileById(row.fileId);
			                      	}
			                    },
						    }
						    ],
					data: this.projectFileList
				});
			},
			deleteOneFileById(fileId){
				let that = this;
				
				if(undefined == fileId || 0 == fileId)return;
				axios.delete(that.timattServerUrl + 'taskFiles/deletAllByFileId/'+ fileId)
					.then((res) => {
						if(res.data.code == 200){
						that.initParam();
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
				
			},
		},
		mounted: function() {
			this.timattServerUrl = this.$root.timattHandlers;
			this.currentUserId=this.$store.state.baseData.userInfo.userId;
			this.initParam();
		},
	}
</script>

<style>
</style>