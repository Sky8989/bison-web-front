<template>
	<div id="createEvent">
		<el-button type="primary"  @click="createEventAssi"　style="float: left;" >创建</el-button>
		<el-dialog :title="theTitle" :visible.sync="dialogFormVisible" :close-on-click-modal="false" >
			<el-form :model="form" label-width="120px">
				<el-form-item label="标题">
					<el-input v-model="form.eventTitle" autocomplete="off"></el-input>
				</el-form-item>
				<el-form-item label="选择">
					<el-select v-model="form.submitter" placeholder="请选择提交人" autocomplete="off" filterable id = 'perSelect' >
						<el-option v-for="item in personsList" :label="item.name" :value="item.id" :key="item.id"></el-option>
					</el-select>

					<el-select v-model="form.departmentId" placeholder="选择部门">
						<el-option v-for="item in departmentList" :label="item.name" :value="item.id" :key="item.id"></el-option>
					</el-select>

					<el-select v-model="form.eventType" placeholder="选择类型">
						<el-option v-for="item in typsList" :label="item.name" :value="item.id" :key="item.id"></el-option>
					</el-select>
				</el-form-item>
				<!--<el-form-item label="日期">
					<el-col :span="11">
						<el-date-picker type="date" placeholder="Pick a date" v-model="form.date1" style="width: 100%;"></el-date-picker>
					</el-col>
					<el-col :span="11">
						<el-time-picker placeholder="Pick a time" v-model="form.date2" style="width: 100%;"></el-time-picker>
					</el-col>
				</el-form-item>-->

				<el-form-item label="内容">

					<quill-editor v-model="form.content"
								  ref="myQuillEditor"
								  @blur="onEditorBlur($event)"
								  @focus="onEditorFocus($event)"
								  @ready="onEditorReady($event)">
					</quill-editor>
				</el-form-item>
				<el-form-item>
					<el-button type="primary" @click="onFormSubmit">保存</el-button>
					<el-button @click="closeMethod">取消</el-button>
				</el-form-item>
			</el-form>
		</el-dialog>
	</div>
</template>

<script>

	import axios from 'axios';
	import Vue from 'vue';
	import 'quill/dist/quill.core.css';
	import 'quill/dist/quill.snow.css';
	import 'quill/dist/quill.bubble.css';

	import { quillEditor } from 'vue-quill-editor'

	export default{
		data(){
			return {
				departmentList:[],
				personsList:[],
				typsList:[],
				modelProjectName:'',
				modelProjectDescription:'',
				dialogFormVisible:false,
				isPublic:0,
				theTitle:'创建',
				form: {
					submitter: '',
					departmentId: '',
					eventType: '',
					eventTitle: '',
					content: ''
				},
				formLabelWidth: '120px',
				preUrl:'http://support.leaderment.com:10206/',
				// preUrl:'http://localhost:10206/',
				editform:{},
				formSubmitName:'',
				formDepartName:'',
				formTypeString:'',
			}
		},
		components: {
			quillEditor,
		},
		mounted(){

			this.init();
		},
		methods:{
			init() {
				let that = this;
				that.initBaseSelectData();
			},
			closeMethod(){
				this.dialogFormVisible = false;
			},
			createEventAssi(){
				let that = this;
				that.theTitle = '创建';
				that.dialogFormVisible = true;
				that.form = {
					submitter: '',
					departmentId: '',
					eventType: '',
					eventTitle: '',
					content: ''
				};


			},
			sendEmail(){
				let that = this;
				let param = that.form;

				param.submitterName = that.formSubmitName ;
				param.departmentName = that.formDepartName ;
				param.eventTypeName = that.formTypeString ;
				axios.post(that.preUrl + 'applyEvents/sendInsertEmail',param)
						.then((res) => {
							if(res.data.code == 200){
								let result = res.data.data;

							}else{

							}
						}).catch(err => {

				});
			},
			onFormSubmit(){
				let that = this;
				let param = that.form;
				debugger;
				if('' == param.submitter|| '' == param.eventTitle ){
					alert('请输入有效提交人或主题！');
					return;
				}

				if(that.theTitle == '创建'){
					axios.post(that.preUrl + 'applyEvents/',param)
							.then((res) => {
								if(res.data.code == 200){
									debugger;
									let result = res.data.data;
									that.initTable();
									that.sendEmail();

								}else{

								}
							}).catch(err => {

					});
				}else if(that.theTitle == '编辑'){

					let param = that.editform;
					if(undefined == that.editform.id)return;

					axios.put(that.preUrl + 'applyEvents/'+that.editform.id,that.form)
							.then((res) => {
								if(res.data.code == 200){
									
									that.initTable();
								}else{

								}
							}).catch(err => {

					});
				}


			},
			initBaseSelectData(){
				let that = this;
				axios.get(that.preUrl + 'applyEvents/getRealityData')
						.then((res) => {
							if(res.data.code == 200){
								let result = res.data.data;
								that.departmentList = result.departments;
								that.personsList = result.persons;
								that.typsList = result.types;
							}else{

							}
						}).catch(err => {

				});
			},

			onEditorBlur(quill) {　},
			onEditorFocus(quill) { },
			onEditorReady(quill) {　},
			onEditorChange({ quill, html, text }) {　this.form.content = html; },
			initTable(){

				this.dialogFormVisible =false;

				this.$emit('initTable');
			},
			initEditDisplayData(therow){
				let that = this;
				that.theTitle = '编辑';
				that.editform = {};
				that.editform = therow;
				that.form.content = therow.content;
				that.form.departmentId = therow.departmentId;
				that.form.eventTitle = therow.eventTitle;
				that.form.eventType = therow.eventType;
				that.form.submitter = therow.submitter;
				that.dialogFormVisible = true;
			},
		},
		watch:{
			'form.submitter':function(val){

				for(let per of this.personsList){
					if(per.id == val){
						this.formSubmitName = per.name;
						return;
					}
				}
			},

			'form.departmentId':function(val){

				for(let per of this.departmentList){
					if(per.id == val){
						this.formDepartName = per.name;
						return;
					}
				}
			},

			'form.eventType':function(val){

				for(let per of this.typsList){
					if(per.id == val){
						this.formTypeString = per.name;
						return;
					}
				}
			},
		},
	}
</script>

<style>
	#createEventModal .list-group-item{
		/*padding: 10px 15px !important;*/
	}
	.ql-container{
		min-height: 230px;
	}

</style>