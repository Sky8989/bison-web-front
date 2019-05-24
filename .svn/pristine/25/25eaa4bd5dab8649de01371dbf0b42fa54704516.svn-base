<template>
  <div class="department-warp">
    <el-container>
      <el-aside width="200px" style="border-right: 1px solid #eee;">
        <el-menu style="background-color: rgb(238, 241, 246);border: none">
          <treeDepartment @tree="_TreeDepartmentId" ref="treeDepartment"></treeDepartment>
        </el-menu>
      </el-aside>
      <el-container>
        <el-header height="auto">
          <div
            class="parentPath"
            v-if="departmentItem.parentPath"
          >{{departmentItem.parentPath.substring(0,departmentItem.parentPath.length-1)}}</div>
          <div class="groupTitle" style="height:30px;line-height:30px;">{{departmentItem.departmentName}}</div>
          <div class="groupNewNameDelete" v-if="groupId != 0">
            <ul>
              <li @click="_modifyDepartmentName">修改部门名称 |</li>
              <li @click="_newDepartment">新建子部门</li>
              <li v-if="!deleteDepartments && deleteGroup">
                |
                <deleteDepartment @success="departmentSuccess" :departmentItem="departmentItem"></deleteDepartment>
              </li>
            </ul>
          </div>
        </el-header>
        <el-header style="padding: 0px 20px 0px 20px; height:auto">
          <div class="SettingMemberTop">
            <el-button type="primary" size="small" icon="el-icon-edit" @click="_newPersonnel">新增成员</el-button>
          </div>
        </el-header>
        <el-main>
          <tablePersonnel
            ref="tablePersonnel"
            :groupId="groupId"
            :departmentItem="departmentItem"
            @success="_editPersonnel"
            @deleteGroup="_deleteGroup"
          ></tablePersonnel>
        </el-main>
      </el-container>
    </el-container>
    <addPersonnel
      ref="addPersonnel"
      :departmentItem="departmentItem"
      @success="addPersonnelSuccess"
      :personnelList="personnelList"
      :departmentArray="departmentArray"
    ></addPersonnel>
    <modifyDepartmentName
      ref="modifyname"
      :departmentItem="departmentItem"
      @success="departmentSuccess"
    ></modifyDepartmentName>
    <newDepartment
      ref="newDepartment"
      :departmentItem="departmentItem"
      @success="departmentSuccess"
    ></newDepartment>
    <editPersonnel
      ref="edit"
      :personnelList="personnelList"
      :personnelItem="personnelItem"
      :departmentArray="departmentArray"
      @success="addPersonnelSuccess"
    ></editPersonnel>

  </div>
</template>
 <script>
const ERR_OK = 200;

export default {
  data() {
    return {
      groupId: this.$store.state.LoginedUser.departmentId,
      deleteDepartments: true,
      departmentItem: "",
      personnelList: [],
      personnelItem: [],
      deleteGroup: false,
      departmentArray: [],
    };
  },
  created() {
    this._personnelList();
  },
  methods: {
    // 获取职位权限列表
    _personnelList() {
      this.$ajax.get(this.URL_ROOT + "/login-service/roles/findAllRole",).then(res => {
        if (res.data.code == ERR_OK) {
          this.personnelList = res.data.data;
          this.personnelList.push({
              roleName: '其他',
              roleId: '0'
          })
        }
      });
    },
    // 点击部门导航获取内容
    _TreeDepartmentId(item,array) {
      this.groupId = item.id;
      this.departmentItem = item;
      this.departmentArray = array
      if (!item.childern) {
        this.deleteDepartments = false;
      } else {
        this.deleteDepartments = true;
      } 
    },
    // 是否部门有人员
    _deleteGroup(i) {
      this.deleteGroup = i;
    },
    // 新建部门
    _newDepartment() {
      this.$refs.newDepartment._show();
    },
    // 修改部门名称
    _modifyDepartmentName() {
      this.$refs.modifyname._show();
    },
    // 添加人员
    _newPersonnel() {
      this.$refs.addPersonnel._show();
    },
    //新增部门成功
    departmentSuccess(name) {
      this.$refs.treeDepartment.addDepartment();
    },
    //新增人员成功
    addPersonnelSuccess() {
      this.$refs.tablePersonnel.personnel();
    },
    // 编辑人员
    _editPersonnel(val) {
      this.personnelItem = val;
      this.$refs.edit._show();
    }
  },
  components: {
    addPersonnel: resolve =>
      require(["components/department/opts/addPersonnel.vue"], resolve),
    deleteDepartment: resolve =>
      require(["components/department/opts/deleteDepartment.vue"], resolve),
    modifyDepartmentName: resolve =>
      require(["components/department/opts/modifyDepartmentName.vue"], resolve),
    newDepartment: resolve =>
      require(["components/department/opts/newDepartment.vue"], resolve),
    tablePersonnel: resolve =>
      require(["components/department/opts/tablePersonnel.vue"], resolve),
    treeDepartment: resolve =>
      require(["components/department/opts/treeDepartment.vue"], resolve),
    editPersonnel: resolve =>
      require(["components/department/opts/editPersonnel.vue"], resolve),

  },
};
</script>
 
 <style lang="stylus">
 .department-warp {
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
 