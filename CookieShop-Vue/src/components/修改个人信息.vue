<template>
  <div class="box">
    <h1>{{ $t('editProfileTitle') }}</h1>

    <form @submit.prevent="handleSubmit" class="form-container">
      <p><strong>{{ $t('userId') }}:</strong> {{ formData.id }}</p>

      <div class="form-group">
        <label for="userName">{{ $t('userName') }}:</label>
        <input
          type="text"
          id="userName"
          v-model="formData.userName"
          required
          class="form-input"
        />
      </div>

      <div class="form-group">
        <label for="name">{{ $t('name') }}:</label>
        <input
          type="text"
          id="name"
          v-model="formData.name"
          required
          class="form-input"
        />
      </div>

      <div class="form-group">
        <label for="email">{{ $t('email') }}:</label>
        <input
          type="text"
          id="email"
          v-model="formData.email"
          required
          class="form-input"
        />
      </div>

      <div class="form-group">
        <label for="phone">{{ $t('phone') }}:</label>
        <input
          type="text"
          id="phone"
          v-model="formData.phone"
          required
          class="form-input"
        />
      </div>

      <div class="form-group">
        <label for="address">{{ $t('address') }}:</label>
        <input
          type="text"
          id="address"
          v-model="formData.address"
          required
          class="form-input"
        />
      </div>

      <div class="form-actions">
        <button type="submit" class="btn-submit">{{ $t('saveChanges') }}</button>
        <router-link to="/profile" class="btn-cancel">{{ $t('cancelBack') }}</router-link>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()
const route = useRoute()
const router = useRouter()

const formData = ref({
  id: null,
  userName: '',
  name: '',
  email: '',
  phone: '',
  address: '',

  
})

// 1. 从 URL 获取 id
const userId = route.params.id

// 2. 加载当前用户数据（从 store 获取）
const loadUser = async () => {
  try {
    if (!userStore.id || String(userStore.id) !== String(userId)) {
      throw new Error('未找到该用户')
    }
    formData.value = {
      id: userStore.id,
      userName: userStore.userName || '',
      name: userStore.name || '',
      email: userStore.email || '',
      phone: userStore.phone || '',
      address: userStore.address || ''
    }
  } catch (error) {
    console.error('加载用户失败:', error)
    alert('无法加载用户信息')
    router.push('/profile')
  }
}

// 3. 提交修改
const handleSubmit = async () => {
  if (!window.confirm(`确定要修改个人信息吗？ `)) {
    return // 用户点击“取消”，直接退出
  }
  try {
    const res = await axios.post('/api/updateUser', null, {
      params: {
        id: formData.value.id,
        username: formData.value.userName,
        name: formData.value.name,
        email: formData.value.email,
        phone: formData.value.phone,
        address: formData.value.address,
 
      }
    })

    if (res.data.code === 0) {
      alert('修改成功！')
      userStore.updateUser({
        id: formData.value.id,
        userName: formData.value.userName,
        name: formData.value.name,
        email: formData.value.email,
        phone: formData.value.phone,
        address: formData.value.address,})
      router.push('/profile')
    } else {
      alert('修改失败：' + res.data.msg)
    }
  } catch (error) {
    console.error('请求失败:', error)
    alert('网络异常，请检查后端服务')
  }
}

onMounted(() => {
  if (userId) {
    loadUser()
  } else {
    alert('无效的用户 ID')
    router.push('/profile')
  }
})
</script>


<style scoped>
.box {
  width: 75%;
  margin: 40px auto;
  font-size: 16px;
}

h1 {
  margin-bottom: 24px;
  color: #333;
  font-size: 28px;
  font-weight: bold;
}

.form-container {
  background-color: #f9f9f9;
  padding: 24px;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  border: 1px solid #eee;
}

.form-group {
  margin-bottom: 16px;
}

.form-group label {
  display: block;
  margin-bottom: 6px;
  font-weight: 500;
  color: #333;
}

.form-input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 14px;
  box-sizing: border-box;
}

.form-actions {
  display: flex;
  gap: 16px;
  margin-top: 20px;
}

.btn-submit {
  padding: 10px 20px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
  transition: background-color 0.2s;
}

.btn-submit:hover {
  background-color: #45a049;
}

.btn-cancel {
  text-decoration: none;
  color: #666;
  padding: 10px 20px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background-color: transparent;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
}

.btn-cancel:hover {
  background-color: #f0f0f0;
  color: #333;
}
</style>