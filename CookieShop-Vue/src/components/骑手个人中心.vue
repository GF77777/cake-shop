<template>
  <div class="profile-container">
    <!-- 顶部标题栏 -->
    <header class="header">
      <h1>{{ $t('profile') }}</h1>
    </header>

    <!-- 账户信息区域 -->
    <div class="account-section">
      <div class="section-title">
        <span class="section-icon">💰</span>
        <span>{{ $t('accountInfo') }}</span>
      </div>
      <div class="info-list">
        <div class="info-item">
          <div class="info-label">
            <span class="label-icon">👤</span>
            <span>{{ $t('username') }}</span>
          </div>
          <span class="info-value">{{ riderInfo?.userName || 'rider01' }}</span>
        </div>
        <div class="info-item">
          <div class="info-label">
            <span class="label-icon">📱</span>
            <span>{{ $t('phone') }}</span>
          </div>
          <span class="info-value">{{ riderInfo?.phone || '13800138001' }}</span>
        </div>
        <div class="info-item">
          <div class="info-label">
            <span class="label-icon">📈</span>
            <span>{{ $t('totalIncome') }}</span>
          </div>
          <span class="info-value income">¥ {{ totalIncome.toFixed(2) }}</span>
        </div>
      </div>
    </div>

    <!-- 功能菜单 -->
    <div class="menu-section">
      <div class="menu-item" @click="editProfile">
        <div class="menu-left">
          <span class="menu-icon">✏️</span>
          <span class="menu-text">{{ $t('editProfile') }}</span>
        </div>
        <span class="menu-arrow">›</span>
      </div>
      <div class="menu-item" @click="goToStatistics">
        <div class="menu-left">
          <span class="menu-icon">💰</span>
          <span class="menu-text">{{ $t('incomeDetails') }}</span>
        </div>
        <span class="menu-arrow">›</span>
      </div>
      <div class="menu-item" @click="goToMessages">
        <div class="menu-left">
          <span class="menu-icon">🔔</span>
          <span class="menu-text">{{ $t('messageNotifications') }}</span>
        </div>
        <span class="menu-arrow">›</span>
      </div>
    </div>

    <!-- 退出登录 -->
    <div class="logout-section">
      <button class="logout-btn" @click="logout">
        <span class="logout-icon">🚪</span>
        <span>{{ $t('logout') }}</span>
      </button>
    </div>

    <!-- 底部导航栏 -->
    <footer class="footer">
      <button class="footer-btn" @click="goToHome">
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
      <button class="footer-btn active">
        <span class="footer-icon">👤</span>
        <span class="footer-text">{{ $t('my') }}</span>
      </button>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const riderInfo = ref(null);
const totalIncome = ref(0.00);

const getRiderInfo = () => {
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    riderInfo.value = JSON.parse(riderStr);
  }
};

const getAccountInfo = async () => {
  if (!riderInfo.value) return;
  try {
    const response = await axios.get(`/api/rider/account/info?riderId=${riderInfo.value.id}`);
    if (response.data.code === 200) {
      totalIncome.value = response.data.data.totalIncome || 0;
    }
  } catch (error) {
    console.error('获取账户信息失败', error);
  }
};

const editProfile = () => {
  window.location.href = '#/rider/profile-edit';
};

const logout = () => {
  if (confirm(t('confirmLogout'))) {
    localStorage.removeItem('rider');
    localStorage.removeItem('rider_token');
    window.location.href = '#/rider/login';
  }
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

onMounted(() => {
  getRiderInfo();
  getAccountInfo();
});
</script>

<style scoped>
.profile-container {
  min-height: 100vh;
  background: #f5f5f5;
  padding-bottom: 70px;
}

/* 顶部标题栏 */
.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 15px 20px;
  text-align: left;
}

.header h1 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
}

/* 账户信息区域 */
.account-section {
  background: white;
  margin: 15px;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.section-title {
  padding: 15px;
  border-bottom: 1px solid #f0f0f0;
  font-size: 14px;
  font-weight: bold;
  color: #333;
  display: flex;
  align-items: center;
  gap: 8px;
}

.section-icon {
  font-size: 16px;
}

.info-list {
  padding: 0 15px;
}

.info-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px 0;
  border-bottom: 1px solid #f5f5f5;
}

.info-item:last-child {
  border-bottom: none;
}

.info-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #666;
}

.label-icon {
  font-size: 14px;
}

.info-value {
  font-size: 14px;
  color: #333;
  font-weight: 500;
}

.info-value.income {
  color: #4caf50;
  font-weight: bold;
}

/* 功能菜单 */
.menu-section {
  background: white;
  margin: 0 15px 15px;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.menu-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 15px;
  border-bottom: 1px solid #f5f5f5;
  cursor: pointer;
  transition: background 0.2s;
}

.menu-item:hover {
  background: #fafafa;
}

.menu-item:last-child {
  border-bottom: none;
}

.menu-left {
  display: flex;
  align-items: center;
  gap: 10px;
}

.menu-icon {
  font-size: 16px;
}

.menu-text {
  font-size: 14px;
  color: #333;
}

.menu-arrow {
  font-size: 18px;
  color: #ccc;
}

/* 退出登录 */
.logout-section {
  margin: 0 15px;
}

.logout-btn {
  width: 100%;
  padding: 15px;
  border: 1px solid #f44336;
  border-radius: 8px;
  background: white;
  color: #f44336;
  font-size: 14px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.2s;
}

.logout-btn:hover {
  background: #fff5f5;
}

.logout-icon {
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
