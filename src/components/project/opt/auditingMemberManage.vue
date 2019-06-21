<template>
	<span id="fileHistoryInfo">
		<div class="modal fade" id="auditingUserModal" tabindex="-1" role="dialog" aria-labelledby="myAuditingUserModal" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h3 class="modal-title fa fa-info-circle" id="myAuditingModalLabel">审核人员</h3>
		            </div>
		            <div class="modal-body">
		            	
		            	<div class="row">
		            		<div v-if="!isProjectReadOnly" class="col-md-6">
		            			<div class="row pre-scrollable">
		            				<div class="col-md-12">
		            					<div class="list-group">
				            				<a v-for="(user_iterator,index) in auditingTheotherUsers" class="list-group-item">{{user_iterator.userName}}<button @click="addUser(index)" class="pull-right btn btn-sm btn-info fa fa-plus"></button></a>
				            			</div>	
		            				</div>			            				
		            			</div>		            			
		            		</div>
		            		<div :class="{'col-md-6':!isProjectReadOnly, 'col-md-12':isProjectReadOnly}">
		            			<div class="row pre-scrollable">
		            				<div class="col-md-12">
		            					<div class="list-group">
				            				<a v-for="(user_iterator,index) in selectedUserList" class="list-group-item">{{user_iterator.userName}} <button v-if="!isProjectReadOnly" @click="removeUser(index)" class="pull-right btn btn-sm btn-danger fa fa-minus"></button></a>
				            			</div>	
		            				</div>			            				
		            			</div>		  
		            		</div>
		            	</div>
		            	
		            </div>
		            <div class="modal-footer">
		            	<button type="button" class="btn btn-primary" @click="confirmUpdateAuditingUsers" data-dismiss="modal">Confirm</button>
		                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
	export default{
		name:"ProjectInfoEditor",
		props: {
			isProjectReadOnly:false,
			roleId:0,
		},
		data(){
			return{
				fileList:[],
				auditingTheotherUsers:[],
				selectedUserList:[],
			}
		},
		methods: {
			init(){
				if(this.$store.state.baseData) {
					//初始化变量
					this.serverUrl = this.$root.pageHandlers;
					this.timattServerUrl = this.$root.timattHandlers;
					this.token = this.$store.state.baseData.userInfo.token;
					this.userId = this.$store.state.baseData.userInfo.userId;
					
				}
			},
			confirmUpdateAuditingUsers(){
				let that = this;
				let theTaskNodeId = that.$parent.selectTask.id;
				let theProjectId = that.$parent.projectId;
				let theUserIds = ''; let userArr = [];
				if(this.selectedUserList.length<1)return;
				for(let onevo of this.selectedUserList){
					userArr.push(onevo.userId);
				}
				theUserIds = userArr.join(',');
				if(undefined == theTaskNodeId || undefined == theProjectId || undefined == theUserIds || '' == theUserIds )return;
				let param = {
					taskNodeId : theTaskNodeId,
					projectId : theProjectId,
					projectMemberTypeId : 0,
					taskNodeAuditingStatusId :1,
					userIds:theUserIds,
				};
	    		axios.post(that.timattServerUrl + 'taskNodeAuditings/updateRelation/'+ theTaskNodeId,param,{
					headers: {
						"Access-Token": this.token
					}
				}).then((res) => {
						if(res.data.code == 200){
							let result = res.data.data;
							that.$parent.initTaskAuditingList();
						}else{
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
				
			},
			initBaseParam(){
				this.auditingTheotherUsers = this.$parent.auditingTheotherUsers;
				this.selectedUserList = this.$parent.auditingRelUsers;
			},
			addUser(index){
				let tempUser=this.auditingTheotherUsers[index];
				this.selectedUserList.push(tempUser);
				this.auditingTheotherUsers.splice(index,1);
			},
			removeUser(index){
				let tempUser=this.selectedUserList[index];
				this.auditingTheotherUsers.push(tempUser);
				this.selectedUserList.splice(index,1);
			}
		},
		
		mounted: function() {
			this.init();
		},
		watch:{
			longSize:function(value){
				this.calculateVolume();
			},
		},
	}
</script>

<style>

</style>