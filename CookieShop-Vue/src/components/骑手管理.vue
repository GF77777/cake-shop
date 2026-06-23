<template>
  <div class="rider-management">
    <div class="page-header">
      <h2>骑手管理</h2>
      <div class="header-actions">
        <button @click="showAddModal = true" class="btn-add">+ 添加骑手</button>
        <button @click="showAnnouncementModal = true" class="btn-announcement">📢 发布公告</button>
      </div>
    </div>

    <div class="search-bar">
      <input 
        type="text" 
        v-model="searchKeyword" 
        placeholder="搜索骑手账号、姓名、电话"
        class="search-input"
        @keyup.enter="handleSearch"
      />
      <button @click="handleSearch" class="btn-search">搜索</button>
    </div>

    <table class="rider-table">
      <thead>
        <tr>
          <th>骑手ID</th>
          <th>账号</th>
          <th>姓名</th>
          <th>电话</th>
          <th>工号</th>
          <th>状态</th>
          <th>配送区域</th>
          <th>创建时间</th>
          <th>操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="rider in riders" :key="rider.id">
          <td>{{ rider.id }}</td>
          <td>{{ rider.userName }}</td>
          <td>{{ rider.realName }}</td>
          <td>{{ rider.phone }}</td>
          <td>{{ rider.workNo || '-' }}</td>
          <td>
            <span :class="['status-badge', rider.status === 1 ? 'online' : 'offline']">
              {{ rider.status === 1 ? '在线' : '离线' }}
            </span>
          </td>
          <td>{{ rider.area || '-' }}</td>
          <td>{{ formatTime(rider.createTime) }}</td>
          <td class="actions">
            <button @click="editRider(rider)" class="btn-edit">编辑</button>
            <button @click="deleteRider(rider.id)" class="btn-delete">删除</button>
          </td>
        </tr>
      </tbody>
    </table>

    <div v-if="riders.length === 0" class="empty-state">
      <p>暂无骑手数据</p>
    </div>

    <div class="pagination-wrapper">
      <div class="pagination-info">
        共 {{ total }} 条记录，每页 {{ pageSize }} 条
      </div>
      <div class="pagination">
        <button
          @click="prevPage"
          :disabled="currentPage === 1"
          class="pagination-btn"
        >
          上一页
        </button>
        <span class="pagination-current">第 {{ currentPage }} / {{ totalPages }} 页</span>
        <button
          @click="nextPage"
          :disabled="currentPage >= totalPages"
          class="pagination-btn"
        >
          下一页
        </button>
      </div>
    </div>

    <!-- 发布公告弹窗 -->
    <div v-if="showAnnouncementModal" class="modal-overlay" @click.self="closeAnnouncementModal">
      <div class="modal-content">
        <h3>📢 发布系统公告</h3>
        <form @submit.prevent="publishAnnouncement">
          <div class="form-group">
            <label>公告标题</label>
            <input 
              type="text" 
              v-model="announcementForm.title" 
              required 
              placeholder="请输入公告标题"
            />
          </div>
          <div class="form-group">
            <label>公告内容</label>
            <textarea 
              v-model="announcementForm.content" 
              required 
              placeholder="请输入公告内容"
              rows="5"
            ></textarea>
          </div>
          <div class="form-actions">
            <button type="button" @click="closeAnnouncementModal" class="btn-cancel">取消</button>
            <button type="submit" class="btn-submit">发布公告</button>
          </div>
        </form>
      </div>
    </div>

    <!-- 添加/编辑骑手弹窗 -->
    <div v-if="showAddModal" class="modal-overlay" @click.self="closeModal">
      <div class="modal-content">
        <h3>{{ editingRider ? '编辑骑手' : '添加骑手' }}</h3>
        <form @submit.prevent="saveRider">
          <div class="form-group">
            <label>登录账号</label>
            <input 
              type="text" 
              v-model="form.userName" 
              required 
              placeholder="请输入登录账号"
            />
          </div>
          <div class="form-group">
            <label>登录密码</label>
            <input 
              type="password" 
              v-model="form.passWord" 
              :required="!editingRider"
              placeholder="请输入登录密码"
            />
          </div>
          <div class="form-group">
            <label>真实姓名</label>
            <input 
              type="text" 
              v-model="form.realName" 
              required 
              placeholder="请输入真实姓名"
            />
          </div>
          <div class="form-group">
            <label>联系电话</label>
            <input 
              type="text" 
              v-model="form.phone" 
              required 
              placeholder="请输入联系电话"
            />
          </div>
          <div class="form-group">
            <label>工号</label>
            <input 
              type="text" 
              v-model="form.workNo" 
              placeholder="请输入工号（可选）"
            />
          </div>
          <div class="form-group">
            <label>配送区域</label>
            <input 
              type="text" 
              v-model="form.area" 
              placeholder="请输入配送区域（可选）"
            />
          </div>
          <div class="form-group">
            <label>状态</label>
            <select v-model="form.status">
              <option :value="0">离线</option>
              <option :value="1">在线</option>
            </select>
          </div>
          <div class="form-actions">
            <button type="button" @click="closeModal" class="btn-cancel">取消</button>
            <button type="submit" class="btn-submit">保存</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, computed } from 'vue';
import axios from 'axios';

const riders = ref([]);
const searchKeyword = ref('');
const showAddModal = ref(false);
const editingRider = ref(null);
const showAnnouncementModal = ref(false);

const currentPage = ref(1);
const pageSize = ref(10);
const total = ref(0);

const totalPages = computed(() => {
  return Math.ceil(total.value / pageSize.value) || 1;
});

const announcementForm = reactive({
  title: '',
  content: ''
});

const form = reactive({
  id: null,
  userName: '',
  passWord: '',
  realName: '',
  phone: '',
  workNo: '',
  area: '',
  status: 0
});

const fetchRiders = async () => {
  try {
    const response = await axios.get('/api/admin/riders', {
      params: {
        pageNum: currentPage.value,
        pageSize: pageSize.value,
        keyword: searchKeyword.value
      }
    });
    if (response.data.code === 200) {
      riders.value = response.data.data.list;
      total.value = response.data.data.total;
    }
  } catch (error) {
    console.error('获取骑手列表失败', error);
  }
};

const handleSearch = () => {
  currentPage.value = 1;
  fetchRiders();
};

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
    fetchRiders();
  }
};

const nextPage = () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++;
    fetchRiders();
  }
};

const addRider = async () => {
  try {
    const data = {
      userName: form.userName,
      passWord: form.passWord,
      realName: form.realName,
      phone: form.phone,
      status: form.status
    };
    // 只在有值时添加可选字段，避免空字符串触发唯一约束冲突
    if (form.workNo && form.workNo.trim()) {
      data.workNo = form.workNo.trim();
    } else {
      data.workNo = null;
    }
    if (form.area && form.area.trim()) {
      data.area = form.area.trim();
    } else {
      data.area = null;
    }
    
    const response = await axios.post('/api/admin/riders', data);
    if (response.data.code === 200) {
      alert('添加成功');
      closeModal();
      fetchRiders();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('添加骑手失败', error);
    alert('添加失败');
  }
};

const updateRider = async () => {
  try {
    const data = {
      userName: form.userName,
      realName: form.realName,
      phone: form.phone,
      status: form.status
    };
    // 只在有值时添加可选字段，避免空字符串触发唯一约束冲突
    if (form.workNo && form.workNo.trim()) {
      data.workNo = form.workNo.trim();
    } else {
      data.workNo = null;
    }
    if (form.area && form.area.trim()) {
      data.area = form.area.trim();
    } else {
      data.area = null;
    }
    
    const response = await axios.put(`/api/admin/riders/${form.id}`, data);
    if (response.data.code === 200) {
      alert('修改成功');
      closeModal();
      fetchRiders();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('修改骑手失败', error);
    alert('修改失败');
  }
};

const saveRider = () => {
  if (editingRider.value) {
    updateRider();
  } else {
    addRider();
  }
};

const editRider = (rider) => {
  editingRider.value = rider;
  form.id = rider.id;
  form.userName = rider.userName;
  form.passWord = '';
  form.realName = rider.realName;
  form.phone = rider.phone;
  form.workNo = rider.workNo || '';
  form.area = rider.area || '';
  form.status = rider.status;
  showAddModal.value = true;
};

const deleteRider = async (id) => {
  if (!confirm('确定要删除该骑手吗？')) return;
  try {
    const response = await axios.delete(`/api/admin/riders/${id}`);
    if (response.data.code === 200) {
      alert('删除成功');
      fetchRiders();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('删除骑手失败', error);
    alert('删除失败');
  }
};

const closeModal = () => {
  showAddModal.value = false;
  editingRider.value = null;
  form.id = null;
  form.userName = '';
  form.passWord = '';
  form.realName = '';
  form.phone = '';
  form.workNo = '';
  form.area = '';
  form.status = 0;
};

const formatTime = (dateStr) => {
  if (!dateStr) return '-';
  return new Date(dateStr).toLocaleString('zh-CN');
};

// 发布系统公告
const publishAnnouncement = async () => {
  try {
    const response = await axios.post('/api/message/announcement', {
      title: announcementForm.title,
      content: announcementForm.content
    });
    if (response.data.code === 200) {
      alert('公告发布成功，已发送给所有骑手');
      closeAnnouncementModal();
    } else {
      alert(response.data.message);
    }
  } catch (error) {
    console.error('发布公告失败', error);
    alert('发布公告失败');
  }
};

// 关闭公告弹窗
const closeAnnouncementModal = () => {
  showAnnouncementModal.value = false;
  announcementForm.title = '';
  announcementForm.content = '';
};

onMounted(() => {
  fetchRiders();
});
</script>

<style scoped>
.rider-management {
  padding: 20px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.page-header h2 {
  margin: 0;
  color: #333;
}

.header-actions {
  display: flex;
  gap: 10px;
}

.btn-add {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
}

.btn-add:hover {
  background-color: #2980b9;
}

.btn-announcement {
  background-color: #e74c3c;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
}

.btn-announcement:hover {
  background-color: #c0392b;
}

.search-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.search-input {
  flex: 1;
  max-width: 300px;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
}

.btn-search {
  background-color: #fff;
  color: #3498db;
  border: 1px solid #3498db;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
}

.rider-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.rider-table th,
.rider-table td {
  padding: 12px 16px;
  text-align: left;
  border-bottom: 1px solid #eee;
}

.rider-table th {
  background-color: #f8f9fa;
  font-weight: 600;
  color: #666;
}

.status-badge {
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
}

.status-badge.online {
  background-color: #d4edda;
  color: #155724;
}

.status-badge.offline {
  background-color: #f8d7da;
  color: #721c24;
}

.actions {
  display: flex;
  gap: 8px;
}

.btn-edit {
  background-color: #fff;
  color: #3498db;
  border: 1px solid #3498db;
  padding: 4px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.btn-delete {
  background-color: #fff;
  color: #e74c3c;
  border: 1px solid #e74c3c;
  padding: 4px 12px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 12px;
}

.empty-state {
  text-align: center;
  padding: 40px;
  color: #999;
  background: white;
  border-radius: 8px;
}

.pagination-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-top: 1px solid #eee;
  background-color: #fafafa;
  margin-top: 20px;
}

.pagination-info {
  font-size: 14px;
  color: #666;
}

.pagination {
  display: flex;
  align-items: center;
  gap: 12px;
}

.pagination-btn {
  padding: 8px 16px;
  border: 1px solid #ddd;
  border-radius: 4px;
  background-color: white;
  color: #333;
  font-size: 14px;
  cursor: pointer;
  transition: all 0.2s;
}

.pagination-btn:hover:not(:disabled) {
  background-color: #f0f0f0;
  border-color: #ccc;
}

.pagination-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.pagination-current {
  font-size: 14px;
  color: #666;
  min-width: 100px;
  text-align: center;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  padding: 24px;
  border-radius: 8px;
  width: 400px;
  max-width: 90%;
}

.modal-content h3 {
  margin: 0 0 20px 0;
  color: #333;
}

.form-group {
  margin-bottom: 16px;
}

.form-group label {
  display: block;
  margin-bottom: 6px;
  font-size: 14px;
  color: #666;
}

.form-group input,
.form-group select,
.form-group textarea {
  width: 100%;
  padding: 8px 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  box-sizing: border-box;
}

.form-group textarea {
  resize: vertical;
  min-height: 100px;
}

.form-actions {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
  margin-top: 24px;
}

.btn-cancel {
  background-color: #fff;
  color: #666;
  border: 1px solid #ddd;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
}

.btn-submit {
  background-color: #3498db;
  color: white;
  border: none;
  padding: 8px 16px;
  border-radius: 6px;
  cursor: pointer;
}
</style>