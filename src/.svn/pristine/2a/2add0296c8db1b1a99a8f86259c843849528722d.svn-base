<template>
    <div>
      <el-select placeholder="ModelNumber" clearable filterable v-model="input.modelNumbers" @change="chooseModelNumber" >
       <el-option v-for="product in inputProductList"  :key="product.productModelNumber" :value="product.productModelNumber" :label="product.productModelNumber"></el-option>


      </el-select>

      <select   size="10" class="el-input el-input--3 el-input--suffix"  style="width: 225px;color: #606266"  v-model="show.modelNumbers" @change="chooseModelNumberSearch" >
        <option label="查询所有数据" ></option>
        <option v-for="product in showProductList"  :key="product.productModelNumber" :value="product.productModelNumber" :label="product.productModelNumber"></option>
      </select>
    </div>
</template>

<script>
    export default {
        name: "productLeftSelect",
      data(){
          return{
            input:{modelNumbers:""},
            show:{modelNumbers:""},
            inputProductList:[],
            showProductList:[],
            userChargeList:[],    //产品负责人列表
          }
      },
      methods:{
          init(){
            this.input.modelNumbers = ""
            this.initModelNumber()
          },
        initModelNumber(){
          var url = this.URL_ROOT + this.URL_PREFIX  + "/productSubscription/findModelNumberAll"
          this.$ajax.get( url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              this.inputProductList = data
              this.showProductList = data
            }
          })
        },
        chooseModelNumber(){
          var modelNumbers = this.input.modelNumbers
          if(modelNumbers == null || modelNumbers ==  ""){
              this.initModelNumber()
          }else {
            console.log("modelNumbers")
            console.log(modelNumbers)

            this.showProductList = []
            var product = {productModelNumber:modelNumbers}
            this.showProductList.push(product)


            /*for(var i = 0; i < modelNumbers.length; i++){
              var product = {productModelNumber:modelNumbers[i]}

            }*/
            console.log("showProductList")
            console.log(this.showProductList)
          }
        },
        chooseModelNumberSearch(){
            console.log("chooseModelNumberSearch")

          var productModelNumbers = this.show.modelNumbers
          this.$emit("sendModelNumbers", this.show.modelNumbers);

        }
      }

    }
</script>

<style lang="stylus">



</style>
