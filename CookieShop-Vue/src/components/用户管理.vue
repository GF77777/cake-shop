<template>
  <div class="user-management-container">
    <div class="user-management-card">
      <div class="header">
        <h2 class="page-title">{{ $t('userManagement') }}</h2>
        <div class="header-actions">
          <div class="search-box">
            <input
              v-model="searchKeyword"
              type="text"
              :placeholder="$t('userSearchPlaceholder')"
              class="search-input"
              @keyup.enter="handleSearch"
            />
            <button @click="handleSearch" class="btn btn-search">{{ $t('searchBtn') }}</button>
            <button v-if="searchKeyword" @click="clearSearch" class="btn btn-clear">{{ $t('clear') }}</button>
          </div>
          <router-link to="/admin/user-add" class="btn btn-primary">+ {{ $t('addNewUser') }}</router-link>
        </div>
      </div>

      <!-- 加载中 -->
      <div v-if="loading" class="loading">{{ $t('loading') }}</div>

      <!-- 无数据 -->
      <div v-else-if="allUsers.length === 0" class="empty-state">
        <p>{{ $t('noUserData') }}</p>
      </div>

      <!-- 用户列表 -->
      <div v-else class="table-wrapper">
        <table class="user-table">
          <thead>
            <tr>
              <th>{{ $t('userId') }}</th>
              <th>{{ $t('userName') }}</th>
              <th>{{ $t('name') }}</th>
              <th>{{ $t('email') }}</th>
              <th>{{ $t('phone') }}</th>
              <th>{{ $t('address') }}</th>
              <th>{{ $t('admin') }}</th>
              <th>{{ $t('accountStatus') }}</th>
              <th>{{ $t('action') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="user in displayUsersList" :key="user.id">
              <td>{{ user.id }}</td>
              <td>{{ user.userName }}</td>
              <td>{{ user.name }}</td>
              <td>{{ user.email }}</td>
              <td>{{ user.phone }}</td>
              <td>{{ user.address || '—' }}</td>
              <td>
                <span
                  class="status-badge"
                  :class="{ admin: user.isAdmin }"
                >
                  {{ user.isAdmin ? $t('yes') : $t('no') }}
                </span>
              </td>
              <td>
                <span
                  class="status-badge"
                  :class="{ valid: user.isValidate, invalid: !user.isValidate }"
                >
                  {{ user.isValidate ? $t('invalid') : $t('valid') }}
                </span>
              </td>
              <td class="actions">
                <router-link
                  :to="`/admin/user-reset/${user.id}`"
                  class="btn btn-small btn-warning"
                >
                  {{ $t('resetPassword') }}
                </router-link>
                <button @click="deleteUser(user.id)" class="btn btn-small btn-danger">
                  {{ $t('delete') }}
                </button>
                <router-link
                  :to="`/admin/user-edit/${user.id}`"
                  class="btn btn-small btn-primary"
                >
                  编辑
                </router-link>
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

const usersList = ref([])
const allUsers = ref([])
const loading = ref(false)
const searchKeyword = ref('')

// 分页相关
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

// 总页数
const totalPages = computed(() => {
  return Math.ceil(total.value / pageSize.value) || 1
})

// 当前页显示的用户列表（支持模糊搜索）
const displayUsersList = computed(() => {
  // 先过滤搜索结果
  let filtered = allUsers.value
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.toLowerCase().trim()
    filtered = allUsers.value.filter(user => {
      const idMatch = String(user.id).includes(keyword)
      const userNameMatch = (user.userName || '').toLowerCase().includes(keyword)
      const nameMatch = (user.name || '').toLowerCase().includes(keyword)
      const emailMatch = (user.email || '').toLowerCase().includes(keyword)
      const phoneMatch = String(user.phone).includes(keyword)
      const addressMatch = (user.address || '').toLowerCase().includes(keyword)
      return idMatch || userNameMatch || nameMatch || emailMatch || phoneMatch || addressMatch
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

const fetchData = async () => {
    loading.value = true
    try{
        const res = await axios.get('/api/users')
        // 控制台输出返回信息
        console.log('=== 用户分页数据 ===')
        console.log('响应数据:', res.data)
        console.log('用户总数:', res.data.data?.length)
        
        // 兼容不同的响应结构：后端可能返回数组或分页对象
        const data = res.data.data || []
        if (Array.isArray(data)) {
          // 后端返回完整数组，前端做分页
          allUsers.value = data
          total.value = data.length
        } else {
          // 后端返回分页对象
          allUsers.value = data.list || []
          total.value = data.total || 0
        }
        
        // 重置到第一页
        currentPage.value = 1
    }catch(error){
         console.error('获取用户失败:', error)
    } finally {
        loading.value = false
    }
}
onMounted(() => {
  fetchData()
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

// 删除用户
const deleteUser = async (id) => {
  if (!window.confirm(`确定要删除用户 "${id}" 吗？`)) return

  try {
    const res = await axios.delete(`/api/login?id=${id}`)

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
.user-management-container {
  padding: 24px;
  background-color: #f8f9fa;
  min-height: 100vh;
  display: flex;
  justify-content: center;
}

.user-management-card {
  max-width: 1200px;
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
  font-size: 24px;
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

.user-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 16px;
}

.user-table th,
.user-table td {
  padding: 12px 10px;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
  white-space: nowrap;
}

.user-table th {
  font-weight: 600;
  color: #555;
  font-size: 13px;
}

.user-table tbody tr:hover {
  background-color: #f9f9f9;
}

/* 斑马纹 */
.user-table tbody tr:nth-child(even) {
  background-color: #fafafa;
}
.user-table tbody tr:nth-child(even):hover {
  background-color: #f0f8ff;
}

/* 状态标签 */
.status-badge {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

.admin {
  background-color: #d1ecf1;
  color: #0c5460;
}

.valid {
  background-color: #d4edda;
  color: #155724;
}

.invalid {
  background-color: #f8d7da;
  color: #721c24;
}

.actions {
  display: flex;
  gap: 8px;
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
  width: 100px;
  background-color: #3498db;
  color: white;
}
.btn-primary:hover {
  background-color: #2980b9;
}

.btn-warning {
  background-color: #f39c12;
  color: white;
}
.btn-warning:hover {
  background-color: #d68910;
}

.btn-danger {
  background-color: #e74c3c;
  color: white;
}
.btn-danger:hover {
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