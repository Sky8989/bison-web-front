webpackJsonp([29],{O448:function(t,e,o){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var a={name:"SearchBar",data:function(){return{searchfield:"",fieldValue:"",BU:"",model:"",productCategoryId:"",product:{brandId:0,businessUnitId:0,cTime:null,productCategoryId:0,productCertification:"",productDescriptionChs:"",productDescriptionEn:"",productGrossweight:0,productHeight:0,productId:0,productLong:0,productMaterial:"",productModelNumber:"",productNetweight:0,productPackageContains:"",productWidth:0,userId:0},productCategoryList:[],productDetailList:[],BUList:[]}},mounted:function(){this.init()},methods:{init:function(){this.initBU()},initBU:function(){var t=this;this.$ajax.get("http://192.168.1.224:10022/businessUnit/findAllBU",{}).then(function(e){if("200"==e.data.code){var o=e.data.data;t.BUList=o,t.$emit("sendBUList",t.BUList)}})},searchProduct:function(){var t=this;this.productCategoryList=[];var e=this.searchfield,o=this.fieldValue,a="";null==o||""===o?a="/findProduct/findProductByModelNumber/"+this.model:"model"===e?(console.log(e),a="/findProduct/findProductByModelNumber/"+o):"sku"===e?(a="/findProduct/findProductBySku/"+o,console.log(e)):"asin"==e&&(a="/findProduct/findProductByAsin/"+o,console.log(e)),this.$ajax.get(this.URL_ROOT+this.URL_PREFIX+a,{}).then(function(e){if("200"==e.data.code){if(null==e.data.data.productDetails)return void t.$message.warning("查询产品结果为空!");t.$emit("sendSearchResult",e.data.data)}else"500"==e.data.code&&t.$message.error("后台报错 "+e.data.msg)}).catch(function(t){console.log(t)})},open:function(t){this.$message(t)},chooseBU:function(){var t=this,e=this.URL_ROOT+this.URL_PREFIX+"/product/findByBusiness/"+this.BU;this.$ajax.get(e,{}).then(function(e){if("200"==e.data.code){var o=e.data.data;console.log(e.data.data.productCategoryList),t.productCategoryList=o.productCategoryList}}).catch(function(t){console.log(t)})},chooseProduct:function(){var t=this;this.productDetails=[];var e=this.URL_ROOT+this.URL_PREFIX+"/product/findByBusiness/"+this.BU;this.$ajax.get(e,{}).then(function(e){if("200"==e.data.code){var o=e.data.data;console.log(e.data.data.productCategoryList),t.productCategoryList=o.productCategoryList,console.log(t.productCategoryList[0].productCategoryId),console.log(t.productCategoryList[0].productCategory)}}).catch(function(t){console.log(t)})},chooseProductCategory:function(){var t=this,e=this.URL_ROOT+this.URL_PREFIX+"/product/findByCategory/"+this.productCategoryId;this.$ajax.get(e,{}).then(function(e){if("200"==e.data.code){var o=e.data.data;console.log(e.data.data.productDetails),t.productDetailList=o.productDetails}}).catch(function(t){console.log(t)})}}},r={render:function(){var t=this,e=t.$createElement,o=t._self._c||e;return o("div",{attrs:{id:"SearchBar"}},[o("el-form",{attrs:{id:"searchForm"}},[o("el-row",{attrs:{gutter:10}},[o("el-col",{attrs:{span:3}},[o("el-select",{staticClass:"placeholder",attrs:{placeholder:"Model/ASIN/SKU",clearable:""},model:{value:t.searchfield,callback:function(e){t.searchfield=e},expression:"searchfield"}},[o("b",[o("el-option",{attrs:{label:"Model",value:"model"}}),t._v(" "),o("el-option",{attrs:{label:"ASIN",value:"asin"}}),t._v(" "),o("el-option",{attrs:{label:"SKU",value:"sku"}})],1)])],1),t._v("\n        \n      "),o("el-col",{attrs:{span:2}},[o("el-input",{staticStyle:{display:"inline-block",width:"150px"},attrs:{value:"aaa"},model:{value:t.fieldValue,callback:function(e){t.fieldValue=e},expression:"fieldValue"}})],1),t._v("\n        \n    ")],1),t._v(" "),o("el-row",{attrs:{gutter:10}},[o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{clearable:"",placeholder:"BU"},on:{change:t.chooseBU},model:{value:t.BU,callback:function(e){t.BU=e},expression:"BU"}},t._l(t.BUList,function(t){return o("el-option",{key:t.businessUnitId,attrs:{value:t.businessUnitId,label:t.businessUnit}})}),1)],1),t._v("\n       \n      "),o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{clearable:"",placeholder:"系列"},on:{change:t.chooseProductCategory},model:{value:t.productCategoryId,callback:function(e){t.productCategoryId=e},expression:"productCategoryId"}},t._l(t.productCategoryList,function(t){return o("el-option",{key:t.productCategoryId,attrs:{value:t.productCategoryId,label:t.productCategory}})}),1)],1),t._v("\n       \n      "),o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{clearable:"",placeholder:"Model"},model:{value:t.model,callback:function(e){t.model=e},expression:"model"}},t._l(t.productDetailList,function(t){return o("el-option",{key:t.productModelNumber,attrs:{value:t.productModelNumber,label:t.productModelNumber}})}),1)],1),t._v("\n       \n      "),o("el-col",{attrs:{span:1}},[o("el-button",{on:{click:t.searchProduct}},[t._v("查找")])],1)],1)],1)],1)},staticRenderFns:[]};var c=o("VU/8")(a,r,!1,function(t){o("vjEz")},null,null);e.default=c.exports},vjEz:function(t,e){}});
//# sourceMappingURL=29.5c413a2e896cb1d1eec1.js.map