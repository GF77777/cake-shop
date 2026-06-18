<template>
  <div class="rider-home">
    <!-- 通知组件 -->
    <div class="notifications">
      <transition-group name="notification">
        <div 
          v-for="notification in notifications" 
          :key="notification.id" 
          class="notification-item"
        >
          <div class="notification-title">{{ notification.title }}</div>
          <div class="notification-message">{{ notification.message }}</div>
        </div>
      </transition-group>
    </div>
    
    <!-- 顶部导航栏 -->
    <header class="header">
      <div class="logo">
        <span class="logo-icon">🛵</span>
        <span class="logo-text">{{ $t('rider') }}</span>
      </div>
      <div class="user-info">
        <span class="user-name">{{ riderInfo?.realName }}</span>
        <button @click="logout" class="logout-btn">{{ $t('logout') }}</button>
      </div>
    </header>

    <!-- 统计卡片区域 -->
    <div class="stats-section">
      <div class="stat-card">
        <div class="stat-number">{{ pendingCount }}</div>
        <div class="stat-label">{{ $t('pendingOrders') }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">{{ acceptedCount }}</div>
        <div class="stat-label">{{ $t('acceptedOrders') }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">{{ deliveringCount }}</div>
        <div class="stat-label">{{ $t('deliveringOrders') }}</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">{{ completedCount }}</div>
        <div class="stat-label">{{ $t('completedOrders') }}</div>
      </div>
    </div>

    <!-- 标签页切换 -->
    <div class="tabs">
      <button 
        v-for="tab in tabs" 
        :key="tab.key"
        :class="['tab-btn', { active: activeTab === tab.key }]" 
        @click="activeTab = tab.key"
      >
        {{ $t(tab.key) }}
        <span v-if="tab.key === 'pendingOrders' && pendingCount > 0" class="badge">{{ pendingCount }}</span>
      </button>
    </div>

    <!-- 内容区域 -->
    <div class="content">
      <!-- 待接单 -->
      <div v-if="activeTab === 'pendingOrders'">
        <div v-if="pendingOrders.length === 0" class="empty">{{ $t('noPendingOrders') }}</div>
        <div v-else class="order-list">
          <div v-for="order in pendingOrders" :key="order.orderId" class="order-card">
            <div class="order-header">
              <span class="order-id">{{ $t('orderId') }}: {{ order.orderId }}</span>
              <span class="order-status">{{ $t('pendingOrders') }}</span>
            </div>
            <div class="order-body">
              <div class="order-info">
                <span class="info-item">
                  <span class="info-icon">📦</span>
                  {{ $t('productCount') }}: {{ order.amount }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📍</span>
                  {{ order.address }}
                </span>
                <span class="info-item">
                  <span class="info-icon">👤</span>
                  {{ order.name }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📞</span>
                  {{ order.phone }}
                </span>
                <span class="info-item">
                  <span class="info-icon">🕐</span>
                  {{ formatTime(order.dateTime) }}
                </span>
              </div>
              <div class="order-footer">
                <span class="order-amount">¥{{ order.total.toFixed(2) }}</span>
                <div class="order-actions">
                  <button @click="showDetail(order)" class="btn-detail">{{ $t('viewDetail') }}</button>
                  <button @click="acceptOrder(order.orderId)" class="btn-accept">{{ $t('acceptOrder') }}</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 待取货 -->
      <div v-if="activeTab === 'acceptedOrders'">
        <div v-if="acceptedOrders.length === 0" class="empty">{{ $t('noAcceptedOrders') }}</div>
        <div v-else class="order-list">
          <div v-for="order in acceptedOrders" :key="order.orderId" class="order-card">
            <div class="order-header">
              <span class="order-id">{{ $t('orderId') }}: {{ order.orderId }}</span>
              <span class="order-status accepted">{{ $t('acceptedOrders') }}</span>
            </div>
            <div class="order-body">
              <div class="order-info">
                <span class="info-item">
                  <span class="info-icon">📦</span>
                  {{ $t('productCount') }}: {{ order.amount }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📍</span>
                  {{ order.address }}
                </span>
                <span class="info-item">
                  <span class="info-icon">👤</span>
                  {{ order.name }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📞</span>
                  {{ order.phone }}
                </span>
              </div>
              <div class="order-footer">
                <span class="order-amount">¥{{ order.total.toFixed(2) }}</span>
                <div class="order-actions">
                  <button @click="showDetail(order)" class="btn-detail">{{ $t('viewDetail') }}</button>
                  <button @click="startDelivery(order.orderId)" class="btn-start">{{ $t('startDelivery') }}</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 配送中 -->
      <div v-if="activeTab === 'deliveringOrders'">
        <div v-if="deliveringOrders.length === 0" class="empty">{{ $t('noDeliveringOrders') }}</div>
        <div v-else class="order-list">
          <div v-for="order in deliveringOrders" :key="order.orderId" class="order-card">
            <div class="order-header">
              <span class="order-id">{{ $t('orderId') }}: {{ order.orderId }}</span>
              <span class="order-status delivering">{{ $t('deliveringOrders') }}</span>
            </div>
            <div class="order-body">
              <div class="order-info">
                <span class="info-item">
                  <span class="info-icon">📦</span>
                  {{ $t('productCount') }}: {{ order.amount }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📍</span>
                  {{ order.address }}
                </span>
                <span class="info-item">
                  <span class="info-icon">👤</span>
                  {{ order.name }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📞</span>
                  {{ order.phone }}
                </span>
              </div>
              <div class="order-footer">
                <span class="order-amount">¥{{ order.total.toFixed(2) }}</span>
                <div class="order-actions">
                  <button @click="callCustomer(order.phone)" class="btn-call">{{ $t('callCustomer') }}</button>
                  <button @click="completeDelivery(order.orderId)" class="btn-complete">{{ $t('completeDelivery') }}</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 已完成 -->
      <div v-if="activeTab === 'completedOrders'">
        <div v-if="completedOrders.length === 0" class="empty">{{ $t('noCompletedOrders') }}</div>
        <div v-else class="order-list">
          <div v-for="order in completedOrders" :key="order.orderId" class="order-card">
            <div class="order-header">
              <span class="order-id">{{ $t('orderId') }}: {{ order.orderId }}</span>
              <span class="order-status completed">{{ $t('completedOrders') }}</span>
            </div>
            <div class="order-body">
              <div class="order-info">
                <span class="info-item">
                  <span class="info-icon">📦</span>
                  {{ $t('productCount') }}: {{ order.amount }}
                </span>
                <span class="info-item">
                  <span class="info-icon">📍</span>
                  {{ order.address }}
                </span>
                <span class="info-item">
                  <span class="info-icon">👤</span>
                  {{ order.name }}
                </span>
                <span class="info-item">
                  <span class="info-icon">🕐</span>
                  {{ formatTime(order.dateTime) }}
                </span>
              </div>
              <div class="order-footer">
                <span class="order-amount">¥{{ order.total.toFixed(2) }}</span>
                <div class="order-actions">
                  <button @click="showDetail(order)" class="btn-detail">{{ $t('viewDetail') }}</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 底部导航栏 -->
    <footer class="footer">
      <button class="footer-btn active">
        <span class="footer-icon">🏠</span>
        <span class="footer-text">{{ $t('home') }}</span>
      </button>
      <button class="footer-btn" @click="goToStatistics">
        <span class="footer-icon">💰</span>
        <span class="footer-text">{{ $t('income') }}</span>
      </button>
      <button class="footer-btn" @click="goToMessages">
        <span class="footer-icon">💬</span>
        <span class="footer-text">{{ $t('messages') }}</span>
      </button>
      <button class="footer-btn" @click="goToProfile">
        <span class="footer-icon">👤</span>
        <span class="footer-text">{{ $t('profile') }}</span>
      </button>
    </footer>

    <!-- 订单详情弹窗 -->
    <div v-if="showModal" class="modal-overlay" @click.self="closeModal">
      <div class="modal-content">
        <div class="modal-header">
          <h3>{{ $t('orderDetail') }}</h3>
          <button @click="closeModal" class="modal-close">&times;</button>
        </div>
        <div class="modal-body" v-if="selectedOrder">
          <div class="detail-section">
            <p><strong>{{ $t('orderId') }}:</strong> {{ selectedOrder.orderId }}</p>
            <p><strong>{{ $t('recipient') }}:</strong> {{ selectedOrder.name }}</p>
            <p><strong>{{ $t('phone') }}:</strong> {{ selectedOrder.phone }}</p>
            <p><strong>{{ $t('address') }}:</strong> {{ selectedOrder.address }}</p>
            <p><strong>{{ $t('amount') }}:</strong> ¥{{ selectedOrder.total.toFixed(2) }}</p>
            <p><strong>{{ $t('productCount') }}:</strong> {{ selectedOrder.amount }}</p>
            <p><strong>{{ $t('orderTime') }}:</strong> {{ formatTime(selectedOrder.dateTime) }}</p>
          </div>
        </div>
        <div class="modal-footer">
          <button @click="closeModal" class="btn-close">{{ $t('close') }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const riderInfo = ref(null);
const activeTab = ref('pendingOrders');
const pendingOrders = ref([]);
const acceptedOrders = ref([]);
const deliveringOrders = ref([]);
const completedOrders = ref([]);
const showModal = ref(false);
const selectedOrder = ref(null);
const notifications = ref([]);

const tabs = [
  { key: 'pendingOrders', label: '待接单' },
  { key: 'acceptedOrders', label: '待取货' },
  { key: 'deliveringOrders', label: '配送中' },
  { key: 'completedOrders', label: '已完成' }
];

const pendingCount = computed(() => pendingOrders.value.length);
const acceptedCount = computed(() => acceptedOrders.value.length);
const deliveringCount = computed(() => deliveringOrders.value.length);
const completedCount = computed(() => completedOrders.value.length);

const getRiderInfo = () => {
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    riderInfo.value = JSON.parse(riderStr);
  }
};

const loadPendingOrders = async () => {
  try {
    const response = await axios.get('/api/rider/orders/pending');
    if (response.data.code === 200) {
      pendingOrders.value = response.data.data;
    }
  } catch (error) {
    console.error('获取待接单订单失败', error);
  }
};

const loadAcceptedOrders = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/orders/accepted?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      acceptedOrders.value = response.data.data;
    }
  } catch (error) {
    console.error('获取已接单订单失败', error);
  }
};

const loadDeliveringOrders = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/orders/delivering?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      deliveringOrders.value = response.data.data;
    }
  } catch (error) {
    console.error('获取配送中订单失败', error);
  }
};

const loadCompletedOrders = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/orders/history?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      completedOrders.value = response.data.data;
    }
  } catch (error) {
    console.error('获取已完成订单失败', error);
  }
};

const acceptOrder = async (orderId) => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.post('/api/rider/order/accept', {
      orderId,
      riderId: riderInfo.value.id
    });
    if (response.data.code === 200) {
      showNotification(t('acceptSuccess'), t('acceptSuccessMsg').replace('{orderId}', orderId));
      loadPendingOrders();
      loadAcceptedOrders();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('接单失败', error);
    alert('接单失败');
  }
};

const startDelivery = async (orderId) => {
  try {
    const response = await axios.post('/api/rider/order/start', { orderId });
    if (response.data.code === 200) {
      showNotification(t('startDeliverySuccess'), t('startDeliverySuccessMsg').replace('{orderId}', orderId));
      loadAcceptedOrders();
      loadDeliveringOrders();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('开始配送失败', error);
    alert('操作失败');
  }
};

const completeDelivery = async (orderId) => {
  try {
    const response = await axios.post('/api/rider/order/complete', { orderId });
    if (response.data.code === 200) {
      showNotification(t('deliveryCompleteSuccess'), t('deliveryCompleteSuccessMsg').replace('{orderId}', orderId));
      loadDeliveringOrders();
      loadCompletedOrders();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('确认送达失败', error);
    alert('操作失败');
  }
};

const callCustomer = (phone) => {
  window.location.href = `tel:${phone}`;
};

const logout = () => {
  localStorage.removeItem('rider');
  localStorage.removeItem('rider_token');
  window.location.href = '#/rider/login';
};

const goToStatistics = () => {
  window.location.href = '#/rider/statistics';
};

const goToMessages = () => {
  window.location.href = '#/rider/message';
};

const goToProfile = () => {
  window.location.href = '#/rider/profile';
};

const showDetail = (order) => {
  selectedOrder.value = order;
  showModal.value = true;
};

const closeModal = () => {
  showModal.value = false;
  selectedOrder.value = null;
};

const formatTime = (dateStr) => {
  if (!dateStr) return '';
  return new Date(dateStr).toLocaleString('zh-CN');
};

const showNotification = (title, message) => {
  const id = Date.now();
  notifications.value.push({ id, title, message });
  
  setTimeout(() => {
    notifications.value = notifications.value.filter(n => n.id !== id);
  }, 3000);
};

const loadAllOrders = () => {
  loadPendingOrders();
  loadAcceptedOrders();
  loadDeliveringOrders();
  loadCompletedOrders();
};

onMounted(() => {
  getRiderInfo();
  loadAllOrders();
});
</script>

<style scoped>
.rider-home {
  min-height: 100vh;
  background: #f5f5f5;
  display: flex;
  flex-direction: column;
}

/* 通知组件 */
.notifications {
  position: fixed;
  top: 150px;
  right: 20px;
  z-index: 1000;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.notification-item {
  background: white;
  border-radius: 8px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  padding: 12px 16px;
  min-width: 280px;
  max-width: 350px;
  border-left: 4px solid #667eea;
}

.notification-title {
  font-weight: bold;
  font-size: 14px;
  color: #333;
  margin-bottom: 4px;
}

.notification-message {
  font-size: 12px;
  color: #666;
}

/* 通知动画 */
.notification-enter-active {
  animation: slideIn 0.3s ease-out;
}

.notification-leave-active {
  animation: slideOut 0.3s ease-in;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateX(100%);
  }
  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes slideOut {
  from {
    opacity: 1;
    transform: translateX(0);
  }
  to {
    opacity: 0;
    transform: translateX(100%);
  }
}

/* 顶部导航栏 */
.header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 100;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
}

.logo-icon {
  font-size: 24px;
}

.logo-text {
  font-size: 18px;
  font-weight: bold;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 15px;
}

.user-name {
  font-size: 16px;
}

.logout-btn {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  padding: 6px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

/* 统计卡片区域 */
.stats-section {
  position: fixed;
  top: 55px;
  left: 0;
  right: 0;
  z-index: 99;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 10px;
  padding: 15px;
  background: white;
}

.stat-card {
  text-align: center;
  padding: 15px;
  background: #fafafa;
  border-radius: 8px;
}

.stat-number {
  font-size: 28px;
  font-weight: bold;
  color: #667eea;
}

.stat-label {
  font-size: 12px;
  color: #999;
  margin-top: 5px;
}

/* 标签页 */
.tabs {
  padding-top: 135px;
  display: flex;
  background: white;
  border-bottom: 1px solid #eee;
}

.tab-btn {
  flex: 1;
  padding: 14px;
  border: none;
  background: transparent;
  cursor: pointer;
  font-size: 14px;
  position: relative;
}

.tab-btn.active {
  color: #667eea;
  font-weight: bold;
}

.tab-btn.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 40px;
  height: 3px;
  background: #667eea;
  border-radius: 2px;
}

.badge {
  background: #f44336;
  color: white;
  font-size: 10px;
  padding: 2px 6px;
  border-radius: 10px;
  margin-left: 4px;
}

/* 内容区域 */
.content {
  flex: 1;
  padding: 15px;
  padding-bottom: 70px;
}

.empty {
  text-align: center;
  padding: 50px;
  color: #999;
  background: white;
  border-radius: 8px;
}

/* 订单列表 */
.order-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.order-card {
  background: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
  overflow: hidden;
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 15px;
  border-bottom: 1px solid #f0f0f0;
}

.order-id {
  font-size: 14px;
  font-weight: bold;
  color: #333;
}

.order-status {
  font-size: 12px;
  padding: 3px 8px;
  border-radius: 4px;
  background: #fff3cd;
  color: #856404;
}

.order-status.accepted {
  background: #d1ecf1;
  color: #0c5460;
}

.order-status.delivering {
  background: #d4edda;
  color: #155724;
}

.order-status.completed {
  background: #e8f5e9;
  color: #2e7d32;
}

.order-body {
  padding: 12px 15px;
}

.order-info {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 12px;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 13px;
  color: #666;
}

.info-icon {
  font-size: 14px;
}

.order-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 12px;
  border-top: 1px dashed #eee;
}

.order-amount {
  font-size: 16px;
  font-weight: bold;
  color: #e74c3c;
}

.order-actions {
  display: flex;
  gap: 8px;
}

.btn-detail {
  padding: 6px 12px;
  border: 1px solid #667eea;
  border-radius: 4px;
  color: #667eea;
  font-size: 12px;
  cursor: pointer;
}

.btn-accept {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  background: #f39c12;
  color: white;
  font-size: 12px;
  cursor: pointer;
}

.btn-start {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  background: #3498db;
  color: white;
  font-size: 12px;
  cursor: pointer;
}

.btn-call {
  padding: 6px 12px;
  border: 1px solid #27ae60;
  border-radius: 4px;
  color: #27ae60;
  font-size: 12px;
  cursor: pointer;
}

.btn-complete {
  padding: 6px 12px;
  border: none;
  border-radius: 4px;
  background: #27ae60;
  color: white;
  font-size: 12px;
  cursor: pointer;
}

/* 底部导航栏 */
.footer {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: white;
  padding: 10px 0;
  display: flex;
  box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
  z-index: 100;
}

.footer-btn {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  border: none;
  background: transparent;
  cursor: pointer;
  padding: 5px;
}

.footer-icon {
  font-size: 22px;
}

.footer-text {
  font-size: 12px;
  color: #999;
}

.footer-btn.active .footer-text {
  color: #667eea;
}

/* 弹窗 */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 200;
}

.modal-content {
  background: white;
  border-radius: 8px;
  width: 90%;
  max-width: 400px;
  overflow: hidden;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 20px;
  border-bottom: 1px solid #eee;
}

.modal-header h3 {
  margin: 0;
  font-size: 16px;
}

.modal-close {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #999;
}

.modal-body {
  padding: 20px;
}

.detail-section p {
  margin: 8px 0;
  font-size: 14px;
  color: #333;
}

.modal-footer {
  padding: 15px 20px;
  border-top: 1px solid #eee;
  text-align: right;
}

.btn-close {
  padding: 8px 20px;
  border: none;
  border-radius: 4px;
  background: #667eea;
  color: white;
  font-size: 14px;
  cursor: pointer;
}
</style>
