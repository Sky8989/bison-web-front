webpackJsonp([34],{odMv:function(e,t,s){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var r={props:["roleItem"],data:function(){return{status:!1,formedit:{userDisplayName:""},parentDeptId:[],rules:{roleName:[{required:!0,message:"请填写职位名称",trigger:"blur"}]}}},mounted:function(){this.formedit.userDisplayName=this.roleItem.roleName},activated:function(){this.formedit.userDisplayName=this.roleItem.roleName},created:function(){this.formedit.userDisplayName=this.roleItem.roleName},methods:{_show:function(){this.status=!this.status},_roleList:function(){this.formedit.userDisplayName=roleItem.roleName},_submitEditRole:function(e){var t=this;if(this.formedit.userDisplayName){var s={roleName:this.formedit.userDisplayName,roleId:this.roleItem.roleId,parentId:this.roleItem.parentId};this.$ajax({method:"put",url:this.URL_ROOT+"/login-service/roles/"+this.roleItem.roleId,data:s}).then(function(e){200==e.data.code?(t.$emit("success"),t.$message.success("修改成功"),t.status=!1):t.$message.error("修改失败")})}},handleChange:function(e){this.formedit.departmentId=e[e.length-1]}},watch:{}},o={render:function(){var e=this,t=e.$createElement,s=e._self._c||t;return s("el-dialog",{attrs:{visible:e.status,width:"400px",title:e.roleItem.roleName},on:{"update:visible":function(t){e.status=t}}},[s("el-form",{ref:"addRoles",attrs:{model:e.formedit,rules:e.rules,"label-width":"100px"}},[s("el-form-item",{attrs:{label:"角色名称:",prop:"roleName",placeholder:"formedit.userDisplayName"}},[s("el-input",{attrs:{autocomplete:"off"},model:{value:e.formedit.userDisplayName,callback:function(t){e.$set(e.formedit,"userDisplayName",t)},expression:"formedit.userDisplayName"}})],1)],1),e._v(" "),s("div",{staticClass:"dialog-footer",attrs:{slot:"footer"},slot:"footer"},[s("el-button",{on:{click:e._show}},[e._v("取 消")]),e._v(" "),s("el-button",{attrs:{type:"primary"},on:{click:e._submitEditRole}},[e._v("确 定")])],1)],1)},staticRenderFns:[]},i=s("VU/8")(r,o,!1,null,null,null);t.default=i.exports}});
//# sourceMappingURL=34.18d661e253985be134d5.js.map