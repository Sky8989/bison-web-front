<template>
  <el-pagination
    background
    layout="prev, pager, next"
    :total="length"
    :page-size="pagination.pagesize"
    @current-change="handleCurrentChange"
    @size-change="handleSizeChange"
    :style="'float:'+float"
  ></el-pagination>
</template>
<script>
export default {
  props: {
    float: {},
    length: {
        type: Number
    },
    pagination: {}
  }, 
  methods: {
    //分页
    handleCurrentChange(cpage) {
      this.pagination.currpage = cpage
    },
    handleSizeChange(psize) {
      this.pagination.pagesize = psize
    }
  }
};
</script>

