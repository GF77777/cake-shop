//src/stores/user.js

//defineStore????
import { defineStore } from 'pinia';
import axios from 'axios';

//选项式 (Pinia 定义 Store 的方式 ,还有一种，，组合式)
export const useUserStore = defineStore('user',{
    state: ()=>({
        id :"",
        userName :"",
        name :"",
        email:"",
        phone:"",
        address:"",
        isAdmin:0,
        isValidate:0,
        isLoggedIn: false // ✅ 新增：明确登录状态
    }),


    actions: {
     // 登录成功后保存用户信息
     login(userData) {
       const { id, userName,name, email, phone, address,isAdmin,isValidate } = userData.data;
       this.id = id;
       this.name = name;
       this.userName = userName;
       this.email = email;
       this.phone = phone;
       this.address = address;
      //  this.isadmin = isadmin;
      //  this.isvalidate = isvalidate;
       this.isAdmin = Number(isAdmin);      // ✅ 转数字
       this.isValidate = Number(isValidate);

       this.isLoggedIn = true; // ✅ 标记已登录


      // ✅ 关键：同步到 localStorage
      localStorage.setItem('user', JSON.stringify({
        id: this.id,
        name: this.name,
        userName:this.userName,
        email: this.email,
        phone: this.phone,
        address: this.address,
        isAdmin: this.isAdmin,
        isValidate: this.isValidate,
        isLoggedIn: this.isLoggedIn
      }));
     },

     // 退出登录
     async logout() {
      try {
        // 调用后端退出登录接口记录日志
        await axios.post('http://localhost:8080/api/logout', {
          id: this.id,
          userName: this.userName,
          name: this.name,
          isAdmin: this.isAdmin
        });
      } catch (error) {
        console.error('退出登录记录失败:', error);
      } finally {
        this.$reset(); // 清空所有状态
        localStorage.removeItem('user'); // 删除 localStorage
      }
    },

    // 新增：启动时恢复状态
    restoreFromStorage() {
      const saved = localStorage.getItem('user');
      if (saved) {
        try {
          const user = JSON.parse(saved);
          this.id = user.id || "";
          this.name = user.name || "";
          this.userName = user.userName || "";
          this.email = user.email || "";
          this.phone = user.phone || "";
          this.address = user.address || "";
          this.isAdmin = Number(user.isAdmin) || 0;
          this.isValidate = Number(user.isValidate) || 0;
          this.isLoggedIn = user.isLoggedIn === true;
        } catch (e) {
          console.error('恢复失败，清除 localStorage');
          localStorage.removeItem('user');
        }
      }
    },

    //更新用户信息
    updateUser(userData) {
      Object.assign(this, userData)
      localStorage.setItem('user', JSON.stringify(this.$state))
    },


   }


})
