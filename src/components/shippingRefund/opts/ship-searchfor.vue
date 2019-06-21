<template>
  <el-form ref="form" :model="form" label-width="80px">
    <el-form-item label="日期">
      <el-date-picker
        v-model="form.time"
        type="daterange"
        range-separator="至"
        start-placeholder="开始日期"
        end-placeholder="结束日期"
        format="yyyy 年 MM 月 dd 日"
        value-format="yyyy-MM-dd HH:mm:ss"
        :picker-options="pickerOptions"
      ></el-date-picker>
    </el-form-item>
    <el-form-item label="状态" prop="findBuId">
      <el-select
        v-model="ruleForm.findBuId"
        multiple
        collapse-tags
        @change="getFindByBu"
        placeholder="请选择UB"
      >
        <div class="businessReport-customize-select-btn-group">
          <el-button size="mini" @click="selectAll(arrData.findBu,'findBuId')">全部选中</el-button>
          <el-button size="mini" @click="selectDel('findBuId')">全部删除</el-button>
        </div>
        <div class="businessReport-customize-select-height"></div>
        <el-option label="区域一" value="shanghai"></el-option>
        <el-option label="区域二" value="beijing"></el-option>
      </el-select>
    </el-form-item>
  </el-form>
</template>
<script>
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
      form: {
        time: ""
      }
    };
  }
};
</script>
