<template>
  <div class="statistics-container">
    <!-- 顶部导航栏 -->
    <header class="header">
      <button @click="goBack" class="back-btn">← 返回</button>
      <h1>收入</h1>
      <div class="placeholder"></div>
    </header>

    <!-- 统计卡片区域 -->
    <div class="stats-section">
      <div class="stat-card">
        <div class="stat-number">¥{{ todayIncome.toFixed(2) }}</div>
        <div class="stat-label">今日收益</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">{{ todayOrders }}</div>
        <div class="stat-label">今日单量</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">¥{{ monthIncome.toFixed(2) }}</div>
        <div class="stat-label">本月收益</div>
      </div>
      <div class="stat-card">
        <div class="stat-number">{{ monthOrders }}</div>
        <div class="stat-label">本月单量</div>
      </div>
    </div>

    <!-- 收益明细 -->
    <div class="section">
      <h3>收益明细</h3>
      <div v-if="incomeDetail.length === 0" class="empty">暂无收益记录</div>
      <div v-else class="detail-list">
        <div v-for="item in incomeDetail" :key="item.orderId" class="detail-item">
          <div class="detail-header">
            <span class="order-id">订单号: {{ item.orderId }}</span>
            <span class="order-time">{{ formatTime(item.deliveryTime) }}</span>
          </div>
          <div class="detail-body">
            <span class="delivery-fee">配送费: ¥{{ item.deliveryFee?.toFixed(2) || '0.00' }}</span>
            <span class="order-total">订单总额: ¥{{ item.total?.toFixed(2) || '0.00' }}</span>
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
      <button class="footer-btn active">
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
const todayIncome = ref(0);
const todayOrders = ref(0);
const monthIncome = ref(0);
const monthOrders = ref(0);
const incomeDetail = ref([]);

const getRiderInfo = () => {
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    riderInfo.value = JSON.parse(riderStr);
  }
};

const loadTodayStatistics = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/statistics/today?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      todayIncome.value = response.data.data.todayIncome || 0;
      todayOrders.value = response.data.data.todayOrders || 0;
    }
  } catch (error) {
    console.error('获取今日统计失败', error);
  }
};

const loadMonthStatistics = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/statistics/month?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      monthIncome.value = response.data.data.monthIncome || 0;
      monthOrders.value = response.data.data.monthOrders || 0;
    }
  } catch (error) {
    console.error('获取本月统计失败', error);
  }
};

const loadIncomeDetail = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/statistics/income?riderId=${riderInfo.value.id}&month=0`);
    if (response.data.code === 200) {
      incomeDetail.value = response.data.data;
    }
  } catch (error) {
    console.error('获取收益明细失败', error);
  }
};

const goBack = () => {
  window.location.href = '#/rider/home';
};

const goToHome = () => {
  window.location.href = '#/rider/home';
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
  loadTodayStatistics();
  loadMonthStatistics();
  loadIncomeDetail();
});
</script>

<style scoped>
.statistics-container {
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

/* 统计卡片区域 */
.stats-section {
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

/* 内容区域 */
.section {
  padding: 15px;
  padding-bottom: 70px;
}

.section h3 {
  margin-bottom: 15px;
  color: #333;
  font-size: 16px;
}

.empty {
  text-align: center;
  padding: 50px;
  color: #999;
  background: white;
  border-radius: 8px;
}

/* 明细列表 */
.detail-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.detail-item {
  background: white;
  padding: 12px 15px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.detail-header {
  display: flex;
  justify-content: space-between;
  margin-bottom: 10px;
}

.order-id {
  font-weight: bold;
  color: #333;
  font-size: 14px;
}

.order-time {
  color: #999;
  font-size: 12px;
}

.detail-body {
  display: flex;
  justify-content: space-between;
}

.delivery-fee {
  color: #27ae60;
  font-weight: bold;
  font-size: 14px;
}

.order-total {
  color: #666;
  font-size: 14px;
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
