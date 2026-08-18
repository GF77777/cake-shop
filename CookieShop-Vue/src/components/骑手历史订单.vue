<template>
  <div class="history-container">
    <!-- 顶部导航栏 -->
    <header class="header">
      <button @click="goBack" class="back-btn">← 返回</button>
      <h1>历史订单</h1>
      <div class="placeholder"></div>
    </header>

    <!-- 内容区域 -->
    <div class="content">
      <div v-if="historyOrders.length === 0" class="empty">暂无历史订单</div>
      <div v-else class="order-list">
        <div v-for="order in historyOrders" :key="order.orderId" class="order-card">
          <div class="order-header">
            <span class="order-id">订单号: {{ order.orderId }}</span>
            <span :class="['order-status', getStatusClass(order.status)]">{{ getStatusText(order.status) }}</span>
          </div>
          <div class="order-body">
            <div class="order-info">
              <span class="info-item">
                <span class="info-icon">📦</span>
                商品数量: {{ order.amount }}件
              </span>
              <span class="info-item">
                <span class="info-icon">📍</span>
                {{ order.address }}
              </span>
              <span class="info-item">
                <span class="info-icon">👤</span>
                {{ order.name }}
              </span>
            </div>
            <div class="order-footer">
              <span class="order-amount">¥{{ order.total.toFixed(2) }}</span>
              <span class="order-time">{{ formatTime(order.dateTime) }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 底部导航栏 -->
    <footer class="footer">
      <button class="footer-btn" @click="goToHome">
        <span class="footer-icon">🏠</span>
        <span class="footer-text">首页</span>
      </button>
      <button class="footer-btn" @click="goToStatistics">
        <span class="footer-icon">💰</span>
        <span class="footer-text">收入</span>
      </button>
      <button class="footer-btn" @click="goToMessages">
        <span class="footer-icon">💬</span>
        <span class="footer-text">消息</span>
      </button>
      <button class="footer-btn" @click="goToProfile">
        <span class="footer-icon">👤</span>
        <span class="footer-text">我的</span>
      </button>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';

const riderInfo = ref(null);
const historyOrders = ref([]);

const getRiderInfo = () => {
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    riderInfo.value = JSON.parse(riderStr);
  }
};

const loadHistoryOrders = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/orders/history?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      historyOrders.value = response.data.data;
    }
  } catch (error) {
    console.error('获取历史订单失败', error);
  }
};

const getStatusText = (status) => {
  const statusMap = {
    0: '已付款',
    1: '已发货',
    2: '已完成',
    3: '已送达',
    5: '已取消'
  };
  return statusMap[status] || '未知';
};

const getStatusClass = (status) => {
  const classMap = {
    3: 'delivered',
    4: 'completed',
    5: 'cancelled'
  };
  return classMap[status] || '';
};

const goBack = () => {
  window.location.href = '#/rider/home';
};

const goToHome = () => {
  window.location.href = '#/rider/home';
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

const formatTime = (dateStr) => {
  if (!dateStr) return '';
  return new Date(dateStr).toLocaleString('zh-CN');
};

onMounted(() => {
  getRiderInfo();
  loadHistoryOrders();
});
</script>

<style scoped>
.history-container {
  min-height: 100vh;
  background: #f5f5f5;
}

/* 顶部导航栏 */
.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.back-btn {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  padding: 8px 15px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.placeholder {
  width: 60px;
}

.header h1 {
  margin: 0;
  font-size: 18px;
}

/* 内容区域 */
.content {
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
}

.order-status.delivered {
  background: #e3f2fd;
  color: #1565c0;
}

.order-status.completed {
  background: #e8f5e9;
  color: #2e7d32;
}

.order-status.cancelled {
  background: #ffebee;
  color: #c62828;
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

.order-time {
  color: #999;
  font-size: 12px;
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
</style>
