<template>
    <div id="ganttTaskId">
        <div ref="gantt" class="left-container" />
        <perTaskFile ref="perTaskFile" :selectTask="selectTask"></perTaskFile>
    </div>

</template>

<script>
    import axios from 'axios';
    import gantt from 'dhtmlx-gantt'  // 引入模块
    import 'dhtmlx-gantt/codebase/dhtmlxgantt.css'
    import 'dhtmlx-gantt/codebase/locale/locale_cn'  // 本地化
    export default {
        name: "DhtmlxGantt",
        props: ["projectMemberGroupList"],
        components: {
            perTaskFile: resolve =>
                require(["components/project/detailOpt/perTaskFile.vue"], resolve),
        },
        data() {
            return {
                timattServerUrl:'',
                loginUrl:'',
                projectMemberGroupLists:[],
                addTaskLinkList:[],
                theTaskLinkList:[],
                theTaskNodeList:[],
                addTaskParamList:[],
                tasks:undefined,          //项目的任务列表
                selectTask:{},          //用于初始化每个task相关文件
            }
        },
        activated(){
            this.projectId = this.$parent.$route.query.projectId;
        },
        mounted() {
            this.loginUrl = this.URL_ROOT + "/login-service/";
            this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
            this.projectId = this.$parent.$route.query.projectId;
            this.initialize();
        },

        methods: {
            getRrojectMemberGroupList(){
                this.projectMemberGroupLists = this.projectMemberGroupList;


            },
            initialize(){
                this.initTaskMsg();
                this.initGanttMsg();
            },
            initGanttMsg(){
                let that=this;
//				gantt.detachAllEvents();
                this.initAfterAddTask();
                this.initAfterAddAndDeleteLink();
                this.initAfterDeleteTask();
                gantt.attachEvent("onTaskSelected", this.chooseTask);
                gantt.attachEvent("onAfterTaskUpdate", this.afterTaskUpdate);
                let labels = gantt.locale.labels;
                labels.column_owner = labels.section_owner = "Owner";
                gantt.serverList("memmber", this.projectMemberGroupList);
                //设置显示的列
                gantt.config.columns = [
                    {name:"text",       label:"任务名称",  tree:true, min_width:110 },
                    {name: "owner", label:"负责人", width: 70, align: "center",
                        template: function (item) {
                            return that.getMemberNameById(that.projectMemberGroupList, item.owner_id)
                        }
                    },
                    {name:"start_date", label:"开始时间", align:"center" , width:143},
                    {name:"end_date",   label:"完成时间",   align:"center" , width:143},
                    {name:"progress",   label:"进度",   align:"center" , template:function(obj){
                            let result = Math.round(obj.progress*100)+'%';
                            return result;
                        }
                    },
                    {name:"add",   label:"+",   align:"center" },
                ];
                gantt.config.lightbox.sections = [
                    {name: "description", height: 38, map_to: "text", type: "textarea", focus: true},
                    {name: "owner", height: 22, map_to: "owner_id", type: "select", options: that.projectMemberGroupList ,id:'ownerId'},
                    {name: "time", type: "duration", map_to: "auto",year_range: [2019, 2022]}
                ];
                gantt.templates.rightside_text = function(start, end, task){
                    return that.getMemberNameById(that.projectMemberGroupList, task.owner_id);
                };
                gantt.config.autofit = true;    //自适应尺寸
                gantt.config.grid_width = 550;
                gantt.config.autosize = "y";	//只自适应高度
                that.initGanttLocal();
                gantt.init(this.$refs.gantt);

//				document.getElementsByClassName('gantt_section_time')[0].firstElementChild.lastElementChild.firstElementChild.selected = true;
            },
            initAfterAddTask(){
                let that = this;

                let thisProjectId = this.$parent.projectId;
                that.attachAfterAddId = gantt.attachEvent("onAfterTaskAdd", function(id,item){
                    if(undefined == item.text)return;
                    let newdate = new Date(item.start_date) ;
                    let date_str = that.initStandartDateStr(newdate);
                    let param = {
                        taskNodeText : item.text,
                        taskParentId : item.parent,
                        taskStartDateStr : date_str,
                        userId : item.owner_id,
                        taskDuration : item.duration,
                        taskProgress : 0,
                        taskNodeId : item.id,
                    };

                    that.initAddTaskNodeParam(param);
                });
//				gantt.detachEvent(that.attachAfterAddId);
            },
            initGanttLocal(){
                gantt.locale = {
                    date:{
                        month_full:["1月", "2月", "3月", "4月", "5月", "6月", "7月",
                            "8月", "9月", "10月", "11月", "12月"],
                        month_short:["1月", "2月", "3月", "4月", "5月", "6月", "7月",
                            "8月", "9月", "10月", "11月", "12月"],
                        day_full:["周日","周一", "周二", "周三", "周四", "周五", "周六"],
                        day_short:["周日","周一", "周二", "周三", "周四", "周五", "周六"]
                    },
                    labels:{
                        new_task:"新题案",
                        icon_save:"保存",
                        icon_cancel:"取消",
                        icon_details:"Details",
                        icon_edit:"编辑",
                        icon_delete:"删除",
                        confirm_closing:"关闭",//Your changes will be lost, are you sure ?
                        confirm_deleting:"题案将被删除,请再次确定!",

                        section_description:"题案名称",
                        section_time:"预设时间",
                        section_owner:'负责人',

                        /* link confirmation */

                        confirm_link_deleting:" 关联将被删除,请再次确定!",
                        link_from: "从 ",
                        link_to: "到 ",
                        link_start: "Start",
                        link_end: "End",

                        minutes: "Minutes",
                        hours: "Hours",
                        days: "Days",
                        weeks: "Week",
                        months: "Months",
                        years: "Years"
                    }
                };
            },
            initAfterAddAndDeleteLink(){
                let that = this;
                let thisProjectId = this.projectId;
                that.attachAfterAddLinkId = gantt.attachEvent("onAfterLinkAdd", function(id,item){
                    if(undefined == item.id)return;
                    let param = {
                        taskLinkId : item.id,
                        projectId : thisProjectId,
                        taskDuration : item.duration,
                        source : item.source,
                        target : item.target,
                        type: item.type,
                    };
                    that.initAddTaskLinksParam(param);
                });
                gantt.attachEvent('onAfterLinkDelete',function(id,item){

                    axios.delete(that.timattServerUrl + 'taskLinks/deleteTaskLink/' + id ).then((res) => {

                    }).catch(err => {
                        that.$root.requestError(err);
                    });

                });
            },
            initAfterDeleteTask(){
                let that = this;
                gantt.attachEvent("onAfterTaskDelete", function(id,item){
                    if(undefined == id || 0 == id)return;
                    axios.delete(that.timattServerUrl + 'taskNodes/deleteTaskNodeById/' + id).then((res) => {

                        that.refreshInitMilestone();
                    }).catch(err => {
                        that.$root.requestError(err);
                    });
                });
            },
            getMemberNameById(list, id)	{
                for (var i = 0; i < list.length; i++) {
                    if (list[i].key == id)
                        return list[i].label || "";
                }
                return "";
            },
            //任务事件更新事件
            afterTaskUpdate(id,item){
                let that = this;

                if(undefined == item.start_date)return;

                let param = {
                    taskNodeId : id,
                    taskProgress : item.progress,
                    taskDuration : item.duration,
                    taskStartDate : item.start_date,
                    userId:item.owner_id,
                    taskNodeText:item.text,
                };
                axios.put(that.timattServerUrl + 'setUpProjectMsg/updateOneProgress',param).then((res) => {

                    if(res.data.code == 200){
                        that.refreshInitMilestone();
                    }else{
                    }
                }).catch(err => {
                    that.$root.requestError(err);
                });
            },
            refreshInitMilestone(){
                this.$emit("milestoneSuccess");
            },
            //选中任务事件
            chooseTask(id){
                let that=this;
                //从甘特图获取到任务的基础信息

               if(that.$refs.perTaskFile){
                   that.$refs.perTaskFile.initTaskId(id);
                   that.selectTask=gantt.getTask(id);
               }
            },
            initAddTaskLinksParam(param){
                let that = this;
                let thisProjectId = that.projectId;
                param.projectId = thisProjectId;
                that.addTaskLinkList.push(param);
            },

            initAddTaskNodeParam(param){

                let that = this;
                let thisProjectId = that.projectId;
                let thisTaskNodeId = param.taskNodeId;
                param.projectId = thisProjectId;
                that.addTaskParamList.push(param);
            },
            initTaskMsg(){
                let that = this;

                if(undefined == that.projectId)return;
                axios.get(that.timattServerUrl + 'setUpProjectMsg/getAllTaskByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){
                            let nodeList = res.data.data;
                            that.theTaskNodeList.length = 0 ;
                            let the_arr = [];
                            for(let oneNode of nodeList){
                                let onedata = {
                                    'id' : oneNode.taskNodeId ,
                                    'user' : oneNode.userName,
                                    'owner_id': oneNode.userId,
                                    'text' : oneNode.taskNodeText,
                                    'start_date' : new Date(oneNode.taskStartDate),
                                    'duration' : oneNode.taskDuration,
                                    'progress' : oneNode.taskProgress,
                                    "parent" : oneNode.taskParentId,
                                    'open' : false,
                                };
                                the_arr.push(onedata);
                            }
                            that.theTaskNodeList=the_arr;
                            that.initTaskLinkList();

                        }else{

                        }
                    }).catch(err => {

                    });
            },
            initTaskLinkList(){
                let that = this;
                if(undefined == that.projectId || 0 ==that.projectId)return;
                axios.get(that.timattServerUrl + 'taskLinks/getTaskLinksByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){
                            let result = res.data.data;
                            if(result.length<1){
                                that.initTheGankDisplay();
                                return;
                            }
                            for(let oneLink of result){
                                oneLink.id = oneLink.taskLinkId;
                            }
                            that.theTaskLinkList = result;
                            that.initTheGankDisplay();
                        }else{
                        }
                    }).catch(err => {
                    that.$root.requestError(err);
                });
            },
            initTheGankDisplay(){
                let that = this;
                gantt.clearAll();
                that.tasks={"data":that.theTaskNodeList,"links": that.theTaskLinkList };
                gantt.init(that.$refs.gantt);
                gantt.parse(that.tasks);
            },
            ganttRefreshSelect(){
                gantt.init(this.$refs.gantt);
            },
            //初始化标准的日期格式./
            initStandartDateStr(param){
                let standardMonth = param.getMonth()+1;
                let tem_month = (standardMonth+"").trim().length == 1?('0'+ standardMonth).trim():standardMonth;
                let tem_date_number = (param.getDate()+"").trim().length == 1?('0'+param.getDate()).trim():param.getDate();
                let tem_str = param.getFullYear()+'-'+tem_month+'-'+tem_date_number + ' 00:00:00' ;
                return tem_str;
            },
        },
        watch:{
            addTaskParamList:function(value){
                let that = this;
                if(value.length<1)return;

                let theParam = value[value.length-1];
                axios.post(that.timattServerUrl + 'taskNodes/addTaskNode',theParam).then((res) => {
                    if(res.data.code == 200){

                        if( 0 == theParam.taskParentId){

                            that.refreshInitMilestone();
                        }
                    }else{
                    }
                }).catch(err => {

                });
            },
            projectMemberGroupList:{
                handler(newValue, oldValue) {
                    console.log(newValue,oldValue)
                },
                deep: true
            },
            addTaskLinkList:function(value){
                let that = this;
                if(value.length<1)return;
                let theParam = value[value.length-1];

                axios.post(that.timattServerUrl + 'taskLinks/addTaskLink',theParam).then((res) => {
//						that.initTaskMsg();
                }).catch(err => {

                });
            },
            projectId:function(value){
                let that = this;
                that.initialize();
            },
        },


    }
</script>

<style scoped>

</style>