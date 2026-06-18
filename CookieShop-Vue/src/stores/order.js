// src/stores/order.js
import { defineStore } from 'pinia'

export const useOrderStore = defineStore('order', {
  state: () => ({
    currentOrder: {
      name: '',
      phone: '',
      address: '',
      userId: null,
      total: 0,
      amount: 0,
      status: 0,
      payType: 2,
      items: []
    } 
  }),

  actions: {
    // 添加购物车到支付页面
    createOrderFromCart(cartItems, userInfo) {
      //计算总金额
      const total = cartItems.reduce((sum, item) => sum + item.price * item.count, 0)
      //计算总件数（不是种类数！）
      const totalQuantity = cartItems.reduce((sum, item) => sum + item.count, 0)
      this.currentOrder = {
        name: userInfo.name,
        phone: userInfo.phone,
        address: userInfo.address,
        userId: userInfo.id,
        total: parseFloat(total.toFixed(2)),
        amount: totalQuantity,
        status: 0,
        payType: 2,
        items: cartItems.map(item => ({
          goodId: item.id,
          name:item.name,
          price: item.price,
          amount: item.count 
        }))
      }
    },

    clearOrder() {
      // this.currentOrder = null
      this.currentOrder = {
        name: '',
        phone: '',
        address: '',
        userId: null,
        total: 0,
        amount: 0,
        status: 0,
        payType: 2,
        items: []
      }
    }
  }

  
})