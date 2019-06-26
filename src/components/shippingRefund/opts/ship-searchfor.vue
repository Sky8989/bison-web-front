<template>
  <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="50px">
    <el-form-item label="时间状态" prop="timeType" label-width="80px">
      <el-select v-model="ruleForm.timeType" placeholder="请选择状态">
        <el-option v-for="item in timeType" :key="item.id" :label="item.name" :value="item.id"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="创建时间" prop="time" label-width="80px" v-if="ruleForm.timeType">
      <el-date-picker
        v-model="ruleForm.time"
        type="daterange"
        unlink-panels
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        :picker-options="pickerOptions"
        @change="time"
        value-format="yyyy-MM-dd"
        format="yyyy 年 MM 月 dd 日"
      ></el-date-picker>
    </el-form-item>
    <el-form-item label="状态" prop="status">
      <el-select v-model="ruleForm.status" placeholder="请选择状态">
        <el-option v-for="item in findStatus" :key="item.id" :label="item.name" :value="item.id"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label="渠道" prop="channel">
      <el-select v-model="ruleForm.channel" placeholder="请选择渠道">
        <el-option v-for="item in findChannel" :key="item.id" :label="item.name" :value="item.id"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item label-width="10px">
      <el-button type="primary" @click="submitForm('ruleForm')" icon="el-icon-search">搜索</el-button>
      <el-button @click="resetForm('ruleForm')" icon="el-icon-circle-close">清空</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
const ERR_OK = 200;
export default {
  data() {
    return {
      pickerOptions: {
        shortcuts: [
          {
            text: "最近一周",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", [start, end]);
            }
          },
          {
            text: "最近一个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
              picker.$emit("pick", [start, end]);
            }
          },
          {
            text: "最近三个月",
            onClick(picker) {
              const end = new Date();
              const start = new Date();
              start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
              picker.$emit("pick", [start, end]);
            }
          }
        ]
      },
      ruleForm: {
        status: "",
        channel: "",
        time: [],
        startDate: "",
        endDate: "",
        timeType: ""
      },
      findStatus: [
        {
          id: "ready",
          name: "待提交"
        },
        {
          id: "submited",
          name: "已提交"
        },
        {
          id: "invalid",
          name: "已取消"
        }
      ],
      findChannel: [
        {
          id: "amazon",
          name: "亚马逊"
        },
        {
          id: "edayun",
          name: "易达云"
        }
      ],
      timeType: [
        {
          id: "createTime",
          name: "创建时间"
        },
        {
          id: "submitTime",
          name: "提交时间"
        }
      ],
      rules: {
        time: [
          {
            required: true,
            message: "请选择日期",
            trigger: "change"
          }
        ]
      }
    };
  },
  methods: {
    time(data) {
      if (data) {
        this.ruleForm.startDate = data[0];
        this.ruleForm.endDate = data[1];
      }
    },
    // 提交查询
    submitForm(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$emit("submitForm", this.ruleForm);
        } else {
          return false;
        }
      });
    },
    resetForm(formName) {
      this.$refs[formName].resetFields();
    }
  }
};
</script>
<style lang="stylus" scoped>
.el-form-item {
  display: inline-block;
}
</style>
