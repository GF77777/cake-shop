<!-- src/views/GoodDetail.vue -->
<template>
  <div class="good-detail-container">
    <!-- 返回按钮 -->
    <button @click="goBack" class="btn-back">
      ← {{ $t('back') }}
    </button>
    
    <div class="main-content">
      <!-- 商品主图与信息 -->
      <div class="product-info">
        <div class="product-image">
          <img :src="imgUrl" alt="商品封面" />
        </div>
        <div class="product-details">
          <h1 class="product-title">{{ name }}</h1>
          <p class="product-category">{{ $t('category') }}：{{ typeName }}</p>
          <p class="product-description">{{ intro }}</p>
          <div class="product-price">¥ {{ price.toFixed(2) }}</div>
          <button @click="addToCart" class="btn-add-to-cart">
            {{ $t('addToCart') }}
          </button>
        </div>
      </div>

      <!-- 分类导航侧边栏 -->
      <div class="category-sidebar">
        <router-link to="/products"><h3>{{ $t('allCategories') }}</h3></router-link>
        <ul class="category-list">
          <li v-for="category in categories" :key="category.id" class="category-item">
            <router-link
              :to="{ path: '/products', query: { type: category.name } }"
              class="category-link"
            >
              {{ category.name }}
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
import { useCartStore } from '@/stores/cart'

const imgUrl = ref('')
const name = ref('')
const intro = ref('')
const price = ref(0)
const typeName = ref('')
const route = useRoute()
const router = useRouter()
const cartStore = useCartStore()

// 获取当前商品数据（用于添加购物车）
const currentGood = ref(null)

const fetchGoodDetail = async () => {
  const id = route.query.id
  if (!id) {
    console.error('缺少商品ID')
    return
  }

  try {
    const res = await axios.get('/api/goods')
    const goodsList = res.data.data || []
    const good = goodsList.find(item => String(item.id) === String(id))

    if (good) {
      imgUrl.value = good.cover
      name.value = good.name
      intro.value = good.intro
      price.value = good.price
      typeName.value = good.typeName
      currentGood.value = good 
    }
  } catch (error) {
    console.error('请求失败:', error)
  }
}

const addToCart = () => {
  if (currentGood.value) {
    cartStore.addToCart(currentGood.value)
    alert(`${name.value} 已添加到购物车`)
  }
}

// 返回上一页
const goBack = () => {
  // 获取来源页面标识、页码参数和订单ID
  const from = route.query.from
  const page = route.query.page
  const orderId = route.query.orderId
  
  // 根据来源页面决定返回哪个页面
  if (from === 'orders') {
    // 从订单页面来的，返回我的订单页面
    const query = {}
    if (page) query.page = page
    if (orderId) query.orderId = orderId
    router.push({ 
      path: '/orders', 
      query 
    })
  } else if (from === 'admin-products') {
    // 从管理员商品管理页面来的，返回管理员商品管理页面
    router.push({ 
      path: '/admin/products', 
      query: page ? { page } : {} 
    })
  } else {
    // 默认返回商品列表页
    router.push({ 
      path: '/products', 
      query: page ? { page } : {} 
    })
  }
}

onMounted(() => {
  fetchGoodDetail()
  fetchCategories()
})

//
const categories = ref([])
// 获取商品分类
const fetchCategories = async () => {
  try {
    const response = await fetch('/api/types')
    const result = await response.json()
    if (result.code === 200) {
      categories.value = result.data 
    } else {
      console.warn('获取分类失败:', result)
    }
  } catch (error) {
    console.error('请求分类接口出错:', error)
  }
}
</script>

<style scoped>
.good-detail-container {
  max-width: 1200px;
  margin: 7% auto;
  padding: 24px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

/* 返回按钮 */
.btn-back {
  padding: 10px 20px;
  background-color: #f5f5f5;
  color: #333;
  border: 1px solid #ddd;
  border-radius: 8px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s;
  margin-bottom: 20px;
}

.btn-back:hover {
  background-color: #eee;
  border-color: #ccc;
}

.main-content {
  display: flex;
  gap: 32px;
  flex-wrap: wrap;
}

/* 商品信息区 */
.product-info {
  flex: 2;
  min-width: 300px;
  display: flex;
  gap: 24px;
  flex-wrap: wrap;
}

.product-image {
  flex: 1;
  min-width: 280px;
}

.product-image img {
  width: 100%;
  height: auto;
  border-radius: 12px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  object-fit: cover;
}

.product-details {
  flex: 1;
  min-width: 280px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.product-title {
  font-size: 28px;
  color: #2c3e50;
  margin: 0 0 12px 0;
}

.product-category {
  color: #7f8c8d;
  margin: 0 0 16px 0;
  font-size: 16px;
}

.product-description {
  color: #555;
  line-height: 1.6;
  margin: 0 0 20px 0;
  font-size: 16px;
}

.product-price {
  font-size: 24px;
  font-weight: bold;
  color: #e74c3c;
  margin: 0 0 20px 0;
}

.btn-add-to-cart {
  padding: 12px 24px;
  background-color: #3498db;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 18px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s;
  align-self: flex-start;
}

.btn-add-to-cart:hover {
  background-color: #2980b9;
}

/* 分类侧边栏 */
.category-sidebar {
  flex: 1;
  min-width: 200px;
  background-color: #f9f9f9;
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.category-sidebar h3 {
  margin-top: 0;
  color: #2c3e50;
  font-size: 18px;
  margin-bottom: 16px;
}

.category-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.category-item {
  margin-bottom: 10px;
}

.category-link {
  text-decoration: none;
  color: #3498db;
  font-size: 16px;
  padding: 6px 0;
  display: block;
  transition: color 0.2s;
}

.category-link:hover {
  color: #2980b9;
  text-decoration: underline;
}

.category-link.router-link-exact-active {
  color: #e74c3c;
  font-weight: bold;
}


</style>