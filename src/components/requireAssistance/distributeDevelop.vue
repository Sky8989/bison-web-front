<template>
    <div id="distributeDevelopId">
        <el-dialog
                title="提示"
                :visible.sync="dialogVisible"
                width="30%"
                :before-close="handleClose">
            <span>确认要删除这条事件么？？？？</span>
            <span slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="confirmDelete">确 定</el-button>
            </span>
        </el-dialog>

        <createDistribute ref="create_distribute" @initAllData='initAllData'></createDistribute>
        <el-table
                :data="tableData"
                style="width: 100%">
            <el-table-column
                    fixed
                    prop="submitterName"
                    label="提交者"
                    width="160">
            </el-table-column>
            <el-table-column
                    prop="departmentName"
                    label="部门"
                    sortable
                    width="150">
            </el-table-column>
            <!-- [硬件事件,软件事件,浏览网页事件,U8事件,WIFI事件] -->
            <el-table-column
                    prop="eventTypeName"
                    label="类型"
                    sortable
                    width="120">
            </el-table-column>
            <el-table-column
                    prop="eventTitle"
                    label="标题"
                    sortable
                    width="160">
            </el-table-column>
            <el-table-column
                    prop="createTime"
                    label="提交时间"
                    sortable
                    width="300">
            </el-table-column>
            <el-table-column
                    prop="statusName"
                    label="状态"
                    sortable
                    width="150">
            </el-table-column>
            <el-table-column
                    prop="developerName"
                    label="对接人"
                    sortable
                    width="150">
            </el-table-column>
            <el-table-column
                    prop="exTime"
                    label="期待完成时间"
                    sortable
                    width="300">
            </el-table-column>
            <el-table-column
                    prop="developRating"
                    label="处理评分"
                    sortable
                    width="90">
            </el-table-column>
            <!--富文本框编辑,可贴图片,表格-->
            <el-table-column
                    fixed="right"
                    prop='content'
                    label="操作"
                    width="400">
                <template slot-scope="scope">
                    <el-button @click="handleEditClick(scope.row)" type="text" >编辑</el-button>
                    <el-button @click="handleDeleteClick(scope.row)" type="text" >删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>

    import axios from 'axios';
    import createDistribute from 'components/requireAssistance/createDistribute';

    export default {
        name: "distributeDevelop",
        components: {
            createDistribute,
        },
        data () {
            return {
                preUrl:'http://support.leaderment.com:10206/',
                tableData:[],
                dialogVisible:false,
                temDeleteRow : {},
            }
        },
        methods:{
            init(){

                this.initAllData();
            },
            handleEditClick(therow){
                this.$refs.create_distribute.initEditDisplayDisData(therow);
            },
            handleClose(done) {
                let that = this;
                this.$confirm('确认关闭？')
                    .then(_ => {
                        done();

                    })
                    .catch(_ => {});
            },
            confirmDelete(){
                let that = this;
                that.dialogVisible = false;
                if(undefined ==  that.temDeleteRow.id)return;
                axios.delete(that.preUrl + 'developRequireds/'+that.temDeleteRow.id)
                    .then((res) => {
                        if(res.data.code == 200){
                            that.initAllData();
                        }else{

                        }
                    }).catch(err => {

                });
            },
            handleDeleteClick(therow){
                let that = this;
                that.temDeleteRow = {};
                that.temDeleteRow = therow;
                that.dialogVisible = true;
            },
            initAllData(){
                let that = this;

                axios.get(that.preUrl + 'developRequireds/')
                    .then((res) => {
                        if(res.data.code == 200){
                            let result = res.data.data;
                            that.tableData = result;
                        }else{

                        }
                    }).catch(err => {

                });

            },
        },
        mounted:function(){
            this.init();
        },
    }
</script>

<style scoped>

</style>
