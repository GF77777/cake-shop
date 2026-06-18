<template>
  <div class="login-container">
    <div class="login-box">
      <div class="back-link">
        <router-link to="/login">{{ $t('backToUserLogin') }}</router-link>
      </div>
      <h2>{{ $t('riderLogin') }}</h2>
      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label>{{ $t('riderAccount') }}</label>
          <input v-model="userName" type="text" :placeholder="$t('enterAccount')" required />
        </div>
        <div class="form-group">
          <label>{{ $t('password') }}</label>
          <input v-model="passWord" type="password" :placeholder="$t('enterPassword')" required />
        </div>
        <button type="submit" class="login-btn">{{ $t('login') }}</button>
      </form>
      <div class="register-link">
        <router-link to="/rider/register">{{ $t('noAccountYet') }}</router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { RouterLink } from 'vue-router';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const userName = ref('');
const passWord = ref('');

const handleLogin = async () => {
  try {
    const response = await axios.post('/api/rider/login', {
      userName: userName.value,
      passWord: passWord.value
    });
    if (response.data.code === 200) {
      localStorage.setItem('rider', JSON.stringify(response.data.data));
      localStorage.setItem('rider_token', 'rider_' + Date.now());
      alert('登录成功');
      window.location.href = '#/rider/home';
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('登录失败', error);
    alert('登录失败，请重试');
  }
};
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-box {
  background: white;
  padding: 40px;
  border-radius: 10px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
  width: 350px;
}

.login-box h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #333;
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #666;
}

.form-group input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 16px;
  box-sizing: border-box;
}

.login-btn {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  cursor: pointer;
}

.login-btn:hover {
  opacity: 0.9;
}

.back-link {
  text-align: left;
  margin-bottom: 20px;
}

.back-link a {
  color: #667eea;
  text-decoration: none;
  font-size: 14px;
}

.back-link a:hover {
  text-decoration: underline;
}

.register-link {
  text-align: center;
  margin-top: 20px;
}

.register-link a {
  color: #667eea;
  text-decoration: none;
  font-size: 14px;
}

.register-link a:hover {
  text-decoration: underline;
}
</style>