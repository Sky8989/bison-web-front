webpackJsonp([24],{DnW1:function(e,t,o){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var l={name:"CodedInfo",data:function(){return{LabelPosition:"right",addCodedInfo:!1,searchInfo:{seller:"",asin:"",sku:"",fnsku:""},codedInfoList:[],form:{country:"",countryId:"",seller:"",sellerId:"",asin:"",UPC:"",transportType:"",sku:"",fnsku:"",sellerSkuId:""},countryList:[],sellerList:[],asinList:[],transportTypeList:[],skuAndFnSkuList:[],countrys:[]}},methods:{getProductId:function(){console.log("getProductId");var e=this.$store.state.product.productId;if(null!=e&&""!=e)return e;this.$message("请先选择产品")},init:function(){this.getCountryList(),this.getSellerList(),this.getTransportTypeList(),this.firstSearchCodedInfo(this.getProductId()),this.findCountryByProductId(this.getProductId())},firstSearchCodedInfo:function(e){var t=this;if(this.$refs.filterTable.clearFilter(),console.log("firstSearchCodedInfo"),null==e||""==e)return!1;var o=this.URL_ROOT+this.URL_PREFIX+"/productCoded/findProductCodeInformationByProductId";this.$ajax.get(o,{params:{productId:e}}).then(function(e){"200"==e.data.code&&(t.codedInfoList=e.data.data)}).catch(function(e){console.log(e)})},search:function(){var e=this;console.log("提交搜索信息");var t=this.getProductId();if(console.log("seller = "+this.searchInfo.seller+"  asin = "+this.searchInfo.asin+" sku="+this.searchInfo.sku+" fnsku="+this.searchInfo.fnsku),null==t||""==t)return!1;var o=this.URL_ROOT+this.URL_PREFIX+"/productCoded/findByProductIdAndSellerIdAndAsinAndSkuAndFnsku";this.$ajax.get(o,{params:{productId:t,sellerId:this.searchInfo.seller,asin:this.searchInfo.asin,sku:null==this.searchInfo.sku?"":this.searchInfo.sku,fnsku:null==this.searchInfo.fnsku?"":this.searchInfo.fnsku}}).then(function(t){"200"==t.data.code&&(null!=t.data.data&&0!=t.data.data.length||e.$message.info("查询结果为空"),e.codedInfoList=t.data.data)}).catch(function(e){console.log(e)})},submitCodedInfo:function(){var e=this;console.log("添加编码信息");var t=this.form,o=t.sellerSkuId;console.log(o);var l=this.URL_ROOT+this.URL_PREFIX,s=null;null!=o&&""!=o?(l+="/productCoded/updateProductCodedInformation",s=t.sellerId):(l+="/productCoded/addProductCodedInformation",s=t.seller);var r={userId:1,productId:this.getProductId(),productModelNumber:this.$store.state.product.productModelNumber,sellerId:s,countryId:t.country,sellerSkuId:t.sellerSkuId,asin:t.asin,sku:t.sku,fnsku:t.fnsku,upc:t.UPC,transportType:t.transportType,record:"当前用户"};console.log("data"),console.log(r),this.$ajax({method:"post",url:l,data:r}).then(function(t){"200"==t.data.code&&(console.log(t.data.data),e.codedInfoList=t.data.data)}).catch(function(e){console.log(e)}),this.addCodedInfo=!1},filterCountry:function(e,t){return console.log("value = "+e),console.log(t),t.countryName==e},filterTransportType:function(e,t){return t.transportType==e},getCountryList:function(){var e=this,t=this.URL_ROOT+this.URL_PREFIX+"/productCoded/findCountryList";this.$ajax.get(t,{}).then(function(t){"200"==t.data.code&&(console.log(t.data.data),e.countryList=t.data.data)}).catch(function(e){console.log(e)})},getSellerList:function(){var e=this,t=this.URL_ROOT+this.URL_PREFIX+"/productCoded/findSellerList";this.$ajax.get(t,{}).then(function(t){"200"==t.data.code&&(console.log(t.data.data),e.sellerList=t.data.data)}).catch(function(e){console.log(e)})},getTransportTypeList:function(){var e=this,t=this.URL_ROOT+this.URL_PREFIX+"/productCoded/findTransportType";this.$ajax.get(t,{}).then(function(t){"200"==t.data.code&&(console.log(t.data.data),e.transportTypeList=t.data.data)}).catch(function(e){console.log(e)})},chooseSeller:function(){var e=this,t=this.searchInfo.seller;null!=t&&""!=t||(t=this.form.seller);var o=this.URL_ROOT+this.URL_PREFIX+"/productCoded/findAsinByProductIdAndSellerId";this.$ajax.get(o,{params:{productId:this.getProductId(),sellerId:t}}).then(function(t){"200"==t.data.code&&(console.log(t.data.data),e.asinList=t.data.data)}).catch(function(e){console.log(e)})},findCountryByProductId:function(e){var t=this,o=this.URL_ROOT+this.URL_PREFIX+"/findProductCharge/findProductUserCountryByProductId/"+e;this.$ajax.get(o,{}).then(function(e){"200"==e.data.code&&(console.log(e.data.data),t.countrys=e.data.data)}).catch(function(e){console.log(e)})},editCodedInfo:function(e,t){if(console.log(t.label),console.log(e),"编辑"!=t.label)return!1;this.form.sellerSkuId=e.sellerSkuId,this.form.countryId=e.countryId,this.form.country=e.countryId,this.form.seller=e.sellerId,this.form.sellerId=e.sellerId,this.form.asin=e.asin,this.form.UPC=e.upc,this.form.transportType=e.transportType,this.form.sku=e.sku,this.form.fnsku=e.fnsku},closeDialog:function(){console.log("closeDialog 关闭回调"),this.form={country:"",countryId:"",seller:"",sellerId:"",asin:"",UPC:"",transportType:"",sku:"",fnsku:"",sellerSkuId:""}}}},s={render:function(){var e=this,t=e.$createElement,o=e._self._c||t;return o("div",{attrs:{id:"CodedInfo"}},[o("el-row",[o("el-col",{attrs:{span:4}},[o("el-button",{staticStyle:{float:"left"},on:{click:function(t){e.addCodedInfo=!0}}},[e._v("新增+")])],1)],1),e._v(" "),o("el-dialog",{staticStyle:{width:"auto",height:"auto"},attrs:{title:"新增/编辑",visible:e.addCodedInfo},on:{"update:visible":function(t){e.addCodedInfo=t},close:e.closeDialog}},[o("el-form",{attrs:{"label-width":"100px",model:e.form,"label-position":e.LabelPosition,encType:"multipart/form-data"}},[o("input",{directives:[{name:"model",rawName:"v-model",value:e.form.sellerSkuId,expression:"form.sellerSkuId"}],attrs:{hidden:""},domProps:{value:e.form.sellerSkuId},on:{input:function(t){t.target.composing||e.$set(e.form,"sellerSkuId",t.target.value)}}}),e._v(" "),o("input",{directives:[{name:"model",rawName:"v-model",value:e.form.countryId,expression:"form.countryId"}],attrs:{hidden:""},domProps:{value:e.form.countryId},on:{input:function(t){t.target.composing||e.$set(e.form,"countryId",t.target.value)}}}),e._v(" "),o("input",{directives:[{name:"model",rawName:"v-model",value:e.form.sellerId,expression:"form.sellerId"}],attrs:{hidden:""},domProps:{value:e.form.sellerId},on:{input:function(t){t.target.composing||e.$set(e.form,"sellerId",t.target.value)}}}),e._v(" "),o("el-row",[o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"Model No:"}},[o("span",[e._v(e._s(this.$store.state.product.productModelNumber))])])],1),e._v(" "),o("el-col",{attrs:{span:6}})],1),e._v(" "),o("el-row",[o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"国家:"}},[o("el-select",{attrs:{placeholder:"请选择国家"},model:{value:e.form.country,callback:function(t){e.$set(e.form,"country",t)},expression:"form.country"}},e._l(e.countrys,function(e){return o("el-option",{key:e.countryId,attrs:{label:e.countryName,value:e.countryId}})}),1)],1)],1),e._v(" "),o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"账号:"}},[o("el-select",{attrs:{placeholder:"请选择账号",selected:"selected"},on:{change:e.chooseSeller},model:{value:e.form.seller,callback:function(t){e.$set(e.form,"seller",t)},expression:"form.seller"}},e._l(e.sellerList,function(e){return o("el-option",{key:e.sellerId,attrs:{value:e.sellerId,label:e.sellerName}})}),1)],1)],1),e._v(" "),o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"ASIN:"}},[o("el-select",{attrs:{placeholder:"ASIN",filterable:"","allow-create":""},on:{change:e.chooseAsin},model:{value:e.form.asin,callback:function(t){e.$set(e.form,"asin",t)},expression:"form.asin"}},e._l(e.asinList,function(e){return o("el-option",{key:e,attrs:{value:e,label:e}})}),1)],1)],1),e._v(" "),o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"UPC:"}},[o("el-input",{model:{value:e.form.UPC,callback:function(t){e.$set(e.form,"UPC",t)},expression:"form.UPC"}})],1)],1)],1),e._v(" "),o("el-row",[o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"发货方式:"}},[o("el-select",{attrs:{placeholder:"发货方式"},model:{value:e.form.transportType,callback:function(t){e.$set(e.form,"transportType",t)},expression:"form.transportType"}},e._l(e.transportTypeList,function(e){return o("el-option",{key:e.text,attrs:{value:e.text,label:e.text}})}),1)],1)],1),e._v(" "),o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"SKU:"}},[o("el-select",{attrs:{placeholder:"SKU",filterable:"","allow-create":""},model:{value:e.form.sku,callback:function(t){e.$set(e.form,"sku",t)},expression:"form.sku"}},e._l(e.skuAndFnSkuList,function(e){return o("el-option",{key:e.sku,attrs:{value:e.sku,label:e.sku}})}),1)],1)],1),e._v(" "),o("el-col",{attrs:{span:6}},[o("el-form-item",{attrs:{label:"FNSKU:"}},[o("el-select",{attrs:{placeholder:"FNSKU",filterable:"","allow-create":""},model:{value:e.form.fnsku,callback:function(t){e.$set(e.form,"fnsku",t)},expression:"form.fnsku"}},e._l(e.skuAndFnSkuList,function(e){return o("el-option",{key:e.fnsku,attrs:{value:e.fnsku,label:e.fnsku}})}),1)],1)],1)],1)],1),e._v(" "),o("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[o("el-button",{on:{click:function(t){e.addCodedInfo=!1}}},[e._v("取 消")]),e._v(" "),o("el-button",{attrs:{type:"primary"},on:{click:e.submitCodedInfo}},[e._v("确 定")])],1)],1),e._v(" "),o("el-form",{attrs:{model:e.searchInfo}},[o("el-form-item",{staticStyle:{float:"left"}},[o("el-row",{attrs:{gutter:10}},[o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{placeholder:"账号",filterable:"",clearable:""},on:{change:e.chooseSeller},model:{value:e.searchInfo.seller,callback:function(t){e.$set(e.searchInfo,"seller",t)},expression:"searchInfo.seller"}},e._l(e.sellerList,function(e){return o("el-option",{key:e.sellerId,attrs:{value:e.sellerId,label:e.sellerName}})}),1)],1),e._v(" "),o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{placeholder:"ASIN",clearable:""},model:{value:e.searchInfo.asin,callback:function(t){e.$set(e.searchInfo,"asin",t)},expression:"searchInfo.asin"}},e._l(e.asinList,function(e){return o("el-option",{key:e,attrs:{value:e,label:e}})}),1)],1),e._v(" "),o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{placeholder:"SKU",clearable:"",filterable:""},model:{value:e.searchInfo.sku,callback:function(t){e.$set(e.searchInfo,"sku",t)},expression:"searchInfo.sku"}},e._l(e.skuAndFnSkuList,function(e){return o("el-option",{key:e.sku,attrs:{value:e.sku,label:e.sku}})}),1)],1),e._v(" "),o("el-col",{attrs:{span:3}},[o("el-select",{attrs:{placeholder:"FNSKU",clearable:"",filterable:""},model:{value:e.searchInfo.fnsku,callback:function(t){e.$set(e.searchInfo,"fnsku",t)},expression:"searchInfo.fnsku"}},e._l(e.skuAndFnSkuList,function(e){return o("el-option",{key:e.fnsku,attrs:{value:e.fnsku,label:e.fnsku}})}),1)],1),e._v(" "),o("el-col",{attrs:{span:3}},[o("el-button",{on:{click:e.search}},[e._v("搜索")])],1)],1)],1)],1),e._v(" "),o("el-table",{attrs:{data:e.codedInfoList,height:"250px",border:"border"},on:{"cell-click":e.editCodedInfo}},[o("el-table-column",{attrs:{prop:"sellerSkuId",label:"id"}}),e._v(" "),o("el-table-column",{attrs:{prop:"productModelNumber",label:"model"}}),e._v(" "),o("el-table-column",{attrs:{prop:"sellerName",label:"账号"}}),e._v(" "),o("el-table-column",{attrs:{prop:"countryName",label:"国家",filters:e.countryList,"filter-method":e.filterCountry}}),e._v(" "),o("el-table-column",{attrs:{prop:"asin",label:"ASIN"}}),e._v(" "),o("el-table-column",{attrs:{prop:"sku",label:"SKU"}}),e._v(" "),o("el-table-column",{attrs:{prop:"fnsku",label:"FNSKU"}}),e._v(" "),o("el-table-column",{attrs:{prop:"upc",label:"UPC"}}),e._v(" "),o("el-table-column",{attrs:{prop:"transportType",label:"发货方式",filters:e.transportTypeList,"filter-method":e.filterTransportType}}),e._v(" "),o("el-table-column",{attrs:{prop:"record",label:"记录人"}}),e._v(" "),o("el-table-column",{attrs:{prop:"edit",label:"编辑"}},[o("el-button",{on:{click:function(t){e.addCodedInfo=!0}}},[e._v("编辑")])],1)],1)],1)},staticRenderFns:[]};var r=o("VU/8")(l,s,!1,function(e){o("M79U")},"data-v-779186f2",null);t.default=r.exports},M79U:function(e,t){}});
//# sourceMappingURL=24.fd78728fa16ba12a75e2.js.map