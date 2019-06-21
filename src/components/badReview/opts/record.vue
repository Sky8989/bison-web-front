<template>
  <el-dialog title="添加记录" :visible.sync="dialogFormVisible" width="400px">
    <el-form :model="form" :rules="rules" ref="form">
      <el-form-item label="日期" label-width="50px" prop="recordDate">
        <el-date-picker
          v-model="form.recordDate"
          type="date"
          placeholder="选择日期"
          format="yyyy 年 MM 月 dd 日"
          value-format="yyyy-MM-dd"
          :picker-options="pickerOptions"
        ></el-date-picker>
      </el-form-item>
      <el-form-item label="记录" label-width="50px" prop="record">
        <el-input type="textarea" :rows="4" placeholder="请输入内容" v-model="form.record"></el-input>
      </el-form-item>
    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="getRecord('form')">确 定</el-button>
    </div>
  </el-dialog>
</template>
<script>
export default {
  props: {
    itemRecord: {}
  },
  data() {
    return {
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() > Date.now();
        },
        shortcuts: [
          {
            text: "今天",
            onClick(picker) {
              picker.$emit("pick", new Date());
            }
          },
          {
            text: "昨天",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24);
              picker.$emit("pick", date);
            }
          },
          {
            text: "一周前",
            onClick(picker) {
              const date = new Date();
              date.setTime(date.getTime() - 3600 * 1000 * 24 * 7);
              picker.$emit("pick", date);
            }
          }
        ]
      },
      form: {
        record: "",
        recordDate: ""
      },
      rules: {
          recordDate: [
            { required: true, message: '请选择日期', trigger: 'change' },
          ],
          record: [
            { required: true, message: '请输入记录', trigger: 'blur' },
          ]
        },
      dialogFormVisible: false
    };
  },
  methods: {
    getRecord(formName) {
      this.$refs[formName].validate(valid => {
        if (valid) {
          if (this.itemRecord.record) {
            this.itemRecord.record +=
              "<br>" + this.form.recordDate + "：" + this.form.record;
            this.itemRecord.recordDate = this.form.recordDate;
          } else {
            this.itemRecord.record =
              this.form.recordDate + "：" + this.form.record;
            this.itemRecord.recordDate = this.form.recordDate;
          }
          this.$emit("getRecord");
          this.dialogFormVisible = false;
        } else {
          return false;
        }
      });
    },
    _show() {
      this.form.record = "";
      this.form.recordDate = "";
      this.dialogFormVisible = true;
    }
  }
};
</script>

