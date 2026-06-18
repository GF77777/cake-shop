<template>
  <div class="edit-profile-container">
    <!-- 顶部标题栏 -->
    <header class="header">
      <button class="back-btn" @click="goBack">←</button>
      <h1>编辑个人信息</h1>
      <span class="placeholder"></span>
    </header>

    <!-- 表单区域 -->
    <form class="form-container" @submit.prevent="submitForm">
      <div class="form-item">
        <label class="form-label">
          <span class="label-icon">👤</span>
          <span>真实姓名</span>
        </label>
        <input 
          type="text" 
          class="form-input" 
          v-model="formData.realName" 
          placeholder="请输入真实姓名"
          required
        />
      </div>

      <div class="form-item">
        <label class="form-label">
          <span class="label-icon">📱</span>
          <span>手机号</span>
        </label>
        <input 
          type="tel" 
          class="form-input" 
          v-model="formData.phone" 
          placeholder="请输入手机号"
          required
        />
      </div>

      <div class="form-item">
        <label class="form-label">
          <span class="label-icon">📍</span>
          <span>配送区域</span>
        </label>
        <input 
          type="text" 
          class="form-input" 
          v-model="formData.area" 
          placeholder="请输入配送区域"
        />
      </div>

      <div class="form-item">
        <label class="form-label">
          <span class="label-icon">🆔</span>
          <span>工号</span>
        </label>
        <input 
          type="text" 
          class="form-input" 
          v-model="formData.workNo" 
          placeholder="请输入工号"
        />
      </div>

      <!-- 提交按钮 -->
      <button type="submit" class="submit-btn" :disabled="isSubmitting">
        <span v-if="isSubmitting">保存中...</span>
        <span v-else>保存修改</span>
      </button>
    </form>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';

const formData = ref({
  id: '',
  realName: '',
  phone: '',
  area: '',
  workNo: ''
});

const isSubmitting = ref(false);

const getRiderInfo = () => {
  const riderStr = localStorage.getItem('rider');
  if (riderStr) {
    const rider = JSON.parse(riderStr);
    formData.value.id = rider.id;
    formData.value.realName = rider.realName || '';
    formData.value.phone = rider.phone || '';
    formData.value.area = rider.area || '';
    formData.value.workNo = rider.workNo || '';
  }
};

const submitForm = async () => {
  if (!formData.value.realName.trim()) {
    alert('请输入真实姓名');
    return;
  }
  if (!formData.value.phone.trim()) {
    alert('请输入手机号');
    return;
  }

  isSubmitting.value = true;

  try {
    const response = await axios.post('/api/rider/updateInfo', {
      id: formData.value.id,
      realName: formData.value.realName.trim(),
      phone: formData.value.phone.trim(),
      area: formData.value.area.trim(),
      workNo: formData.value.workNo.trim()
    });

    if (response.data.code === 200) {
      alert('修改成功');
      // 更新本地存储的骑手信息
      const riderStr = localStorage.getItem('rider');
      if (riderStr) {
        const rider = JSON.parse(riderStr);
        rider.realName = formData.value.realName.trim();
        rider.phone = formData.value.phone.trim();
        rider.area = formData.value.area.trim();
        rider.workNo = formData.value.workNo.trim();
        localStorage.setItem('rider', JSON.stringify(rider));
      }
      goBack();
    } else {
      alert(response.data.message || '修改失败');
    }
  } catch (error) {
    console.error('修改失败', error);
    alert('修改失败，请检查网络');
  } finally {
    isSubmitting.value = false;
  }
};

const goBack = () => {
  window.location.href = '#/rider/profile';
};

onMounted(() => {
  getRiderInfo();
});
</script>

<style scoped>
.edit-profile-container {
  min-height: 100vh;
  background: #f5f5f5;
}

/* 顶部标题栏 */
.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 15px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.back-btn {
  background: transparent;
  border: none;
  color: white;
  font-size: 20px;
  cursor: pointer;
  padding: 5px 10px;
}

.back-btn:hover {
  opacity: 0.8;
}

.header h1 {
  margin: 0;
  font-size: 18px;
  font-weight: 500;
}

.placeholder {
  width: 40px;
}

/* 表单区域 */
.form-container {
  padding: 20px;
}

.form-item {
  background: white;
  border-radius: 8px;
  padding: 15px;
  margin-bottom: 15px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.form-label {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  color: #666;
  margin-bottom: 10px;
}

.label-icon {
  font-size: 14px;
}

.form-input {
  width: 100%;
  padding: 12px;
  border: 1px solid #e0e0e0;
  border-radius: 6px;
  font-size: 14px;
  outline: none;
  transition: border-color 0.2s;
  box-sizing: border-box;
}

.form-input:focus {
  border-color: #667eea;
}

.form-input::placeholder {
  color: #ccc;
}

/* 提交按钮 */
.submit-btn {
  width: 100%;
  padding: 15px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  margin-top: 10px;
  transition: opacity 0.2s;
}

.submit-btn:hover:not(:disabled) {
  opacity: 0.9;
}

.submit-btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
</style>