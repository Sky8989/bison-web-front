webpackJsonp([38],{c8md:function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var r={props:["groupId","departmentItem"],data:function(){return{personnelList:[],departmentId:"",theUserId:0,theUserName:""}},activated:function(){this.personnel()},created:function(){this.personnel()},methods:{personnel:function(){var e=this,t="";this.departmentId=this.$store.state.LoginedUser.departmentId,t=0!=this.departmentItem.id&&this.departmentItem.id?"/login-service/getDepartmentUser/getDirectUser/"+this.$store.state.LoginedUser.userId+"/"+this.groupId:"/login-service/getDepartmentUser/"+this.$store.state.LoginedUser.userId+"/"+this.$store.state.LoginedUser.departmentId;var n=[],r=!1;this.$ajax.get(this.URL_ROOT+t).then(function(t){if(200==t.data.code){for(var s in n=t.data.data)n[s].departmentParentName||(n[s].departmentParentName=e.departmentItem.parentPath);e.personnelList=n,r=!(e.personnelList.length>0),e.$emit("deleteGroup",r)}})},_editPersonnel:function(e){this.$emit("success",e)},_deletebutton:function(e){var t=this;this.$confirm("此操作将永久删除该人员, 是否继续?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){t.$ajax.delete(t.URL_ROOT+"/login-service/users/+"+e.userId).then(function(e){200==e.data.code&&(t.$message({type:"success",message:"删除成功!"}),t.personnel())})}).catch(function(){t.$message({type:"info",message:"已取消删除"})})},_setPermission:function(e){this.theUserId=e.userId,this.theUserName=e.departmentName+"/"+e.roleName+":"+e.userName,this.$refs.theUserPermission._show(),this.$refs.theUserPermission.getUserPermission()}},components:{permissionDialog:function(e){return n.e(17).then(function(){var t=[n("xPTv")];e.apply(null,t)}.bind(this)).catch(n.oe)}},watch:{groupId:function(){this.personnel()}}},s={render:function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",[n("el-table",{attrs:{data:e.personnelList}},[n("el-table-column",{attrs:{prop:"userName",label:"账号",width:"120"}}),e._v(" "),n("el-table-column",{attrs:{prop:"userDisplayName",label:"姓名",width:"120"}}),e._v(" "),n("el-table-column",{attrs:{prop:"departmentName",label:"部门",width:"120"}}),e._v(" "),n("el-table-column",{attrs:{prop:"roleName",label:"职位",width:"120"}}),e._v(" "),n("el-table-column",{attrs:{prop:"departmentParentName",label:"直属部门",width:"320"},scopedSlots:e._u([{key:"default",fn:function(t){return[e._v(e._s(t.row.departmentParentName.substring(0,t.row.departmentParentName.length-1)))]}}])}),e._v(" "),n("el-table-column",{attrs:{prop:"name",label:"操作",align:"left"},scopedSlots:e._u([{key:"default",fn:function(t){return e.departmentId!=t.row.departmentId?[n("el-button",{attrs:{type:"text",size:"small",icon:"el-icon-news",title:"权限"},on:{click:function(n){return e._setPermission(t.row)}}}),e._v(" "),n("el-button",{attrs:{type:"text",size:"small",icon:"el-icon-edit",title:"编辑"},on:{click:function(n){return e._editPersonnel(t.row)}}}),e._v(" "),n("el-button",{attrs:{type:"text",size:"small",icon:"el-icon-delete",title:"删除"},on:{click:function(n){return e._deletebutton(t.row)}}})]:void 0}}],null,!0)})],1),e._v(" "),n("permissionDialog",{ref:"theUserPermission",attrs:{theUserId:e.theUserId,theUserName:e.theUserName}})],1)},staticRenderFns:[]},a=n("VU/8")(r,s,!1,null,null,null);t.default=a.exports}});
//# sourceMappingURL=38.e5138e6a30aafddaa183.js.map