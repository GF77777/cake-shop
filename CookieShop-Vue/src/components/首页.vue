<template>
  <h1 class="h11">{{ $t('todayPick') }}</h1>
  <div class="carousel" @mouseenter="stopAutoPlay" @mouseleave="startAutoPlay">
    <!-- 图片容器 -->
    <div class="carousel-track" :style="{ transform: `translateX(-${currentIndex * 100}%)` }">
      <div v-for="(image, index) in images" :key="index" class="carousel-slide" @click="goToDetail(image.id)">
        <img :src="image.cover" :alt="`Slide ${index + 1}`" class="carousel-image" />
      </div>
    </div>

    <!-- 左右箭头 -->
    <button class="carousel-btn prev" @click="prev">&lt;</button>
    <button class="carousel-btn next" @click="next">&gt;</button>

    <!-- 指示器 -->
    <div class="carousel-indicators">
      <span
        v-for="(image, index) in images"
        :key="index"
        class="indicator"
        :class="{ active: index === currentIndex }"
        @click="goTo(index)"
      ></span>
    </div>
  </div>

   <div class="goods">
    <h1 >{{ $t('allGoods') }}</h1>
      <div class="bigbox">
    <div
      class="smallbox"
      v-for="(good, index) in paginatedGoods"
      :key="index"
      @click="goToDetail(good.id)"
    >
      <div class="img"><img :src="good.cover" alt="" /></div>
      <p>{{ $t('product') }}：{{ good.name }}</p>
      <p>{{ $t('price') }}: ¥{{ good.price.toFixed(2) }}</p>
      <button @click.stop="addToCart(good)">{{ $t('addToCart') }}</button>
    </div>
   </div>
    <!-- 分页组件 -->
    <div v-if="totalPages > 1" class="pagination">
      <button 
        :disabled="currentPage <= 1" 
        @click="changePage(currentPage - 1)"
        class="page-btn"
      >{{ $t('prevPage') }}</button>
      <span class="page-info">{{ $t('pageInfo', { current: currentPage, total: totalPages, count: filteredGoods.length }) }}</span>
      <button 
        :disabled="currentPage >= totalPages" 
        @click="changePage(currentPage + 1)"
        class="page-btn"
      >{{ $t('nextPage') }}</button>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, watch, computed } from 'vue'
import axios from 'axios'
import { useRouter, useRoute } from 'vue-router'
import { useCartStore } from '@/stores/cart'

const router = useRouter()
const route = useRoute()
const cartStore = useCartStore()

const goodsList = ref([])

const images = ref([])
const currentIndex = ref(0)
let timer = null

// 分页相关
const currentPage = ref(1)
const pageSize = ref(9)
const filteredGoods = ref([])

// 计算当前页显示的商品
const paginatedGoods = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filteredGoods.value.slice(start, end)
})

// 计算总页数
const totalPages = computed(() => {
  return Math.ceil(filteredGoods.value.length / pageSize.value)
})

// 切换页码
const changePage = (page) => {
  if (page < 1 || page > totalPages.value) return
  currentPage.value = page
  // 滚动到商品区域顶部
  document.querySelector('.goods').scrollIntoView({ behavior: 'smooth' })
}

// 获取图片数据（横条 type=0）
const fetchImages = async () => {
  try {
    const res = await axios.get('/api/findRecommendByType?type=0')
    images.value = res.data.data || []
    currentIndex.value = 0
  } catch (error) {
    console.error('加载图片失败:', error)
  }
}

// 切换到下一张
const next = () => {
  currentIndex.value = (currentIndex.value + 1) % images.value.length
}

// 切换到上一张
const prev = () => {
  currentIndex.value =
    (currentIndex.value - 1 + images.value.length) % images.value.length
}

// 跳转到指定索引
const goTo = (index) => {
  currentIndex.value = index
}

// 自动播放
const startAutoPlay = () => {
  if (images.value.length > 1) { // 只有多于一张图片时才启动自动播放
    timer = setInterval(next, 3000)
  }
}

// 停止自动播放
const stopAutoPlay = () => {
  if (timer) {
    clearInterval(timer)
    timer = null
  }
}

onMounted(() => {
  fetchImages()
  startAutoPlay()
})

onUnmounted(() => {
  stopAutoPlay()
})

// 
const fetchData = async () => {
  const { type, keyword } = route.query

  try {
    let allGoods = []

    if (keyword) {
      // 搜索：调用 /byName 接口
      const res = await axios.get(`/api/byName?name=${encodeURIComponent(keyword)}`)
      allGoods = res.data.data || []
    } else {
      // 否则：获取全部商品
      const res = await axios.get('/api/goods')
      allGoods = res.data.data || []
    }

    // 如果有 type 参数，前端按 typeName 过滤
    if (type) {
      filteredGoods.value = allGoods.filter(good => good.typeName === type)
    } else {
      filteredGoods.value = allGoods
    }
    
    // 更新 goodsList 保持兼容性
    goodsList.value = filteredGoods.value
    
    // 重置到第一页
    currentPage.value = 1

    console.log('商品加载成功:', filteredGoods.value.length, '件')
  } catch (error) {
    console.error('获取商品失败:', error)
    alert('商品加载失败，请稍后重试')
    filteredGoods.value = []
    goodsList.value = []
  }
}
//  第二步：再使用 fetchData
watch(
  () => route.query,
  () => {
    fetchData()
  },
  { immediate: true } // 组件一加载就执行一次
)

// 其他方法
const goToDetail = (id) => {
  router.push({ path: '/product-detail', query: { id } })
}

const addToCart = (good) => {
  cartStore.addToCart(good)
  alert(`${good.name} 已添加到购物车`)
}
</script>

<style scoped>
.h11{
  margin-left: 17%;
}
/* 轮播图 */
.carousel {
  position: relative;
  width: 100%;
  max-width: 1100px;
  margin: 0 auto;
  overflow: hidden;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.2);
}

.carousel-track {
  display: flex;
  transition: transform 0.5s ease-in-out;
}

.carousel-slide {
  min-width: 100%;
  height: 500px; /* 根据需要调整 */
}

.carousel-slide img {
  width: 100%;
  height: 162%;
  object-fit: cover;
  display: block;
}

.carousel-image {
  cursor: pointer;
  transition: transform 0.3s ease;
}

.carousel-image:hover {
  transform: scale(1.02);
}

.carousel-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(0,0,0,0.5);
  color: white;
  border: none;
  width: 40px;
  height: 40px;
  font-size: 18px;
  cursor: pointer;
  border-radius: 50%;
  z-index: 10;
}

.prev { left: 10px; }
.next { right: 10px; }

.carousel-indicators {
  position: absolute;
  bottom: 16px;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  gap: 8px;
}

.indicator {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  background: rgba(255,255,255,0.5);
  cursor: pointer;
}

.indicator.active {
  background: white;
}


/* 所有商品 */
.goods{
  width: 85%;
  margin: auto;
}
.bigbox {
  background-color: #f5f5f5;
  width: 100%;
  padding: 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.smallbox {
  background-color: white;
  width: calc(30% - 20px); /* 更合理的宽度 */
  padding: 16px;
  border: 1px solid #ddd;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s;
}

.smallbox:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.img img {
  width: 100%;
  height: 250px;
  object-fit: cover;
  border-radius: 4px;
}

p {
  margin: 8px 0;
  font-size: 14px;
}

button {
  margin-top: 10px;
  padding: 6px 12px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}

/* 分页样式 */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
  margin-top: 30px;
  padding: 20px 0;
}

.page-btn {
  padding: 10px 20px;
  font-size: 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.page-btn:hover:not(:disabled) {
  background-color: #45a049;
}

.page-btn:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.page-info {
  font-size: 16px;
  color: #666;
}
</style>