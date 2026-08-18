<template>
  <div class="log-management-container">
    <div class="log-management-card">
      <div class="header">
        <h2 class="page-title">操作日志</h2>
        <div class="header-actions">
          <div class="search-box">
            <input
              v-model="searchForm.userName"
              type="text"
              placeholder="用户名"
              class="search-input"
            />
            <select v-model="searchForm.operation" class="search-select">
              <option value="">全部操作</option>
              <option value="LOGIN">登录</option>
              <option value="LOGOUT">退出</option>
              <option value="ADD">添加</option>
              <option value="UPDATE">更新</option>
              <option value="DELETE">删除</option>
            </select>
            <select v-model="searchForm.role" class="search-select">
              <option value="">全部角色</option>
              <option value="管理员">管理员</option>
              <option value="用户">用户</option>
              <option value="游客">游客</option>
            </select>
            <button @click="handleSearch" class="btn btn-search">搜索</button>
            <button @click="clearSearch" class="btn btn-clear">重置</button>
          </div>
        </div>
      </div>

      <div v-if="loading" class="loading">加载中...</div>

      <div v-else-if="logs.length === 0" class="empty-state">
        <p>暂无日志数据</p>
      </div>

      <div v-else class="table-wrapper">
        <table class="log-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>用户</th>
              <th>角色</th>
              <th>操作</th>
              <th>模块</th>
              <th>详情</th>
              <th>IP</th>
              <th>时间</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="log in logs" :key="log.id">
              <td>{{ log.id }}</td>
              <td>{{ log.userName }}</td>
              <td>
                <span class="role-badge" :class="getRoleClass(log.role)">
                  {{ log.role }}
                </span>
              </td>
              <td>
                <span class="operation-badge" :class="getOperationClass(log.operation)">
                  {{ getOperationText(log.operation) }}
                </span>
              </td>
              <td>{{ log.module }}</td>
              <td>{{ log.detail }}</td>
              <td>{{ log.ip || '-' }}</td>
              <td>{{ formatTime(log.createTime) }}</td>
            </tr>
          </tbody>
        </table>
      </div>

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
import { ref, computed, onMounted } from 'vue'
import axios from 'axios'

const logs = ref([])
const loading = ref(false)
const searchForm = ref({
  userName: '',
  operation: '',
  role: ''
})

const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const totalPages = computed(() => {
  return Math.ceil(total.value / pageSize.value) || 1
})

const getRoleClass = (role) => {
  const classes = {
    '管理员': 'role-admin',
    '用户': 'role-user',
    '游客': 'role-guest'
  }
  return classes[role] || ''
}

const getOperationClass = (operation) => {
  const classes = {
    'LOGIN': 'op-login',
    'LOGOUT': 'op-logout',
    'ADD': 'op-add',
    'UPDATE': 'op-update',
    'DELETE': 'op-delete',
    'CLEAN': 'op-clean'
  }
  return classes[operation] || ''
}

const getOperationText = (operation) => {
  const texts = {
    'LOGIN': '登录',
    'LOGOUT': '退出',
    'ADD': '添加',
    'UPDATE': '更新',
    'DELETE': '删除',
    'CLEAN': '清理'
  }
  return texts[operation] || operation
}

const formatTime = (timeStr) => {
  if (!timeStr) return ''
  const date = new Date(timeStr)
  return date.toLocaleString('zh-CN')
}

const handleSearch = () => {
  currentPage.value = 1
  fetchLogs()
}

const clearSearch = () => {
  searchForm.value = { userName: '', operation: '', role: '' }
  currentPage.value = 1
  fetchLogs()
}

const fetchLogs = async () => {
  loading.value = true
  try {
    const res = await axios.get('/api/logs', {
      params: {
        pageNum: currentPage.value,
        pageSize: pageSize.value,
        userName: searchForm.value.userName || undefined,
        operation: searchForm.value.operation || undefined,
        role: searchForm.value.role || undefined
      }
    })
    logs.value = res.data.data.list || []
    total.value = res.data.data.total || 0
  } catch (error) {
    console.error('获取日志失败:', error)
    logs.value = []
    total.value = 0
  } finally {
    loading.value = false
  }
}

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
    fetchLogs()
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
    fetchLogs()
  }
}

onMounted(() => {
  fetchLogs()
})
</script>

<style scoped>
.log-management-container {
  padding: 24px;
  background-color: #f8f9fa;
  min-height: 100vh;
}

.log-management-card {
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
}

.search-box {
  display: flex;
  gap: 8px;
  align-items: center;
}

.search-input {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  width: 150px;
}

.search-select {
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  min-width: 120px;
}

.btn {
  padding: 8px 16px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-search {
  background-color: #3498db;
  color: white;
}

.btn-search:hover {
  background-color: #2980b9;
}

.btn-clear {
  background-color: #f0f0f0;
  color: #666;
  border: 1px solid #ddd;
}

.btn-clear:hover {
  background-color: #e0e0e0;
}

.loading, .empty-state {
  text-align: center;
  padding: 40px;
  color: #666;
}

.table-wrapper {
  padding: 32px;
  overflow-x: auto;
}

.log-table {
  width: 100%;
  border-collapse: collapse;
}

.log-table th, .log-table td {
  padding: 12px 10px;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
}

.log-table th {
  font-weight: 600;
  color: #555;
}

.log-table tbody tr:hover {
  background-color: #f9f9f9;
}

.role-badge, .operation-badge {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
}

.role-admin { background: #d1ecf1; color: #0c5460; }
.role-user { background: #d4edda; color: #155724; }
.role-guest { background: #fff3cd; color: #856404; }

.op-login { background: #d4edda; color: #155724; }
.op-logout { background: #fff3cd; color: #856404; }
.op-add { background: #d1ecf1; color: #0c5460; }
.op-update { background: #e3f2fd; color: #1565c0; }
.op-delete { background: #f8d7da; color: #721c24; }
.op-clean { background: #e2e3e5; color: #495057; }

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