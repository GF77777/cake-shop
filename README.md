# cake-shop

蛋糕商城 - 前后端分离的在线蛋糕销售平台，包含用户端、管理端和骑手端功能

## 📦 上传说明

### 上传内容

**上传初始代码** - 包含完整的前后端项目代码及数据库初始化脚本

### 📁 项目结构

```
cake-shop/
├── CookieShop-Vue/          # 前端项目 (Vue3 + Vite)
│   ├── src/                 # 源代码
│   ├── public/              # 静态资源
│   └── package.json         # 依赖配置
├── cakeproject/             # 后端项目 (Spring Boot)
│   ├── src/main/java/       # Java 源代码
│   ├── src/main/resources/  # 配置文件
│   └── pom.xml             # Maven 配置
├── cookieshop.sql           # 数据库初始化脚本
└── .gitignore              # Git 忽略规则
```

### ✅ 功能模块

- **用户端**: 商品浏览、购物车、订单管理、个人中心
- **管理端**: 用户管理、商品管理、订单管理、骑手管理、数据统计
- **骑手端**: 订单接单、配送管理、收益统计、消息通知

### 🚀 快速开始

```bash
# 1. 创建数据库并导入数据
mysql -u root -p < cookieshop.sql

# 2. 启动后端服务 (端口 8080)
cd cakeproject && mvn spring-boot:run

# 3. 安装前端依赖并启动 (端口 5175)
cd CookieShop-Vue && npm install && npm run dev
```

### 🛠️ 技术栈

- **前端**: Vue 3 + Vite + Pinia + Vue Router
- **后端**: Spring Boot 2.7 + MyBatis + MySQL
- **其他**: Axios、Vue I18n

### 🔗 仓库地址

https://github.com/GF77777/cake-shop