<template>
  <div class="password-wrap">
    <div class="title" v-if="changes">重置密码</div>
    <el-form :model="ruleForm" status-icon :rules="rules2" ref="ruleForm" label-width="80px" >
    <el-form-item label="旧密码" prop="oldUserPassword" v-show="!accountID">
      <el-input type="password" v-model="ruleForm.oldUserPassword" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="密码" prop="pass">
      <el-input type="password" v-model="ruleForm.userPassword" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="确认密码" prop="checkPass">
      <el-input type="password" v-model="ruleForm.checkPass" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item>
      <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
    </el-form-item>
  </el-form>
  </div>
</template>

<script>
const ERR_OK = 200
export default {
    props: ['accountID'],
    data() {
      // 验证密码是否一致
      var validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'));
        } else {
          if (this.ruleForm.checkPass !== '') {
            this.$refs.ruleForm.validateField('checkPass');
          }
          callback();
        }
      };
      var validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.ruleForm.userPassword) {
          callback(new Error('两次输入密码不一致!'));
        } else {
          callback();
        }
      };
      return {
        changes: false,
        ruleForm: {
          parentId: 0,
          userPassword: '',
          checkPass: '',
          oldUserPassword: ""
        },
        rules2: {
          oldUserPassword: [
              { required: true, message: '请输入旧密码', trigger: 'blur' }
          ],
          pass: [
            { validator: validatePass, trigger: 'blur' }
          ],
          checkPass: [
            { validator: validatePass2, trigger: 'blur' }
          ]
        }
      };
    },
    methods: {
      show(){
        this.ruleForm.oldUserPassword = this.accountID
        this.changes = true
      },
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            delete this.ruleForm.checkPass
            this.$ajax({
              method: 'post',
              url: this.URL_ROOT + '/login-service/users/updatePassword/'+this.$store.state.LoginedUser.userId,
              data: this.ruleForm
            }).then((res) => {
              if(res.data.code == ERR_OK){
                this.$message.success('修改成功');
                if(this.changes){
                  this.$router.push({path: '/index?id=1'})
                }
              }else{
                this.$message.error(res.data.msg);
              }
            })
          } else {
              this.$message.error('修改失败');
            return false;
          }
        });
      }
    }
  }
</script>

<style lang="stylus" rel="stylesheet/stylus">
    .password-wrap{
        max-width 500px;
        .title{
          text-align center;
          font-size 16px;
          padding 15px;
        }
    }
</style>
