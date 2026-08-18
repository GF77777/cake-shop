<template>
  <div class="box">
    <h1>{{ $t('profile') }}</h1>

    <div v-if="!user.id" class="empty">
      <p>{{ $t('notLoggedIn') }}</p>
    </div>
    <div v-else class="user-info">
      <p><strong>{{ $t('userName') }}：</strong>{{ user.userName || $t('notFilled') }}</p>
      <p><strong>{{ $t('name') }}：</strong>{{ user.name || $t('notFilled') }}</p>
      <p><strong>{{ $t('email') }}：</strong>{{ user.email || $t('notFilled') }}</p>
      <p><strong>{{ $t('phone') }}：</strong>{{ user.phone || $t('notFilled') }}</p>
      <p><strong>{{ $t('address') }}：</strong>{{ user.address || $t('notFilled') }}</p>

      <div class="action-row">
        <router-link
          :to="`/profile-edit/${user.id}`"
          class="btn-edit"
        >
          {{ $t('editInfo') }}
        </router-link>
        <button class="btn-lang" @click="toggleLocale">
          {{ locale === 'zh' ? 'EN' : '中文' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useI18n } from 'vue-i18n'
import { useUserStore } from '@/stores/user'

const { locale } = useI18n()
const user = useUserStore()

const toggleLocale = () => {
  const newLocale = locale.value === 'zh' ? 'en' : 'zh'
  locale.value = newLocale
  localStorage.setItem('locale', newLocale)
}
</script>

<style scoped>
.box {
  width: 75%;
  margin: auto;
  font-size: 16px;
}

h1 {
  margin-bottom: 20px;
  color: #333;
  font-size: 28px;
  font-weight: bold;
}

.user-info {
  background-color: #f9f9f9;
  padding: 24px;
  border-radius: 8px;
  border: 1px solid #eee;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.user-info p {
  margin: 12px 0;
  font-size: 16px;
  color: #444;
}

.user-info strong {
  color: #222;
  margin-right: 8px;
}

.empty {
  color: #999;
  font-style: italic;
  font-size: 16px;
}

/* 操作按钮行 */
.action-row {
  display: flex;
  gap: 12px;
  margin-top: 16px;
  align-items: center;
}

/* 通用按钮样式 */
.btn-edit,
.btn-lang {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  font-weight: 500;
  transition: background-color 0.2s, transform 0.1s;
  width: 100px;
  height: 40px;
}

.btn-edit:hover,
.btn-lang:hover {
  transform: translateY(-1px);
}

.btn-edit:active,
.btn-lang:active {
  transform: translateY(0);
}

/* 修改信息按钮 */
.btn-edit {
  background-color: #4caf50;
  color: white;
  text-decoration: none;
}

.btn-edit:hover {
  background-color: #45a049;
}

/* 语言切换按钮 */
.btn-lang {
  background-color: #2196f3;
  color: white;
}

.btn-lang:hover {
  background-color: #1976d2;
}
</style>