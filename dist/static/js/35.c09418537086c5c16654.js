webpackJsonp([35],{zz1V:function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var s={render:function(){var e=this.$createElement;return(this._self._c||e)("span",{attrs:{type:"text"},on:{click:this._deletebutton}},[this._v(this._s(this.name))])},staticRenderFns:[]},o=n("VU/8")({props:["roleItem"],data:function(){return{name:"删除角色"}},methods:{_deletebutton:function(){var e=this;this.$confirm("此操作将永久删除角色, 是否继续?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){e.$ajax({method:"delete",url:e.URL_ROOT+"/login-service/roles/"+e.roleItem.roleId}).then(function(t){e.$message.success("删除成功"),e.$emit("success")})}).catch(function(){e.$message.info("已取消删除")})},_delete:function(){}}},s,!1,null,null,null);t.default=o.exports}});
//# sourceMappingURL=35.c09418537086c5c16654.js.map