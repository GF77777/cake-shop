<template>
    <div>
        <h1>{{ $t('hotTitle') }}</h1>
        <div class="bigbox">
            <div class="smallbox" 
                 v-for="(good,index) in paginatedGoods" 
                 :key="index"
                 @click="goToDetail(good.id)">
                    <div class="img"><img :src="good.cover" ></div>
                    <p>{{ $t('product') }}：{{ good.name }}</p>
                    <p>{{ $t('price') }}:¥{{ good.price.toFixed(2) }}</p>
                    <button @click.stop="addToCart(good)" >{{ $t('addToCart') }}</button>

            </div>
        </div>
        
        <!-- 分页组件 -->
        <div v-if="totalPages > 1" class="pagination">
            <button 
                :disabled="currentPage <= 1" 
                @click="changePage(currentPage - 1)"
                class="page-btn"
            >{{ $t('prevPage') }}</button>
            <span class="page-info">{{ $t('pageInfo', { current: currentPage, total: totalPages, count: filteredGoods.length }) }}</span>
            <button 
                :disabled="currentPage >= totalPages" 
                @click="changePage(currentPage + 1)"
                class="page-btn"
            >{{ $t('nextPage') }}</button>
        </div>
    </div>
</template>

<script setup>
import { onMounted, ref, computed } from 'vue';
import axios from 'axios';
import { useRouter, useRoute } from 'vue-router' 
import { useCartStore } from '@/stores/cart' 


const router = useRouter() 
const route = useRoute() 
const cartStore = useCartStore() 
const goodsList = ref([]);
const keyword = route.query.keyword

// 分页相关
const currentPage = ref(1)
const pageSize = ref(8)
const filteredGoods = ref([])

// 计算当前页显示的商品
const paginatedGoods = computed(() => {
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  return filteredGoods.value.slice(start, end)
})

// 计算总页数
const totalPages = computed(() => {
  return Math.ceil(filteredGoods.value.length / pageSize.value)
})

// 切换页码
const changePage = (page) => {
  if (page < 1 || page > totalPages.value) return
  currentPage.value = page
  window.scrollTo({ top: 0, behavior: 'smooth' })
}

const get = async () =>{
    try{
        let url
        if(keyword){
             // 模糊搜索
             url = `/api/byName?name=${encodeURIComponent(keyword)}`

        }else{
             // 查询推荐表中的热销商品（type=1）
             url = '/api/findRecommendByType?type=1'
             
        }

        const res = await axios.get(url)
        
        if (res.data && res.data.data) {
            filteredGoods.value = res.data.data;
            goodsList.value = filteredGoods.value;
        } else {
            filteredGoods.value = [];
            goodsList.value = [];
        }
        currentPage.value = 1; // 重置页码
        console.log('查询成功:', res.data);

    }catch(error){
        filteredGoods.value = [];
        goodsList.value = [];
    }
}

const goToDetail = (id) => {
  router.push({
    path: '/product-detail',
    query: { id: id } 
  })
}

// 添加到购物车
const addToCart = (good) => {
  cartStore.addToCart(good)
  alert( good.name  + "已经添加购物车")
}

onMounted( ()=>{
    get();
})
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box; 
}

.bigbox {
  background-color: #f5f5f5;
  width: 100%;
  padding: 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}

.smallbox {
  background-color: white;
  width: calc(25% - 20px); 
  padding: 16px;
  border: 1px solid #ddd;
  border-radius: 8px;
  cursor: pointer;
  transition: transform 0.2s;
}

.smallbox:hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.img img {
  width: 100%;
  height: 250px;
  object-fit: cover;
  border-radius: 4px;
}

p {
  margin: 8px 0;
  font-size: 14px;
}

button {
  margin-top: 10px;
  padding: 6px 12px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}

/* 分页样式 */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
  margin-top: 30px;
  padding: 20px 0;
}

.page-btn {
  padding: 10px 20px;
  font-size: 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.page-btn:hover:not(:disabled) {
  background-color: #45a049;
}

.page-btn:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.page-info {
  font-size: 16px;
  color: #666;
}
</style>