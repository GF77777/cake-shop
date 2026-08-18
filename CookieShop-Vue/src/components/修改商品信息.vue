<template>
  <div class="edit-goods-container">
    <div class="edit-goods-card">
      <h1 class="page-title">{{ $t('editGoodsTitle') }}</h1>

      <form @submit.prevent="handleSubmit" class="goods-form">
        <!-- 商品ID（只读） -->
        <div class="form-group">
          <label class="form-label">{{ $t('goodsId') }}</label>
          <div class="readonly-value">{{ formData.id }}</div>
        </div>

        <!-- 商品名称 -->
        <div class="form-group">
          <label for="name" class="form-label">{{ $t('goodsName') }} *</label>
          <input
            id="name"
            v-model="formData.name"
            type="text"
            class="form-input"
            :placeholder="$t('enterGoodsName')"
            required
          />
        </div>

        <!-- 封面图 -->
        <div class="form-group">
          <label for="cover" class="form-label">{{ $t('coverImage') }} URL *</label>
          <input
            id="cover"
            v-model="formData.cover"
            type="text"
            class="form-input"
            placeholder="https://example.com/cover.jpg"
            required
          />
          <div v-if="formData.cover" class="image-preview small">
            <img :src="formData.cover" alt="封面预览" />
          </div>
        </div>

        <!-- 详情图1 -->
        <div class="form-group">
          <label for="image1" class="form-label">{{ $t('detailImage1') }} URL *</label>
          <input
            id="image1"
            v-model="formData.image1"
            type="text"
            class="form-input"
            placeholder="https://example.com/detail1.jpg"
            required
          />
          <div v-if="formData.image1" class="image-preview small">
            <img :src="formData.image1" alt="详情图1预览" />
          </div>
        </div>

        <!-- 详情图2 -->
        <div class="form-group">
          <label for="image2" class="form-label">{{ $t('detailImage2') }} URL</label>
          <input
            id="image2"
            v-model="formData.image2"
            type="text"
            class="form-input"
            placeholder="https://example.com/detail2.jpg"
          />
          <div v-if="formData.image2" class="image-preview small">
            <img :src="formData.image2" alt="详情图2预览" />
          </div>
        </div>

        <!-- 价格 -->
        <div class="form-group">
          <label for="price" class="form-label">{{ $t('goodsPrice') }} *</label>
          <input
            id="price"
            v-model.number="formData.price"
            type="number"
            step="0.01"
            min="0"
            class="form-input"
            :placeholder="$t('enterPrice')"
            required
          />
        </div>

        <!-- 描述 -->
        <div class="form-group">
          <label for="intro" class="form-label">{{ $t('description') }} *</label>
          <textarea
            id="intro"
            v-model="formData.intro"
            class="form-input"
            rows="3"
            :placeholder="$t('enterDescription')"
            required
          ></textarea>
        </div>

        <!-- 库存 -->
        <div class="form-group">
          <label for="stock" class="form-label">{{ $t('stock') }} *</label>
          <input
            id="stock"
            v-model.number="formData.stock"
            type="number"
            min="0"
            class="form-input"
            :placeholder="$t('enterStock')"
            required
          />
        </div>

        <!-- 类型ID -->
        <div class="form-group">
          <label for="typeId" class="form-label">{{ $t('typeId') }} *</label>
          <input
            id="typeId"
            v-model.number="formData.typeId"
            type="number"
            min="1"
            class="form-input"
            placeholder="例如：1"
            required
          />
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('saveChanges') }}</button>
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

  name: '',
  cover: '',
  image1: '',
  image2: '',
  price: '',
  intro: '',
  stock: '',
  typeId: null,
  
})

// 1. 从 URL 获取 id（例如 /修改类目/5）
const categoryId = route.params.id

// 2. 加载当前类目数据
const loadCategory = async () => {
  try {
    const res = await axios.get(`/api/goods?id=${categoryId}`) // 假设 GET /types/:id
    
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
  if (!window.confirm(`确定要修改商品信息吗？ `)) {
    return // 用户点击“取消”，直接退出
  }
  try {
    const res = await axios.post('/api/updateGoods', {
      id: formData.value.id,
      name: formData.value.name,
      cover: formData.value.cover,
      image1: formData.value.image1,
      image2: formData.value.image2,
      price: formData.value.price,
      intro: formData.value.intro,
      stock: formData.value.stock,
      typeId: formData.value.typeId,
    })

    if (res.data.code === 200) {
      alert('修改成功！')
      router.push('/admin/products')
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
    alert('无效的商品 ID')
    router.push('/admin/products')
  }
})
</script>


<style scoped>
.edit-goods-container {
  display: flex;
  justify-content: center;
  padding: 24px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

.edit-goods-card {
  width: 100%;
  max-width: 650px;
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

.form-input,
.form-input:focus {
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

/* 图片预览 */
.image-preview.small {
  margin-top: 8px;
  width: 80px;
  height: 80px;
  overflow: hidden;
  border-radius: 6px;
  border: 1px solid #ddd;
}
.image-preview.small img {
  width: 100%;
  height: 100%;
  object-fit: cover;
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