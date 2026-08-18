<template>
  <div class="goods-management-container">
    <div class="goods-management-card">
      <div class="header">
        <h2 class="page-title">{{ $t('productManagement') }}</h2>
        <div class="header-actions">
          <div class="search-box">
            <select v-model="selectedTypeId" class="category-select">
              <option value="">{{ $t('allCategories') }}</option>
              <option v-for="type in goodsTypes" :key="type.id" :value="type.id">
                {{ type.name }}
              </option>
            </select>
            <input
              v-model="searchKeyword"
              type="text"
              :placeholder="$t('goodsSearchPlaceholder')"
              class="search-input"
              @keyup.enter="handleSearch"
            />
            <button @click="handleSearch" class="btn btn-search">{{ $t('searchBtn') }}</button>
          </div>
          <router-link to="/admin/product-add" class="btn btn-primary">+ {{ $t('addNewProduct') }}</router-link>
          <router-link to="/admin/recommend" class="btn btn-secondary">{{ $t('viewRecommend') }}</router-link>
        </div>
      </div>

      <!-- 加载中 -->
      <div v-if="loading" class="loading">{{ $t('loading') }}</div>

      <!-- 无数据 -->
      <div v-else-if="allGoods.length === 0" class="empty-state">
        <p>{{ $t('noProductData') }}</p>
      </div>

      <!-- 商品列表 -->
      <div v-else class="table-wrapper">
        <table class="goods-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>{{ $t('goodsName') }}</th>
              <th>{{ $t('coverImage') }}</th>
              <th>{{ $t('detailImage1') }}</th>
              <th>{{ $t('detailImage2') }}</th>
              <th>{{ $t('goodsPrice') }}</th>
              <th>{{ $t('description') }}</th>
              <th>{{ $t('stock') }}</th>
              <th>{{ $t('typeId') }}</th>
              <th>{{ $t('action') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="goods in displayGoodsList" :key="goods.id">
              <td>{{ goods.id }}</td>
              <td>
                <router-link 
                  :to="{ path: '/product-detail', query: { id: goods.id, from: 'admin-products', page: currentPage } }" 
                  class="goods-name-link"
                >
                  {{ goods.name }}
                </router-link>
              </td>
              <td><img :src="goods.cover" alt="封面" class="thumb" @click="openImage(goods.cover)" /></td>
              <td><img :src="goods.image1" alt="图1" class="thumb" @click="openImage(goods.image1)" /></td>
              <td><img :src="goods.image2" alt="图2" class="thumb" @click="openImage(goods.image2)" /></td>
              <td>¥{{ goods.price.toFixed(2) }}</td>
              <td class="desc-cell">{{ goods.intro || '—' }}</td>
              <td>{{ goods.stock }}</td>
              <td>{{ goods.typeId }}</td>
              <td class="action-cell">
                <router-link
                  :to="`/admin/product-edit/${goods.id}`"
                  class="btn btn-small btn-edit"
                >
                  {{ $t('edit') }}
                </router-link>
                <button @click="deleteGoods(goods.id)" class="btn btn-small btn-delete">
                  {{ $t('delete') }}
                </button>
                <router-link
                  :to="`/admin/recommend-add/${goods.id}`"
                  class="btn btn-small btn-recommend"
                >
                  {{ $t('recommend') }}
                </router-link>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- 分页组件 -->
      <div class="pagination-wrapper">
        <div class="pagination-info">
          {{ $t('totalRecords') }} {{ total }} {{ $t('recordsPerPage') }} {{ pageSize }}
        </div>
        <div class="pagination">
          <button
            @click="prevPage"
            :disabled="currentPage === 1"
            class="pagination-btn"
          >
            {{ $t('prevPage') }}
          </button>
          <span class="pagination-current">{{ $t('pageInfoAdmin', { current: currentPage, total: totalPages }) }}</span>
          <button
            @click="nextPage"
            :disabled="currentPage >= totalPages"
            class="pagination-btn"
          >
            {{ $t('nextPage') }}
          </button>
        </div>
      </div>
    </div>

    <!-- 图片预览遮罩 -->
    <div v-if="previewImage" class="image-preview" @click="previewImage = ''">
      <img :src="previewImage" alt="预览" />
    </div>
  </div>
</template>



<script setup>
import { onMounted, ref, computed, watch } from 'vue'
import axios from 'axios'

import { useRouter, useRoute } from 'vue-router'
const router = useRouter()
const route = useRoute()

const goodsList = ref([])
const allGoods = ref([])
const loading = ref(false)
const previewImage = ref('')
const searchKeyword = ref('')
const selectedTypeId = ref('')
const goodsTypes = ref([])

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 总页数
const totalPages = computed(() => {
  return Math.ceil(total.value / pageSize.value) || 1
})

// 当前页显示的商品列表（支持搜索和分类筛选）
const displayGoodsList = computed(() => {
  // 先按分类筛选
  let filtered = allGoods.value
  if (selectedTypeId.value && selectedTypeId.value !== '') {
    const typeIdNum = parseInt(selectedTypeId.value)
    filtered = filtered.filter(item => {
      const itemTypeId = typeof item.typeId === 'number' ? item.typeId : parseInt(item.typeId)
      return itemTypeId === typeIdNum
    })
  }
  
  // 再过滤搜索结果
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.toLowerCase().trim()
    filtered = filtered.filter(item => {
      const idMatch = String(item.id).includes(keyword)
      const nameMatch = (item.name || '').toLowerCase().includes(keyword)
      const descMatch = (item.intro || '').toLowerCase().includes(keyword)
      return idMatch || nameMatch || descMatch
    })
  }
  
  // 再进行分页
  total.value = filtered.length
  
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filtered.slice(start, end)
})

// 搜索处理
const handleSearch = () => {
  currentPage.value = 1 // 搜索时重置到第一页
}

const openImage = (src) => {
    previewImage.value = src
}

// 获取商品类型列表
const loadGoodsTypes = async () => {
  try {
    const res = await axios.get('/api/types')
    if (res.data.code === 200) {
      goodsTypes.value = res.data.data
    }
  } catch (error) {
    console.error('获取商品类型失败:', error)
  }
}

const fetchData = async () => {
    loading.value = true
    try{
        const res = await axios.get('/api/goods')
        // 控制台输出返回信息
        console.log('=== 商品分页数据 ===')
        console.log('响应数据:', res.data)
        console.log('商品总数:', res.data.data?.length)
        
        // 后端返回的是完整数组，前端做分页
        allGoods.value = res.data.data || []
        total.value = allGoods.value.length
        
    }catch(error){
         console.error('获取商品失败:', error)
    } finally {
        loading.value = false
    }
}
onMounted(() => {
  // 从 query 参数恢复页码
  const page = route.query.page
  if (page) {
    currentPage.value = parseInt(page) || 1
  }
  fetchData()
  loadGoodsTypes()
})

// 监听路由参数变化
watch(() => route.query.page, (newPage) => {
  if (newPage) {
    currentPage.value = parseInt(newPage) || 1
  }
})

// 监听分类变化，重置页码
watch(selectedTypeId, () => {
  currentPage.value = 1
})

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

// 删除商品
const deleteGoods= async (id) => {
  if (!window.confirm(`确定要删除商品 "${id}" 吗？`)) return

  try {
    const res = await axios.delete(`/api/goods?id=${id}`)

    if (res.data.code === 200) {
      alert('删除成功！')
      fetchData(currentPage.value)
    } else {
      alert('删除失败：' + res.data.message)
    }
  } catch (error) {
    console.error('请求失败:', error)
    
  }
}
</script>


<style scoped>
.goods-management-container {
  padding: 24px;
  background-color: #f8f9fa;
  min-height: 100vh;
  display: flex;
  justify-content: center;
}

.goods-management-card {
  max-width: 1400px;
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

.category-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  min-width: 120px;
  cursor: pointer;
  background-color: white;
}

.category-select:focus {
  outline: none;
  border-color: #3498db;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  width: 200px;
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

.goods-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 16px;
  font-size: 13px;
}

.goods-table th,
.goods-table td {
  padding: 12px 10px;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
  vertical-align: middle;
}

.goods-table th {
  font-weight: 600;
  color: #555;
  font-size: 12px;
}

.goods-table tbody tr:hover {
  background-color: #f9f9f9;
}

/* 斑马纹 */
.goods-table tbody tr:nth-child(even) {
  background-color: #fafafa;
}
.goods-table tbody tr:nth-child(even):hover {
  background-color: #f0f8ff;
}

/* 图片缩略图 */
.thumb {
  width: 40px;
  height: 40px;
  object-fit: cover;
  border-radius: 4px;
  cursor: zoom-in;
  border: 1px solid #ddd;
}

/* 描述列限制高度 */
.desc-cell {
  max-width: 150px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* 商品名称链接 */
.goods-name-link {
  color: #3498db;
  text-decoration: none;
  cursor: pointer;
}

.goods-name-link:hover {
  text-decoration: underline;
  color: #2980b9;
}

/* 操作按钮 */
.action-cell {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.btn {
  padding: 6px 10px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
  cursor: pointer;
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
  white-space: nowrap;
}

.btn-small {
  padding: 5px 8px;
  font-size: 12px;
}

.btn-primary {
  background-color: #2ecc71;
  color: white;
}
.btn-primary:hover {
  background-color: #27ae60;
}

.btn-secondary {
  background-color: #3498db;
  color: white;
}
.btn-secondary:hover {
  background-color: #2980b9;
}

.btn-edit {
  background-color: #3498db;
  color: white;
}
.btn-edit:hover {
  background-color: #2980b9;
}

.btn-delete {
  background-color: #e74c3c;
  color: white;
}
.btn-delete:hover {
  background-color: #c0392b;
}

.btn-recommend {
  background-color: #9b59b6;
  color: white;
}
.btn-recommend:hover {
  background-color: #8e44ad;
}

/* 图片预览弹窗 */
.image-preview {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.9);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
  cursor: zoom-out;
}

.image-preview img {
  max-width: 90vw;
  max-height: 90vh;
  object-fit: contain;
  border: 2px solid white;
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