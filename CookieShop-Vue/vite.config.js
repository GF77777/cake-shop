// vite.config.js
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'node:path' // 👈 新增：引入 path 模块

export default defineConfig({
  plugins: [vue()],
    resolve: {
    alias: {
      '@': path.resolve(__dirname, './src') // 👈 关键：让 @ 指向 src 目录
    }
  },

  build: {
    outDir: 'cookieshop-dist' // 打包输出目录
  },

  server: {
    port: 5175,
    proxy: {
      '/api': {
        target: 'http://localhost:8080', // 你的 Tomcat 地址
        changeOrigin: true
        // rewrite 已移除，保持 /api 前缀不变
      },
      '/picture': {  // ← 新增代理
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  }
})