// src/stores/cart.js
import { defineStore } from 'pinia'

export const useCartStore = defineStore('cart', {
  state: () => ({
    items: [] // 购物车商品列表：[{ id, name, price, cover, count }]
  }),

  actions: {
    // 添加商品到购物车
    addToCart(good) {
      // 查找是否已存在
      const existing = this.items.find(item => item.id === good.id)
      if (existing) {
        existing.count += 1 // 已存在，数量+1
      } else {
        // 不存在，新增
        this.items.push({
          id: good.id,
          name: good.name,
          price: good.price,
          cover: good.cover,
          count: 1
        })
      }
    },

    // 从购物车中移除商品
    removeFromCart(id) {
      // 找到商品在数组中的索引并删除
      const index = this.items.findIndex(item => item.id === id);
      if (index > -1) {
        this.items.splice(index, 1);
      }
    },

    //清空购物车
    clearCart() {
      this.items = [] // 最安全、最清晰的方式
    }


  }
})