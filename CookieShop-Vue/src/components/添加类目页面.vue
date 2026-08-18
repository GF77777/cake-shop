<template>
  <div class="add-category-container">
    <div class="add-category-card">
      <h1 class="page-title">{{ $t('addNewCategory') }}</h1>

      <form @submit.prevent="handleSubmit" class="category-form">
        <div class="form-group">
          <label for="typeName" class="form-label">{{ $t('categoryName') }} *</label>
          <input
            id="typeName"
            v-model="formData.name"
            type="text"
            class="form-input"
            :placeholder="$t('enterCategoryName')"
            required
          />
        </div>

        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('addCategory') }}</button>
          <router-link to="/admin/categories" class="btn btn-secondary">{{ $t('cancelBack') }}</router-link>
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
  name: ''
})

// 提交表单
const handleSubmit = async () => {
  try {
    // 发送 POST 请求
    const res = await axios.post('/api/types', {
      name: formData.value.name
    });

    if (res.data.code === 200) {
      alert('添加成功！')
      router.push('/admin/categories') // 跳转回列表页
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
.add-category-container {
  margin-top: 100px;
  display: flex;
  justify-content: center;
  padding: 24px;
  height: 500px;
  background-color: #f8f9fa;
}

.add-category-card {
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

.form-group {
  margin-bottom: 24px;
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

.form-actions {
  display: flex;
  gap: 16px;
  margin-top: 20px;
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