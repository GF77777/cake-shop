<template>
  <div class="edit-order-container">
    <div class="edit-order-card">
      <h1 class="page-title">{{ $t('editOrderTitle') }}</h1>

      <form @submit.prevent="handleSubmit" class="order-form">
        <!-- 订单ID（只读） -->
        <div class="form-group">
          <label class="form-label">{{ $t('orderId') }}</label>
          <div class="readonly-value">{{ formData.orderId }}</div>
        </div>

        <!-- 订单状态 -->
        <div class="form-group">
          <label for="status" class="form-label">{{ $t('status') }} *</label>
          <select
            id="status"
            v-model="formData.status"
            class="form-select"
            required
          >
            <option :value="0">已付款(未发货)</option>
            <option :value="1">已发货</option>
            <option :value="2">配送中</option>
            <option :value="3">已送达</option>
            <option :value="4">已完成</option>
            <option :value="5">已取消</option>
          </select>
        </div>

        <!-- 支付方式 -->
        <div class="form-group">
          <label for="payType" class="form-label">{{ $t('payType') }} *</label>
          <select
            id="payType"
            v-model="formData.payType"
            class="form-select"
            required
          >
            <option :value="0">{{ $t('wechatPay') }}</option>
            <option :value="1">{{ $t('alipay') }}</option>
            <option :value="2">{{ $t('bankCard') }}</option>
          </select>
        </div>

        <!-- 收货人姓名 -->
        <div class="form-group">
          <label for="name" class="form-label">{{ $t('receiverName') }} *</label>
          <input
            id="name"
            v-model="formData.name"
            type="text"
            class="form-input"
            :placeholder="$t('enterReceiverName')"
            required
          />
        </div>

        <!-- 收货人电话 -->
        <div class="form-group">
          <label for="phone" class="form-label">{{ $t('contactPhone') }} *</label>
          <input
            id="phone"
            v-model="formData.phone"
            type="tel"
            class="form-input"
            :placeholder="$t('enterPhone')"
            required
          />
        </div>

        <!-- 收货地址 -->
        <div class="form-group">
          <label for="address" class="form-label">{{ $t('shippingAddress') }} *</label>
          <input
            id="address"
            v-model="formData.address"
            type="text"
            class="form-input"
            :placeholder="$t('enterAddress')"
            required
          />
        </div>

        <!-- 操作按钮 -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">{{ $t('saveChanges') }}</button>
          <router-link to="/admin/orders" class="btn btn-secondary">{{ $t('cancelBack') }}</router-link>
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
  orderId: null,

  status:null,
  payType:null,
  name: '',
  phone: '',
  address: '',
  
  
})

// 1. 从 URL 获取 id
const orderId = route.params.orderId

// 2. 加载当前订单数据
const loadOrder = async () => {
  try {
    const res = await axios.get('/api/orderDetail', { params: { orderId } })
    
    if (res.data.code !== 200) {
      throw new Error(res.data.message || '未找到该订单')
    }
    
    const data = res.data.data
    if (!data || !data.order) {
      throw new Error('未找到该订单')
    }
    
    const target = data.order
    formData.value = {
      orderId: target.orderId,
      status: target.status,
      payType: target.payType,
      name: target.name,
      phone: target.phone,
      address: target.address
    }

  } catch (error) {
    console.error('加载订单失败:', error)
    alert('无法加载该订单')
    router.push('/admin/orders')
  }
}

// 3. 提交修改
const handleSubmit = async () => {
  if (!window.confirm(`确定要修改订单信息吗？ `)) {
    return // 用户点击“取消”，直接退出
  }
  try {
    const res = await axios.post('/api/updateOrder', null, {
      params: {

        orderId: formData.value.orderId,
        status: formData.value.status,
        payType: formData.value.payType,
        name: formData.value.name,
        phone: formData.value.phone,
        address: formData.value.address,


      }
    })

    if (res.data.code === 200) {
      alert('修改成功！')
      router.push('/admin/orders')
    } else {
      alert('修改失败：' + (res.data.msg || res.data.message))
    }
  } catch (error) {
    console.error('请求失败:', error)
    alert('网络异常，请检查后端服务')
  }
}

onMounted(() => {
  if (orderId) {
    loadOrder()
  } else {
    alert('无效的订单 ID')
    router.push('/admin/orders')
  }
})
</script>


<style scoped>
.edit-order-container {
  display: flex;
  justify-content: center;
  padding: 24px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

.edit-order-card {
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
.form-select {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ced4da;
  border-radius: 6px;
  font-size: 16px;
  transition: border-color 0.2s;
}

.form-input:focus,
.form-select:focus {
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
  .edit-order-card {
    padding: 20px;
  }

  .form-actions {
    flex-direction: column;
  }
}
</style>