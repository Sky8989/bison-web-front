<template>
  <div class="app">
    <div class="container-wrap">
      <div class="header" v-if="!$route.meta.navShow">
        <v-header></v-header>
      </div>
      <div class="containerBox">
        <breadcrumb v-if="!$route.meta.breadcrumb"></breadcrumb>
        <keep-alive>
          <router-view></router-view>
        </keep-alive>
      </div>
    </div>
  </div>
</template>
 
<script type="text/ecmascript-6">
export default {
  data() {
    return {};
  },
  created() {},
  beforeUpdate: function() {},
  components: {
    "v-header": resolve => require(["components/header/header.vue"], resolve),
    "breadcrumb": resolve => require(["components/common/breadcrumb.vue"], resolve)
  }
};
</script>

<style lang="stylus" rel="stylesheet/stylus">
@import './common/css/reset.css';

.container-wrap {
  .containerBox {
    position: absolute;
    left: 0;
    right: 0;
    top: 61px;
    bottom: 0;
    padding: 20px;
    overflow: auto;
  }
}

.el-dialog__header {
  padding: 15px 10px;
  background: #eaeaea;
  line-height: 100%;
}
</style>
