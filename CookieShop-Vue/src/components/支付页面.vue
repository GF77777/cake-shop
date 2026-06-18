<template>
  <div class="payment-container">
    <div class="payment-card">
      <h1 class="page-title">{{ $t('paymentTitle') }}</h1>

      <!-- 订单不存在时提示 -->
      <div v-if="!order" class="empty-state">
        <p>{{ $t('orderNotFound') }}</p>
        <button @click="router.push('/products')" class="btn-secondary">{{ $t('backHome') }}</button>
      </div>

      <!-- 表单区域 -->
      <form v-else @submit.prevent="handlePay" class="payment-form">
        <!-- 收货信息 -->
        <section class="form-section">
          <h2>{{ $t('shippingInfo') }}</h2>
          <div class="form-group">
            <label for="name">{{ $t('receiverName') }}</label>
            <input
              id="name"
              v-model="formData.name"
              type="text"
              :placeholder="$t('enterRealName')"
              required
              class="form-input"
            />
          </div>

          <div class="form-group">
            <label for="phone">{{ $t('contactPhone') }}</label>
            <input
              id="phone"
              v-model="formData.phone"
              type="tel"
              :placeholder="$t('enterPhone')"
              required
              class="form-input"
            />
          </div>

          <div class="form-group">
            <label for="address">{{ $t('shippingAddress') }}</label>
            <textarea
              id="address"
              v-model="formData.address"
              :placeholder="$t('enterAddress')"
              required
              rows="3"
              class="form-textarea"
            ></textarea>
          </div>
        </section>

        <!-- 支付方式 -->
        <section class="form-section">
          <h2>{{ $t('paymentMethod') }}</h2>
          <div class="pay-options">
            <label class="pay-option" :class="{ active: formData.paytype === '0' }">
              <input type="radio" v-model="formData.paytype" value="0" />
              <span>{{ $t('wechatPay') }}</span>
            </label>
            <label class="pay-option" :class="{ active: formData.paytype === '1' }">
              <input type="radio" v-model="formData.paytype" value="1" />
              <span>{{ $t('alipay') }}</span>
            </label>
            <label class="pay-option" :class="{ active: formData.paytype === '2' }">
              <input type="radio" v-model="formData.paytype" value="2" />
              <span>{{ $t('bankCard') }}</span>
            </label>
          </div>
        </section>

        <!-- 商品清单 -->
        <section class="form-section">
          <h2>{{ $t('productList') }}</h2>
          <div class="item-list">
            <div v-for="(item, index) in order.items" :key="index" class="item-row">
              <div class="item-info">
                <p class="item-name">{{ item.name }}</p>
                <p class="item-meta">¥{{ item.price.toFixed(2) }} × {{ item.amount }}</p>
              </div>
              <p class="item-total">¥{{ (item.price * item.amount).toFixed(2) }}</p>
            </div>
          </div>
        </section>

        <!-- 订单汇总 -->
        <div class="order-summary">
          <div class="summary-row">
            <span>{{ $t('totalQuantity') }}：</span>
            <strong>{{ order.amount }} {{ $t('items') }}</strong>
          </div>
          <div class="summary-row total">
            <span>{{ $t('totalAmount') }}：</span>
            <strong class="total-amount">¥{{ order.total.toFixed(2) }}</strong>
          </div>
        </div>

        <!-- 提交按钮 -->
        <button type="submit" class="btn-primary btn-submit">{{ $t('confirmPay') }}</button>
      </form>
    </div>
  </div>
</template>

<script setup>
import { computed, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useOrderStore } from '@/stores/order' // 引入 store
import axios from 'axios'

const orderStore = useOrderStore()
const router = useRouter()

const order = computed(() => orderStore.currentOrder)

const handlePay = async () => {

  const currentOrder = order.value

  // 安全检查
  if (!currentOrder || !currentOrder.items) {
    alert('订单数据异常，请返回重试')
    return
  }

  const orderData = {
    order: {
      total: currentOrder.total,
      amount: currentOrder.amount,
      status: 0,
      payType: formData.paytype.trim(),
      name: formData.name.trim(),
      phone: formData.phone.trim(),
      address: formData.address.trim(),
      userId: currentOrder.userId
    },
    items: currentOrder.items.map(item => ({
      goodId: item.goodId,
      price: item.price,
      amount: item.amount
    }))
  }

  try {
    // 发送 POST 请求到后端
    const res = await axios.post('/api/order', orderData)
    
    if (res.data.code === 200) {
      alert('订单提交成功！')
      orderStore.clearOrder()
      router.push('/orders')
    } else {
      const errorMsg = res.data.message || res.data.msg || '未知错误'
      alert('提交失败：' + errorMsg)
    }
  } catch (error) {
    console.error('提交订单失败:', error)
    const errorMsg = error.response?.data?.msg || error.response?.data?.message || '网络错误，请重试'
    alert(errorMsg)
  }
}

// ✅ 声明 formData 响应式对象
const formData = reactive({
  name: '',
  phone: '',
  address: '',
  paytype: 0 // 默认微信
})

// ✅ 在订单加载后，用 order 数据填充表单（作为默认值）
onMounted(() => {
  const o = order.value
  if (o) {
    formData.name = o.name || ''
    formData.phone = o.phone || ''
    formData.address = o.address || ''
    formData.paytype = o.payType || ''
  }
})
</script>

<style>
.payment-container {
  display: flex;
  justify-content: center;
  padding: 20px;
  min-height: 100vh;
  background-color: #f8f9fa;
}

.payment-card {
  width: 100%;
  max-width: 700px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
  padding: 32px;
  margin-top: 20px;
}

.page-title {
  text-align: center;
  color: #333;
  margin-bottom: 24px;
  font-size: 24px;
  font-weight: 600;
}

.empty-state {
  text-align: center;
  padding: 40px 20px;
  color: #666;
}

.empty-state .btn-secondary {
  margin-top: 16px;
  background: #e9ecef;
  color: #495057;
  border: none;
  padding: 8px 20px;
  border-radius: 6px;
  cursor: pointer;
}

.form-section {
  margin-bottom: 28px;
}

.form-section h2 {
  font-size: 18px;
  margin-bottom: 16px;
  color: #495057;
  font-weight: 600;
  padding-bottom: 8px;
  border-bottom: 1px solid #eee;
}

.form-group {
  margin-bottom: 16px;
}

.form-group label {
  display: block;
  margin-bottom: 6px;
  font-weight: 500;
  color: #333;
}

.form-input,
.form-textarea {
  width: 100%;
  padding: 10px 12px;
  border: 1px solid #ced4da;
  border-radius: 6px;
  font-size: 15px;
  transition: border-color 0.2s;
}

.form-input:focus,
.form-textarea:focus {
  outline: none;
  border-color: #3498db;
  box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
}

/* 支付方式 */
.pay-options {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.pay-option {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 16px;
  border: 2px solid #e9ecef;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
  font-size: 14px;
}

.pay-option:hover {
  border-color: #adb5bd;
}

.pay-option.active {
  border-color: #3498db;
  background-color: #f0f9ff;
}

.pay-option input {
  display: none;
}

/* 商品清单 */
.item-list {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 12px;
}

.item-row {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
  border-bottom: 1px solid #eee;
}

.item-row:last-child {
  border-bottom: none;
}

.item-info {
  flex: 1;
}

.item-name {
  font-weight: 500;
  margin: 0;
  color: #333;
}

.item-meta {
  font-size: 13px;
  color: #6c757d;
  margin: 4px 0 0;
}

.item-total {
  font-weight: 600;
  color: #e74c3c;
  margin: 0;
}

/* 订单汇总 */
.order-summary {
  background: #f8f9fa;
  padding: 16px;
  border-radius: 8px;
  margin: 24px 0;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
  font-size: 15px;
}

.summary-row:last-child {
  margin-bottom: 0;
}

.total {
  font-size: 18px;
  margin-top: 12px;
  padding-top: 12px;
  border-top: 1px dashed #ddd;
}

.total-amount {
  color: #e74c3c;
  font-size: 20px;
}

/* 按钮 */
.btn-primary {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 6px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  width: 100%;
  transition: background-color 0.2s;
}

.btn-primary:hover {
  background-color: #2980b9;
}

.btn-primary:disabled {
  background-color: #b0bec5;
  cursor: not-allowed;
}


</style>