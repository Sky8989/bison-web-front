import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)

const routes = [
  {
    path: '/',
    title: 'bison后台管理',
    redirect: '/index'
  }, {
    path: '/login',
    name: '登录页面',
    component: resolve => require(['../components/login/login.vue'], resolve),
    meta: {
      navShow: true,
      breadcrumb: true
    }
  }, {
    path: '/index',
    name:'首页',
    component: resolve => require(['../components/index/index.vue'], resolve),
    meta: {
      breadcrumb: true
    }
  }, {
    path: '/user-subscription',
    name:'产品订阅',
    component: resolve => require(['../components/user/subscription/subscription.vue'], resolve),
  }, {
    path: '/user-password',
    name:'个人密码',
    component: resolve => require(['../components/user/modifyPassword/modifyPassword.vue'], resolve),
  }, {
    path: '/department',
    name:'部门人员',
    component: resolve => require(['../components/department/department.vue'], resolve),
  }, {
    path: '/roleManager',
    name:'角色管理',
    component: resolve => require(['../components/role/roleManager.vue'], resolve),
  }, {
    path: '/product',
    name:'产品基础信息',
    component: resolve => require(['../components/product/Product.vue'], resolve),
  },
  {
    path: '/productSubscription',
    name:'产品订阅',
    component: resolve => require(['../components/product/subscription/Subscription.vue'], resolve),
  },
  // {
  //   path: '/businessReport',
  //   name:'销售报告',
  //   component: resolve => require(['../components/businessReport/businessReport.vue'], resolve),
  // },
  {
    path: '/productCodeInfo',
    name:'产品编码信息管理',
    component: resolve => require(['../components/productCodeInfo/productCodeInfo.vue'], resolve),
  },
  {
    path: '/paoductProfitCalculation',
    name:'产品利润测算',
    component: resolve => require(['../components/paoductProfitCalculation/paoductProfitCalculation.vue'], resolve),
  },
  {
    path: '/salePlan',
    name:'销售计划',
    component: resolve => require(['../components/sales/plan/SalePlan.vue'], resolve),
  },
  {
    path: '/inventory',
    name:'库存管理',
    component: resolve => require(['../components/inventory/Inventory.vue'], resolve),
  },
]

export default new Router({
  linkActiveClass: 'active',
  routes
});
