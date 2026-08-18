<template>
  <div class="edit-user-container">
    <div class="edit-user-card">
      <h1 class="page-title">{{ $t('editUserTitle') }}</h1>

      <form @submit.prevent="handleSubmit" class="user-form">
        <!-- 用户ID（只读） -->
        <div class="form-group">
          <label class="form-label">{{ $t('userId') }}</label>
          <div class="readonly-value">{{ formData.id }}</div>
        </div>

        <!-- 用户名 -->
        <div class="form-group">
          <label for="userName" class="form-label">{{ $t('userName') }} *</label>
          <input
            id="userName"
            v-model="formData.userName"
            type="text"
            class="form-input"
            :placeholder="$t('enterUsername')"
            required
          />
        </div>

        <!-- 姓名 -->
        <div class="form-group">
          <label for="name" class="form-label">{{ $t('name') }} *</label>
          <input
            id="name"
            v-model="formData.name"
            type="text"
            class="form-input"
            :placeholder="$t('enterRealName')"
            required
          />
        </div>

        <!-- 邮箱 -->
        <div class="form-group">
          <label for="email" class="form-label">{{ $t('email') }} *</label>
          <input
            id="email"
            v-model="formData.email"
            type="email"
            class="form-input"
            placeholder="example@domain.com"
            required
          />
        </div>

        <!-- 电话 -->
        <div class="form-group">
          <label for="phone" class="form-label">{{ $t('phone') }} *</label>
          <input
            id="phone"
            v-model="formData.phone"
            type="tel"
            class="form-input"
            :placeholder="$t('enterPhone')"
            required
          />
        </div>

        <!-- 地址 -->
        <div class="form-group">
          <label for="address" class="form-label">{{ $t('address') }}</label>
          <input
            id="address"
            v-model="formData.address"
            type="text"
            class="form-input"
            :placeholder="$t('enterAddress')"
          />
        </div>

        <!-- 是否为管理员 -->
        <div class="form-group toggle-group">
          <label class="form-label">{{ $t('isAdmin') }}</label>
          <div class="toggle-switch">
            <input
              id="isAdmin"
              type="checkbox"
              v-model="formData.isAdmin"
              true-value="1"
              false-value="0"
            />
            <label for="isAdmin" class="switch"></label>
            <span class="toggle-text">
              {{ formData.isAdmin === '1' ? $t('yes') : $t('no') }}
            </span>
          </div>
        </div>

        <!-- 账号是否有效 -->
        <div class="form-group toggle-group">
          <label class="form-label">{{ $t('accountStatus') }}</label>
          <div class="toggle-switch">
            <input
              id="isValidate"
              type="checkbox"
              v-model="formData.isValidate"
              true-value="0"
              false-value="1"
            />
            <label for="isValidate" class="switch"></label>
            <span class="toggle-text">
              {{ formData.isValidate === '1' ? $t('invalid') : $t('valid') }}
            </span>
          </div>
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
  userName: '',
  name: '',
  email: '',
  phone: '',
  address: '',
  isAdmin: '0',
  isValidate: '0',
  
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
      userName: target.userName || '',
      name: target.name || '',
      email: target.email || '',
      phone: target.phone || '',
      address: target.address || '',
      isAdmin: String(target.isAdmin),
      isValidate: String(target.isValidate)
    }

  } catch (error) {
    console.error('加载用户失败:', error)
    alert('无法加载该用户')
    router.push('/admin/users')
  }
}

// 3. 提交修改
const handleSubmit = async () => {
  if (!window.confirm(`确定要修改用户信息吗？ `)) {
    return // 用户点击“取消”，直接退出
  }
  try {
    const res = await axios.post('/api/update', {
      id: formData.value.id,
      userName: formData.value.userName,
      name: formData.value.name,
      email: formData.value.email,
      phone: formData.value.phone,
      address: formData.value.address,
      isAdmin: parseInt(formData.value.isAdmin),
      isValidate: parseInt(formData.value.isValidate)
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
/* 全局容器 */
.edit-user-container {
  display: flex;
  justify-content: center;
  padding: 24px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

/* 卡片 */
.edit-user-card {
  width: 100%;
  max-width: 600px;
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

/* 表单组 */
.form-group {
  margin-bottom: 20px;
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

.readonly-value {
  padding: 10px 12px;
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 6px;
  color: #6c757d;
}

/* 自定义开关 */
.toggle-group {
  display: flex;
  align-items: center;
  gap: 12px;
}

.toggle-switch {
  display: flex;
  align-items: center;
  gap: 10px;
}

.switch {
  position: relative;
  display: inline-block;
  width: 48px;
  height: 24px;
  background: #ccc;
  border-radius: 12px;
  cursor: pointer;
  transition: background 0.2s;
}

.switch::before {
  content: '';
  position: absolute;
  top: 2px;
  left: 2px;
  width: 20px;
  height: 20px;
  background: white;
  border-radius: 50%;
  transition: transform 0.2s;
  box-shadow: 0 1px 3px rgba(0,0,0,0.3);
}

/* 隐藏原生 checkbox */
input[type='checkbox'] {
  opacity: 0;
  position: absolute;
}

/* 勾选状态 */
input[type='checkbox']:checked + .switch {
  background: #3498db;
}

input[type='checkbox']:checked + .switch::before {
  transform: translateX(24px);
}

.toggle-text {
  font-size: 14px;
  color: #555;
  min-width: 30px;
  text-align: center;
}

/* 按钮 */
.form-actions {
  display: flex;
  gap: 16px;
  margin-top: 28px;
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