<template>
    <div>
      <el-select placeholder="ModelNumber" clearable filterable v-model="input.userId"  @change="chooseUserList" >
       <el-option v-for="user in inputUserList"  :key="user.userId" :value="user.userId" :label="user.userName +' --  ' + user.roleName " >
         <!--<span style="float: left">{{ user.userName }}</span>
         <span style="float: right; color: #8492a6; font-size: 13px">{{user.roleName}}</span>-->
       </el-option>
      </el-select>

      <select  size="10" class="el-input el-input--3 el-input--suffix"  style="width: 225px;color: #606266"  v-model="show.userId" @change="chooseUserSearch" >
        <option label="查询所有数据"></option>
        <option v-for="user in showUserList"  :key="user.userId" :value="user.userId" :label="user.userName + '  -- ' + user.roleName " selected></option>

      </select>
    </div>
</template>

<script>
    export default {
        name: "UserLeftSelect",
      data(){
          return{
            input:{userId:""},
            show:{userId:""},
            inputUserList:[],
            showUserList:[],
            userChargeList:[],    //产品负责人列表
            user:this.$store.state.LoginedUser,
          }
      },
      methods:{
          init(){
            this.input.userId = ""
            this.show.userId = ""
            this.inputUserList = [],
            this.showUserList = [],
            this.getDeptUserAll()
          },
        initInputSelectAndShowInput(){
            this.input.userId = ""
            this.show.userId = ""

          },
        getDeptUserAll(){
            console.log("user = " + this.user)
          var url =  this.URL_ROOT + "/login-service/getDepartmentUser/" + this.user.userId +"/" + this.user.departmentId
          this.$ajax.get(url,{
          }).then(res => {
            if(res.data.code == "200"){
              var data = res.data.data
              console.log("data")
              console.log(data)
              this.inputUserList = data
              this.showUserList = data
            }
          })
        },
        chooseUserList(){
          var userId = this.input.userId
          console.log("  chooseUserList  ")
          console.log(userId)
          if(userId == null || userId.length == 0){
              this.getDeptUserAll()
          }else {
            console.log("userId")
            var url = this.URL_ROOT + this.URL_PREFIX + "/productSubscriptionUserRel/findUserByUserId/" + userId
            //  var url = "http://192.168.1.224:10025/relPermission/getPermissions/" + userId
            this.$ajax.get(url,{
            }).then(res => {
              if(res.data.code == "200"){
                var data = res.data.data
                console.log("data")
                console.log(data)
                this.showUserList = data

              }
            })


          }
        },
        chooseUserSearch(){
            console.log("chooseModelNumberSearch")
            console.log(this.show.userId)
          this.$emit("sendUserIds", this.show.userId);

        }
      }

    }
</script>

<style lang="stylus">



</style>
