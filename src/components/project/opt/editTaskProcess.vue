<template>
    <span id="editTaskProcess">
		<a href="#" class="fa fa-anchor ml-2" data-toggle="modal" data-target="#taskProcess"> 进度调整</a>
		<div class="modal fade" id="taskProcess" tabindex="-1" role="dialog" aria-labelledby="taskProcessModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
		                <i class="fa fa-users"></i> 进度调整
		            </div>
		            <div class="modal-body">
		            	<div class="row">
		            		<table id="editOrderAndDelayTAble"></table>
		            	</div>
		            </div>
		            <div class="modal-footer">
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
	export default{
		name:"editTaskProcess",
		props: {

		},
		data(){
			return{
				brandList:[],
				buList:[],
				projectId : 0,
				changeTabData:[],

			}
		},
		methods: {
			init(){
				if(this.$store.state.baseData) {
					//初始化变量
					this.serverUrl = this.$root.pageHandlers;
					this.timattServerUrl = this.$root.timattHandlers;
					this.token = this.$store.state.baseData.userInfo.token;
					this.projectId = this.$parent.$route.query.projectId;

					this.initChangeTabData();
					this.initOrderTableData();
				}
			},
			initChangeTabData(){
				let that = this;
				if( undefined == that.projectId || 0 == that.projectId)return;
				axios.get(that.timattServerUrl + 'setUpProjectMsg/getAllTaskByProjectId/'+ that.projectId )
						.then((res) => {
							if(res.data.code == 200){

								that.changeTabData.length = 0 ;
								that.changeTabData=res.data.data;
								that.initChangeTable();
							}else{

							}
						}).catch(err => {
					that.$root.requestError(err);
				});
			},
			initChangeTable(){
				let that = this;
				$('#editOrderAndDelayTAble').bootstrapTable('destroy');
				$('#editOrderAndDelayTAble').bootstrapTable({
					pagination: true,
					pageSize: 10,
					pageNumber:1,
					pageList: [10, 20, 50, 100, 200, 500],
					sidePagination:"client",
					columns: [
						{
							title: '任务名称',
							field: "taskNodeText",
							width: 120,
						},
						{
							field: "sortorder",
							title: "任务顺序",
							width: 80,
							editable: true,
							formatter: function (value, row, index) {
								let result ; let template ;
								if(undefined == value){
									result = 0;
								}else{
									result = value;
								}
								let theRowId = 'sortOrderId'+ index;
								template = '<input class="sortOrderCla" value="'+ result
										+ '" id= "' + theRowId + '" ></input>';
								return template;
							},
							events: {
								'change .sortOrderCla': function(e, value, row, index) {

									that.dealsortOrder(row,index);
								}
							},

						},
					],
					data: that.changeTabData,

				});

			},
			initOrderTableData(){
				let that = this;
			},
			dealsortOrder(row, index){
				let theRowId = 'sortOrderId'+ index;
				let that = this;
				let temvalue = document.getElementById(theRowId).value;
				if( undefined == row.taskNodeId ||undefined == temvalue || isNaN(temvalue))return;
				let param = {
					taskNodeId : row.taskNodeId,
					sortorder : temvalue
				}
				axios.put(that.timattServerUrl + 'taskNodes/updateTaskNodeOrder', param )
						.then((res) => {
							if(res.data.code == 200){
								that.initChangeTabData();
								that.$parent.repeatViewProcess();
								that.$parent.refreshInitMilestone();
							}else{

							}
						}).catch(err => {
					that.$root.requestError(err);
				});
			},
		},
		mounted: function() {
			let that=this;
			that.init();
			//请求接口
		},
		watch:{

		},
	}
</script>

<style scoped>

</style>