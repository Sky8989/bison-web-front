<template>
    <div>
      <el-button type="primary" @click="addOrUpdate" size="mini">新增规则</el-button>
      <!--<el-button type="primary" v-if="updateMethod" @click="addOrUpdate">修改</el-button>-->

       <div name="addRule" >


         <el-dialog
           title="新增规则并绑定参考列"
           :visible.sync="addRuleDialog"
           width="50%"
           :before-close="CloseRule">

           <el-form :model="ruleForm"   label-width="100px" class="demo-dynamic" style="width: 80%">

             <el-form-item label="参考列选择">
               <el-select v-model="ruleForm.itemKeyId"  size="mini">

                 <el-option v-for="itemKeyObj in dynamicValidateForm.itemKeyList" :key="itemKeyObj.itemKey"
                            v-if="itemKeyObj.type == 1 && itemKeyObj.itemKey != '' " :label="itemKeyObj.itemKey + itemKeyNameLast" :value="itemKeyObj.itemKeyId"  >
                 </el-option>
               </el-select>
             </el-form-item>

             <el-form-item label="规则范围填写">
               <el-input-number  v-model="ruleForm.minSalesVolume" controls-position="right" style="display: inline-block;width:110px;" size="mini"></el-input-number> &lt; <span>销量</span> &lt;=
               <el-input-number  v-model="ruleForm.maxSalesVolume" controls-position="right" style="display: inline-block;width:110px;" size="mini"></el-input-number>
             </el-form-item>

             <el-form-item >
               <div style="float: right">
                 <el-button type="primary" @click="submitRuleForm">提交</el-button>
               </div>
             </el-form-item>

           </el-form>
         </el-dialog>


         <el-dialog
           title="新增自定义列"
           :visible.sync="addItemKeyDialog"
           width="50%">
           <el-form :model="ItemKeyForm"   label-width="120px" class="demo-dynamic" style="width: 80%">

             <el-form-item label="新增自定义列名"
               :rules="[{required: true, message: '新增列名不能为空', trigger: 'blur'},{type : 'number' ,message: '输入对应天数数字即可'}]">

               <el-radio-group v-model="ItemKeyForm.type" >
                 <el-radio  :label="itemKeyLastType" size="mini" :border="border" >历史日均</el-radio>
                 <el-radio  :label="itemKeyEstType" size="mini" :border="border"  >预测日均</el-radio>
               </el-radio-group>

               <el-input v-model.number="ItemKeyForm.itemKey" style="display: inline-block;width:100px;"
                         placeholder="输入天数" autocomplete="off" size="mini"></el-input>

             </el-form-item>

             <el-form-item >
               <div style="float: right">
                 <el-button type="primary" @click="submitItemKeyForm">提交</el-button>
               </div>
             </el-form-item>

           </el-form>
         </el-dialog>


         <el-dialog
           title="新增销量规则以及相关比率填写"
           :visible.sync="dialogVisible"
           width="70%"
           :before-close="handleClose">

           <el-form :model="dynamicValidateForm" ref="dynamicValidateForm" label-width="100px" class="demo-dynamic" style="width: 80%">

             <el-row>
               <el-col :span="24">
                 &nbsp;<br/><br/>

                 <el-button type="primary" @click="addDomain" size="mini">新增列名</el-button>

                 <el-form-item
                   v-for="(itemKey, index) in dynamicValidateForm.itemKeyList"
                   :label="'新增列名 ' + index"
                   :key="itemKey.itemKey +'-' + itemKey.type"
                   :prop="'itemKeyList.' + index + '.itemKeyId' "
                   :rules="[{required: true, message: '新增列名不能为空', trigger: 'blur'},{type : 'number' ,message: '输入对应天数数字即可'}]">


                   <el-select v-model="itemKey.type" @change="chooseItemType(itemKey)" size="mini">
                     <el-option :value="itemKeyLastType" label="历史日均"></el-option>
                     <el-option :value="itemKeyEstType" label="预测日均"></el-option>
                   </el-select>


                   <el-input v-model.number="itemKey.itemKey" v-if="itemKey.status == 1"  style="display: inline-block;width:100px;"
                              placeholder="输入天数" autocomplete="off" size="mini"></el-input>

                   <el-input v-model.number="itemKey.itemKey" v-if="itemKey.status == -1"  style="display: inline-block;width:100px;"
                              placeholder="输入天数" autocomplete="off" size="mini"  disabled></el-input>

                   <el-button type="danger" @click.prevent="deleteItemKey(itemKey)" size="mini">
                     <span v-if="itemKey.status === 1">禁用</span>
                     <span v-if="itemKey.status === -1">启用</span>
                   </el-button>

                   <el-button type="danger" @click.prevent="updateItemKey(itemKey)"  v-if="itemKey.status == 1" size="mini">保存</el-button>

                 </el-form-item>
                 <el-button type="primary" @click="showRuleDialog" size="mini" >新增规则</el-button>
               </el-col>
             </el-row>

           </el-form>

           <el-table border="border" height="300px" style="width: 100%" :data="salesVolumeRuleList">

             <el-table-column  label="规则" >
               <template  slot-scope="scope">
                 <span >{{scope.row.itemKey + itemKeyNameLast + "(" + scope.row.minSalesVolume +  '< 销量 <=' + scope.row.maxSalesVolume +")"}}</span>
               </template>
             </el-table-column>

             <el-table-column v-for="itemKeys in dynamicValidateForm.itemKeyList"  :key="itemKeys.itemKey"
                              v-if="itemKeys.itemKey != null && itemKeys.itemKey != '' ">
               <template slot="header" slot-scope="scope">

                 <span v-if=" itemKeys.type == 1">{{itemKeys.itemKey + itemKeyNameLast}}</span>
                 <span v-if=" itemKeys.type == 2">{{itemKeys.itemKey + itemKeyNameEst}}</span>
               </template>
               <!--<template slot-scope="scope">
                 {{scope.row.salesVolumeRuleRatioList}}
               </template>-->
              <template slot-scope="scope" >

                <!--可编辑-->
                  <div v-for="salesVolumeRuleRatio in scope.row.salesVolumeRuleRatioList"
                       v-if="itemKeys.itemKeyId == salesVolumeRuleRatio.itemKeyId && itemKeys.status == 1 &&  scope.row.status == 1">
                       <!--v-if="itemKeys.itemKeyId == salesVolumeRuleRatio.itemKeyId && scope.row.status === 1 && itemKeys.status === 1">-->

                    <el-input-number :key="salesVolumeRuleRatio.itemKeyId+'-'+salesVolumeRuleRatio.salesVolumeRuleId"
                                     :step="0.1" :precision="2" :max="1.0"  placeholder="同类型占比和=1"
                                     v-model="salesVolumeRuleRatio.itemKeyRatio"
                                     controls-position="right" size="mini"  ></el-input-number>

                  </div>

                  <!--不可编辑-->
                <div v-for="salesVolumeRuleRatio in scope.row.salesVolumeRuleRatioList"
                     v-if="itemKeys.itemKeyId == salesVolumeRuleRatio.itemKeyId && ( itemKeys.status == -1 || scope.row.status == -1)">
                    <!-- v-if="itemKeys.itemKeyId == salesVolumeRuleRatio.itemKeyId && (scope.row.status === -1 || itemKeys.status === -1)">-->

                  <el-input-number
                                   :key="salesVolumeRuleRatio.itemKeyId+'-'+salesVolumeRuleRatio.salesVolumeRuleId"
                                   :step="0.1" :precision="2" :max="1.0"  placeholder="同类型占比和=1"
                                   v-model="salesVolumeRuleRatio.itemKeyRatio"
                                   controls-position="right" size="mini"  :disabled="true"></el-input-number>
                </div>


               </template>
             </el-table-column>

             <el-table-column  label="合理性" >
               <template  slot-scope="scope">
                 <el-input-number :step="0.1" :precision="2" :max="1.0"  placeholder="合理性" size="mini"  v-if=""
                                  v-model="scope.row.rationality = scope.row.rationality > 1 ? scope.row.rationality*0.01 : scope.row.rationality"
                                  controls-position="right" :disabled="scope.row.status == 1 ? false : true"></el-input-number>
               </template>
             </el-table-column>

             <el-table-column>
               <template  slot-scope="scope">
                  <el-button type="primary" @click="saveRow(scope)" size="mini"  v-if="scope.row.status == 1">保存</el-button>
                 <el-button type="danger"   @click="deleteRow(scope)" size="mini" v-if="scope.row.status == 1">删除</el-button>
               </template>
             </el-table-column>
           </el-table>


           <el-row >
             <el-col>
               <div style="float: right">
                <!-- <el-button type="primary" @click="submitForm">提交</el-button>-->
                 <!--<el-button @click="resetForm('dynamicValidateForm')">重置</el-button>-->
               </div>
             </el-col>
           </el-row>

         </el-dialog>
       </div>

    </div>
</template>

<script>
    import SalePlan from "../SalePlan";
    export default {
      name: "AddItemKeyAndSalesVolumeRule",
      components: {SalePlan},
      data() {
        return {
          i:1,
          itemKeyLastType:1,
          itemKeyEstType:2,
          updateMethod:false, //标识修改
          border:true,
          dialogVisible:false,
          addRuleDialog:false,
          addItemKeyDialog:false,
          itemKeyNameLast : '天历史日均',
          itemKeyNameEst : '天预测日均',
         // userId:this.$store.state.LoginedUser.userId,
          userId:1,
          dynamicValidateForm: {
            itemKeyList: [],  //自定义列 数组
          },
          ruleSelect:'',

          salesVolumeRuleList:[],       //销量规则列表

          //添加自定义列
          ItemKeyForm:{
            type:1,
            itemKey:'', },

          //添加规则
          ruleForm:{
            itemKey:'',
            maxSalesVolume:'',
            minSalesVolume:'',
          },
          //修改删除相关数据
          deleteSalesVolumeRuleItemKeyRelList:[],  //用来删除一整行的比率 和某一个销量规则 {salesVolumeRuleId:salesVolumeRuleId,itemKeyId:itemKeyId}
          deleteItemKeyIdList:[]                    //存itemKeyId 删除itemKey 如果存itemKeyId为销售规则中的参考itemKeyId删除对应规则  同时删除等于itemKeyId这一列的比率
        }
      },

      methods:{
        chooseItemType(itemKeyObj){
          // console.log"chooseItemType")
          // console.log)

        // var  itemKeyObj = ""
          var type = itemKeyObj.type
          //1:判断类型 如果 type=1 是参考列 不能修改
          if(type == 2){
            i

            var str = ""
            var flag = false
            for(var i = 0; i < this.salesVolumeRuleList.length; i++){
              var salesVolumeRule = this.salesVolumeRuleList[i];

              if(salesVolumeRule.itemKeyId == itemKeyObj.itemKeyId){
                var min = salesVolumeRule.minSalesVolume
                var max = salesVolumeRule.maxSalesVolume
                flag = true;

                str += '(' +min  +'<销量<='+ max +')' + ","

              }
            }
            if(flag){
              itemKeyObj.type = 1
              this.$message.warning("当前自定义是"+ str +"销量规则参考列不能更改类型")
            }
          }
          //2:type=2 可以修改

        },
        initItemKeyList(){
          // console.log"initItemKeyList")

          var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/salesPalnSalesChargeViewHandler/findItemKeyAll"
          // var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/productCoded/findCountryList"
          this.$ajax.get(url,{


          }).then(res => {
            if(res.data.code == "200"){
              // console.logres.data.data)
              this.dynamicValidateForm.itemKey = res.data.data
              // console.log this.dynamicValidateForm.itemKey)
            }

          }).catch(error => {
            console.log(error)
          })
        },
        checkRatioSum(ratioList,additemKeyVOList){
          /**
           * 将 ratioList min-max-itemKey-type=ratio
           * key: min-max-itemKey-type
           * val: ratio
           * */
          var map = new Map()
          for(var i = 0; i < ratioList.length; i++){
            var array = ratioList[i].split("=");
            var ratio = Number.parseFloat(array[1])
            // console.log"array = " + array)
            // console.logratio )
            // console.log ratio === null)
            // console.log  ratio === undefined)
            if(array != null && array.length == 2){
              if(array[1] === null || array[1] === undefined){
                this.$message.error("占比不能为空,请填写占比!")
                return false
              }
              map.set(array[0].toString(),array[1])
            }
          }
          // console.log"map = " )
          // console.logmap)



          for(var j = 0;  j < this.saveSalesVolumeList.length; j++){

            /**
             * 所有历史日均 的总占比
             **/
            var lastSumRatio = 0.0;
            /**
             * 所有预测日均 的总占比
             **/
            var estSumRatio = 0.0;

            var ruleObject = this.saveSalesVolumeList[j];
            var min = ruleObject.minSalesVolume;
            var max = ruleObject.maxSalesVolume;

            // console.log"min = " + min)
            // console.log"max = " + max)

            for (var k = 0 ; k < additemKeyVOList.length; k++){
              var itemKeyObject =  additemKeyVOList[k];
              var strIndex = min + "-" + max +"-"+ itemKeyObject.itemKey+'-'+itemKeyObject.type;

              // console.log"strIndex = " + strIndex)
              var num = map.get(strIndex.toString());
              // console.log"num = " + num)
              //默认为0.0
              var resultRatio = Number.parseFloat(num ===  undefined ? 0.0 : num);
              // console.log"resultRatio = " + resultRatio)

              if(resultRatio != null){
                if(itemKeyObject.type == "1"){
                  // console.log"type = " + itemKeyObject.type)
                  lastSumRatio += resultRatio
                  // console.log"lastSumRatio = " + lastSumRatio)
                }else if(itemKeyObject.type == "2"){
                  estSumRatio += resultRatio
                }
              }
            }

          //每一个规则判断一次
            // console.logtypeof(lastSumRatio))
            // console.loglastSumRatio)
            // console.logestSumRatio)

            // console.loglastSumRatio != 0.0)
            // console.loglastSumRatio != 1.0)
            // console.loglastSumRatio !== NaN)
            if(lastSumRatio != 0.0 && lastSumRatio != 1.0 && lastSumRatio !== NaN){
              this.$message.error( min +" < 销量 <= "+ max + "销量规则下的 历史销量总占比不等于1,请重新填写占比")
              return false
            }else if(estSumRatio != 0.0 && estSumRatio != 1.0 && lastSumRatio !== NaN){
              this.$message.error( min +" < 销量 <= "+ max + "销量规则下的 预测销量总占比不等于1,请重新填写占比")
              return false
            }

          }
          return true
        },

        submitRuleForm(){
          var ruleForm = this.ruleForm

          var minSalesVolume = ruleForm.minSalesVolume
          var maxSalesVolume = ruleForm.maxSalesVolume

          // console.logminSalesVolume)
          // console.logmaxSalesVolume)
          // console.logminSalesVolume === undefined)
          // console.logminSalesVolume === "")

          if(ruleForm.itemKeyId == null || ruleForm.itemKeyId == ""){
            this.$message.warning("请选择参考自定义列!!!")
            return
          }

          if((minSalesVolume === undefined || minSalesVolume === null ) || (maxSalesVolume === undefined || maxSalesVolume == null)){
            this.$message.error("新增规则不能为空");
            return;
          }

          if(minSalesVolume < 0 || maxSalesVolume < 0){
            this.$message.error("新增规则最大值或最小值不能小于0");
            return;
          }

          if(maxSalesVolume === 0){
            this.$message.error("新增规则最大值不能为0");
            return;
          }

          if(minSalesVolume >= maxSalesVolume){
            this.$message.error("最小销量不能大于或等于最大销量")
            return
          }

          // console.log"判断是否出现交叉的规则")
          for(var i in this.salesVolumeRuleList){
            var min = this.salesVolumeRuleList[i].minSalesVolume
            var max = this.salesVolumeRuleList[i].maxSalesVolume

            // console.log"min = " + min +" max = " + max)
            // console.log"minSalesVolume = " + minSalesVolume +" maxSalesVolume = " + maxSalesVolume)

            if((min <= minSalesVolume && minSalesVolume < max ) || (min <  maxSalesVolume && maxSalesVolume < max)){
              this.$message.error("当前设置的最小销量 = " + minSalesVolume +" 最大销量 = " + maxSalesVolume +  " 不能与前面设置过的销量有交叉数据")
              return;
            }
          }

          var data = {
            itemKeyId:ruleForm.itemKeyId,
            minSalesVolume:minSalesVolume,
            maxSalesVolume:maxSalesVolume,
            userId:this.userId
          }

          // console.log"data")
          // console.logdata)

          var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesVolumeRuleHandler/addSalesVolumeRule"

          // console.log"addSalesVolumeRule")

          this.$ajax({
            method:"post",
            url:url,
            data:data
          }).then(res => {
            var data = res.data
            // console.logdata.data)
            if(data.code === 200){
              this.salesVolumeRuleList.push(data.data)
              this.$message.success(data.msg)
            }else if(data.code === 500){
              this.$message.error(data.msg)
            }
          })


        //关闭窗口
        //  this.addRuleDialog = false
          this.$message.success("添加规则成功")

        },
        submitForm() {
          if(this.updateMethod){
            //修改操作
          }else {
            //新增操作
            //数据判断需要处理
            var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesPalnSalesChargeViewHandler/addSalesVolumeRule"


            var ratioStr = ''
            // 传后台 itemKey列表
            var  additemKeyVOList = []
            for(var i = 0; i < this.dynamicValidateForm.itemKeyList.length; i++){
              var obj  = this.dynamicValidateForm.itemKeyList[i].ratioList;
              var itemKeyObj = this.dynamicValidateForm.itemKeyList[i];

              //
              additemKeyVOList.push({itemKeyId:itemKeyObj.itemKeyId,itemKey:itemKeyObj.itemKey,type:itemKeyObj.type})

              // console.log"length")
              //   // console.logi)
              // // console.logthis.dynamicValidateForm.itemKeyList.length)
              // console.logobj)

              ratioStr +=  this.qs.stringify(obj);

              if(i+1 != this.dynamicValidateForm.itemKeyList.length)
                ratioStr += "&"

              // console.logratioStr)
              //ratioList.push(obj)

            }
            var ratioList = ratioStr.split("&");

            // console.logratioList)
            if(!this.checkRatioSum(ratioList,additemKeyVOList)){
              return
            }
            // console.logthis.saveSalesVolumeList)
            var data = {
              userId:this.userId,
              salesVolumeRuleList:this.saveSalesVolumeList, //存销量规则数据 格式: {min,max,itemKey,rationality}
              salesVolumeItemKeyRelList:ratioList, //存所有的比率 格式 min-max-itemKey-type=ratio
              itemKeyVOList:additemKeyVOList,   //存{itemKey,type}
            }

            // console.log"data")
            // console.logdata)

            this.$ajax({
              method:"post",
              url:url,
              data:data

            }).then(res => {
              if(res.data.code == "200"){
                // console.logres.data.data)
                this.$message.success(res.data.msg)
              }else if(res.data.code == "500"){
                this.$message.success(res.data.msg)
              }
            }).catch(err => {
              console.log(err)
            })

            //最后关闭窗口
            this.dialogVisible = false

          }
        },

        updateItemKey(itemKeyObj){
          // console.log"updateItemKey")
          // console.logitemKeyObj)

          var type = itemKeyObj.type
          var itemKeyId = itemKeyObj.itemKeyId
          var itemKey = itemKeyObj.itemKey

          if(itemKey == null || itemKey == ""){
            this.$message.error(" 自定义列名不能为空 "  );
            return
          }
          if(itemKeyId == null || itemKeyId == 0){
            this.$message.error(" 自定义列名Id不能为空 "  );
            return
          }

          var url = this.URL_ROOT + this.PREFIX_INVENTORY +"/itemKeyHandler/updateItemKey"

          var data = {
            type:type,
            itemKeyId:itemKeyId,
            itemKey:itemKey,
            userId:this.userId
          }

          this.$ajax({
            method:'post',
            url:url,
            data:data

          }).then(res => {
            var data = res.data
            // console.log"data")
            // console.logdata)
            if(data.code == 200){
              this.dynamicValidateForm.itemKeyList = data.data.showItemKeyVOList

              if(data.data.showSalesVolumeRuleVOList != null && data.data.showSalesVolumeRuleVOList.size > 0){
                this.salesVolumeRuleList = data.data.showSalesVolumeRuleVOList
              }


            }else if(data.code == 500){
              this.$message.error(dada.msg)
            }

          }).catch(err => {
            console.log(err)
          })


        },
        deleteItemKey(itemKeyObj) {
          // console.log"deleteItemKey")
          // console.logitemKeyObj)

          var type = itemKeyObj.type
          var itemKeyId = itemKeyObj.itemKeyId
          var status = itemKeyObj.status

          // console.log"status = " + status)



          var ruleStr = ""

          //判断当前 itemkey 是否销量规则参考列
          if(type == 1){
           for(var i = 0; i <  this.salesVolumeRuleList .length; i++){
             var salesVolumeRule =  this.salesVolumeRuleList[i]
             if(itemKeyId == salesVolumeRule.itemKeyId){
               var salesStr = ""
               var min = salesVolumeRule.minSalesVolume;
               var max = salesVolumeRule.maxSalesVolume;
               salesStr = "(" + min + " <销量<= " + max +")"
                ruleStr += salesStr + ","
             }
           }
          }

          var str = ""
          if(ruleStr != null && ruleStr != ""){
            str = "当前列有关联一下规则 " +ruleStr +"将会禁用";
          }


          var tip =  ""
          var select = ""
          if(status == 1){
            tip = "确认禁用自定义列？" + str
            select = "禁用"
            status = -1
          }else if(status == -1){
            tip = "确认启用自定义列？"
            select = "启用"
            status = 1
          }

          this.$confirm(tip, '提示', {
            confirmButtonText: '确定' + select,
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {
            //修改删除相关数据存储
              var itemKeyId = itemKeyObj.itemKeyId
              // console.log"删除自定义列 ==")

              //禁用
              var  url = this.URL_ROOT + this.PREFIX_INVENTORY + "/itemKeyHandler/updateItemKeyStatus/"+itemKeyId+"/"+status

              this.$ajax.get(url)
                .then(res => {
                  var data = res.data
                  // console.logdata)
                  if(data.code === 200){
                    this.$message.success(data.msg);
                    itemKeyObj.status = status
                    //更新 自定义列数据
                    // this.dynamicValidateForm.itemKeyList = []
                    // this.dynamicValidateForm.itemKeyList = data.data.showItemKeyVOList;


                    //更新规则数据
                    //注意规则 在禁用时可以直接改状态不需要更新,更新会导致页面显示问题
                    this.salesVolumeRuleList = []
                    this.salesVolumeRuleList = data.data.showSalesVolumeRuleVOList

                    // console.logthis.dynamicValidateForm.itemKeyList)
                    // console.logthis.salesVolumeRuleList)

                  }else if(data.code === 500){
                    this.$message.error(data.msg);
                  }

              }).catch(err => {
                console.log(err)

              })

          });

        },


        removeRule(item){
          var index = this.dynamicValidateForm.salesVolumeRuleList.indexOf(item)
          if (index !== -1) {
            this.dynamicValidateForm.salesVolumeRuleList.splice(index, 1)
            this.salesVolumeRuleList = this.dynamicValidateForm.salesVolumeRuleList
          }


        },

        addDomain() {
          // console.log"===addDomain ===" )
         var itemKeyList =  this.dynamicValidateForm.itemKeyList
         //var salesVolumeRuleList = this.dynamicValidateForm.salesVolumeRuleList;

          /**
           * 临时变量
          **/
          var ratioList1 = [];

          for(var i = 0; i < itemKeyList.length; i++) {
              var itemKey = itemKeyList[i].itemKey;

              // console.logitemKey)
              if (itemKey == null || itemKey == '') {
                this.$message.error("新增列名的名字为空,请先填写列名在进行新增");
                return;
             }

            //判断自定义列 名称和type是否一样,一样提醒修改
           var type1 = itemKeyList[i].type
            for (var k = 0; k < itemKeyList.length-1; k++) {
                var itemKey2 = itemKeyList[k].itemKey
                var type2 = itemKeyList[k].type
              // console.log"i =" + i +" == k ==" + k)
              // console.log"itemKey =" +itemKey +" == itemKey2 ==" + itemKey2)
              // console.log"type2 =" +type2 +" == type ==" + type1)
                if (i != k && itemKey == itemKey2 && type2 == type1) {

                  var str = type1 == '1' ? this.itemKeyNameLast : this.itemKeyNameEst;
                  this.$message.error("新增的自定义列名 和列名类型不能重复,请修改! " + itemKey + str );
                  return;

                }
            }
            }


          // console.log"ratioList1")
          // console.logratioList1)

          //打开新增ItemKey 对话框
          this.addItemKeyDialog = true


        },
        addRule(itemKeyList,index) {

         // console.log"addRule")
        // console.log(index)


          if(itemKeyList.itemKey == null || itemKeyList.itemKey == ''){
            this.$message.error("新增列名的名字为空,请先填写列名在新增规则");
            return;
          }


          var minSalesVolume = itemKeyList.salesVolumeRuleList.minSalesVolume;
          // console.logminSalesVolume)
          var maxSalesVolume = itemKeyList.salesVolumeRuleList.maxSalesVolume;

          if( minSalesVolume == 0 ||  (minSalesVolume == null || minSalesVolume == "") || (maxSalesVolume == null || maxSalesVolume == "")){
            this.$message.error("新增规则不能为空");
            return;
          }
          if(minSalesVolume < 0 || maxSalesVolume < 0){
            this.$message.error("新增规则最大值或最小值不能小于0");
            return;
          }

          // console.log"新增销量")
          // console.logminSalesVolume)
          // console.logmaxSalesVolume)

          if(minSalesVolume >= maxSalesVolume){
            this.$message.error("最小销量不能大于或等于最大销量")
            return
          }

          // console.log"itemKey")
          var itemKey =  itemKeyList.itemKey;
          var type =  itemKeyList.type;

          var strIndex = minSalesVolume+'-'+maxSalesVolume+'-'+itemKey +'-'+ type;
          itemKeyList.ratioList[strIndex]= ""

          // itemKey参考字段 控制一组的比率
          var obj = {
            itemKey:itemKey,
            minSalesVolume:minSalesVolume,
            maxSalesVolume:maxSalesVolume,
            rationality:0.0
          }

         if( this.salesVolumeRuleList == null ||  this.salesVolumeRuleList == 0){
           //第一次添加
           this.salesVolumeRuleList.push(obj)
           this.saveSalesVolumeList = this.salesVolumeRuleList
         }else{
           //判断是否出现交叉的规则
           // console.log"判断是否出现交叉的规则")
           for(var i in this.salesVolumeRuleList){
             // console.logi)
             var min = this.salesVolumeRuleList[i].minSalesVolume
             var max = this.salesVolumeRuleList[i].maxSalesVolume

             // console.log"min = " + min +" max = " + max)
             // console.log"minSalesVolume = " + minSalesVolume +" maxSalesVolume = " + maxSalesVolume)

             if((min <= minSalesVolume && minSalesVolume < max ) || (min <= maxSalesVolume && maxSalesVolume <=max)){
               this.$message.error("当前设置的最小销量 = " + minSalesVolume +" 最大销量 = " + maxSalesVolume +  " 不能与前面设置过的销量有交叉数据")
               return;
             }else{
             }
           }

           //第二次添加 存储销售规则 用来传到后台
           this.salesVolumeRuleList.push(obj);
           this.saveSalesVolumeList = this.salesVolumeRuleList
         }

          // console.log" this.saveSalesVolumeList")
          // console.log this.saveSalesVolumeList)
          // console.log"itemKeyList ")
          // console.log this.dynamicValidateForm.itemKeyList)

        },

        handleClose(done){
          this.$confirm('确认关闭？')
            .then(_ => {
              done();
            })
            .catch(_ => {});
        },

        checkAddRowData(row){
          var itemKeyId = row.itemKeyId
          //规则 最大 最小范围
          var max = row.maxSalesVolume
          var min = row.minSalesVolume
          var rationality = row.rationality


          if(rationality == null || rationality == ""){
            this.$message.error("合理性不能为空")
            return false
          }
          if(rationality < 0){
            this.$message.error("合理性不能为负数")
            return false
          }

          /**
           * 所有历史日均 的总占比
           **/
          var lastSumRatio = 0.0;
          /**
           * 所有预测日均 的总占比itemKeyList
           **/
          var estSumRatio = 0.0;

          //一组比率
          var salesVolumeRuleRatioList =  row.salesVolumeRuleRatioList

          if(salesVolumeRuleRatioList == null || salesVolumeRuleRatioList.length == 0){
            this.$message.error("占比不能为空")
            return false
          }

          var itemKeyList = this.dynamicValidateForm.itemKeyList

          for(var j = 0 ; j < salesVolumeRuleRatioList.length; j++){
            var salesVolumeRuleRatio = salesVolumeRuleRatioList[j]
            var ratio = salesVolumeRuleRatio.itemKeyRatio


            // console.log"ratio = " + ratio)
            for(var i = 0; i < itemKeyList.length; i++){
              if(salesVolumeRuleRatio.itemKeyId == itemKeyList[i].itemKeyId){
                if(ratio == null){
                  var name = ""
                  if(type == 1){
                    name = this.itemKeyNameLast
                  }else{
                    name = this.itemKeyNameEst
                  }

                  this.$message.error(itemKeyList[i].itemKey + name + " 的占比不能为空")
                  return false
                }
                  var type = itemKeyList[i].type
                  if(type == 1){
                    lastSumRatio += ratio
                    // console.log"lastSumRatio = " +　lastSumRatio)
                  }else{
                    estSumRatio += ratio
                    // console.log"estSumRatio = " +　estSumRatio)
                  }
              }
            }
          }

          // console.log"end ==")
          // console.log"lastSumRatio = " +　lastSumRatio)
          // console.log"estSumRatio = " +　estSumRatio)

          if(lastSumRatio == 0.0 || lastSumRatio != 1.0 || lastSumRatio == NaN){
            this.$message.error( min +" < 销量 <= "+ max + "销量规则下的 历史销量总占比不等于1,请重新填写占比")
            return false
          }
          if(estSumRatio == 0.0 || estSumRatio != 1.0 || lastSumRatio == NaN){
            this.$message.error( min +" < 销量 <= "+ max + "销量规则下的 预测销量总占比不等于1,请重新填写占比")
            return false
          }
          return true

        },

        saveRow(scope){
        // console.log"saveRatio")
        var row =  scope.row
        // console.logrow)

        if(!this.checkAddRowData(row)){
          return
        }
        var rationality = row.rationality
        //规则 最大 最小范围
        // console.log"rationality")
        // console.logrationality)

        // console.log"salesVolumeRuleRatioList = " )
        // console.logrow.salesVolumeRuleRatioList)


          var data = {
            salesVolumeRuleId:row.salesVolumeRuleId,
            itemKeyId:row.itemKeyId,
            itemKey:row.itemKey,
            rationality:row.rationality*100,
            maxSalesVolume:row.maxSalesVolume,
            minSalesVolume:row.minSalesVolume,
            salesVolumeRuleRatioList:row.salesVolumeRuleRatioList

          }

        var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesPalnSalesChargeViewHandler/updateRowSalesVolumeRule"

          this.$ajax({
            method: 'post',
            url:url,
            data:data,
          }).then(res => {
            if(res.data.code == "200"){
              // console.logres.data)
              this.$message.success(res.data.msg)
              //返回全部数据
             // this.salesVolumeRuleList = res.data.data.showSalesVolumeRuleVOList
            //  this.dynamicValidateForm.itemKeyList = res.data.data.showItemKeyVOList
            }else if(res.data.code == "500"){
              this.$message.error(res.data.msg)
            }

          }).catch(err => {
            console.log(err)

          })

            },
        deleteRow(scope){
          // console.logscope)
          var row = scope.row;
          var min = row.minSalesVolume
          var max = row.maxSalesVolume
          var itemKey = row.itemKey
          var type = row.type

          // console.logrow)
          // console.log"this.salesVolumeRuleList")
          // console.logthis.salesVolumeRuleList)

          this.$confirm('确认删除一行规则？ 规则相关比率以及合理性将一并删除!!! ', '提示', {
            confirmButtonText: '确定删除',
            cancelButtonText: '取消',
            type: 'warning'
          }).then(() => {

            var index = this.salesVolumeRuleList.indexOf(row)
            // console.logindex)
            if (index !== -1) {
              this.salesVolumeRuleList.splice(index, 1)
            }
            // console.log"this.dynamicValidateForm.itemKeyList")
            // console.logthis.dynamicValidateForm.itemKeyList)

            //删除
              this.deleteSalesVolumeRuleItemKeyRelList.push(row.salesVolumeRuleId)

              // console.log"deleteSalesVolumeRuleItemKeyRelList")
              // console.logthis.deleteSalesVolumeRuleItemKeyRelList)

              var url =  this.URL_ROOT + this.PREFIX_INVENTORY + "/salesPalnSalesChargeViewHandler/deleteRowSalesVolumeRule/" + row.salesVolumeRuleId

              this.$ajax.delete(url).then(res => {
                var data = res.data
                if(data.code === 200){
                  this.$message.success(data.msg)
                }else if(data.code === 500){
                  this.$message.error(data.msg)
                }
              }).catch(err => {
                console.log(err)
              })
          })
        },
       showRuleDialog(){
          var itemKeyList = this.dynamicValidateForm.itemKeyList

         // console.log"itemKeyList")
         // console.logitemKeyList)

         if(itemKeyList == null ||itemKeyList.length == 0){
           this.$message.error("请先添加自定义列!!!")
           return
         }

         for(var i = 0; i < itemKeyList.length; i++){
           if(itemKeyList[i].itemKey == null || itemKeyList[i].itemKey == ""){
             this.$message.error("请先将全部自定义列上对应天数!!!")
             return
           }
         }

         this.addRuleDialog = true
        },
        CloseRule(){
          this.ruleForm = {
            itemKey:'',
            maxSalesVolume:'',
            minSalesVolume:'',
          }
          this.addRuleDialog  = false
        },
        addOrUpdate(){
          //显示
          this.dialogVisible = true

          //1:先查询数据库是否存在数据


          var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/salesPalnSalesChargeViewHandler/getAllSalesVolumeRuleByUserId/"+this.userId

          this.$ajax.get(url).then(res => {
            if(res.data.code == "200"){
             var data = res.data.data
              // console.log"data")
              // console.logdata)
              this.dynamicValidateForm.itemKeyList = data.showItemKeyVOList
              this.salesVolumeRuleList = data.showSalesVolumeRuleVOList
            }else if(res.data.code == "500"){
              if(res.data.msg != "新增")
              this.$message.error(res.data.msg)
            }
          }).catch(err =>{
            console.log(err)
          })


        },
        submitItemKeyForm(){
          var itemKeyForm = this.ItemKeyForm;
          // console.log"submitItemKeyForm")
          // console.logitemKeyForm)

          if(itemKeyForm.itemKey == null || itemKeyForm.itemKey == ""){
            this.$message.error("新增自定义列不能为空!!!")
          }
          if(itemKeyForm.type == null || itemKeyForm.type == 0){
            this.$message.error("请选择自定义列的类型!!!")
          }

          var data = {itemKey:itemKeyForm.itemKey,type:itemKeyForm.type,userId:this.userId}
          // console.log"data = ")
          // console.logdata)

          var url = this.URL_ROOT + this.PREFIX_INVENTORY + "/itemKeyHandler/addItemKey"

          this.$ajax({
            method:"post",
            url:url,
            data:data
          }).then(res => {
            var data = res.data
            // console.logdata.data)
            if(data.code === 200){
             // this.dynamicValidateForm.itemKeyList.push(data.data)
              this.dynamicValidateForm.itemKeyList = data.data.showItemKeyVOList
              this.salesVolumeRuleList = data.data.showSalesVolumeRuleVOList
              this.$message.success(data.msg)
            }
            else if(data.code === 500){
              this.$message.error(data.msg)
            }
          })
        }
      },

    }
</script>

<style lang="stylus">

 /* .el-radio--mini.is-bordered{
    padding : 6px 1px 0 3px
  }
  .el-radio.is-bordered+.el-radio.is-bordered{
    margin-left : 1px
  }*/
  .el-radio{
    margin-right : 10px
  }

</style>
