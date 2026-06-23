<!-- src/App.vue -->
<template>
  
  <nav v-if="!isRiderPage">
    <div class="left">
      <ul>
        <li><router-link to="/home">{{ $t('home') }}</router-link></li>

        <!-- 商品分类下拉菜单 -->
        <div class="dropdown">
          <button class="dropbtn">{{ $t('productCategory') }}</button>
          <div class="dropdown-content">
            <router-link to="/products">{{ $t('allProducts') }}</router-link>
            <!-- 动态生成分类 -->
            <template v-for="category in categories" :key="category.id">
              <router-link 
                :to="{ path: '/products', query: { type: category.name } }"
                class="dropdown-item"
              >
                {{ category.name }}
              </router-link>
            </template>
          </div>
        </div>

        <li><router-link to="/hot">{{ $t('hot') }}</router-link></li>
        <li><router-link to="/new">{{ $t('new') }}</router-link></li>

        
        <li><router-link to="/orders">{{ $t('myOrders') }}</router-link></li>
        <li><router-link to="/profile">{{ $t('profile') }}</router-link></li>

        <li v-if="isAdmin">
            <router-link to="/admin">{{ $t('adminPanel') }}</router-link>
        </li>
        <button @click="handleLogout">{{ $t('logout') }}</button>

      </ul>
    </div>

    <div class="right">
      <div>
        <input type="text" v-model="searchKeyword" :placeholder="$t('searchPlaceholder')" />
        <button @click="handleSearch">{{ $t('search') }}</button>
      </div>
      <router-link to="/cart">{{ $t('cart') }}</router-link>
      <button class="btn-lang" @click="toggleLocale">{{ locale === 'zh' ? 'EN' : '中文' }}</button>
    </div>
  </nav>


  <router-view />

  <AI客服 v-if="!isRiderPage && !isAdminPage" />
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { useUserStore } from '@/stores/user'
import AI客服 from './components/AI客服.vue'

const { locale } = useI18n()
const router = useRouter()
const userStore = useUserStore()

const toggleLocale = () => {
  const newLocale = locale.value === 'zh' ? 'en' : 'zh'
  locale.value = newLocale
  localStorage.setItem('locale', newLocale)
}

const handleLogout = async () => {
  await userStore.logout()
  router.replace('/login')
}




const searchKeyword = ref('')

const categories = ref([])

// 获取商品分类
const fetchCategories = async () => {
  try {
    const response = await fetch('/api/types')
    const result = await response.json()
    if (result.code === 200) {
      categories.value = result.data // 假设返回 { code: 0, data: [...] }
    } else {
      console.warn('获取分类失败:', result)
    }
  } catch (error) {
    console.error('请求分类接口出错:', error)
  }
}

// 搜索功能
const handleSearch = async () => {
  if (!searchKeyword.value.trim()) return

  try {
    const response = await fetch(`/api/byName?name=${encodeURIComponent(searchKeyword.value)}`)
    const data = await response.json()

    console.log('搜索结果:', data)
    
    router.push({
      path: '/所有商品',
      query: { keyword: searchKeyword.value }
    })
    //清空搜索栏
    searchKeyword.value = ''

  } catch (error) {
    console.error('搜索失败:', error)
    alert('搜索失败，请检查网络或服务器')
  }
}

// 页面加载时获取分类
onMounted(() => {
  userStore.restoreFromStorage() 
  fetchCategories()
})


// ---------------
// 获取当前用户信息
const currentUser = computed(() => userStore.userInfo)

// 判断是否为管理员
const isAdmin = computed(() => {
  return userStore.isAdmin === 1
})

// 判断是否在骑手页面
const isRiderPage = computed(() => {
  return router.currentRoute.value.path.startsWith('/rider')
})

// 判断是否在管理员页面
const isAdminPage = computed(() => {
  return router.currentRoute.value.path.startsWith('/admin')
})
// ---------------
</script>

<style scoped>
* {
  box-sizing: border-box;
}

/* 导航栏 */
nav {
  padding: 10px 20px;
  background-color: #fff;
  box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
  display: flex;
  justify-content: space-between;
  align-items: center;
  position: sticky;
  top: 0;
  z-index: 100;
}

nav ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  display: flex;
  gap: 20px;
  align-items: center;
}

/* 所有导航链接 */
nav a {
  text-decoration: none;
  color: #8a2be2; /* 紫色 */
  font-size: 15px;
  padding: 8px 16px;
  border-radius: 4px;
  transition: all 0.2s ease;
  display: block;
  text-align: center;
}

/* 悬停效果 */
nav a:hover {
  background-color: #e8f5e9;
  color: #2e7d32;
}

/* 当前激活的路由（精确匹配）——重点修改部分 */
nav a.router-link-exact-active {
  background-color: #4caf50; /* 深绿色背景 */
  color: white !important;
  font-weight: bold;
}

/* 商品分类下拉菜单 */
.dropdown {
  position: relative;
  display: inline-block;
}

.dropbtn {
  background-color: #4caf50;
  color: white;
  padding: 8px 16px;
  font-size: 15px;
  border: none;
  cursor: pointer;
  border-radius: 4px;
  font-weight: 500;
  transition: background-color 0.2s;
}

.dropbtn:hover {
  background-color: #45a049;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #fff;
  min-width: 160px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  z-index: 999;
  top: 100%;
  left: 0;
  border-radius: 4px;
  overflow: hidden;
}

.dropdown:hover .dropdown-content {
  display: block;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  transition: background-color 0.2s;
}

.dropdown-content a:hover {
  background-color: #f5f5f5;
}

/* 下拉菜单中当前激活项 */
.dropdown-content a.router-link-exact-active {
  background-color: #e8f5e9;
  color: #2e7d32 !important;
  font-weight: bold;
}

/* 右侧区域 */
.right {
  display: flex;
  align-items: center;
  gap: 15px;
}

.right input[type="text"] {
  padding: 8px 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 14px;
  outline: none;
}

.right button {
  background-color: #4caf50;
  color: white;
  border: none;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.right button:hover {
  background-color: #45a049;
}

.right a {
  color: #8a2be2;
  font-size: 15px;
  text-decoration: none;
  font-weight: 500;
  padding: 8px 12px;
  border-radius: 4px;
  transition: all 0.2s;
}

.right a:hover {
  background-color: #e8f5e9;
  color: #2e7d32;
}

.right a.router-link-exact-active {
  background-color: #4caf50;
  color: white !important;
  font-weight: bold;
}

/* 语言切换按钮 */
.btn-lang {
  background-color: #2196f3;
  color: white;
  border: none;
  padding: 8px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.btn-lang:hover {
  background-color: #1976d2;
}

/* 添加购物车按钮样式（在商品页用） */
.add-to-cart-btn {
  background-color: #4caf50;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  margin-top: 10px;
  transition: background-color 0.2s;
}

.add-to-cart-btn:hover {
  background-color: #45a049;
}

/* 商品卡片样式（在所有商品页使用） */
.goods-card {
  border: 1px solid #eee;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  margin: 10px;
  width: 280px;
  transition: transform 0.2s;
}

.goods-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.goods-card img {
  width: 100%;
  height: 180px;
  object-fit: cover;
}

.goods-info {
  padding: 12px;
}

.goods-info h3 {
  margin: 0 0 8px 0;
  font-size: 14px;
  color: #333;
}

.goods-info p {
  margin: 0;
  color: #666;
  font-size: 14px;
}

/* 页面主内容 */
.container {
  padding: 20px;
  max-width: 1200px;
  margin: 0 auto;
}
</style>