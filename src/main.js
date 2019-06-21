// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import axios from 'axios'
import ElementUI from 'element-ui'
import Vuex from 'vuex'
import router from './router/index.js'
import store from './store/index.js'
import VeLine from 'v-charts/lib/line.common'
import 'element-ui/lib/theme-chalk/index.css'
//引入qs 
import qs from 'qs'
// import {post,fetch,patch,put} from './http'
//引入jquery
import $ from 'jquery'
// 导入表格
import vueXlsxTable from 'vue-xlsx-table'
// 直线图
Vue.component(VeLine.name, VeLine)
// 直线图结束
Vue.config.productionTip = false
Vue.use(Vuex)
Vue.use(ElementUI)
Vue.use(vueXlsxTable, {rABS: false})
//定义全局变量
Vue.prototype.$ajax = axios
Vue.prototype.$ = $
Vue.prototype.qs = qs 
//定义全局变量URL
Vue.prototype.URL_ROOT = "http://192.168.1.220:10122"
Vue.prototype.URL_PREFIX = "/product-service"
Vue.prototype.PREFIX_SALES_PLAN = "/sales-plan"
Vue.prototype.PREFIX_INVENTORY = "/inventory"
Vue.prototype.HOST = "/api"
Vue.prototype.ORDERANDOVERSEA_SERVICE = "/orderAndOversea-service"
Vue.prototype.BUSINESSREPORT_SERVICE = "/businessReport-service"
Vue.prototype.PROFITMEASUREMENT_SERVICE = "/profitMeasurement-service" 
Vue.prototype.CODINGINFORMATIONMANAGEMENT_SERVICE = "/codingInformationManagement-service"
Vue.prototype.OVERSEASWAREHOUSESTORAGET_SERVICE = "/overseasWarehouseStoraget-service"
Vue.prototype.REVIEWMONITORING_SERVICE = "/reviewMonitoring-service"


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

