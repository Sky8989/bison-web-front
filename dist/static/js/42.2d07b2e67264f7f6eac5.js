webpackJsonp([42],{v2oA:function(t,e,n){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var s={render:function(){var t=this.$createElement;return(this._self._c||t)("span",{attrs:{type:"text"},on:{click:this._deletebutton}},[this._v(this._s(this.name))])},staticRenderFns:[]},a=n("VU/8")({props:["departmentItem"],data:function(){return{name:"删除组"}},methods:{_deletebutton:function(){var t=this,e={departmentName:this.departmentItem.departmentName,id:this.departmentItem.id};this.$confirm("此操作将永久删除该组, 是否继续?","提示",{confirmButtonText:"确定",cancelButtonText:"取消",type:"warning"}).then(function(){t.$ajax({method:"post",url:t.URL_ROOT+"/login-service/departments/deleteDepartment/",data:e}).then(function(e){t.$message.success("删除成功"),t.$emit("success")})}).catch(function(){t.$message.info("已取消删除")})},_delete:function(){}}},s,!1,null,null,null);e.default=a.exports}});
//# sourceMappingURL=42.2d07b2e67264f7f6eac5.js.map