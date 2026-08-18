// src/main.js

// -----------
// 应用入口
// 
// -----------

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import { createI18n } from 'vue-i18n'
import zh from './locales/zh'
import en from './locales/en'
// import './style.css'

//  1. 导入你的 user store
import { useUserStore } from '@/stores/user'  // ← 这行不能少！

import App from './App.vue'
import router from './router'

// i18n 配置
const i18n = createI18n({
  legacy: false,
  locale: localStorage.getItem('locale') || 'zh',
  fallbackLocale: 'zh',
  messages: { zh, en }
})

const app = createApp(App)
const pinia = createPinia()
app.use(router)      // 使用路由功能
app.use(pinia)       //  注册 Pinia
app.use(i18n)         // 注册 i18n

// 启动时恢复登录状态
const userStore = useUserStore();
userStore.restoreFromStorage();

app.mount('#app')