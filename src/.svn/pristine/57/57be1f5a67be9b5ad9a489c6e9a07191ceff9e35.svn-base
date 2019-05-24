<template>
    <div>
        <el-table
            ref="multipleTable"
            :data="subscriptionList"
            tooltip-effect="dark"
            style="width: 100%"
            @selection-change="_productSelection">
                <el-table-column type="selection" width="55">
                </el-table-column>
                <el-table-column
                prop="countryName"
                label="国家"
                width="120">
                </el-table-column>
                <el-table-column
                prop="productModelNumber"
                label="产品名称"
                width="220">
                </el-table-column>
                <el-table-column
                label="人员名称"
                >
                    <template slot-scope="scope" type="info">
                        <el-tag closable v-for="item in scope.row._child" v-if="item.userName" type="info" @close="_deletePersonnel(item)" :key="item.id">
                        {{item.userName}}
                        </el-tag>
                    </template>
                </el-table-column>
        </el-table>
        <div style="margin-top: 20px">
            <el-button @click="_distributionPersonnel()">分配</el-button>
        </div>
    </div>
</template>
<script>
    const ERR_OK = 200
    export default {
        props: ['countryId'],
        data(){
            return {
                subscriptionList: [],
                productSelection: []
            }
        },
        methods: {
            // 人员分配列表
            _personnelList(){
                this.subscriptionList = []
                this.$ajax.get(this.URL_ROOT+'/product-service/userCountryProductRel/findByCountryIdAndBusinessId?countryId='+this.countryId+'&businessId='+ this.$store.state.LoginedUser.userId).then((res) => {
                    if(res.data.code == ERR_OK){
                        var arr = res.data.data
                        var map = {},
                            dest = [];
                        for(var i = 0; i < arr.length; i++){
                            var a = arr[i];
                            if(!map[a.productId]){
                                dest.push({
                                    productId: a.productId,
                                    productModelNumber: a.productModelNumber,
                                    countryName: a.countryName,
                                    countryId: a.countryId,
                                    _child: [a]
                                });
                                map[a.productId] = a;
                            }else{
                                for(var j = 0; j < dest.length; j++){
                                    var dj = dest[j];
                                    if(dj.productId == a.productId){
                                        dj._child.push(a);
                                        break;
                                    }
                                }
                            }
                        }
                        this.subscriptionList = dest
                    }
                })
            },
            // 分配人员
            _distributionPersonnel(rows) {
                if(rows){
                   let productId = ''
                    for(let i in this.productSelection){
                        productId += this.productSelection[i].productId+","
                    }
                    this.$ajax.put(this.URL_ROOT+'/product-service/userCountryProductRel/listInsert?productList='+productId+'&countryId='+this.countryId+'&user_id='+this.userId).then((res) => {
                        if(res.data.code === ERR_OK){
                            this.$notify({
                                title: '添加成功',
                                type: 'success'
                            });
                            this.addressclick()
                        }else{
                            const h = this.$createElement;
                            this.$notify({
                                title: '添加失败',
                            });
                        }
                    }) 
                }
            },
            // 删除人员
            _deletePersonnel(val){
                let data = {
                    'countryId': val.countryId,
                    'productId': val.productId,
                    'userId': val.userId
                }
                this.$ajax({
                    method: 'post',
                    url: this.URL_ROOT+'/product-service/userCountryProductRel/delete',
                    data: data,
                }).then((res) => {
                    if(res.data.code === ERR_OK){
                        this.$notify({
                            title: '删除成功',
                            type: 'success'
                        });
                        this.addressclick()
                    }else{
                        const h = this.$createElement;
                        this.$notify({
                            title: '删除失败',
                        });
                    }
                })
            },
            // 获取多个商品id
            _productSelection(val) {
                this.productSelection = val;
            },
        }
    }
</script>

