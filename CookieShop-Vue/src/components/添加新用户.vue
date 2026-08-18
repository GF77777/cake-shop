<template>
  <div class="add-user-container">
    <div class="add-user-card">
      <h1 class="page-title">{{ $t('addNewUser') }}</h1>

      <form @submit.prevent="handleSubmit" class="user-form">
        <!-- 用户名 -->
        <div class="form-group">
          <label for="username" class="form-label">{{ $t('userName') }} *</label>
          <input
            id="username"
            v-model="formData.username"
            type="text"
            class="form-input"
            :placeholder="$t('enterUsername')"
            required
          />
        </div>

        <!-- 密码 -->
        <div class="form-group">
          <label for="password" class="form-label">{{ $t('password') }} *</label>
          <input
            id="password"
            v-model="formData.password"
            type="password"
            class="form-input"
            :placeholder="$t('enterPassword')"
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
              id="isadmin"
              type="checkbox"
              v-model="formData.isadmin"
              true-value="1"
              false-value="0"
            />
            <label for="isadmin" class="switch"></label>
            <span class="toggle-text">
              {{ formData.isadmin === '1' ? $t('yes') : $t('no') }}
            </span>
          </div>
        </div>

        <!-- 账号是否有效 -->
        <div class="form-group toggle-group">
          <label class="form-label">{{ $t('accountStatus') }}</label>
          <div class="toggle-switch">
            <input
              id="isvalidate"
              type="checkbox"
              v-model="formData.isvalidate"
              true-value="0"
              false-value="1"
            />
            <label for="isvalidate" class="switch"></label>
            <span class="toggle-text">
              {{ formData.isvalidate === '0' ? $t('valid') : $t('invalid') }}
            </span>
          </div>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('addUser') }}</button>
          <router-link to="/admin/users" class="btn btn-secondary">{{ $t('cancelBack') }}</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import axios from 'axios';

import { useRouter } from 'vue-router'
const router = useRouter()

// 表单数据
const formData = ref({
  username:'',
  password: '',
  name: '',
  email: '',
  phone: '',
  address: '',
  isadmin: '0',
  isvalidate: '0',
})

// 提交表单
const handleSubmit = async () => {
  try {
    // 发送 POST 请求
    const res = await axios.post('/api/adduser', {
      userName: formData.value.username,
      passWord: formData.value.password,
      name: formData.value.name,
      email: formData.value.email,
      phone: formData.value.phone,
      address: formData.value.address,
      isAdmin: parseInt(formData.value.isadmin),
      isValidate: parseInt(formData.value.isvalidate)
    });

    if (res.data.code === 200) {
      alert('添加成功！')
      router.push('/admin/users') // 跳转回列表页
    } else {
      alert('添加失败：' + res.data.message)
    }
  } catch (error) {
    console.error('请求失败:', error)
    alert('网络异常，请检查后端服务')
  }
}
</script>


<style scoped>
/* 全局容器 */
.add-user-container {
  display: flex;
  justify-content: center;
  padding: 24px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

/* 卡片 */
.add-user-card {
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

/* 自定义开关（复用你已有的样式）*/
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
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
}

input[type='checkbox'] {
  opacity: 0;
  position: absolute;
}

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

/* 手机端适配 */
@media (max-width: 600px) {
  .add-user-card {
    padding: 20px;
  }

  .form-actions {
    flex-direction: column;
  }

  .toggle-group {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>