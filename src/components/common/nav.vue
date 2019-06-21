<template>
  <div class="nav">
    <ul>
      <li v-for="(item,index) in nav" :key="index">
        <router-link :to="item.router">{{item.name}}</router-link>
      </li>
    </ul>
  </div>
</template>
<script>
export default {
    props:['nav'] 
}
</script>

<style lang="stylus" scoped>
.nav {
  font-size: 0; 

  ul {
    display: inline-block;
    border-bottom: none;
    border-radius: 10px 10px 0 0;
    overflow: hidden;
    background: #ebeef5;

    li {
      display: inline-block;

      a {
        display: block;
        padding: 8px 40px;
        font-size: 16px;
        color: #333;
      }

      .router-link-exact-active {
        background: #409EFF;
        color: #ffffff;
      }
    }
  }
}
</style>

