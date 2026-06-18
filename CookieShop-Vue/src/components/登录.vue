
<template>
  <div class="login-container">
    <div class="login-card">
      <div class="title">{{ $t('loginTitle') }}</div>

      <div class="login">
        <form @submit.prevent="handleLogin">
            <div>
                <label for="name">{{ $t('usernameEmail') }}</label><br>
                <input type="text" id="name" v-model="username"><br>
            </div>

            <div>
                <label for="password">{{ $t('password') }}</label><br>
                <input type="password" id="password" v-model="password"><br>
            </div><br>
            <button>{{ $t('login') }}</button>
        </form>
        <router-link to="/register">{{ $t('goRegister') }}</router-link>
        <span style="margin: 0 8px;">|</span>
        <router-link to="/rider/login">{{ $t('riderLogin') }}</router-link>
        
      </div>


    </div>

  </div>
    
</template>


<!--js  -->
<script setup>
import { ref } from 'vue'

import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user' 

import axios from 'axios'

const userStore = useUserStore() 
const router = useRouter()

// 数据绑定
const username = ref('')
const password = ref('')

// 登录处理函数
const handleLogin = async () => {
  try {
    const data = {
      userName: username.value,
      passWord: password.value
    };

    const response = await axios.post('/api/login', data, {
      headers: {
        'Content-Type': 'application/json'
      }
    });

    console.log('登录成功:', response.data);
    if (response.data.code == 200) {
      // 登录成功，调用 login 方法
      userStore.login(response.data) 

      
      console.log('login 后 isadmin:', userStore.isAdmin); 
      // 根据 isadmin 决定跳哪里
      if (userStore.isAdmin === 1) {
          console.log('跳转到管理员后台'); // ← 新增
          router.push('/admin');
      } else {
          console.log('跳转到个人中心'); // ← 新增
         router.push('/profile');
      }
      
    } else {
      alert('登录失败：' + response.data.msg)
    }
  } catch (error) {
    console.error('登录失败:', error.response?.data || error.message);
  }
}

</script>

<!-- css -->
<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 90vh;
  background-color: #f5f7fa;

}

.login-card {
  width: 100%;
  max-width: 500px;
  background: white;
  padding: 30px;
  border-radius: 12px;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);

  

}
.title {
  width: 100%;
  text-align: center;
  margin-bottom: 24px;
  color: #333;
  font-size: 27px;
  font-weight: 600;
}
.login{
  width: 85%;
  margin-left: 25%;

  font-size: 20px;
  
}
input{
  font-size: 20px;
}
button{
  width: 60%;
  font-size: 20px;
  
}
</style>