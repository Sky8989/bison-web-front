import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    country: [],
    logined: false,
    LoginedUser: {},
    product: {},
    businessReportData: {
      businessUnitId: [],
      countryId: [], 
      productCategoryId: [],
      productId: []
    },
    businessReportDataCloumnSetting:[]
  },
  mutations: {
    // 改变状态的方法也需要2个，一个是登录或注册了，一个是登出了
    // 登录
    LOGIN(state, val) {
      // 先让登录状态变为登录了
      state.logined = true
      state.LoginedUser = val
      localStorage.setItem('LoginedUser', JSON.stringify(val))
    },
    // 登出
    LOGOUT(state) {
      state.logined = true
      state.LoginedUser = {}
      localStorage.setItem('LoginedUser', '')
    },
    // 地址
    set_country(state, country) {
      let data = JSON.stringify(country)
      localStorage.setItem('country', data)
      console.log(JSON.parse(localStorage.getItem("country")))
    },
    setProduct(state, data) {
      // console.log("---setProduct")
      state.product = data
    },
    // 销售报告
    businessReport(state, data){
      state.businessReportData = data
    },
    _businessReportDataCloumnSetting(state, data){
      state.businessReportDataCloumnSetting = data
    }
  },
  getters: {
    isLogin(state) {
      if (!state.LoginedUser) {
        state.LoginedUser = localStorage.getItem('isLogin');   //从sessionStorage中读取状态  
      }
      return state.LoginedUser
    }
  }
})
