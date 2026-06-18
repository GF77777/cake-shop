<template>
  <div class="category-list-container">
    <div class="category-list-card">
      <div class="header">
        <h1 class="page-title">{{ $t('categoryManagementTitle') }}</h1>
        <div class="header-right">
          <div class="search-box">
            <input
              v-model="searchKeyword"
              type="text"
              :placeholder="$t('categorySearchPlaceholder')"
              class="search-input"
              @keyup.enter="handleSearch"
            />
            <button @click="handleSearch" class="btn btn-search">{{ $t('searchBtn') }}</button>
          </div>
          <router-link to="/admin/category-add" class="btn btn-primary">+ {{ $t('addCategory') }}</router-link>
        </div>
      </div>

      <div class="table-wrapper">
        <table class="category-table">
          <thead>
            <tr>
              <th>{{ $t('categoryId') }}</th>
              <th>{{ $t('categoryName') }}</th>
              <th>{{ $t('action') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="type in displayTypesList" :key="type.id">
              <td>{{ type.id }}</td>
              <td>{{ type.name }}</td>
              <td class="action-cell">
                <router-link
                  :to="`/admin/category-edit/${type.id}`"
                  class="btn btn-small btn-edit"
                >
                  {{ $t('edit') }}
                </router-link>
                <button @click="deleteType(type.id)" class="btn btn-small btn-delete">
                  {{ $t('delete') }}
                </button>
              </td>
            </tr>
            <tr v-if="displayTypesList.length === 0">
              <td colspan="3" class="empty-text">{{ $t('noCategoryData') }}</td>
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
            :disabled="pageNum <= 1"
            class="pagination-btn"
          >
            {{ $t('prevPage') }}
          </button>
          <span class="pagination-current">{{ $t('pageInfoAdmin', { current: pageNum, total: pages }) }}</span>
          <button
            @click="nextPage"
            :disabled="pageNum >= pages"
            class="pagination-btn"
          >
            {{ $t('nextPage') }}
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

const typesList = ref([])
const allTypes = ref([])
const searchKeyword = ref('')

// 分页相关状态
const pageNum = ref(1)
const pageSize = ref(10)
const total = ref(0)
const pages = ref(0)

// 当前页显示的类目列表
const displayTypesList = computed(() => {
  // 先过滤搜索结果
  let filtered = allTypes.value
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.toLowerCase().trim()
    filtered = allTypes.value.filter(item => {
      const idMatch = String(item.id).includes(keyword)
      const nameMatch = (item.name || '').toLowerCase().includes(keyword)
      return idMatch || nameMatch
    })
  }
  
  // 再进行分页
  total.value = filtered.length
  pages.value = Math.ceil(total.value / pageSize.value) || 1
  
  const start = (pageNum.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filtered.slice(start, end)
})

const fetchData = async () => {
    try{
        const res = await axios.get('/api/types/page', {
          params: {
            pageNum: 1,
            pageSize: 1000 // 获取所有数据用于前端搜索
          }
        })
        
        if (res.data.code === 200) {
          const pageData = res.data.data
          allTypes.value = pageData.list || []
          // 初始化分页
          total.value = allTypes.value.length
          pages.value = Math.ceil(total.value / pageSize.value) || 1
        }
    }catch(error){
         console.error('获取分类失败:', error)
    }
}

// 搜索处理
const handleSearch = () => {
  pageNum.value = 1 // 搜索时重置到第一页
}

// 清除搜索
const clearSearch = () => {
  searchKeyword.value = ''
  pageNum.value = 1
}

// 上一页
const prevPage = () => {
  if (pageNum.value > 1) {
    pageNum.value--
    fetchData()
  }
}

// 下一页
const nextPage = () => {
  if (pageNum.value < pages.value) {
    pageNum.value++
    fetchData()
  }
}

onMounted(() => {
  fetchData()
})

// 删除类目
const deleteType = async (id) => {
  if (!window.confirm(`确定要删除类目 "${id}" 吗？`)) return

  try {
    const res = await axios.delete(`/api/types?id=${id}`)

    if (res.data.code === 200) {
      alert('删除成功！')
      // 如果当前页只剩一条数据，删除后跳转到上一页
      if (typesList.value.length === 1 && pageNum.value > 1) {
        pageNum.value--
      }
      fetchData()
    } else {
      alert('删除失败：' + res.data.message)
    }
  } catch (error) {
    console.error('请求失败:', error)
    
  }
}
</script>


<style scoped>
.category-list-container {
  padding: 24px;
  background-color: #f8f9fa;
  min-height: 100vh;
}

.category-list-card {
  max-width: 900px;
  margin: 0 auto;
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

.header-right {
  display: flex;
  align-items: center;
  gap: 16px;
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

.page-title {
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin: 0;
}

.btn {
  padding: 8px 16px;
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

.btn-primary {
  width: 100px;
  background-color: #3498db;
  color: white;
}
.btn-primary:hover {
  background-color: #2980b9;
}

/* 表格区域 */
.table-wrapper {
  padding: 0 32px 32px;
  overflow-x: auto;
}

.category-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 16px;
}

.category-table th,
.category-table td {
  padding: 14px 12px;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
}

.category-table th {
  font-weight: 600;
  color: #555;
  font-size: 15px;
}

.category-table tbody tr:hover {
  background-color: #f9f9f9;
}

/* 斑马纹（可选） */
.category-table tbody tr:nth-child(even) {
  background-color: #fafafa;
}
.category-table tbody tr:nth-child(even):hover {
  background-color: #f0f8ff;
}

.action-cell {
  display: flex;
  gap: 10px;
}

.btn-small {
  padding: 6px 12px;
  font-size: 13px;
}

.btn-edit {
  width: 100px;
  background-color: #2ecc71;
  color: white;
}
.btn-edit:hover {
  background-color: #27ae60;
}

.btn-delete {
  width: 100px;
  background-color: #e74c3c;
  color: white;
}
.btn-delete:hover {
  background-color: #c0392b;
}

.empty-text {
  text-align: center;
  color: #999;
  font-style: italic;
  padding: 24px;
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

/* 手机端适配 */
@media (max-width: 600px) {
  .header {
    flex-direction: column;
    gap: 16px;
    padding: 20px;
  }

  .category-table th,
  .category-table td {
    padding: 12px 8px;
    font-size: 14px;
  }

  .action-cell {
    flex-direction: column;
    gap: 8px;
  }

  .btn-small {
    width: 100%;
  }
}
</style>