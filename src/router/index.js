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
  },
  {
    path: '/index',
    name:'首页',
    component: resolve => require(['../components/index/index.vue'], resolve),
    meta: {
      breadcrumb: true
    },
    children: [{
      path: '/index/calendar',
      component: resolve => require(['../components/index/opts/calendar.vue'], resolve),
    }]
  },
  {
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
    name:'产品管理',
    component: resolve => require(['../components/product/subscription/Subscription.vue'], resolve),
  },
  {
    path: '/businessReport',
    name:'销售报告',
    component: resolve => require(['../components/businessReport/businessReport.vue'], resolve),
  },
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

  {
    path: '/overseasStock',
    name:'海外库存',
    component: resolve => require(['../components/overseasStock/overseasStock.vue'], resolve),
    children: [{
      path: '/overseasStock',
      name: '易达云',
      component: resolve => require(['../components/overseasStock/edayun.vue'], resolve),
      meta: {
        keepAlive: false
      }
    },{
      path: '/overseasStock/winit',
      name: '万邑通',
      component: resolve => require(['../components/overseasStock/winit.vue'], resolve),
      meta: {
        keepAlive: false
      }
    }]
  },
  {
    path: '/project',
    name:'产品项目',
    component: resolve => require(['../components/project/project.vue'], resolve),
    children: [{
      path: '/project',
      name:'产品列表',
      component: resolve => require(['../components/project/projectList.vue'], resolve),
    },{
      path: '/project/projectDetail',
      name:'项目产品',
      component: resolve => require(['../components/project/projectDetail.vue'], resolve),
    }]
  },
  {
    path: '/orderTracking',
    name:'订单查询',
    component: resolve => require(['../components/orderTracking/orderTracking.vue'], resolve),
    children: [{
      path: '/orderTracking',
      name:'找订单号',
      component: resolve => require(['../components/orderTracking/orderNumber.vue'], resolve),
    },{
      path: '/orderTracking/orderDetailst',
      name:'订单详情',
      component: resolve => require(['../components/orderTracking/orderDetailst.vue'], resolve),
    }]
  },{
    path: '/shipmentTracking',
    name:'货件追踪',
    component: resolve => require(['../components/shipmentTracking/shipmentTracking.vue'], resolve),
  },{
    path: '/reviewManagement',
    name:'评价管理',
    component: resolve => require(['../components/reviewManagement/reviewManagement.vue'], resolve),
  },{
    path: '/badReview',
    name:'差评追踪',
    component: resolve => require(['../components/badReview/badReview.vue'], resolve),
  },{
    path: '/shippingRefund/ship',
    name:'售后及退款',
    component: resolve => require(['../components/shippingRefund/index.vue'], resolve),
    children: [{
      path: '/shippingRefund/ship',
      name:'发货',
      component: resolve => require(['../components/shippingRefund/ship.vue'], resolve),
      children: [{
        path: '/shippingRefund/ship/edayun',
        name:'发货-易达云',
        component: resolve => require(['../components/shippingRefund/opts/ship-edayun.vue'], resolve), 
      },{
        path: '/shippingRefund/ship/amazon',
        name:'发货-亚马逊',
        component: resolve => require(['../components/shippingRefund/opts/ship-amazon.vue'], resolve), 
      }]
    },{
      path: '/shippingRefund/refund',
      name:'退款',
      component: resolve => require(['../components/shippingRefund/refund.vue'], resolve),
    }]
  },{
    path: '/requireAssistance',
    name:'事件支持',
    component: resolve => require(['../components/requireAssistance/developProcess.vue'], resolve),
  },
  {
    path: '/sellerData',
    name:'数据设置',
    component: resolve => require(['../components/seller/data/SellerData.vue'], resolve),
  }
]

export default new Router({
  linkActiveClass: 'active',
  routes
});
