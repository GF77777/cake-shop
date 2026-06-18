<template>
  <div class="box">
      <h1>{{ $t('myOrders') }}</h1>

      <!-- 搜索框 -->
      <div class="search-container">
        <input 
          type="text" 
          v-model="searchKeyword" 
          :placeholder="$t('orderSearchPlaceholder')" 
          class="search-input"
          @keyup.enter="handleSearch"
        />
        <button @click="handleSearch" class="search-btn">{{ $t('searchBtn') }}</button>
        <button v-if="searchKeyword" @click="clearSearch" class="clear-btn">{{ $t('clear') }}</button>
      </div>

      <div v-if="loading">{{ $t('loading') }}</div>
      <div v-else-if="error" class="error">{{ error }}</div>
      <div v-else-if="orders.length === 0">{{ $t('noOrders') }}</div>
      <div v-else class="order-list">
        <div v-for="order in orders" :key="order.orderId" class="order-item">
          <p><strong>{{ $t('orderId') }}：</strong>{{ order.orderId }}</p>
          <p><strong>{{ $t('orderTime') }}：</strong>{{ order.dateTime }}</p>
          <p><strong>{{ $t('receiver') }}：</strong>{{ order.name }}（{{ order.phone }}）</p>
          <p><strong>{{ $t('receiverAddress') }}：</strong>{{ order.address }}</p>
          <p><strong>{{ $t('productCount') }}：</strong>{{ order.amount }} 件</p>
          <p><strong>{{ $t('total') }}：</strong>¥{{ order.total.toFixed(2) }}</p>
          <p><strong>{{ $t('payType') }}：</strong>{{ payTypeText(order.payType) }}</p>
          <p><strong>{{ $t('status') }}：</strong><span :class="['status-tag', `status-${order.status}`]">{{ statusText(order.status) }}</span></p>
          <button v-if="order.status === 0 || order.status === 1" @click="cancelOrder(order.orderId)" class="cancel-btn">取消订单</button>
          <button @click="showOrderDetail(order.orderId)" class="detail-btn">{{ $t('viewDetail') }}</button>
        </div>
      </div>

      <!-- 分页组件 -->
      <div v-if="total > 0" class="pagination">
        <button 
          :disabled="pageNum <= 1" 
          @click="changePage(pageNum - 1)"
          class="page-btn"
        >{{ $t('prevPage') }}</button>
        <span class="page-info">{{ $t('pageInfo', { current: pageNum, total: pages, count: total }) }}</span>
        <button 
          :disabled="pageNum >= pages" 
          @click="changePage(pageNum + 1)"
          class="page-btn"
        >{{ $t('nextPage') }}</button>
      </div>

      <!-- 订单详情弹窗 -->
      <div v-if="showDetail" class="modal-overlay" @click="closeDetail">
        <div class="modal-content" @click.stop>
          <div class="modal-header">
            <h2>{{ $t('orderDetail') }}</h2>
            <button class="close-btn" @click="closeDetail">&times;</button>
          </div>
          <div class="modal-body">
            <div v-if="detailLoading">{{ $t('loading') }}</div>
            <div v-else-if="detailError" class="detail-error">{{ detailError }}</div>
            <div v-else>
              <!-- 订单基本信息 -->
              <div class="order-info">
                <h3>{{ $t('orderInfo') }}</h3>
                <p><strong>{{ $t('orderId') }}：</strong>{{ detailData.order.orderId }}</p>
                <p><strong>{{ $t('orderTime') }}：</strong>{{ detailData.order.dateTime }}</p>
                <p><strong>{{ $t('receiver') }}：</strong>{{ detailData.order.name }}（{{ detailData.order.phone }}）</p>
                <p><strong>{{ $t('receiverAddress') }}：</strong>{{ detailData.order.address }}</p>
                <p><strong>{{ $t('payType') }}：</strong>{{ payTypeText(detailData.order.payType) }}</p>
                <p><strong>{{ $t('status') }}：</strong>{{ statusText(detailData.order.status) }}</p>
                <p><strong>{{ $t('totalCount') }}：</strong>{{ detailData.order.amount }} 件</p>
                <p><strong>{{ $t('orderTotal') }}：</strong>¥{{ detailData.order.total.toFixed(2) }}</p>
              </div>
              
              <!-- 商品列表（可滚动） -->
              <div class="order-items">
                <h3>{{ $t('productDetail') }}</h3>
                <div class="items-list">
                  <div 
                    v-for="item in detailData.items" 
                    :key="item.id" 
                    class="item-row"
                    @click="goToProductDetail(item.goodsId)"
                  >
                    <img :src="item.goodsCover" :alt="item.goodsName" class="item-image" />
                    <div class="item-info">
                      <p><strong>{{ $t('productName') }}：</strong>{{ item.goodsName }}</p>
                      <p><strong>{{ $t('unitPrice') }}：</strong>¥{{ item.price.toFixed(2) }}</p>
                      <p><strong>{{ $t('quantity') }}：</strong>{{ item.amount }} 件</p>
                      <p><strong>{{ $t('subtotal') }}：</strong>¥{{ (item.price * item.amount).toFixed(2) }}</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

  </div>

</template>

<script setup>
import { onMounted, ref, watch } from 'vue'
import axios from 'axios'
import { useUserStore } from '@/stores/user'
import { useRoute } from 'vue-router'
import router from '@/router'

const route = useRoute()
const userStore = useUserStore()
const userId = userStore.id

const loading = ref(true)
const orders = ref([])
const error = ref(null)
const searchKeyword = ref('')

// 分页相关
const pageNum = ref(1)
const pageSize = ref(5)
const total = ref(0)
const pages = ref(0)

// 订单详情相关
const showDetail = ref(false)
const detailLoading = ref(false)
const detailError = ref(null)
const detailData = ref({
  order: {},
  items: []
})

// 支付方式映射
const payTypeText = (type) => {
  const map = { 0: '微信', 1: '支付宝', 2: '银行卡' }
  return map[type] || '未知'
}

// 订单状态映射
const statusText = (status) => {
  const map = { 
    0: '已付款', 
    1: '已发货', 
    2: '已完成',
    3: '已送达',
    5: '已取消'
  }
  return map[status] || '未知'
}

// 获取订单数据（支持模糊搜索和分页）
const getOrders = async (keyword = '') => {
  if (!userId) {
    loading.value = false
    error.value = '请先登录'
    return
  }

  try {
    const params = { 
      userId: Number(userId),
      pageNum: pageNum.value,
      pageSize: pageSize.value
    }
    if (keyword) {
      params.keyword = keyword
    }
    const res = await axios.get('/api/orderByUserId', {
      params
    })
    const pageData = res.data.data
    orders.value = pageData.list || []
    total.value = pageData.total || 0
    pages.value = pageData.pages || 0
    error.value = null
  } catch (err) {
    console.error('获取订单失败:', err)
    error.value = '加载订单失败，请稍后重试'
  } finally {
    loading.value = false
  }
}

// 切换页码
const changePage = (newPage) => {
  if (newPage < 1 || newPage > pages.value) return
  pageNum.value = newPage
  getOrders(searchKeyword.value)
}

// 搜索处理
const handleSearch = () => {
  pageNum.value = 1
  getOrders(searchKeyword.value)
}

// 清除搜索
const clearSearch = () => {
  searchKeyword.value = ''
  pageNum.value = 1
  getOrders()
}

// 取消订单（仅允许取消待接单和待取货状态的订单）
const cancelOrder = async (orderId) => {
  if (!window.confirm(`确定要取消订单 "${orderId}" 吗？`)) return

  try {
    const res = await axios.put(`/api/order/cancel?orderId=${orderId}`)

    if (res.data.code === 200) {
      alert('订单取消成功！')
      await getOrders(searchKeyword.value)
    } else {
      alert('取消失败：' + (res.data.message || res.data.msg))
    }
  } catch (error) {
    console.error('取消订单失败:', error)
    alert('取消失败，请重试')
  }
}

onMounted(() => {
  const page = route.query.page
  if (page) {
    pageNum.value = parseInt(page) || 1
  }
  getOrders()
  
  const orderId = route.query.orderId
  if (orderId) {
    setTimeout(() => {
      showOrderDetail(orderId)
    }, 500)
  }
})

watch(() => route.query.page, (newPage) => {
  if (newPage) {
    pageNum.value = parseInt(newPage) || 1
    getOrders()
  }
})

watch(() => route.query.orderId, (newOrderId) => {
  if (newOrderId) {
    showOrderDetail(newOrderId)
  }
})

// 显示订单详情
const showOrderDetail = async (orderId) => {
  showDetail.value = true
  detailLoading.value = true
  detailError.value = null

  try {
    const res = await axios.get('/api/orderDetail', {
      params: { orderId }
    })
    
    if (res.data.code === 200) {
      detailData.value = res.data.data
    } else {
      detailError.value = res.data.message || '获取订单详情失败'
    }
  } catch (error) {
    console.error('获取订单详情失败:', error)
    detailError.value = '获取订单详情失败，请稍后重试'
  } finally {
    detailLoading.value = false
  }
}

// 关闭订单详情弹窗
const closeDetail = () => {
  showDetail.value = false
  detailError.value = null
}

// 跳转到商品详情页
const goToProductDetail = (goodsId) => {
  const currentOrderId = detailData.value.order.orderId
  closeDetail()
  router.push({ 
    path: '/product-detail', 
    query: { id: goodsId, from: 'orders', page: pageNum.value, orderId: currentOrderId } 
  })
}
</script>

<style scoped>

.box{
  width: 75%;
  margin: auto;
  font-size: 25px;
}

h1 {
  margin-bottom: 20px;
  color: #333;
}

.search-container {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
  align-items: center;
}

.search-input {
  flex: 1;
  padding: 10px 15px;
  font-size: 18px;
  border: 1px solid #ddd;
  border-radius: 6px;
  outline: none;
  transition: border-color 0.3s;
}

.search-input:focus {
  border-color: #4CAF50;
}

.search-btn {
  padding: 10px 20px;
  font-size: 18px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.search-btn:hover {
  background-color: #45a049;
}

.clear-btn {
  padding: 10px 15px;
  font-size: 18px;
  background-color: #f0f0f0;
  color: #666;
  border: 1px solid #ddd;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.clear-btn:hover {
  background-color: #e0e0e0;
}

.error {
  color: #d32f2f;
  font-weight: bold;
}

.order-list {
  margin-top: 16px;
}

.order-item {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 16px;
  margin-bottom: 16px;
  background-color: #fafafa;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}

.order-item p {
  margin: 6px 0;
  font-size: 20px;
  color: #444;
}

.order-item strong {
  color: #222;
}

.status-tag {
  padding: 4px 10px;
  border-radius: 4px;
  font-size: 14px;
  font-weight: bold;
}

.status-0 {
  background-color: #fff3cd;
  color: #856404;
}

.status-1 {
  background-color: #d1ecf1;
  color: #0c5460;
}

.status-2 {
  background-color: #d4edda;
  color: #155724;
}

.status-3 {
  background-color: #e3f2fd;
  color: #1565c0;
}

.status-4 {
  background-color: #e8f5e9;
  color: #2e7d32;
}

.status-5 {
  background-color: #ffebee;
  color: #c62828;
}

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
  font-size: 18px;
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
  font-size: 18px;
  color: #666;
}

.cancel-btn {
  padding: 8px 16px;
  font-size: 18px;
  background-color: #f44336;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
  margin-right: 10px;
}

.cancel-btn:hover {
  background-color: #d32f2f;
}

.detail-btn {
  padding: 8px 16px;
  font-size: 18px;
  background-color: #2196F3;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.detail-btn:hover {
  background-color: #1976D2;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.modal-content {
  background-color: white;
  border-radius: 12px;
  width: 90%;
  max-width: 800px;
  max-height: 80vh;
  overflow: hidden;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
  border-bottom: 1px solid #eee;
  background-color: #fafafa;
}

.modal-header h2 {
  margin: 0;
  font-size: 24px;
  color: #333;
}

.close-btn {
  width: 36px;
  height: 36px;
  font-size: 24px;
  line-height: 32px;
  text-align: center;
  background: none;
  border: none;
  color: #666;
  cursor: pointer;
  border-radius: 50%;
  transition: background-color 0.2s;
}

.close-btn:hover {
  background-color: #eee;
  color: #333;
}

.modal-body {
  padding: 24px;
  max-height: calc(80vh - 80px);
  overflow-y: auto;
}

.detail-error {
  color: #d32f2f;
  font-weight: bold;
  text-align: center;
}

.order-info {
  margin-bottom: 24px;
  padding: 16px;
  background-color: #fafafa;
  border-radius: 8px;
}

.order-info h3 {
  margin: 0 0 16px 0;
  font-size: 20px;
  color: #333;
  border-bottom: 1px solid #eee;
  padding-bottom: 12px;
}

.order-info p {
  margin: 8px 0;
  font-size: 16px;
  color: #444;
}

.order-items {
  margin-top: 24px;
}

.order-items h3 {
  margin: 0 0 16px 0;
  font-size: 20px;
  color: #333;
  border-bottom: 1px solid #eee;
  padding-bottom: 12px;
}

.items-list {
  max-height: 300px;
  overflow-y: auto;
}

.item-row {
  display: flex;
  gap: 16px;
  padding: 16px;
  border-bottom: 1px solid #eee;
  align-items: center;
  cursor: pointer;
  transition: background-color 0.2s;
}

.item-row:hover {
  background-color: #f5f5f5;
}

.item-row:last-child {
  border-bottom: none;
}

.item-image {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 8px;
  flex-shrink: 0;
}

.item-info {
  flex: 1;
}

.item-info p {
  margin: 6px 0;
  font-size: 16px;
  color: #444;
}

.order-item {
  cursor: default;
}

.order-item:hover {
  background-color: #f5f5f5;
}

</style>
