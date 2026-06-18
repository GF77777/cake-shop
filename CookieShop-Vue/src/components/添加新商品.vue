<template>
  <div class="add-goods-container">
    <div class="add-goods-card">
      <h1 class="page-title">{{ $t('addGoodsTitle') }}</h1>

      <form @submit.prevent="handleSubmit" class="goods-form">
        <!-- 商品名称 -->
        <div class="form-group">
          <label for="name" class="form-label">{{ $t('goodsName') }} *</label>
          <input
            id="name"
            v-model="formData.name"
            type="text"
            class="form-input"
            :placeholder="$t('goodsNamePlaceholder')"
            required
          />
        </div>

        <!-- 封面图 -->
        <div class="form-group">
          <label class="form-label">{{ $t('coverImage') }} *</label>
          <div class="upload-area" @click="openFileDialog('cover')" @dragover.prevent @drop.prevent="onDrop($event, 'cover')">
            <input type="file" id="cover-input" class="hidden-input" accept="image/*" />
            <div v-if="!preview.cover" class="upload-placeholder">
              <div class="upload-icon">📷</div>
              <span>{{ $t('uploadCover') }}</span>
            </div>
            <div v-else class="image-preview">
              <img :src="preview.cover" alt="封面预览" />
              <button type="button" class="remove-btn" @click.stop="clearImage('cover')">×</button>
            </div>
          </div>
        </div>

        <!-- 详情图1 -->
        <div class="form-group">
          <label class="form-label">{{ $t('detailImage1') }} *</label>
          <div class="upload-area" @click="openFileDialog('image1')" @dragover.prevent @drop.prevent="onDrop($event, 'image1')">
            <input type="file" id="image1-input" class="hidden-input" accept="image/*" />
            <div v-if="!preview.image1" class="upload-placeholder">
              <div class="upload-icon">📷</div>
              <span>{{ $t('uploadDetail1') }}</span>
            </div>
            <div v-else class="image-preview">
              <img :src="preview.image1" alt="详情图1预览" />
              <button type="button" class="remove-btn" @click.stop="clearImage('image1')">×</button>
            </div>
          </div>
        </div>

        <!-- 详情图2 -->
        <div class="form-group">
          <label class="form-label">{{ $t('detailImage2') }}</label>
          <div class="upload-area" @click="openFileDialog('image2')" @dragover.prevent @drop.prevent="onDrop($event, 'image2')">
            <input type="file" id="image2-input" class="hidden-input" accept="image/*" />
            <div v-if="!preview.image2" class="upload-placeholder">
              <div class="upload-icon">📷</div>
              <span>{{ $t('uploadDetail2') }}</span>
            </div>
            <div v-else class="image-preview">
              <img :src="preview.image2" alt="详情图2预览" />
              <button type="button" class="remove-btn" @click.stop="clearImage('image2')">×</button>
            </div>
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
            :placeholder="$t('pricePlaceholder')"
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
            :placeholder="$t('descriptionPlaceholder')"
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
            :placeholder="$t('stockPlaceholder')"
            required
          />
        </div>

        <!-- 类型ID -->
        <div class="form-group">
          <label for="typeId" class="form-label">{{ $t('category') }} *</label>
          <select
            id="typeId"
            v-model.number="formData.typeId"
            class="form-input"
            required
          >
            <option value="" disabled>{{ $t('selectCategory') }}</option>
            <option v-for="type in goodsTypes" :key="type.id" :value="type.id">
              {{ type.name }}
            </option>
          </select>
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('addProduct') }}</button>
          <router-link to="/admin/products" class="btn btn-secondary">{{ $t('backToProducts') }}</router-link>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue';
import axios from 'axios';
import { useRouter } from 'vue-router'

const router = useRouter()

// 表单数据（存储相对路径）
const formData = reactive({
  name: '',
  cover: '',
  image1: '',
  image2: '',
  price: '',
  intro: '',
  stock: '',
  typeId: '',
})

// 预览数据（存储完整URL用于显示）
const preview = reactive({
  cover: '',
  image1: '',
  image2: '',
})

// 商品类型列表
const goodsTypes = ref([])

// 获取商品类型列表
const loadGoodsTypes = async () => {
  try {
    const res = await axios.get('/api/types')
    if (res.data.code === 200) {
      goodsTypes.value = res.data.data
    }
  } catch (error) {
    console.error('获取商品类型失败:', error)
  }
}

// 组件挂载时加载商品类型
onMounted(() => {
  loadGoodsTypes()
})

// 打开文件选择对话框
const openFileDialog = (field) => {
  const input = document.getElementById(`${field}-input`)
  input.onchange = async (e) => {
    const file = e.target.files[0]
    if (file) {
      await uploadAndSave(file, field)
    }
    e.target.value = ''
  }
  input.click()
}

// 处理拖拽上传
const onDrop = async (event, field) => {
  const file = event.dataTransfer.files[0]
  if (file && file.type.startsWith('image/')) {
    await uploadAndSave(file, field)
  }
}

// 上传文件并保存路径
const uploadAndSave = async (file, field) => {
  const fd = new FormData()
  fd.append('file', file)
  
  try {
    const res = await axios.post('/api/upload', fd, {
      headers: { 'Content-Type': 'multipart/form-data' }
    })
    
    if (res.data.code === 200) {
      // 保存相对路径到表单数据
      formData[field] = res.data.data
      // 保存完整URL到预览
      preview[field] = 'http://localhost:8080' + res.data.data
    } else {
      alert('上传失败：' + res.data.message)
    }
  } catch (error) {
    console.error('上传失败:', error)
    alert('上传失败，请检查后端服务')
  }
}

// 清除图片
const clearImage = (field) => {
  formData[field] = ''
  preview[field] = ''
}

// 提交表单
const handleSubmit = async () => {
  try {
    if (!formData.name || !formData.cover || !formData.image1) {
      alert('请填写必填字段：商品名称、封面图、详情图1')
      return
    }
    
    const price = parseFloat(formData.price)
    if (isNaN(price) || price < 0 || price > 999999.99) {
      alert('请输入有效的价格（0-999999.99）')
      return
    }
    
    const postData = {
      name: formData.name,
      cover: formData.cover,
      image1: formData.image1,
      image2: formData.image2,
      price: Number(formData.price),
      intro: formData.intro,
      stock: Number(formData.stock),
      typeId: Number(formData.typeId)
    }
    
    console.log('提交数据:', postData)
    
    const res = await axios.post('/api/addGoods', postData)

    if (res.data.code === 200) {
      alert('添加成功！')
      router.push('/admin/products')
    } else {
      alert('添加失败：' + res.data.message)
    }
  } catch (error) {
    console.error('请求失败:', error.response?.data || error.message)
    alert('网络异常，请检查后端服务')
  }
}
</script>

<style scoped>
.add-goods-container {
  display: flex;
  justify-content: center;
  padding: 24px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

.add-goods-card {
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

.hidden-input {
  display: none;
}

.upload-area {
  position: relative;
  border: 2px dashed #ddd;
  border-radius: 8px;
  padding: 24px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s;
  background: #fafafa;
}

.upload-area:hover {
  border-color: #3498db;
  background: #f0f8ff;
}

.upload-placeholder {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: #666;
}

.upload-icon {
  font-size: 36px;
}

.image-preview {
  position: relative;
  width: 150px;
  height: 150px;
  margin: 0 auto;
  border-radius: 8px;
  overflow: hidden;
  border: 1px solid #ddd;
}

.image-preview img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.remove-btn {
  position: absolute;
  top: 4px;
  right: 4px;
  width: 24px;
  height: 24px;
  border: none;
  border-radius: 50%;
  background: rgba(0, 0, 0, 0.6);
  color: white;
  font-size: 18px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.remove-btn:hover {
  background: rgba(231, 76, 60, 0.8);
}

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
}

.btn-primary {
  background-color: #2ecc71;
  color: white;
}

.btn-primary:hover {
  background-color: #27ae60;
}

.btn-secondary {
  background-color: #e9ecef;
  color: #495057;
}

.btn-secondary:hover {
  background-color: #dfe3e6;
}
</style>
