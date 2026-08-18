<template>
  <div class="admin-layout">
    <!-- 头部导航 -->
    <header class="admin-header">
      <div class="header-left">
        <h1 class="site-title">{{ $t('adminTitle') }}</h1><br>
        <nav class="nav-menu">
          <ul>
            <li>
              <router-link to="/admin/orders" :class="{ active: $route.path === '/admin/orders' }">
                {{ $t('orderManagement') }}
              </router-link>
            </li>
            <li>
              <router-link to="/admin/users" :class="{ active: $route.path === '/admin/users' }">
                {{ $t('userManagement') }}
              </router-link>
            </li>
            <li>
              <router-link to="/admin/products" :class="{ active: $route.path === '/admin/products' }">
                {{ $t('productManagement') }}
              </router-link>
            </li>
            <li>
              <router-link to="/admin/categories" :class="{ active: $route.path === '/admin/categories' }">
                {{ $t('categoryManagement') }}
              </router-link>
            </li>
            <li>
              <router-link to="/admin/statistics" :class="{ active: $route.path === '/admin/statistics' }">
                {{ $t('dataStatistics') }}
              </router-link>
            </li>
            <li>
              <router-link to="/admin/logs" :class="{ active: $route.path === '/admin/logs' }">
                操作日志
              </router-link>
            </li>
            <li>
              <router-link to="/admin/riders" :class="{ active: $route.path === '/admin/riders' }">
                骑手管理
              </router-link>
            </li>
          </ul>
        </nav>
      </div>

    </header>

    <!-- 主内容区 -->
    <main class="admin-main">
      <router-view></router-view>
    </main>

    <!-- AI客服组件 -->
    <AI客服 />
  </div>
</template>

<script>
import AI客服 from './AI客服.vue'

export default {
  components: {
    'AI客服': AI客服
  }
}
</script>

<style scoped>
.admin-layout {
  min-height: 100vh;
  background-color: #f5f7fa;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

/* 头部样式 */
.admin-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background-color: white;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border-bottom: 1px solid #e0e0e0;
}

.site-title {
  color: #333;
  font-size: 24px;
  font-weight: 700;
  margin: 0;
}

.nav-menu ul {
  list-style: none;
  margin: 0;
  padding: 0;
  display: flex;
  gap: 24px;
}

.nav-menu li a {
  text-decoration: none;
  color: #666;
  font-size: 15px;
  padding: 8px 12px;
  border-radius: 6px;
  transition: all 0.2s;
}

.nav-menu li a:hover,
.nav-menu li a.active {
  color: #fff;
  background-color: #3498db;
}

/* 右侧按钮 */
.btn-logout {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-logout:hover {
  background-color: #c0392b;
}

/* 主内容区 */
.admin-main {
  padding: 24px;
  max-width: 1200px;
  margin: 0 auto;
  min-height: calc(100vh - 80px);
}

/* 响应式设计 */
@media (max-width: 768px) {
  .admin-header {
    flex-direction: column;
    gap: 16px;
    padding: 16px;
  }

  .nav-menu ul {
    flex-wrap: wrap;
    gap: 12px;
  }

  .nav-menu li a {
    padding: 6px 10px;
    font-size: 14px;
  }

  .admin-main {
    padding: 16px;
  }
}
</style>