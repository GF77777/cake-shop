<template>
  <div class="edit-category-container">
    <div class="edit-category-card">
      <h1 class="page-title">{{ $t('editCategoryTitle') }}</h1>

      <form @submit.prevent="handleSubmit" class="category-form">
        <!-- 类目ID（只读） -->
        <div class="form-group">
          <label class="form-label">{{ $t('categoryId') }}</label>
          <div class="readonly-value">{{ formData.id }}</div>
        </div>

        <!-- 类目名称 -->
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

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('saveChanges') }}</button>
          <router-link to="/admin/categories" class="btn btn-secondary">{{ $t('cancelBack') }}</router-link>
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
  name: ''
})

// 1. 从 URL 获取 id（例如 /修改类目/5）
const categoryId = route.params.id

// 2. 加载当前类目数据
const loadCategory = async () => {
  try {
    const res = await axios.get(`/api/types?id=${categoryId}`) // 假设 GET /types/:id
    // 或者用查询参数：`/api/types?id=${categoryId}`
    // formData.value = res.data.data

    
    const list = res.data.data || []
    const target = list.find(item => String(item.id) === String(categoryId))
    if (!target) {
      throw new Error('未找到该类目')
    }
    formData.value = target

  } catch (error) {
    console.error('加载类目失败:', error)
    alert('无法加载该类目')
    router.push('/admin/categories')
  }
}

// 3. 提交修改
const handleSubmit = async () => {
  try {
    const res = await axios.post('/api/updateTypes', {
      id: formData.value.id,
      name: formData.value.name
    })

    if (res.data.code === 200) {
      alert('修改成功！')
      router.push('/admin/categories')
    } else {
      alert('修改失败：' + res.data.message)
    }
  } catch (error) {
    console.error('请求失败:', error)
    alert('网络异常，请检查后端服务')
  }
}

onMounted(() => {
  if (categoryId) {
    loadCategory()
  } else {
    alert('无效的类目 ID')
    router.push('/admin/categories')
  }
})
</script>


<style scoped>
.edit-category-container {
  margin-top: 100px;
  display: flex;
  justify-content: center;
  padding: 10px 24px;
  height: 500px;
  background-color: #f8f9fa;
}

.edit-category-card {
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

.readonly-value {
  padding: 10px 12px;
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 6px;
  color: #6c757d;
  font-family: monospace;
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