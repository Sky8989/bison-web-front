<template>
  <div class="role-warp">
    <el-container>
      <el-aside width="200px" style="border-right: 1px solid #eee;">
        <el-menu style="background-color: rgb(238, 241, 246);border: none">
          <treeRole @tree="_treeRoleId" ref="treeRole"></treeRole>
        </el-menu>
      </el-aside>
      <el-container>
        <el-header height="auto">
          <div
            class="parentPath"
            v-if="roleItem.parentPath"
          >{{roleItem.parentPath.substring(0,roleItem.parentPath.length-1)}}</div>
          <div class="groupTitle" style="height:30px;line-height:30px;">{{roleItem.roleName}}</div>
          <div class="groupNewNameDelete" v-if="roleId != 0">
            <ul>
              <li @click="_modifyRoleName">修改角色名称 |</li>
              <li>
                <deleteTheRole @success="roleSuccess" :roleItem="roleItem"></deleteTheRole>
              </li>
            </ul>
          </div>
        </el-header>
        <el-header style="padding: 0px 20px 0px 20px; height:auto">
          <div class="SettingMemberTop">
            <el-button type="primary" size="small" icon="el-icon-edit" @click="_addRole">创建角色</el-button>
            <el-button id="savePerBtnId" type="success" size="small" icon="el-icon-edit" @click="savePermission">保存</el-button>
          </div>
        </el-header>
        <el-main>
          <rolePermissonRel
            ref="rolePermissonRel"
            :roleId="roleId"
            :roleItem="roleItem"
            @success="_editRoleName"
            @deleteRole="_deleteRole"
          ></rolePermissonRel>
        </el-main>
      </el-container>
    </el-container>
    <addRole
      ref="addRole"
      :roleItem="roleItem"
      @success="roleSuccess"
      :allRolelList="allRolelList"
      :roleArray="roleArray"
    ></addRole>
    <editRole
      ref="modifyname"
      :roleItem="roleItem"
      @success="roleSuccess"
    ></editRole>

  </div>
</template>
 <script>
const ERR_OK = 200;

export default {
  data() {
    return {
      roleId: this.$store.state.LoginedUser.roleId,
      roles: true,
      roleItem: "",
      allRolelList:[],
      personnelItem: [],
      deleteRole: false,
      roleArray: []
    };
  },
  created() {
    this._allRolelList();
  },
  methods: {
    // 获取职位权限列表
    _allRolelList() {
      this.$ajax.get(this.URL_ROOT + "/login-service/roles/findAllRole",).then(res => {
        if (res.data.code == ERR_OK) {
          this.allRolelList = res.data.data;
          this.allRolelList.push({
            roleName: '其他',
            roleId: '0'
          })
        }
      });
    },
    savePermission(){
      this.$refs.rolePermissonRel.saveThePermissions();
    },
    // 点击部门导航获取内容
    _treeRoleId(item, array) {

      this.roleId = item.roleId;
      this.roleItem = item;
      this.roleArray = array;
      if (!item.childern) {
        this.roles = false;
      } else {
        this.roles = true;
      }
    },
    // 删除角色
    _deleteRole(i) {
      // this.deleteRole = i;
    },

    // 修改部门名称
    _modifyRoleName() {
       this.$refs.modifyname._show();
    },
    // 添加角色.
    _addRole() {

      this.$refs.addRole._show();
    },
    //新增部门成功
    roleSuccess(name) {
      this.$refs.treeRole.addRole();
    },

    // 编辑角色
    _editRoleName(val) {
      this.personnelItem = val;
      // this.$refs.edit._show();
    }
  },
  components: {
    addRole: resolve =>
      require(["components/role/opts/addRole.vue"], resolve),
    deleteTheRole: resolve =>
      require(["components/role/opts/deleteTheRole.vue"], resolve),
    editRole: resolve =>
      require(["components/role/opts/editRole.vue"], resolve),
    rolePermissonRel: resolve =>
            require(["components/role/opts/rolePermissonRel.vue"], resolve),
    treeRole: resolve =>
            require(["components/role/opts/treeRoleManager.vue"], resolve),
  },
};
</script>

 <style lang="stylus">
 .role-warp {
   .el-tree--highlight-current .el-tree-node.is-current>.el-tree-node__content {
     background-color: #419eff;
     color: #fff;
   }
  .el-button--text{
    font-size 18px;
  }
   .groupTitle {
     font-size: 18px;
     font-weight: bold;
   }

   .groupNewNameDelete {
     padding: 10px 0;

     li {
       display: inline-block;
       color: #333;
       font-size: 14px;
       cursor: pointer;
     }
   }
    .el-dialog__title{
        font-size: 14px;
        color: #666;
    }
   .parentPath {
     font-size: 13px;
     height: 20px;
     line-height: 20px;
     color: #666;
     padding-bottom: 10px;
   }
 }
</style>
 