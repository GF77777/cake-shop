<template>
  <div class="add-recommend-container">
    <div class="add-recommend-card">
      <h1 class="page-title">{{ $t('addToRecommend') }}</h1>

      <form @submit.prevent="handleSubmit" class="recommend-form">
        <!-- 商品ID（只读） -->
        <div class="form-group">
          <label class="form-label">{{ $t('goodsId') }}</label>
          <div class="readonly-value">{{ formData.id }}</div>
        </div>

        <!-- 推荐类型 -->
        <div class="form-group">
          <label for="type" class="form-label">{{ $t('recommendType') }} *</label>
          <select
            id="type"
            v-model.number="formData.type"
            class="form-select"
            required
          >
            <option value="" disabled>{{ $t('selectRecommendType') }}</option>
            <option :value="0">{{ $t('horizontalRecommend') }}</option>
            <option :value="1">{{ $t('hotRecommend') }}</option>
            <option :value="2">{{ $t('newRecommend') }}</option>
          </select>
          <div class="help-text">{{ $t('recommendTypeHelp') }}</div>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('addToRecommend') }}</button>
          <router-link to="/admin/products" class="btn btn-secondary">{{ $t('cancelBack') }}</router-link>
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
  type: null,
 
  
})

// 1. 从 URL 获取 id（例如 /修改类目/5）
const categoryId = route.params.id

// 2. 加载当前类目数据
const loadCategory = async () => {
  try {
    const res = await axios.get(`/api/goods?id=${categoryId}`) 

    const list = res.data.data || []
    const target = list.find(item => String(item.id) === String(categoryId))
    if (!target) {
      throw new Error('未找到该商品')
    }
    formData.value = target

  } catch (error) {
    console.error('加载商品失败:', error)
    alert('无法加载该商品')
    router.push('/admin/products')
  }
}

// 3. 提交修改
const handleSubmit = async () => {
  if (!window.confirm(`确定要添加商品至推荐表吗？ `)) {
    return // 用户点击“取消”，直接退出
  }
  try {
    const res = await axios.post('/api/addRecommend', {
      type: formData.value.type,
      goodId: formData.value.id
    })

    if (res.data.code === 200) {
      alert('添加成功！')
      router.push('/admin/products')
    } else {
      alert('添加失败：' + res.data.message)
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
    alert('无效的商品 ID')
    router.push('/admin/products')
  }
})
</script>


<style scoped>
.add-recommend-container {
  display: flex;
  justify-content: center;
  padding: 24px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

.add-recommend-card {
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
  margin-bottom: 20px;
}

.form-label {
  display: block;
  margin-bottom: 8px;
  font-weight: 600;
  color: #333;
}

.readonly-value {
  padding: 10px 12px;
  background-color: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 6px;
  color: #6c757d;
  font-family: monospace;
}

.form-select {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ced4da;
  border-radius: 6px;
  font-size: 16px;
  background-color: white;
  cursor: pointer;
}

.form-select:focus {
  outline: none;
  border-color: #3498db;
  box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
}

.help-text {
  margin-top: 6px;
  font-size: 13px;
  color: #6c757d;
}

/* 操作按钮 */
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
  background-color: #9b59b6; /* 紫色，突出“推荐”主题 */
  color: white;
}
.btn-primary:hover {
  background-color: #8e44ad;
}

.btn-secondary {
  background-color: #e9ecef;
  color: #495057;
}
.btn-secondary:hover {
  background-color: #dfe3e6;
}


</style>