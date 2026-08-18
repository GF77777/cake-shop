<template>
  <div class="message-page">
    <!-- 顶部导航栏 -->
    <div class="msg-header">
      <div class="header-left" @click="goBack">
        <svg class="back-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M19 12H5M12 19l-7-7 7-7"/>
        </svg>
      </div>
      <div class="header-title">{{ $t('messageNotification') }}</div>
      <div class="header-right">
        <span class="exit-btn" @click="logout">{{ $t('logout') }}</span>
      </div>
    </div>

    <!-- 标签筛选区 -->
    <div class="msg-tabs">
      <button 
        v-for="tab in tabs" 
        :key="tab.key"
        :class="['tab-item', { active: activeTab === tab.key }]"
        @click="switchTab(tab.key)"
      >
        <span class="tab-icon">{{ tab.icon }}</span>
        <span class="tab-text">{{ $t(tab.key) }}</span>
      </button>
    </div>

    <!-- 消息列表 -->
    <div class="msg-list">
      <div v-for="msg in messages" :key="msg.id" class="msg-card" @click="markAsRead(msg.id)">
        <div class="msg-icon" :class="msg.type || 'default'">
          <span>{{ getIcon(msg.type) }}</span>
        </div>
        <div class="msg-content">
          <div class="msg-title">{{ msg.title }}</div>
          <div class="msg-desc">{{ msg.content }}</div>
        </div>
        <div class="msg-time">
          <span>{{ formatTime(msg.createTime) }}</span>
          <span v-if="!msg.isRead" class="unread-dot"></span>
        </div>
      </div>

      <!-- 空状态 -->
      <div v-if="messages.length === 0" class="empty-state">
        <div class="empty-icon">📭</div>
        <div class="empty-text">{{ $t('noMessages') }}</div>
      </div>
    </div>

    <!-- 底部导航栏 -->
    <div class="rider-nav">
      <div class="nav-item" @click="navigateTo('/rider/home')">
        <span class="nav-icon">🏠</span>
        <span class="nav-text">{{ $t('home') }}</span>
      </div>
      <div class="nav-item" @click="navigateTo('/rider/statistics')">
        <span class="nav-icon">💰</span>
        <span class="nav-text">{{ $t('income') }}</span>
      </div>
      <div class="nav-item active">
        <span class="nav-icon">📧</span>
        <span class="nav-text">{{ $t('messages') }}</span>
      </div>
      <div class="nav-item" @click="navigateTo('/rider/profile')">
        <span class="nav-icon">👤</span>
        <span class="nav-text">{{ $t('profile') }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const riderInfo = ref(null);

const activeTab = ref('all');
const messages = ref([]);

const tabs = [
  { key: 'all', label: '全部', icon: '📋' },
  { key: 'order', label: '订单', icon: '📦' },
  { key: 'system', label: '系统', icon: '⚙️' },
  { key: 'income', label: '收入', icon: '💰' }
];

const getIcon = (type) => {
  if (!type || typeof type !== 'string') return '📄';
  const icons = {
    order: '📋',
    system: '⚠️',
    income: '💰'
  };
  return icons[type] || '📄';
};

const formatTime = (timestamp) => {
  if (!timestamp) return '';
  const now = new Date();
  const msgTime = new Date(timestamp);
  const diff = now - msgTime;
  
  const minutes = Math.floor(diff / (1000 * 60));
  const hours = Math.floor(diff / (1000 * 60 * 60));
  const days = Math.floor(diff / (1000 * 60 * 60 * 24));
  
  if (minutes < 1) return t('justNow');
  if (minutes < 60) return t('minutesAgo', { n: minutes });
  if (hours < 24) return t('hoursAgo', { n: hours });
  return t('daysAgo', { n: days });
};

const loadMessages = async () => {
  if (!riderInfo.value?.id) return;
  
  try {
    const typeParam = activeTab.value === 'all' ? '' : activeTab.value;
    const response = await axios.get(`/api/message/list`, {
      params: {
        riderId: riderInfo.value.id,
        type: typeParam
      }
    });
    
    if (response.data.code === 200) {
      messages.value = response.data.data;
    }
  } catch (error) {
    console.error('获取消息列表失败', error);
  }
};

const switchTab = (tabKey) => {
  activeTab.value = tabKey;
  loadMessages();
};

const markAsRead = async (messageId) => {
  try {
    await axios.put(`/api/message/read`, { messageId });
    const msg = messages.value.find(m => m.id === messageId);
    if (msg) msg.isRead = true;
  } catch (error) {
    console.error('标记消息已读失败', error);
  }
};

const goBack = () => {
  window.location.href = '#/rider/home';
};

const logout = () => {
  localStorage.removeItem('riderInfo');
  window.location.href = '#/rider/login';
};

const navigateTo = (path) => {
  window.location.href = '#' + path;
};

onMounted(() => {
  // 获取骑手信息
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    riderInfo.value = JSON.parse(riderStr);
  }
  loadMessages();
});
</script>

<style scoped>
.message-page {
  min-height: 100vh;
  background-color: #f5f5f5;
  display: flex;
  flex-direction: column;
}

.msg-header {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 100;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 40px 20px 15px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  color: white;
}

.header-left {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.back-icon {
  width: 24px;
  height: 24px;
}

.header-title {
  font-size: 18px;
  font-weight: 600;
}

.exit-btn {
  font-size: 14px;
  cursor: pointer;
  padding: 5px 10px;
  border-radius: 4px;
  background: rgba(255,255,255,0.2);
}
/* 标签筛选区 */
.msg-tabs {
  position: fixed;
  top: 85px;
  left: 0;
  right: 0;
  z-index: 99;
  display: flex;
  background: white;
  padding: 10px 15px;
  gap: 10px;
  border-bottom: 1px solid #eee;
}

.tab-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 5px;
  padding: 10px;
  border: none;
  border-radius: 20px;
  background: #f5f5f5;
  cursor: pointer;
  transition: all 0.3s;
}

.tab-item.active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.tab-icon {
  font-size: 16px;
}

.tab-text {
  font-size: 14px;
}

.msg-list {
  flex: 1;
  padding: 130px 15px 80px;
  overflow-y: auto;
}

.msg-card {
  display: flex;
  align-items: center;
  background: white;
  padding: 15px;
  margin-bottom: 10px;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.06);
  cursor: pointer;
  transition: transform 0.2s;
}

.msg-card:hover {
  transform: translateX(5px);
}

.msg-icon {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 20px;
  margin-right: 15px;
}

.msg-icon.default {
  background: #f5f5f5;
}

.msg-icon.order {
  background: #e8f5e9;
}

.msg-icon.system {
  background: #fff3e0;
}

.msg-icon.income {
  background: #e3f2fd;
}

.msg-content {
  flex: 1;
  min-width: 0;
}

.msg-title {
  font-size: 15px;
  font-weight: 600;
  color: #333;
  margin-bottom: 5px;
}

.msg-desc {
  font-size: 13px;
  color: #999;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.msg-time {
  text-align: right;
  margin-left: 15px;
}

.msg-time span:first-child {
  font-size: 12px;
  color: #bbb;
  display: block;
}

.unread-dot {
  display: inline-block;
  width: 8px;
  height: 8px;
  background: #ff4757;
  border-radius: 50%;
  margin-top: 5px;
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 60px 20px;
}

.empty-icon {
  font-size: 48px;
  margin-bottom: 15px;
}

.empty-text {
  font-size: 14px;
  color: #999;
}

.rider-nav {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  z-index: 100;
  display: flex;
  background: white;
  padding: 10px 0 25px;
  box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
}

.nav-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 5px;
  cursor: pointer;
  color: #999;
  transition: color 0.3s;
}

.nav-item.active {
  color: #667eea;
}

.nav-icon {
  font-size: 22px;
}

.nav-text {
  font-size: 12px;
}
</style>