<template>
  <div class="register-container">
    <div class="register-box">
      <div class="back-link">
        <router-link to="/rider/login">{{ $t('backToRiderLogin') }}</router-link>
      </div>
      <h2>{{ $t('riderRegister') }}</h2>
      <form @submit.prevent="handleRegister">
        <div class="form-group">
          <label>{{ $t('loginAccount') }}</label>
          <input v-model="userName" type="text" :placeholder="$t('enterLoginAccount')" required />
        </div>
        <div class="form-group">
          <label>{{ $t('loginPassword') }}</label>
          <input v-model="passWord" type="password" :placeholder="$t('enterLoginPassword')" required />
        </div>
        <div class="form-group">
          <label>{{ $t('realName') }}</label>
          <input v-model="realName" type="text" :placeholder="$t('enterRealName')" required />
        </div>
        <div class="form-group">
          <label>{{ $t('contactPhone') }}</label>
          <input v-model="phone" type="text" :placeholder="$t('enterContactPhone')" required />
        </div>
        <div class="form-group">
          <label>{{ $t('workNo') }}</label>
          <input v-model="workNo" type="text" :placeholder="$t('enterWorkNo')" />
        </div>
        <div class="form-group">
          <label>{{ $t('deliveryArea') }}</label>
          <input v-model="area" type="text" :placeholder="$t('enterDeliveryArea')" />
        </div>
        <button type="submit" class="register-btn">{{ $t('register') }}</button>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';
import { RouterLink, useRouter } from 'vue-router';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

const router = useRouter();

const userName = ref('');
const passWord = ref('');
const realName = ref('');
const phone = ref('');
const workNo = ref('');
const area = ref('');

const handleRegister = async () => {
  try {
    const params = new URLSearchParams();
    params.append('userName', userName.value);
    params.append('passWord', passWord.value);
    params.append('realName', realName.value);
    params.append('phone', phone.value);
    // 只在有值时添加可选字段，避免空字符串触发唯一约束冲突
    if (workNo.value && workNo.value.trim()) {
      params.append('workNo', workNo.value.trim());
    }
    if (area.value && area.value.trim()) {
      params.append('area', area.value.trim());
    }

    const response = await axios.post('/api/rider/register', params, {
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    });
    
    console.log('注册响应:', response.data);
    
    if (response.data.code === 200) {
      alert(t('registerSuccess'));
      router.push('/rider/login');
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('注册失败:', error.response?.data || error.message);
    alert('注册失败：' + (error.response?.data?.message || error.message));
  }
};
</script>

<style scoped>
.register-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.register-box {
  background: white;
  padding: 40px;
  border-radius: 10px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
  width: 400px;
}

.register-box h2 {
  text-align: center;
  margin-bottom: 30px;
  color: #333;
}

.form-group {
  margin-bottom: 16px;
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

.register-btn {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  cursor: pointer;
  margin-top: 10px;
}

.register-btn:hover {
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
</style>