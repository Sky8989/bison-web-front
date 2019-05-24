<template>
  <div  class="login-warp">
    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="60px"  v-show="!Parameters">
      <el-form-item label="账号" prop="userName">
        <el-input v-model="ruleForm.userName"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="userPassword">
        <el-input v-model="ruleForm.userPassword" type="password"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
      </el-form-item>
    </el-form> 
    <password ref="accountID" :accountID="ruleForm.userPassword" v-show="Parameters"></password>
  </div>
</template>

<script>
  const ERR_OK = 200
  export default {
      data() {
        return {
          Parameters: false,
          ruleForm: {
            userName: '',
            userPassword: '',
          },
          rules: {
            userName: [
              { required: true, message: '请输入账号', trigger: 'blur' },
            ],
            userPassword: [
              { required: true, message: '请输入密码', trigger: 'change' }
            ]
          }
        };
      },
      created(){
      },
      methods: {
        submitForm(formName) {
          this.$refs[formName].validate((valid) => {
            if (valid) {
              this.$ajax({
                method: 'post',
                url: this.URL_ROOT+'/login-service/login/userLogin',
                data: this.ruleForm
              }).then((res) => {
                if(res.data.code === ERR_OK){
                  this.$store.commit('LOGIN', res.data.data.theUser);  
                  this.$ajax(this.URL_ROOT+'/login-service/login/getCountrys').then((datas) => {
                      this.$store.commit('set_country', datas.data.data);
                      if(res.data.data.theUser.remark == 'firstTime'){
                        this.Parameters = true
                        this.$refs.accountID.show();
                        return
                      }
                      this.$router.push({path: '/index'})
                  })
                }else{
                  this.$message.error('账号密录错误');
                }
              })
            } else {
              return false;
            }
          });
        }
      },
      activated(){
        this.Parameters = false
      },
      components: {
        'password': resolve => require(['components/user/opts/password.vue'], resolve)
      }
    }
</script>

<style lang="stylus" rel="stylesheet/stylus">
  .login-warp{
    position: fixed;
    left: 0;
    right: 0;
    top: 50%;
    width: 330px;
    min-height: 180px;
    margin: -120px auto 0 auto;
    padding: 30px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
    border-radius: 10px;
    button{
      width 100%
    }
  }
</style>
