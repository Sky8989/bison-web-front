<template>
	<div class="projectList">
		<el-button type="primary" @click="_createNewPro">创建项目</el-button>
		<el-table
				:data="projectList"
				border
				highlight-current-row
				@row-click="clickProject"
				>
			<el-table-column
					fixed
					prop="projectName"
					label="项目名称"
					>
			</el-table-column>
			<el-table-column
					prop="projectCtime"
					label="创建时间"
					width="200">
				<template slot-scope="scope" >
					{{scope.row.projectCtime | formatDate}}
				</template>
			</el-table-column>
			<el-table-column
					prop="projectUtime"
					label="更新时间"
					width="200">
				<template slot-scope="scope" >
					{{scope.row.projectUtime | formatDate}}
				</template>
			</el-table-column>
			<el-table-column
					prop="userName"
					label="创建人"
					>
			</el-table-column>
			<el-table-column
					prop="projectMember"
					label="参与人数"
					>
			</el-table-column>

		</el-table>
		<createProject
				ref="createProject"
				:loadProjectList="loadProjectList"
				@success="createProjectSuccess"
		></createProject>

		{{datas}}
	</div>
</template>

<script>
	import Vue from 'vue'
	// import projectDetail from "components/project/projectDetail"
	import {formatDate} from "common/js/date.js"
	
	// Vue.component('ProjectDetail', projectDetail);
	import axios from 'axios';

	// import crypto from 'crypto';
	
	export default {
		components: {
			createProject: resolve =>
					require(["components/project/opt/createProject.vue"], resolve),
			selectBusinessUnit: resolve =>
					require(["components/common/selectBusinessUnit.vue"], resolve),
			projectDetail: resolve =>
					require(["components/project/projectDetail.vue"], resolve),
		},
		data() {
			return {
				//项目列表
				projectList:[],
				timattServerUrl:'',
				loginUrl:'',
			}
		},

		filters:{
			formatDate(time) {
				let date = new Date(time);
				return formatDate(date, "yyyy-MM-dd");
			},
		},
		computed: {
			datas(){
				return "";
			}
		},
		mounted: function() {
			//初始化.
			this.init();
		},
		activated(){
			this.init();
		},
		methods: {
			init() {
				this.loginUrl = this.URL_ROOT + "/login-service/";
				this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
				this.loadProjectList();
			},
			_createNewPro(){
				this.$refs.createProject._show();
			},
			loadProjectList(){
				//请求接口获取数据******************************
				let that = this;
				axios.get(that.timattServerUrl + 'project/getAllProject')
					.then((res) => {
						if(res.data.code == 200){
							let result = res.data.data;
							that.projectList = result;
							if(projectList && projectList.length>0){
								this.initProjectListTable();
							}

						}else{
							let alData = res.data.msg;
							alert(alData);
						}
					}).catch(err => {

					});
			},

			clickProject(rowData,$element){
				this.$router.push(
					{
						path:'/project/projectDetail',
						query: {projectId: rowData.projectId},
					}
				);
				// this.$refs.projectDetail.initMemberList();
			},
			createProjectSuccess(){

			},
		},

	}
</script>

<style lang="stylus" scoped>
.projectList{
		max-width: 1200px
		.el-button{
			margin-bottom 15px;
		}
	}
</style>
