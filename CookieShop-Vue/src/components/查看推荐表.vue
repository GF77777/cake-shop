<template>
  <div class="recommend-list-container">
    <div class="recommend-list-card">
      <div class="header">
        <h2 class="page-title">{{ $t('recommendList') }}</h2>
        <div class="header-actions">
          <div class="search-box">
            <input
              v-model="searchKeyword"
              type="text"
              :placeholder="$t('recommendSearchPlaceholder')"
              class="search-input"
              @keyup.enter="handleSearch"
            />
            <button @click="handleSearch" class="btn btn-search">{{ $t('searchBtn') }}</button>
            <button v-if="searchKeyword" @click="clearSearch" class="btn btn-clear">{{ $t('clear') }}</button>
          </div>
          <router-link to="/admin/products" class="btn btn-secondary">← {{ $t('backToProducts') }}</router-link>
        </div>
      </div>

      <!-- 加载中 -->
      <div v-if="loading" class="loading">{{ $t('loading') }}</div>

      <!-- 无数据 -->
      <div v-else-if="allGoods.length === 0" class="empty-state">
        <p>{{ $t('noRecommendData') }}</p>
      </div>

      <!-- 推荐列表 -->
      <div v-else class="table-wrapper">
        <table class="recommend-table">
          <thead>
            <tr>
              <th>{{ $t('recommendId') }}</th>
              <th>{{ $t('goodsId') }}</th>
              <th>{{ $t('recommendType') }}</th>
              <th>{{ $t('goodsName') }}</th>
              <th>{{ $t('action') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in displayGoodsList" :key="item.id">
              <td>{{ item.id }}</td>
              <td>{{ item.goodId }}</td>
              <td>
                <span
                  class="type-badge"
                  :class="getTypeClass(item.type)"
                >
                  {{ getTypeText(item.type) }}
                </span>
              </td>
              <td>{{ item.goodsName || '—' }}</td>
              <td>
                <button @click="deleteRecommend(item.id)" class="btn btn-small btn-delete">
                  {{ $t('delete') }}
                </button>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- 分页组件 -->
      <div class="pagination-wrapper">
        <div class="pagination-info">
          共 {{ total }} 条记录，每页 {{ pageSize }} 条
        </div>
        <div class="pagination">
          <button
            @click="prevPage"
            :disabled="currentPage === 1"
            class="pagination-btn"
          >
            上一页
          </button>
          <span class="pagination-current">第 {{ currentPage }} / {{ totalPages }} 页</span>
          <button
            @click="nextPage"
            :disabled="currentPage >= totalPages"
            class="pagination-btn"
          >
            下一页
          </button>
        </div>
      </div>
    </div>
  </div>
</template>



<script setup>
import { onMounted, ref, computed } from 'vue'
import axios from 'axios'
import { useRouter } from 'vue-router'

const router = useRouter()
const goodsList = ref([])
const allGoods = ref([])
const loading = ref(true)
const searchKeyword = ref('')

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 总页数
const totalPages = computed(() => {
  return Math.ceil(total.value / pageSize.value) || 1
})

// 当前页显示的推荐列表（支持模糊搜索）
const displayGoodsList = computed(() => {
  // 先过滤搜索结果
  let filtered = allGoods.value
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.toLowerCase().trim()
    filtered = allGoods.value.filter(item => {
      const idMatch = String(item.id).includes(keyword)
      const goodIdMatch = String(item.goodId).includes(keyword)
      const typeMatch = getTypeText(item.type).toLowerCase().includes(keyword)
      const goodsNameMatch = (item.goodsName || '').toLowerCase().includes(keyword)
      return idMatch || goodIdMatch || typeMatch || goodsNameMatch
    })
  }
  
  // 更新总数
  total.value = filtered.length
  
  // 再进行分页
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filtered.slice(start, end)
})

// 搜索处理
const handleSearch = () => {
  currentPage.value = 1 // 搜索时重置到第一页
}

// 清除搜索
const clearSearch = () => {
  searchKeyword.value = ''
  currentPage.value = 1
}

// 类型文本映射
const getTypeText = (type) => {
  if (type === null || type === undefined || type === '') {
    return '未设置'
  }
  // 处理布尔类型（数据库BIT类型映射）
  if (typeof type === 'boolean') {
    return type ? '热销' : '横条'
  }
  const map = { 0: '横条', 1: '热销', 2: '新品', '0': '横条', '1': '热销', '2': '新品' }
  return map[type] || '未知'
}

// 类型对应的 CSS 类名
const getTypeClass = (type) => {
  if (type === null || type === undefined || type === '') return 'badge-unknown'
  // 处理布尔类型（数据库BIT类型映射）
  if (typeof type === 'boolean') {
    return type ? 'badge-hot' : 'badge-horizontal'
  }
  if (type === 0 || type === '0') return 'badge-horizontal'
  if (type === 1 || type === '1') return 'badge-hot'
  if (type === 2 || type === '2') return 'badge-new'
  return 'badge-unknown'
}

const fetchData = async () => {
  try {
    console.log('=== 推荐列表数据 ===')
    const res = await axios.get('/api/recommendList')
    console.log('响应数据:', res.data)
    
    // 兼容不同的响应结构
    const data = res.data.data || []
    if (Array.isArray(data)) {
      allGoods.value = data
      total.value = data.length
    } else {
      allGoods.value = data.list || []
      total.value = data.total || 0
    }
    
    console.log('推荐列表数据:', allGoods.value)
    console.log('推荐总数:', total.value)
    
    // 重置到第一页
    currentPage.value = 1
    
  } catch (error) {
    console.error('获取推荐列表失败:', error)
    alert('加载推荐列表失败，请检查网络')
  } finally {
    loading.value = false
  }
}

// 上一页
const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

// 下一页
const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

const deleteRecommend = async (id) => {
  if (!window.confirm(`确定要从推荐表中移除该商品吗？`)) return

  try {
    const res = await axios.delete(`/api/deleteRecommend?id=${id}`)
    if (res.data.code === 200) {
      alert('删除成功！')
      fetchData()
    } else {
      alert('删除失败：' + (res.data.message || '未知错误'))
    }
  } catch (error) {
    console.error('请求失败:', error)
    alert('网络异常')
  }
}

onMounted(() => {
  fetchData()
})
</script>


<style scoped>
.recommend-list-container {
  padding: 24px;
  background-color: #f8f9fa;
  min-height: 100vh;
  display: flex;
  justify-content: center;
}

.recommend-list-card {
  max-width: 900px;
  width: 100%;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  overflow: hidden;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px 32px;
  border-bottom: 1px solid #eee;
  flex-wrap: wrap;
  gap: 16px;
}

.page-title {
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-box {
  display: flex;
  gap: 8px;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  width: 250px;
}

.search-input:focus {
  outline: none;
  border-color: #3498db;
}

.btn-search {
  background-color: #3498db;
  color: white;
  padding: 8px 16px;
}

.btn-search:hover {
  background-color: #2980b9;
}

.btn-clear {
  background-color: #f0f0f0;
  color: #666;
  padding: 8px 12px;
  border: 1px solid #ddd;
}

.btn-clear:hover {
  background-color: #e0e0e0;
}

.loading,
.empty-state {
  text-align: center;
  padding: 40px;
  color: #666;
  font-size: 16px;
}

.table-wrapper {
  padding: 0 32px 32px;
  overflow-x: auto;
}

.recommend-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 16px;
  font-size: 14px;
}

.recommend-table th,
.recommend-table td {
  padding: 12px 10px;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
  vertical-align: middle;
}

.recommend-table th {
  font-weight: 600;
  color: #555;
  font-size: 13px;
}

.recommend-table tbody tr:hover {
  background-color: #f9f9f9;
}

/* 斑马纹 */
.recommend-table tbody tr:nth-child(even) {
  background-color: #fafafa;
}
.recommend-table tbody tr:nth-child(even):hover {
  background-color: #f0f8ff;
}

/* 类型标签 */
.type-badge {
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 600;
  color: white;
}

.badge-horizontal {
  background-color: #3498db; /* 蓝色 - 横条 */
}
.badge-hot {
  background-color: #e74c3c; /* 红色 - 热销 */
}
.badge-new {
  background-color: #2ecc71; /* 绿色 - 新品 */
}
.badge-unknown {
  background-color: #95a5a6; /* 灰色 - 未知 */
}

/* 按钮 */
.btn {
  padding: 6px 12px;
  border: none;
  border-radius: 6px;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
}

.btn-secondary {
  background-color: #e9ecef;
  color: #495057;
}
.btn-secondary:hover {
  background-color: #dfe3e6;
}

.btn-small {
  padding: 5px 10px;
  font-size: 12px;
}

.btn-delete {
  background-color: #e74c3c;
  color: white;
}
.btn-delete:hover {
  background-color: #c0392b;
}

/* 分页样式 */
.pagination-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 32px;
  border-top: 1px solid #eee;
  background-color: #fafafa;
}

.pagination-info {
  font-size: 14px;
  color: #666;
}

.pagination {
  display: flex;
  align-items: center;
  gap: 12px;
}

.pagination-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background-color: white;
  color: #333;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.pagination-btn:hover:not(:disabled) {
  background-color: #f0f0f0;
  border-color: #ccc;
}

.pagination-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pagination-current {
  font-size: 14px;
  color: #666;
  min-width: 100px;
  text-align: center;
}

</style>