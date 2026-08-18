// src/router/index.js

// -----------
// Vue Router 的路由配置文件
// 路由配置中心​ - 专门用来管理和配置整个应用的所有页面路由规则
// -----------

import { createRouter,createWebHashHistory } from "vue-router";

// 导入组件
import 登录 from '../components/登录.vue'
import 注册 from '../components/注册.vue'

import 首页 from '../components/首页.vue'
import 购物车 from '../components/购物车.vue'
import 热销 from '../components/热销.vue'
import 新品 from '../components/新品.vue'
import 商品详细页面 from '../components/商品详细页面.vue'

import 所有商品 from "../components/所有商品.vue";
import 个人中心 from "../components/个人中心.vue";
import 支付页面 from "../components/支付页面.vue";
import 我的订单 from "../components/我的订单.vue";

import 管理员后台 from "../components/管理员后台.vue";

import 类目管理 from "../components/类目管理.vue";
import 添加类目页面 from "../components/添加类目页面.vue";
import 修改类目页面 from "../components/修改类目页面.vue";

import 用户管理 from "../components/用户管理.vue";
import 重置用户密码 from "../components/重置用户密码.vue";
import 修改用户信息 from "../components/修改用户信息.vue";
import 添加新用户 from "../components/添加新用户.vue";

import 商品管理 from "../components/商品管理.vue";
import 添加新商品 from "../components/添加新商品.vue";
import 修改商品信息 from "../components/修改商品信息.vue";
import 添加至推荐表 from "../components/添加至推荐表.vue";
import 查看推荐表 from "../components/查看推荐表.vue";

import 订单管理 from "../components/订单管理.vue";
import 修改订单信息 from "../components/修改订单信息.vue";

import 数据统计 from "../components/数据统计.vue";
import 操作日志 from "../components/操作日志.vue";

import 修改个人信息 from "../components/修改个人信息.vue";

// 骑手端组件
import 骑手登录 from "../components/骑手登录.vue";
import 骑手注册 from "../components/骑手注册.vue";
import 骑手首页 from "../components/骑手首页.vue";
import 骑手收益统计 from "../components/骑手收益统计.vue";
import 骑手历史订单 from "../components/骑手历史订单.vue";
import 骑手个人中心 from "../components/骑手个人中心.vue";
import 骑手消息 from "../components/骑手消息.vue";
import 骑手管理 from "../components/骑手管理.vue";
import 骑手编辑个人信息 from "../components/骑手编辑个人信息.vue";

//路由表(数组，包含所有路由规则的配置)
const routes = [
    { path: '/', redirect: '/login'},   //加默认路由（重定向）
    { path: '/login', component: 登录 },
    { path: '/register', component: 注册 },
    { path: '/home', component: 首页,  meta:{ requiresAuth: true } },
    { path: '/cart', component: 购物车,  meta:{ requiresAuth: true } },
    { path: '/hot', component: 热销,  meta:{ requiresAuth: true } },
    { path: '/product-detail', component: 商品详细页面,  meta:{ requiresAuth: true } },
    { path: '/products', component:所有商品,  meta:{ requiresAuth: true } },
    { path: '/profile', component:个人中心, meta:{ requiresAuth: true }  },
    { path: '/payment', component:支付页面,  meta:{ requiresAuth: true } },
    { path: '/orders', component:我的订单,  meta:{ requiresAuth: true } },
    { path: '/new', component:新品,  meta:{ requiresAuth: true } },
    { path: '/admin', component:管理员后台, 
                          meta:{ requiresAuth: true, role: 'admin'  },
                          children:[
                            {
                              path: 'categories', 
                              component: 类目管理,
                              meta: { role: 'admin' }
                            },
                            {
                              path: 'users', 
                              component: 用户管理,
                              meta: { role: 'admin' }
                            },
                            {
                              path: 'products', 
                              component: 商品管理,
                              meta: { role: 'admin' }
                            },
                            {
                              path: 'orders', 
                              component: 订单管理,
                              meta: { role: 'admin' }
                            },
                            {
                              path: 'statistics', 
                              component: 数据统计,
                              meta: { role: 'admin' }
                            },
                            {
                              path: 'logs', 
                              component: 操作日志,
                              meta: { role: 'admin' }
                            },
                            {
                              path: 'riders', 
                              component: 骑手管理,
                              meta: { role: 'admin' }
                            },
                          ]
    },
    { path: '/admin/category-add', component:添加类目页面,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/category-edit/:id', component:  修改类目页面 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/user-reset/:id', component:  重置用户密码 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/user-edit/:id', component:  修改用户信息 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/user-add', component:  添加新用户 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/product-add', component:  添加新商品 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/product-edit/:id', component:  修改商品信息 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/recommend-add/:id', component:  添加至推荐表 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/recommend', component:  查看推荐表 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/admin/order-edit/:orderId', component:  修改订单信息 ,  meta:{ requiresAuth: true, role: 'admin' } },
    { path: '/profile-edit/:id', component:  修改个人信息 ,  meta:{ requiresAuth: true } },

    // 骑手端路由
    { path: '/rider/login', component: 骑手登录 },
    { path: '/rider/register', component: 骑手注册 },
    { path: '/rider/home', component: 骑手首页, meta: { requiresRiderAuth: true } },
    { path: '/rider/statistics', component: 骑手收益统计, meta: { requiresRiderAuth: true } },
    { path: '/rider/history', component: 骑手历史订单, meta: { requiresRiderAuth: true } },
    { path: '/rider/profile', component: 骑手个人中心, meta: { requiresRiderAuth: true } },
    { path: '/rider/message', component: 骑手消息, meta: { requiresRiderAuth: true } },
    { path: '/rider/profile-edit', component: 骑手编辑个人信息, meta: { requiresRiderAuth: true } },

]

//路由器实例
//作用：管理整个应用的路由行为，包含导航、历史记录等
const router = createRouter({
    history:createWebHashHistory(),  // 使用hash路由模式
    routes  // 路由配置数组
})


// 判断是否“已登录”：检查 localStorage 是否有 token 或用户信息
function isAuthenticated() {
  return !!localStorage.getItem('user_token')
}

// 获取当前用户信息（从 localStorage）
function getCurrentUser() {
  const userStr = localStorage.getItem('user');
  if (userStr) {
    try {
      return JSON.parse(userStr);
    } catch (e) {
      console.error('解析用户数据失败', e);
      return null;
    }
  }
  return null;
}

// 判断骑手是否已登录
function isRiderAuthenticated() {
  return !!localStorage.getItem('rider_token')
}

// 获取当前骑手信息
function getCurrentRider() {
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    try {
      return JSON.parse(riderStr);
    } catch (e) {
      console.error('解析骑手数据失败', e);
      return null;
    }
  }
  return null;
}

// ========================
// 全局前置守卫（核心！）
// ========================
router.beforeEach((to, from, next) => {
  const user = getCurrentUser();
  const isAuth = !!user;
  const rider = getCurrentRider();
  const isRiderAuth = !!rider;

  // 骑手端路由拦截
  if (to.meta.requiresRiderAuth && !isRiderAuth) {
    alert('请先登录骑手账号');
    next({ path: '/rider/login', query: { redirect: to.fullPath } });
    return;
  }

  // 骑手已登录访问骑手登录页，跳转到骑手首页
  if (to.path === '/rider/login' && isRiderAuth) {
    next('/rider/home');
    return;
  }

  // 用户端需要登录但未登录
  if (to.meta.requiresAuth && !isAuth) {
    alert('请先登录，再操作')
    next({ path: '/login', query: { redirect: to.fullPath } });
    return;
  }

  // 用户已登录却访问登录页 → 按角色跳走
  if (to.path === '/login' && isAuth) {
    if (user.isAdmin === 1) {
      next('/admin');
    } else {
      next('/profile');
    }
    return;
  }

  // 访问管理员页但不是管理员
  if (to.meta.role === 'admin' && (!isAuth || user.isAdmin !== 1)) {
    alert('您不是管理员，无法访问该页面！');
    next('/profile');
    return;
  }

  // 其他情况放行
  next();
});


export default router


