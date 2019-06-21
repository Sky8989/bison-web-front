<template>

	<el-dialog
			:visible.sync="status"
			:width="'600px'"
			:title="theTitle"
	>
		<el-form :model="formedit":label-width="'100px'">

			<el-form-item label="项目名称">
				<el-input v-model="modelProjectName" placeholder="项目名称"></el-input>
			</el-form-item>
			<el-form-item label="公开">
				<el-switch v-model="isPublic"></el-switch>
			</el-form-item>
			<el-form-item label="描述">
				<el-input type="textarea" v-model="modelProjectDescription"></el-input>
			</el-form-item>
			<el-form-item label="项目团队">
				<el-select
						v-model="selectedUserList"
						multiple
						filterable
						allow-create
						default-first-option
						placeholder="项目团队">
					<el-option
							v-for="item in allUserList"
							:key="item.userId"
							:label="item.userName"
							:value="item.userId">
					</el-option>
				</el-select>
			</el-form-item>
		</el-form>
		<div slot="footer" class="dialog-footer">
			<el-button @click="_show">取 消</el-button>
			<el-button type="primary" @click="confirmInstallAndInsertProject()">创建</el-button>
		</div>
	</el-dialog>
</template>

<script>
	
	import axios from 'axios';
	import $ from "jquery"
	import crypto from 'crypto';
	import Vue from 'vue'

	export default{
		data(){
			return {
				formedit:{},
				allUserList:[],
				selectedUserList:[],
				modelProjectName:'',
				modelProjectDescription:'',
				isPublic:0,
				status:false,
				theTitle:'新建项目',
			}
		},
		mounted(){
			this.init();
		},
		methods:{
			init() {
				this.loginUrl = this.URL_ROOT + "/login-service/";
				this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
				this.userId = this.$store.state.LoginedUser.userId;
				this.initUserList();
			},
			_show() {

				this.status = this.status ? false : true;
				// if (this.status == true) {
				// 	this.formedit.departmentId = this.departmentItem.id;
				// 	this.formedit.roleId = this.personnelList[0].roleId;
				// 	this.parentDeptIds = this.departmentItem.parentDeptIds
				// }
			},

			initUserList(){
				let that = this;
				axios.get(that.loginUrl + 'users/getAllUser')
					.then((res) => {

						if(res.data.code == 200){
							let theResult = res.data.data;
							that.allUserList = theResult;
						}else{
						}
					}).catch(err => {
					});
			},
			confirmInstallAndInsertProject(){
				let that = this;
				let selectUserIdList = [];
				if(that.modelProjectName.length<1)return;
				if(!that.selectedUserList && that.selectedUserList.length < 0 ){
					return;
				}
				let the_blockOut = that.isPublic?1:2;
				let the_data = {
					userIds : that.selectedUserList.join(','),
					projectName : that.modelProjectName,
					projectDiscription : that.modelProjectDescription,
					userId : that.userId,
					blockOut : the_blockOut,
				};

				axios.post(that.timattServerUrl + 'setUpProjectMsg/insertPorject',the_data,{
					headers: {
						"Access-Token": this.token
					}
				})
					.then((res) => {
						if(res.data.code == 200){
							this.status = false;
							that.loadProjectList();
						}else{
							this.status = false;
							alert(res.data.msg);
						}
					}).catch(err => {
						that.$root.requestError(err);
					});
				
				
			},
			loadProjectList(){
				this.$parent.loadProjectList();
			},
		}
	}
</script>

<style>
	#createProjectModal .list-group-item{
		/*padding: 10px 15px !important;*/
	}
</style>