<template>
	<div id="projectDetail" class="projectDetail">
		<h2 class="title">项目名称：{{projectName}}</h2>
		<div id="detailRowId">
			<el-button type="success" size="mini" @click="_goBack" class="display">返回列表</el-button>
			<allFile ref="allFile" :projectId="projectId" @milestoneSuccess="refreshTheData" class="display"></allFile>
			<allImage ref="allImage" :projectId="projectId" @milestoneSuccess="refreshTheData" class="display"></allImage>
			<productInfomation ref="productInfomation"  v-if="!isProjectReadOnly" :projectId="projectId" @milestoneSuccess="refreshTheData" class="display"></productInfomation>
			<projectMemberEdit ref="projectMemberEdit"  v-if="!isProjectReadOnly" :projectId="projectId" :projectName="projectName" :projectDiscription="projectDiscription"
									   @memberSuccess="initMemberList" @preInitProjectMsg="preInitProjectMsg" class="display"></projectMemberEdit>
			<el-button type="danger" size="mini"  v-if="!isProjectReadOnly" icon="el-icon-delete" @click="deleteProject" class="display"></el-button>
		</div>

		<el-tabs v-model="activeTabName" @tab-click="tabClickFun">
			<el-tab-pane label="项目履历" name="first">
				<el-row :gutter="20">
					<el-col :span="6">
						<div style="vertical-align: top;">
							<articleManager ref="articleManager" :projectId="projectId":projectMemberGroupList="projectMemberGroupList" @milestoneSuccess="refreshTheData"></articleManager>
						</div>
					</el-col>
					<el-col :span="14">
						<div style="vertical-align: top;">
							<imageManager ref="imageManager" :projectId="projectId":projectMemberGroupList="projectMemberGroupList" @milestoneSuccess="refreshTheData"></imageManager>
						</div>
					</el-col>
				</el-row>
			</el-tab-pane>
			<el-tab-pane label="项目进度" name="second">
				<el-button type="primary" size="mini" @click="repeatViewProcess">重渲进度</el-button>
				<milestone ref="milestone" :projectId="projectId" @milestoneSuccess="refreshInitMilestoneMsg"></milestone>
				<ganttTask ref="ganttTask" :projectId="projectId":projectMemberGroupList="projectMemberGroupList" @milestoneSuccess="refreshInitMilestoneMsg"></ganttTask>
			</el-tab-pane>
			<el-tab-pane label="项目变更" name="third">暂无变更</el-tab-pane>
		</el-tabs>
	</div>
</template>

<script>
	import axios from 'axios';

	export default {

		mounted() {
			this.loginUrl = this.URL_ROOT + "/login-service/";
			this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
			this.projectId = this.$parent.$route.query.projectId;
			this.userId = this.$store.state.LoginedUser.userId;
			this.currentUserId = this.$store.state.LoginedUser.userId;

			this.projectId = this.$parent.$route.query.projectId;
			this.initProjectMsg();
			this.initMemberList();
			this.initialize();
		},
		components: {
			ganttTask: resolve =>
					require(["components/project/detailOpt/ganttTask.vue"], resolve),
			articleManager: resolve =>
					require(["components/project/detailOpt/articleManager.vue"], resolve),
			imageManager: resolve =>
					require(["components/project/detailOpt/imageManager.vue"], resolve),
			milestone: resolve =>
					require(["components/project/detailOpt/milestone.vue"], resolve),
			productInfomation: resolve =>
					require(["components/project/detailOpt/productInfomation.vue"], resolve),
			projectMemberEdit: resolve =>
					require(["components/project/detailOpt/projectMemberEdit.vue"], resolve),
			allFile: resolve =>
					require(["components/project/detailOpt/allFile.vue"], resolve),
			allImage: resolve =>
					require(["components/project/detailOpt/allImage.vue"], resolve),
		},
		data() {
			return {
				projectId:'',
				timattServerUrl:'',
				loginUrl:'',
				userId : '',
				projectName:"",
				activeTabName:"first",
				projectDiscription:"",
				projectMemberGroupList: [],
				isProjectReadOnly:false,
			}
		},
		activated(){
			this.projectId = this.$parent.$route.query.projectId;
			this.initProjectMsg();
			this.initMemberList();
		},
		methods: {
			initialize(){
				this.initProjectMsg();
				this.initUserList();
			},

			_goBack(){
				this.$router.push(
						{ path:'/project'}
				);
				this.activeTabName = 'first';
			},
			initParam() {
				if(this.$store.state.baseData) {
					//初始化变量
					this.initMemberList();
				}
			},
			repeatViewProcess(){
				this.$refs.ganttTask.initialize();
			},
			refreshTheData(){
				
			},
			refreshInitMilestoneMsg(){
				let that = this;
				that.$refs.milestone.refreshInitMilestone();
			},
			openUploadPage(){
				let that = this;
				if( undefined == that.selectTask.id || 0 == that.selectTask.id )return;
//				this.$router.push('/project/uploadFilePage?taskId='+ that.selectTask.id);
				let routeData = this.$router.resolve({ path: '/project/uploadFilePage?taskId='+ that.selectTask.id });
				window.open(routeData.href, '_blank');
			},


			//初始化甘特图
			addAuditingMethod(){
				let that = this;
				that.$refs.auditingMemberManage.initBaseParam();
			},


			tabClickFun(theTab){
				let that = this;
				if( "second" == that.activeTabName){
					this.repeatViewProcess();
				}
			},
			initMemberList(){
				console.log("```````")
				let that = this;
				if(undefined == that.projectId || 0 == that.projectId)return;
				axios.get(that.timattServerUrl + 'project/getProjectMembers/'+ that.projectId )
						.then((res) => {
							if(res.data.code == 200){
								let theResult = res.data.data;

								that.selectedMemberList = theResult.relUsers;
								that.initUserSelect(that.selectedMemberList);
								that.refreshSelect();
							}else{
							}
						}).catch(err => {

						});
			},
			preInitProjectMsg(){
				this.initProjectMsg();
			},
			refreshSelect(){
				this.$refs.ganttTask.ganttRefreshSelect();
			},
			initUserSelect(param){
				let that = this;
				if(param.length<1)return;
				that.projectMemberGroupList.length = 0;
				for(let oneUser of param){
					let one_item = {
						key : oneUser.userId,
						label : oneUser.userName,
					};
					that.projectMemberGroupList.push(one_item);
				}
				console.log(that.projectMemberGroupList)
				this.$refs.ganttTask.getRrojectMemberGroupList();
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
			initProjectMsg(){

				let that = this;
				if(undefined == that.projectId || 0 ==that.projectId)return;
				axios.get(that.timattServerUrl + 'project/'+ that.projectId )
						.then((res) => {
							if(res.data.code == 200){
								let theResult = res.data.data;
								that.projectMessage = theResult;
								//项目基础数据
								that.projectName = theResult.projectName;
								that.projectDiscription = theResult.projectDiscription;
								that.$refs.projectMemberEdit.modelProjectName = theResult.projectName;
								that.$refs.milestone.refreshInitMilestone();
							}else{
							}
						}).catch(err => {
				});
			},
			deleteProject(){
				let that = this;
				this.$confirm('此操作将永久删除该项目, 是否继续?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {

					let thatone = this;
					if(undefined == that.projectId && 0 == that.projectId)return;
					axios.get(that.timattServerUrl + 'project/counterfeitDelete/'+ that.projectId )
							.then((res) => {
								if(res.data.code == 200){
									thatone.$message({ type: 'success',message: '删除成功!'});
									that.$router.push("/project");
								}else{

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
			initMileStoneMessage(theParam){
				if(undefined == theParam || theParam.size<1)return;
				let that = this;
				let tem_milestone = [];
				//进度条

				for( let oneItem of theParam ){
					let milestoneName= oneItem.projectMilestone +' ('+ oneItem.stoneDateStr +')';
					tem_milestone.push(milestoneName);
				}
				that.initStoneNewStep();

				that.milestoneList = tem_milestone ;

			},
			initStoneNewStep(){
				let that = this;
				if(undefined == that.projectId || 0 == that.projectId)return 0;
				let result = 0;
				axios.get(that.timattServerUrl + 'taskNodes/getStoneStepByProId/'+that.projectId, {
					headers: {
						"Access-Token": this.token
					}
				})
						.then((res) => {
							if(res.data.code == 200){
								that.nowStep　= 0 ;
								result= res.data.data;
								if(result && 0 != result)that.nowStep = result;
							}else{
							}
						}).catch(err => {

				});


			},

			//初始化标准的日期格式./
			initStandartDateStr(param){
				let standardMonth = param.getMonth()+1;
				let tem_month = (standardMonth+"").trim().length == 1?('0'+ standardMonth).trim():standardMonth;
				let tem_date_number = (param.getDate()+"").trim().length == 1?('0'+param.getDate()).trim():param.getDate();
				let tem_str = param.getFullYear()+'-'+tem_month+'-'+tem_date_number + ' 00:00:00' ;
				return tem_str;
			},
			initTaskFileList(){
				let that = this;
				if( undefined == that.selectTask.id || 0 == that.selectTask.id )return;
				//请求任务的相关文件
				let taskNodeId = that.selectTask.id;
				axios.get(that.timattServerUrl + 'taskFiles/getFilesMessageByTaskId/'+ taskNodeId,{
					headers: {
						"Access-Token": this.token
					}
				}).then((res) => {
					if(res.data.code == 200){
						that.selectTaskFileList = res.data.data;
						that.initTaskFileTable();
					}else{
					}
				}).catch(err => {
				});

			},
			oneFileNameOnclick(){
				let that = this;
				that.$refs.fileHistoryInfo.refreshFileHistroyData();
			},
			//---------以上为控件事件--------------------
			//---------以下为其他公用方法--------------------

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
			//---------以上为其他公用方法--------------------
		}
	}
</script>

<style lang="stylus" scoped>
#detailRowId {
		.display{
			display inline-block;
			margin 0 10px 0 0;
		}
	}
	
	.left-container {
		height: 600px;
	}
	.ql-container{
		min-height: 210px;
	}
	.image-viewer-close{
		width: 110px;
		height: 110px;
	}
	.projectDetail{
		.title{
			font-size 16px;
			padding-bottom 10px
			color: #303133;
		}
	}
</style>

