<template>
  <div>
    <div class="select-btn-group">
      <el-button :size="size" @click="selectAll">全部选中</el-button>
      <el-button :size="size" @click="selectDel">全部删除</el-button>
    </div>
    <div class="select-height"></div>
  </div>
</template>
<script>
export default {
  props: {
    selectForm: {},
    selectArray: {
      type: Array
    },
    selectArrayId: {},
    selectFormId: {},
    size:{}
  },
  methods: {
    // 全部选中
    selectAll() {
      let itemArr = [];
      this.selectArray.forEach(item => {
        if (this.selectArrayId) {
          for (let el in item) {
            if (this.selectArrayId === el) {
              itemArr.push(item[el]);
            }
          }
        } else {
          itemArr.push(item);
        }
      });
      for (let item in this.selectForm) {
        if (item == this.selectFormId) {
          this.selectForm[item] = itemArr;
        }
      }
      this.$emit("selectAll");
    },
    // 全部删除
    selectDel() {
      for (let item in this.selectForm) {
        if (item == this.selectFormId) {
          this.selectForm[item] = [];
        }
      }
      this.$emit("selectDel");
    }
  }
};
</script>
<style lang="stylus" scoped>
.select-btn-group{
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  padding: 10px;
  background: #ffffff;
  z-index: 9;
  display flex
  justify-content: space-around;
  .el-button {
    margin:0;
  }
}
.select-height {
  height: 48px;
}
</style>
