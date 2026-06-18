<template>
    <div class="container">
        <div class="card">
             <div class="title">{{ $t('registerTitle') }}</div>

             <div class="register">
                <form @submit.prevent="registerUser">
                <div>
                  <label for="name">{{ $t('username') }}</label><br>
                  <input type="text" id="name" v-model="username">
                </div>

                <div>
                  <label for="email">{{ $t('email') }}</label><br>
                  <input type="email" id="email" v-model="email">
                </div>

                <div>
                  <label for="password">{{ $t('password') }}</label><br>
                  <input type="text" id="password" v-model="password">
                </div>

                <div>
                  <label for="recipient">{{ $t('recipient') }}</label><br>
                  <input type="text" id="recipient" v-model="recipient">
                </div>

                <div>
                  <label for="phone">{{ $t('phone') }}</label><br>
                  <input type="text" id="phone" v-model="phone">
                </div>

               <div>
                  <label for="address">{{ $t('address') }}</label><br>
                  <input type="text" id="address" v-model="address">   
                </div><br>

                <button>{{ $t('submit') }}</button>

                </form>
                <router-link to="/login">{{ $t('backToLogin') }}</router-link>

            </div>
        
            
        

    
        </div>
            
    </div>
        
    
   
</template>


<script setup>
import { ref } from 'vue';
import axios from 'axios'

import { useRouter } from 'vue-router'
const router = useRouter()

const username = ref('');
const email = ref('');
const password = ref('');
const recipient = ref('');  //收货人
const phone = ref('');  
const address = ref('');

// 注册处理函数
const registerUser = async ()=> {
    try{
        const params = new URLSearchParams();
        params.append('username', username.value);
        params.append('email', email.value);
        params.append('password', password.value);
        params.append('name', recipient.value);
        params.append('phone', phone.value);
        params.append('address', address.value);

        const response = await axios.post('/api/register', params, {
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        });
        console.log('注册成功:', response.data);
        if (response.data.code == 0) {
            alert("注册成功")
            router.push('/login');
        }

    }catch(error){
        console.error('注册失败:', error.response?.data || error.message);
    }
}

</script>



<style scoped>
.container {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 90vh;
  background-color: #f5f7fa;

}

.card {
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

.register{
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