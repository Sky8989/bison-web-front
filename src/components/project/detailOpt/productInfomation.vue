<template>
    <div id = "productInfomationId">
        <el-button type="primary" size="mini" @click="openProductModel">产品信息</el-button>

        <el-dialog
                :visible.sync="status"
                :width="'600px'"
                :title="theTitle"
                :close-on-click-modal="false">
            <!--<h3 id="myModalLabel">  {{productSku?productSku:'产品'}}信息</h3>-->
            <el-form :model="formedit":label-width="'100px'">
                <el-row :gutter="20" id="detailRowId">
                    <el-col :span="12">
                        <el-form-item label="长度(厘米)：">
                            <el-input v-bind:disabled="isProjectReadOnly" v-model="longSize"  placeholder="(厘米)："></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="宽度(厘米)：">
                            <el-input v-bind:disabled="isProjectReadOnly" v-model="widthSize"  placeholder="(厘米)："></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20" id="detailRowId">
                    <el-col :span="12">
                        <el-form-item label="高度(厘米)：">
                            <el-input v-bind:disabled="isProjectReadOnly" v-model="heightSize"  placeholder="(厘米)："></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="重量(克)：：">
                            <el-input v-bind:disabled="isProjectReadOnly" v-model="weight"  placeholder="(克)："></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20" id="detailRowId">
                    <el-col :span="12">
                        <el-form-item label="SKU：">
                            <el-input v-bind:disabled="editProductSku" v-model="productSku"  placeholder="(Product SKU)："></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="体积：">
                            <el-input v-bind:disabled="isProjectReadOnly" v-model="volume"  placeholder="(平方厘米)："></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20" id="detailRowId">
                    <el-col :span="12">
                        <el-form-item label="业务部：">
                            <el-select v-model="selectedBU" default-first-option v-bind:disabled="isProjectReadOnly" placeholder="业务部">
                                <el-option
                                        v-for="item in buList"
                                        :key="item.businessUnitId"
                                        :label="item.businessUnit"
                                        :value="item.businessUnitId">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="品牌：">
                            <el-select v-model="selectedBrand" filterable default-first-option v-bind:disabled="isProjectReadOnly" placeholder="品牌">
                                <el-option
                                        v-for="item in brandList"
                                        :key="item.brandId"
                                        :label="item.brandName"
                                        :value="item.brandId">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="20" id="detailRowId">
                    <el-col :span="12">
                        <el-form-item label="类别：">
                            <el-select v-model="selectedCategory" filterable default-first-option v-bind:disabled="isProjectReadOnly" placeholder="类别">
                                <el-option
                                        v-for="item in categoryList"
                                        :key="item.productCategoryId"
                                        :label="item.productCategory"
                                        :value="item.productCategoryId">
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item label="描述(英文)：">
                    <el-input type="textarea" :rows="2" placeholder="English" v-bind:disabled="isProjectReadOnly" v-model="description_en"></el-input>
                </el-form-item>
                <el-form-item label="描述(中文)：">
                    <el-input type="textarea" :rows="2" placeholder="中文" v-bind:disabled="isProjectReadOnly" v-model="description_zh"></el-input>
                </el-form-item>
                <el-form-item label="备注：">
                    <el-input type="textarea" :rows="2" placeholder="请输入内容" v-bind:disabled="isProjectReadOnly" v-model="remark"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="_show">取 消</el-button>
                <el-button type="primary" @click="editProduct()">保存</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import axios from 'axios';
    import Vue from 'vue';
    export default{
        name:"productInfomation",
        props: {
            isProjectReadOnly:false,
            roleId:0,
        },
        data(){
            return{
                brandList:[],
                buList:[],
                categoryList:[],
                editProductSku:true,
                ////////////product form information
                longSize:0,
                widthSize:0,
                heightSize:0,
                weight:0,
                volume:'',
                productSku:'',
                selectedBrand:'',
                selectedBU:'',
                selectedCategory:'',

                description_en:"",
                description_zh:"",
                remark:"",
                projectId:0,
                status: false,
                formedit:{},
                theTitle:"产品信息",
                ////////////product form information

            }
        },
        mounted: function() {
            this.projectId = this.$parent.$route.query.projectId
            this.init();
        },
        activated(){
            this.projectId = this.$parent.$route.query.projectId;
            this.init();
        },
        methods: {
            init(){

                    //初始化变量
                    this.loginUrl = this.URL_ROOT + "/login-service/";
                    this.timattServerUrl = this.URL_ROOT + "/setUpProduct-service/";
                    this.projectId = this.$parent.$route.query.projectId;
                    this.brandList = [];
                    this.buList = [];
                    this.userId = this.$store.state.LoginedUser.userId;

                    this.initListMsg();

            },
            initListMsg(){
                this.initBrandList();
                this.initBusinessUnitList();
                this.initCategoryList();
            },
            initCategoryList(){
                let that = this;
                axios.get(that.loginUrl+"productCategory/findCategory").then((res) =>{
                    if(res.data.code == 200){
                        that.categoryList = res.data.data;
                        this.initProductMsg();
                    }else{
                    }
                }).catch(err => {
                    that.$root.requestError(err);
                });
            },
            initBrandList(){
                let that = this;
                axios.get(that.loginUrl+"brands/findAllBrand").then((res) =>{
                    if(res.data.code == 200){
                        that.brandList = res.data.data;
                    }else{
                    }
                }).catch(err => {
                    that.$root.requestError(err);
                });
            },
            initBusinessUnitList(){
                let that = this;
                axios.get(that.loginUrl+"businessUnit/findAllBU").then((res) =>{
                    if(res.data.code == 200){
                        that.buList = res.data.data;
                    }else{
                    }
                }).catch(err => {
                    that.$root.requestError(err);
                });
            },

            openProductModel(){
                this.status = true;
            },
            initProductMsg(){
                let that = this;
                if( undefined == that.projectId || 0 == that.projectId  )return;

                axios.get(that.timattServerUrl + 'setUpProjectMsg/getProductByProjectId/'+ that.projectId )
                    .then((res) => {
                        if(res.data.code == 200){
                            let result = res.data.data;

                            if(null == result){
                                that.editProductSku = false;
                                this.initProductData(undefined);
                            }else{
                                that.editProductSku = false;
                                this.initProductData(result);
                            }

                        }else{
                        }
                    }).catch(err => {

                });

            },
            initProductData(result){
                let that = this;
                if(undefined == result || null == result) {
                    that.selectedBrand = '';
                    that.selectedBU = '';
                    that.selectedCategory = '';
                    that.description_zh = '';
                    that.description_en = '';
                    that.heightSize = 0;
                    that.imageStr = '';
                    that.longSize = 0;
                    that.productSku = '';
                    that.widthSize = 0;
                    that.weight = 0;
                    that.volume = '';
                    that.remark = '';
                }
                that.selectedBrand = result.brandId;
                that.selectedBU = result.buId;
                that.selectedCategory = result.categoryId;
                that.description_zh = result.descriptionCh;
                that.description_en = result.descriptionEn;
                that.heightSize = result.heightSize;
                that.imageStr = result.imageStr;
                that.longSize = result.longSize;
                that.productSku = result.productSku;
                that.widthSize = result.widthSize;
                that.weight = result.weight;
                that.volume = result.volume;
                that.remark = result.remark;

            },

            editProduct(){
                let that = this;
                //请求接口
                if(''==that.selectedCategory || 0 == that.selectedBrand)return;
                let param = {
                    longSize:that.longSize,
                    widthSize:that.widthSize,
                    heightSize:that.heightSize,
                    weight:that.weight,
                    volume:that.volume,
                    productSku:that.productSku,
                    brandId:that.selectedBrand,
                    buId:that.selectedBU,
                    categoryId:that.selectedCategory,

                    descriptionEn:that.description_en,
                    descriptionCh:that.description_zh,
                    remark:that.remark,

                    projectId:that.projectId,
                    userId:that.userId,
                    status:1
                };
                let thePath = "insertProduct";
                if(that.editProductSku){
                    thePath = "updateProduct";
                }
                axios.post(that.timattServerUrl + 'setUpProjectMsg/'+thePath, param)
                    .then((res) => {
                        if(res.data.code == 200){
                            let _data = res.data.data;
                            this.status = false;
                        }else{
                            this.status = false;
                        }
                    }).catch(err => {
                        this.status = false;
                    });
            },
            calculateVolume(){
                let that = this;
                if(undefined != that.longSize && undefined != that.widthSize
                    && undefined != that.heightSize )
                    that.volume = (that.widthSize * that.longSize * that.heightSize).toFixed(2);
            },
            _show(){
                this.status = false;
            },

        },
        watch:{
            longSize:function(value){this.calculateVolume();},
            widthSize:function(value){this.calculateVolume();},
            heightSize:function(value){this.calculateVolume();},
        },
    }
</script>

<style>
    .textarea{
        width: 400px;
        min-height: 20px;
        max-height: 300px;
        _height: 120px;
        margin-left: auto;
        margin-right: auto;
        padding: 3px;
        outline: 0;
        border: 1px solid #a0b3d6;
        font-size: 12px;
        line-height: 24px;
        padding: 2px;
        word-wrap: break-word;
        overflow-x: hidden;
        overflow-y: auto;

        /*border-color: rgba(82, 168, 236, 0.8);
        box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1), 0 0 8px rgba(82, 168, 236, 0.6);*/
    }
</style>