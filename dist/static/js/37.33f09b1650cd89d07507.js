webpackJsonp([37],{LMb1:function(t,e,a){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var n={data:function(){return{departmentID:"0",dataList:[],Lists:[],defaultProps:{children:"childern",label:"departmentName"},item:""}},created:function(){this.addDepartment()},activated:function(){this.addDepartment()},methods:{addDepartment:function(){var t=this,e=[],a=[];this.$ajax.get(this.URL_ROOT+"/login-service/departments/getDepartmentByDepartmentId/"+this.$store.state.LoginedUser.departmentId).then(function(n){200==n.data.code&&(e.push({departmentName:"所有员工",parentPath:"所有员工/",childern:[],id:"0"},n.data.data),a.push(n.data.data),t.dataList=e,t.Lists=t.getTreeData(a),console.log(t.departmentID),t.$nextTick(function(){this.$refs.tree.setCurrentKey(this.departmentID)}))})},getTreeData:function(t){for(var e in t)t[e].childern.length<1?t[e].childern=void 0:this.getTreeData(t[e].childern);return t},_handleNodeClick:function(t){console.log(t),this.departmentID=t.id,this.$emit("tree",t,this.Lists)}}},i={render:function(){var t=this.$createElement,e=this._self._c||t;return e("div",[e("el-tree",{ref:"tree",attrs:{"expand-on-click-node":!1,data:this.dataList,props:this.defaultProps,"highlight-current":"","node-key":"id","default-expand-all":""},on:{"node-click":this._handleNodeClick}})],1)},staticRenderFns:[]},r=a("VU/8")(n,i,!1,null,null,null);e.default=r.exports}});
//# sourceMappingURL=37.33f09b1650cd89d07507.js.map