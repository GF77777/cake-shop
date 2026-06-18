<template>
  <div class="cart-container">
    <h1>{{ $t('myCart') }}</h1>

    <!-- 返回链接 -->
    <router-link to="/products" class="back-link">{{ $t('backToProducts') }}</router-link>

    <!-- 购物车为空 -->
    <div v-if="cartStore.items.length === 0" class="empty-cart">
      {{ $t('cartEmpty') }}
    </div>

    <!-- 有商品时 -->
    <div v-else class="cart-table-container">
      <table class="cart-table">
        <thead>
          <tr>
            <th>{{ $t('productImage') }}</th>
            <th>{{ $t('productInfo') }}</th>
            <th>{{ $t('unitPrice') }}</th>
            <th>{{ $t('quantity') }}</th>
            <th>{{ $t('action') }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in cartStore.items" :key="item.id">
            <td class="image-cell">
              <img :src="item.cover" alt="商品图" style="width: 100px; height: 100px; object-fit: cover;" />
            </td>
            <td class="info-cell">{{ item.name }}</td>
            <td class="price-cell">¥{{ item.price.toFixed(2) }}</td>
            <td class="quantity-cell">
              <button @click="decrease(item.id)" class="btn-minus">-</button>
              {{ item.count }}
              <button @click="increase(item.id)" class="btn-plus">+</button>
            </td>
            <td class="action-cell">
              <button @click="removeItem(item.id)" class="btn-remove">{{ $t('remove') }}</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- 底部操作区 -->
      <div class="cart-footer">
        <button @click="clearCart" class="btn-clear">{{ $t('clearCart') }}</button>
        <div class="total-price">
          {{ $t('totalPrice') }}：¥<strong>{{ totalAmount.toFixed(2) }}</strong>
        </div>
        <button @click="submitOrder" :disabled="cartStore.items.length === 0" class="btn-submit">
          {{ $t('submitOrder') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useCartStore } from '@/stores/cart'
import { useOrderStore } from '@/stores/order'
import { useUserStore } from '@/stores/user'

const cartStore = useCartStore()
const orderStore = useOrderStore()
const userStore = useUserStore()
const router = useRouter()

// 计算总金额
const totalAmount = computed(() => {
  return cartStore.items.reduce((sum, item) => sum + item.price * item.count, 0)
})

// 数量增减
const increase = (id) => {
  const item = cartStore.items.find(i => i.id === id)
  if (item) item.count++
}

const decrease = (id) => {
  const item = cartStore.items.find(i => i.id === id)
  if (item && item.count > 1) {
    item.count--
  }
}

const removeItem = (id) => {
  if (confirm(this.$t ? this.$t('confirmRemove') : '确定要删除吗？')) {
    cartStore.removeFromCart(id)
  }
}

const clearCart = () => {
  if (confirm(this.$t ? this.$t('confirmClear') : '确定要清空购物车吗？')) {
    cartStore.clearCart()
  }
}

const submitOrder = () => {
  if (cartStore.items.length === 0) return

  const userInfo = {
    id: userStore.id,
    name: userStore.name,
    phone: userStore.phone,
    address: userStore.address
  }

  orderStore.createOrderFromCart(cartStore.items, userInfo)
  // 可选：清空购物车
  cartStore.clearCart()
  router.push('/payment')
}
</script>

<style scoped>
.cart-container {
  max-width: 1200px;
  margin: 40px auto;
  padding: 0 20px;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
}

.back-link {
  color: #0066cc;
  text-decoration: underline;
  font-size: 14px;
  margin-bottom: 20px;
  display: inline-block;
}

.empty-cart {
  text-align: center;
  padding: 40px;
  color: #999;
  font-size: 16px;
}

.cart-table-container {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  overflow: hidden;
}

.cart-table {
  width: 100%;
  border-collapse: collapse;
  margin: 0;
}

.cart-table th {
  background-color: #f5f5f5;
  padding: 12px 16px;
  text-align: left;
  font-weight: 500;
  color: #333;
  border-bottom: 1px solid #ddd;
}

.cart-table td {
  padding: 16px;
  border-bottom: 1px solid #eee;
  vertical-align: middle;
}

.image-cell img {
  border-radius: 4px;
}

.info-cell {
  font-size: 14px;
  color: #333;
}

.price-cell {
  font-weight: 500;
  color: #333;
}

.quantity-cell {
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-minus,
.btn-plus {
  width: 24px;
  height: 24px;
  border: none;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-minus {
  background-color: #e74c3c;
  color: white;
}

.btn-minus:hover {
  background-color: #c0392b;
}

.btn-plus {
  background-color: #2ecc71;
  color: white;
}

.btn-plus:hover {
  background-color: #27ae60;
}

.action-cell {
  text-align: right;
}

.btn-remove {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 6px 12px;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-remove:hover {
  background-color: #c0392b;
}

.cart-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  background-color: #f9f9f9;
  border-top: 1px solid #eee;
  margin-top: 20px;
}

.btn-clear {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-clear:hover {
  background-color: #c0392b;
}

.total-price {
  font-size: 18px;
  color: #e74c3c;
  font-weight: bold;
}

.btn-submit {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 24px;
  border-radius: 4px;
  font-size: 14px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-submit:hover {
  background-color: #2980b9;
}

.btn-submit:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}
</style>