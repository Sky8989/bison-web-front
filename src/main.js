// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import axios from 'axios'
import ElementUI from 'element-ui'
import Vuex from 'vuex'
import router from './router/index.js'
import store from './store/index.js'
import 'element-ui/lib/theme-chalk/index.css'
//引入qs 
import qs from 'qs'
// import {post,fetch,patch,put} from './http'
//引入jquery
import $ from 'jquery'


Vue.config.productionTip = false
Vue.use(Vuex)
Vue.use(ElementUI)
//定义全局变量
Vue.prototype.$ajax = axios

Vue.prototype.URL_ROOT = "http://192.168.1.220:10122"
Vue.prototype.URL_PREFIX = "/product-service"
Vue.prototype.PREFIX_INVENTORY = "/sales-plan"
Vue.prototype.HOST = "/api"
Vue.prototype.$ = $
Vue.prototype.qs = qs

router.beforeEach((to, from, next) => {
  let item = localStorage.getItem("LoginedUser")
   if(to.fullPath !== '/login'){
      if(item){
        let user = JSON.parse(item)
        console.log(user)
        store.state.LoginedUser = user
      }else{
        next({ path: '/login' })
      } 
   }
   next()
});
 
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
})

