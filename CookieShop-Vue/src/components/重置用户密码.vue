<template>
  <div class="reset-password-container">
    <div class="reset-password-card">
      <h1 class="page-title">{{ $t('resetUserPassword') }}</h1>

      <form @submit.prevent="handleSubmit" class="password-form">
        <!-- 用户信息只读展示 -->
        <div class="info-row">
          <span class="label">{{ $t('userId') }}：</span>
          <span class="value">{{ formData.id }}</span>
        </div>
        <div class="info-row">
          <span class="label">{{ $t('name') }}：</span>
          <span class="value">{{ formData.name }}</span>
        </div>

        <!-- 密码输入 -->
        <div class="form-group">
          <label for="password" class="form-label">{{ $t('newPassword') }}</label>
          <input
            id="password"
            v-model="formData.password"
            type="password"
            class="form-input"
            :placeholder="$t('enterNewPassword')"
            required 
          />
          
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('saveChanges') }}</button>
          <router-link to="/admin/users" class="btn btn-secondary">{{ $t('cancelBack') }}</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import axios from 'axios'

const route = useRoute()
const router = useRouter()

const formData = ref({
  id: null,
  name: '',
  password: ''
})

// 1. 从 URL 获取 id
const userId = route.params.id

// 2. 加载当前用户数据
const loadUser = async () => {
  try {
    const res = await axios.get(`/api/users?id=${userId}`)
    
    let list = []
    const data = res.data.data
    
    if (Array.isArray(data)) {
      list = data
    } else if (data && Array.isArray(data.list)) {
      list = data.list
    }
    
    const target = list.find(item => String(item.id) === String(userId))
    if (!target) {
      throw new Error('未找到该用户')
    }
    formData.value = {
      id: target.id,
      name: target.name || '',
      password: ''
    }

  } catch (error) {
    console.error('加载用户失败:', error)
    alert('无法加载该用户')
    router.push('/admin/users')
  }
}

// 3. 提交修改
const handleSubmit = async () => {
  if (!window.confirm(`确定要将用户 "${formData.value.name}" 的密码修改为 "${formData.value.password}" 吗？`)) {
    return // 用户点击“取消”，直接退出
  }
  try {
    const res = await axios.post('/api/updatePassword', {
      id: formData.value.id,
      passWord: formData.value.password
    })

    if (res.data.code === 200) {
      alert('修改成功！')
      router.push('/admin/users')
    } else {
      alert('修改失败：' + res.data.message)
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
    router.push('/admin/users')
  }
})
</script>

<style scoped>
.reset-password-container {
  margin-top: 100px;
  display: flex;
  justify-content: center;
  padding: 24px;
  height: 500px;
  background-color: #f8f9fa;
}

.reset-password-card {
  width: 100%;
  max-width: 500px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 32px;
}

.page-title {
  text-align: center;
  color: #333;
  margin-bottom: 28px;
  font-size: 24px;
  font-weight: 600;
}

.info-row {
  display: flex;
  margin-bottom: 16px;
  padding: 10px 0;
  border-bottom: 1px dashed #eee;
}

.label {
  font-weight: 600;
  color: #555;
  width: 100px;
}

.value {
  color: #333;
}

.form-group {
  margin: 24px 0;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  font-weight: 600;
  color: #333;
}

.form-input {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ced4da;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.2s;
}

.form-input:focus {
  outline: none;
  border-color: #3498db;
  box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
}

.hint {
  font-size: 13px;
  color: #6c757d;
  margin-top: 6px;
}

.form-actions {
  display: flex;
  gap: 16px;
  margin-top: 24px;
}

.btn {
  flex: 1;
  padding: 10px;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  text-align: center;
  text-decoration: none;
  transition: all 0.2s;
}

.btn-primary {
  background-color: #3498db;
  color: white;
}

.btn-primary:hover {
  background-color: #2980b9;
}

.btn-secondary {
  background-color: #e9ecef;
  color: #495057;
}

.btn-secondary:hover {
  background-color: #dfe3e6;
}


</style>