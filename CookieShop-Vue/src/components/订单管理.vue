<template>
  <div class="order-list-container">
    <div class="order-list-card">
      <div class="header">
        <h1 class="page-title">{{ $t('orderManagementTitle') }}</h1>
        <div class="header-actions">
          <div class="search-box">
            <input
              v-model="searchKeyword"
              type="text"
              :placeholder="$t('orderSearchPlaceholderAdmin')"
              class="search-input"
              @keyup.enter="handleSearch"
            />
            <button @click="handleSearch" class="btn btn-search">{{ $t('searchBtn') }}</button>
            <button v-if="searchKeyword" @click="clearSearch" class="btn btn-clear">{{ $t('clear') }}</button>
          </div>
        </div>
      </div>

      <div class="table-wrapper">
        <table class="order-table">
          <thead>
            <tr>
              <th>{{ $t('orderId') }}</th>
              <th>{{ $t('total') }}</th>
              <th>配送费</th>
              <th>{{ $t('quantity') }}</th>
              <th>{{ $t('status') }}</th>
              <th>{{ $t('payType') }}</th>
              <th>{{ $t('receiver') }}</th>
              <th>{{ $t('phone') }}</th>
              <th>{{ $t('address') }}</th>
              <th>{{ $t('orderTime') }}</th>
              <th>{{ $t('userId') }}</th>
              <th>{{ $t('action') }}</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="order in displayOrdersList" :key="order.orderId">
              <td>{{ order.orderId }}</td>
              <td>¥{{ order.total }}</td>
              <td>¥{{ (order.deliveryFee || 0).toFixed(2) }}</td>
              <td>{{ order.amount }}</td>
              <td>
                <span :class="`status-badge status-${order.status}`">
                  {{ statusText(order.status) }}
                </span>
              </td>
              <td>{{ payTypeText(order.payType) }}</td>
              <td>{{ order.name }}</td>
              <td>{{ order.phone }}</td>
              <td>{{ order.address }}</td>
              <td>{{ order.dateTime }}</td>
              <td>{{ order.userId }}</td>
              <td class="action-cell">
                <router-link
                  :to="`/admin/order-edit/${order.orderId}`"
                  class="btn btn-small btn-edit"
                >
                  查看详情
                </router-link>
                <button
                  @click="openDeliveryFeeModal(order)"
                  class="btn btn-small btn-fee"
                >
                  设置佣金
                </button>
              </td>
            </tr>
            <tr v-if="orderList.length === 0">
              <td colspan="11" class="empty-text">{{ $t('noOrderData') }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- 修改佣金弹窗 -->
      <div v-if="showDeliveryFeeModal" class="modal-overlay" @click.self="closeDeliveryFeeModal">
        <div class="modal-content">
          <div class="modal-header">
            <h3>设置订单佣金</h3>
            <button @click="closeDeliveryFeeModal" class="modal-close">&times;</button>
          </div>
          <div class="modal-body">
            <div class="form-group">
              <label>订单号: {{ selectedOrder.orderId }}</label>
            </div>
            <div class="form-group">
              <label>当前佣金: ¥{{ (selectedOrder.deliveryFee || 0).toFixed(2) }}</label>
            </div>
            <div class="form-group">
              <label>新佣金 (元):</label>
              <input
                v-model.number="newDeliveryFee"
                type="number"
                min="0"
                step="0.01"
                class="fee-input"
                placeholder="请输入佣金"
              />
            </div>
          </div>
          <div class="modal-footer">
            <button @click="closeDeliveryFeeModal" class="btn btn-cancel">取消</button>
            <button @click="saveDeliveryFee" class="btn btn-save">保存</button>
          </div>
        </div>
      </div>

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
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from 'vue'
import axios from 'axios'
import { useI18n } from 'vue-i18n'

const { t } = useI18n()

const orderList = ref([])
const allOrders = ref([])
const searchKeyword = ref('')

const showDeliveryFeeModal = ref(false)
const selectedOrder = ref({})
const newDeliveryFee = ref(0)

const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

const totalPages = computed(() => {
  return Math.ceil(total.value / pageSize.value) || 1
})

const displayOrdersList = computed(() => {
  let filtered = allOrders.value
  if (searchKeyword.value.trim()) {
    const keyword = searchKeyword.value.toLowerCase().trim()
    filtered = allOrders.value.filter(order => {
      const orderIdMatch = String(order.orderId).includes(keyword)
      const nameMatch = (order.name || '').toLowerCase().includes(keyword)
      const phoneMatch = String(order.phone).includes(keyword)
      const addressMatch = (order.address || '').toLowerCase().includes(keyword)
      const userIdMatch = String(order.userId).includes(keyword)
      return orderIdMatch || nameMatch || phoneMatch || addressMatch || userIdMatch
    })
  }
  
  total.value = filtered.length
  
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filtered.slice(start, end)
})

const handleSearch = () => {
  currentPage.value = 1
}

const clearSearch = () => {
  searchKeyword.value = ''
  currentPage.value = 1
}

const payTypeText = (type) => {
  const map = { 0: t('wechatPay'), 1: t('alipay'), 2: t('bankCard') }
  return map[type] || t('unknown')
}

const statusText = (type) => {
  const map = { 
    0: '已付款', 
    1: '已发货', 
    2: '已完成',
    3: '已送达',
    5: '已取消'
  }
  return map[type] || '未知'
}

const fetchData = async () => {
    try{
        const res = await axios.get('/api/order', {
          params: {
            pageNum: 1,
            pageSize: 1000,
            sortBy: 'orderId',
            sortDir: 'desc'
          }
        })
        if (res.data && res.data.data && res.data.data.list) {
            allOrders.value = res.data.data.list
            total.value = res.data.data.total
            orderList.value = allOrders.value
        } else {
            allOrders.value = []
            total.value = 0
            orderList.value = []
        }
    }catch(error){
         console.error('获取订单失败:', error)
         allOrders.value = []
         total.value = 0
         orderList.value = []
    }
}

onMounted(() => {
  fetchData()
})

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--
  }
}

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
  }
}

const openDeliveryFeeModal = (order) => {
  selectedOrder.value = order
  newDeliveryFee.value = order.deliveryFee || 0
  showDeliveryFeeModal.value = true
}

const closeDeliveryFeeModal = () => {
  showDeliveryFeeModal.value = false
  selectedOrder.value = {}
  newDeliveryFee.value = 0
}

const saveDeliveryFee = async () => {
  if (newDeliveryFee.value < 0) {
    alert('佣金不能为负数')
    return
  }

  try {
    const res = await axios.put('/api/order/deliveryFee', null, {
      params: {
        orderId: selectedOrder.value.orderId,
        deliveryFee: newDeliveryFee.value
      }
    })

    if (res.data.code === 200) {
      alert('佣金设置成功！')
      closeDeliveryFeeModal()
      fetchData()
    } else {
      alert('设置失败：' + (res.data.message || res.data.msg))
    }
  } catch (error) {
    console.error('设置佣金失败:', error)
    alert('设置失败，请重试')
  }
}

</script>

<style scoped>
.order-list-container {
  padding: 5px;
  background-color: #f8f9fa;
  min-height: 100vh;
}

.order-list-card {
  max-width: 1400px;
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

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}

.page-title {
  font-size: 22px;
  font-weight: 600;
  color: #333;
  margin: 0;
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

.table-wrapper {
  padding: 0 32px 32px;
  overflow-x: auto;
}

.order-table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 16px;
  font-size: 14px;
}

.order-table th,
.order-table td {
  padding: 12px 10px;
  text-align: left;
  border-bottom: 1px solid #e9ecef;
  white-space: nowrap;
}

.order-table th {
  font-weight: 600;
  color: #555;
  font-size: 13px;
}

.order-table tbody tr:hover {
  background-color: #f9f9f9;
}

.order-table tbody tr:nth-child(even) {
  background-color: #fafafa;
}
.order-table tbody tr:nth-child(even):hover {
  background-color: #f0f8ff;
}

.status-badge {
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: 500;
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

.btn-edit {
  background-color: #2ecc71;
  color: white;
}
.btn-edit:hover {
  background-color: #27ae60;
}

.btn-fee {
  background-color: #f39c12;
  color: white;
}
.btn-fee:hover {
  background-color: #e67e22;
}

.empty-text {
  text-align: center;
  color: #999;
  font-style: italic;
  padding: 24px;
}

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

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 400px;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid #eee;
}

.modal-header h3 {
  margin: 0;
  font-size: 16px;
  color: #333;
}

.modal-close {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #999;
  padding: 0;
  line-height: 1;
}

.modal-close:hover {
  color: #666;
}

.modal-body {
  padding: 20px;
}

.form-group {
  margin-bottom: 16px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  font-size: 14px;
  color: #555;
}

.fee-input {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  box-sizing: border-box;
}

.fee-input:focus {
  outline: none;
  border-color: #3498db;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  padding: 16px 20px;
  border-top: 1px solid #eee;
  background-color: #fafafa;
  border-radius: 0 0 8px 8px;
}

.btn-cancel {
  background-color: #f0f0f0;
  color: #666;
  border: 1px solid #ddd;
}

.btn-cancel:hover {
  background-color: #e0e0e0;
}

.btn-save {
  background-color: #3498db;
  color: white;
}

.btn-save:hover {
  background-color: #2980b9;
}

</style>
