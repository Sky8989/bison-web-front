<template>
    <div id="createDistribute">
        <el-button type="primary"  @click="createDistributeFunc"　style="float: left;" >创建</el-button>
        <el-dialog :title="theDisTitle" :visible.sync="dialogDisFormVisible">
            <el-form :model="disForm" label-width="120px">
                <el-form-item label="标题">
                    <el-input v-model="disForm.eventTitle" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="选择">
                    <el-select v-model="disForm.submitter" placeholder="请选择提交人" autocomplete="off" id = 'perSelect' >
                        <el-option v-for="item in personsList" :label="item.name" :value="item.id" :key="item.id"></el-option>
                    </el-select>

                    <el-select v-model="disForm.departmentId" placeholder="选择部门">
                        <el-option v-for="item in departmentList" :label="item.name" :value="item.id" :key="item.id"></el-option>
                    </el-select>

                    <el-select v-model="disForm.eventType" placeholder="选择类型">
                        <el-option v-for="item in typsList" :label="item.name" :value="item.id" :key="item.id"></el-option>
                    </el-select>

                    <el-select v-model="disForm.developPerson" placeholder="请选对接交人" autocomplete="off" >
                        <el-option v-for="item in personsList" :label="item.name" :value="item.id" :key="item.id"></el-option>
                    </el-select>

                </el-form-item>
                <el-form-item label="期待截止日期">
                    <el-col :span="11">
                        <el-date-picker type="date" placeholder="Pick a date" v-model="disForm.date1" style="width: 100%;"></el-date-picker>
                    </el-col>
                    <el-col :span="11">
                        <el-time-picker placeholder="Pick a time" v-model="disForm.date2" style="width: 100%;"></el-time-picker>
                    </el-col>
                </el-form-item>

                <el-form-item label="功能描述">
                    <quill-editor v-model="disForm.usedToDec"
                                  ref="usedToDecQuill"
                                  @blur="onDisEditorBlur($event)"
                                  @focus="onEditorDisFocus($event)"
                                  @ready="onEditorDisReady($event)">
                    </quill-editor>
                </el-form-item>

                <el-form-item label="数据信息">
                    <quill-editor v-model="disForm.dataContent"
                                  ref="dataContentQuill"
                                  @blur="onDataContentEditorBlur($event)"
                                  @focus="onDataContentEditorFocus($event)"
                                  @ready="onDataContentEditorReady($event)">
                    </quill-editor>
                </el-form-item>

                <el-form-item>
                    <el-button type="primary" @click="onDisFormSubmit">保存</el-button>
                    <el-button @click="closeTheMethod">取消</el-button>
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
    export default {
        name: "createDistribute",
        data(){
            return {
                departmentList:[],
                personsList:[],
                typsList:[],
                developerList:[],
                modelName:'',
                modelDescription:'',
                dialogDisFormVisible:false,
                theDisTitle:'创建',
                disForm: {
                    submitter: '',
                    departmentId: '',
                    eventType: '',
                    eventTitle: '',
                    usedToDec: '',
                    dataContent:'',
                    developPerson:'',
                    date1:'',
                    date2:'',
                },
                // formLabelWidth: '120px',
                preUrl:'http://support.leaderment.com:10206/',

                editform:{},
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
            closeTheMethod(){
                this.dialogDisFormVisible = false;
            },
            createDistributeFunc(){
                let that = this;
                that.theDisTitle = '创建';
                that.dialogDisFormVisible = true;
                that.disForm = {
                    submitter: '',
                    departmentId: '',
                    eventType: '',
                    eventTitle: '',
                    usedToDec: '',
                    dataContent:'',
                    developPerson:'',
                    date1:'',
                    date2:'',
                };


            },

            onDisFormSubmit(){
                let that = this;
                let param = that.disForm;
                if(undefined == param.submitter || undefined == param.departmentId  || undefined == param.eventTitle )return;

                let tempMonth =  parseInt(param.date1.getMonth())+1;
                let theMonth = tempMonth.toString().length>1?tempMonth+1:'0'+tempMonth;
                let theDate = param.date1.getDate().toString().length>1?param.date1.getDate():'0'+param.date1.getDate();
                let theHours = param.date2.getHours().toString().length>1?param.date2.getHours():'0'+param.date2.getHours();
                let theMinutes = param.date2.getMinutes().toString().length>1?param.date2.getMinutes():'0'+param.date2.getMinutes();
                let theSeconds = param.date2.getSeconds().toString().length>1?param.date2.getSeconds():'0'+param.date2.getSeconds();

                let tempTime = param.date1.getFullYear()+'-'+theMonth+'-'+theDate+' ' +theHours+':'+theMinutes+':'+theSeconds;
                param.exTime = tempTime;
                if(that.theDisTitle == '创建'){

                    axios.post(that.preUrl + 'developRequireds/',param)
                        .then((res) => {
                            if(res.data.code == 200){
                                let result = res.data.data;
                                that.initTable();
                            }else{

                            }
                        }).catch(err => {

                    });
                }else if(that.theDisTitle == '编辑'){

                    let param = that.editform;
                    if(undefined == that.editform.id)return;

                    axios.put(that.preUrl + 'developRequireds/'+that.editform.id,that.disForm)
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
                            if(that.personsList.length > 0){
                                for(let per of that.personsList){
                                    if(per.id == 4){
                                        developerList.push(per);
                                    }
                                }

                            }
                        }else{

                        }
                    }).catch(err => {

                });
            },

            onDisEditorBlur(quill) {　},
            onEditorDisFocus(quill) { },
            onEditorDisReady(quill) {　},
            onEditorDisChange({ quill, html, text }) {　this.disForm.usedToDec = html; },

            onDataContentEditorBlur(quill) {　},
            onDataContentEditorFocus(quill) { },
            onDataContentEditorReady(quill) {　},
            onDataContentEditorChange({ quill, html, text }) {　this.disForm.usedToDec = html; },


            initTable(){

                this.dialogDisFormVisible =false;

                this.$emit('initAllData');
            },
            initEditDisplayDisData(therow){
                let that = this;
                that.theDisTitle = '编辑';
                that.editform = {};
                that.editform = therow;
                that.disForm.usedToDec = therow.usedToDec;
                that.disForm.dataContent = therow.dataContent;
                that.disForm.departmentId = therow.departmentId;
                that.disForm.eventTitle = therow.eventTitle;
                that.disForm.eventType = therow.eventType;
                that.disForm.submitter = therow.submitter;
                that.disForm.developPerson = therow.developPerson;
                that.dialogDisFormVisible = true;

                if(undefined != therow.exTime){
                    let oldExDate = new Date(therow.exTime);
                    that.disForm.date1 = oldExDate;
                    that.disForm.date2 = oldExDate;

                }

            },
        },
    }
</script>

<style scoped>

</style>