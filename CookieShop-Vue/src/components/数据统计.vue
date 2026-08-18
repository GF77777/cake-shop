<template>
  <div class="statistics-page">
    <h2 class="page-title">{{ $t('statisticsTitle') }}</h2>
    
    <div class="summary-cards">
      <div class="card">
        <div class="card-icon orders-icon">📦</div>
        <div class="card-content">
          <div class="card-value">{{ statistics.order?.totalOrderCount || 0 }}</div>
          <div class="card-label">{{ $t('totalOrders') }}</div>
        </div>
      </div>
      <div class="card">
        <div class="card-icon sales-icon">💰</div>
        <div class="card-content">
          <div class="card-value">¥{{ statistics.order?.totalSalesAmount || 0 }}</div>
          <div class="card-label">{{ $t('totalSales') }}</div>
        </div>
      </div>
      <div class="card">
        <div class="card-icon goods-icon">🍰</div>
        <div class="card-content">
          <div class="card-value">{{ statistics.goods?.totalGoodsCount || 0 }}</div>
          <div class="card-label">{{ $t('totalProducts') }}</div>
        </div>
      </div>
      <div class="card">
        <div class="card-icon users-icon">👥</div>
        <div class="card-content">
          <div class="card-value">{{ statistics.user?.totalUserCount || 0 }}</div>
          <div class="card-label">{{ $t('totalUsers') }}</div>
        </div>
      </div>
    </div>

    <div class="stats-grid">
      <div class="section">
        <h3>{{ $t('todayData') }}</h3>
        <div class="today-grid">
          <div class="today-item">
            <span class="today-label">{{ $t('todayOrders') }}</span>
            <span class="today-value">{{ statistics.order?.todayOrderCount || 0 }}</span>
          </div>
          <div class="today-item">
            <span class="today-label">{{ $t('todaySales') }}</span>
            <span class="today-value">¥{{ statistics.order?.todaySalesAmount || 0 }}</span>
          </div>
        </div>
      </div>

      <div class="section">
        <h3>{{ $t('orderStatusDistribution') }}</h3>
        <div class="distribution-list">
          <div v-for="item in statistics.order?.statusDistribution" :key="item.statusName" class="distribution-item">
            <span class="dist-label">{{ item.statusName }}</span>
            <div class="dist-bar-wrap">
              <div class="dist-bar" :style="{ width: item.percentage + '%' }"></div>
            </div>
            <span class="dist-value">{{ item.count }} ({{ item.percentage }}%)</span>
          </div>
        </div>
      </div>

      <div class="section">
        <h3>{{ $t('paymentMethodDistribution') }}</h3>
        <div class="distribution-list">
          <div v-for="item in statistics.order?.payTypeDistribution" :key="item.payTypeName" class="distribution-item">
            <span class="dist-label">{{ item.payTypeName }}</span>
            <div class="dist-bar-wrap">
              <div class="dist-bar payment" :style="{ width: item.percentage + '%' }"></div>
            </div>
            <span class="dist-value">{{ item.count }} ({{ item.percentage }}%)</span>
          </div>
        </div>
      </div>

      <div class="section">
        <h3>{{ $t('userStatistics') }}</h3>
        <div class="user-stats">
          <div class="user-item">
            <span class="user-label">{{ $t('admin') }}</span>
            <span class="user-value admin">{{ statistics.user?.adminCount || 0 }}</span>
          </div>
          <div class="user-item">
            <span class="user-label">{{ $t('normalUser') }}</span>
            <span class="user-value normal">{{ statistics.user?.normalUserCount || 0 }}</span>
          </div>
        </div>
      </div>

      <div class="section">
        <h3>{{ $t('productsByCategory') }}</h3>
        <div class="category-list">
          <div v-for="item in statistics.goods?.goodsByType" :key="item.typeName" class="category-item">
            <span class="category-name">{{ item.typeName }}</span>
            <span class="category-count">{{ item.count }} {{ $t('items') }}</span>
          </div>
        </div>
      </div>

      <div class="section">
        <div class="section-header">
          <h3>{{ $t('lowStockWarning') }}</h3>
          <div class="threshold-edit">
            <span class="threshold-label">{{ $t('stockLimitPrefix') }}</span>
            <input 
              v-if="isEditingThreshold" 
              type="number" 
              v-model="editThreshold" 
              min="0" 
              class="threshold-input"
              @keyup.enter="saveThreshold"
            />
            <span v-else class="threshold-value">{{ stockWarningThreshold }}</span>
            <button 
              v-if="!isEditingThreshold" 
              @click="startEditThreshold" 
              class="edit-btn"
            >{{ $t('edit') }}</button>
            <button 
              v-if="isEditingThreshold" 
              @click="saveThreshold" 
              class="save-btn"
            >{{ $t('save') }}</button>
            <button 
              v-if="isEditingThreshold" 
              @click="cancelEditThreshold" 
              class="cancel-btn"
            >{{ $t('cancel') }}</button>
          </div>
        </div>
        <div class="low-stock-list" v-if="statistics.goods?.lowStockGoods?.length">
          <table class="stock-table">
            <thead>
              <tr>
                <th>{{ $t('goodsName') }}</th>
                <th>{{ $t('category') }}</th>
                <th>{{ $t('stock') }}</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="item in statistics.goods?.lowStockGoods" :key="item.id">
                <td>{{ item.name }}</td>
                <td>{{ item.typeName }}</td>
                <td class="low-stock">{{ item.stock }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <div v-else class="empty-message">{{ $t('noLowStockGoods') }}</div>
      </div>

      <div class="section trend-section">
        <h3>{{ $t('last7DaysTrend') }}</h3>
        <div class="chart-container">
          <svg class="line-chart" viewBox="0 0 400 220" preserveAspectRatio="none">
            <defs>
              <linearGradient id="lineGradient" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop offset="0%" style="stop-color:#667eea;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#764ba2;stop-opacity:1" />
              </linearGradient>
              <linearGradient id="areaGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#667eea;stop-opacity:0.3" />
                <stop offset="100%" style="stop-color:#667eea;stop-opacity:0" />
              </linearGradient>
            </defs>
            <path class="grid-lines" d="M 0 40 H 400 M 0 80 H 400 M 0 120 H 400 M 0 160 H 400" />
            <path v-if="statistics.dailyTrend?.length" :d="dailyAreaPath" fill="url(#areaGradient)" />
            <path v-if="statistics.dailyTrend?.length" :d="dailyLinePath" fill="none" stroke="url(#lineGradient)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
            <g v-for="(item, i) in statistics.dailyTrend" :key="'daily-'+i">
              <text :x="getLineX(i, statistics.dailyTrend.length)" :y="getLineY(dailyBarHeights[i]) - 12" text-anchor="middle" class="data-label">¥{{ item.salesAmount }}</text>
              <circle :cx="getLineX(i, statistics.dailyTrend.length)" :cy="getLineY(dailyBarHeights[i])" r="5" fill="#667eea" stroke="white" stroke-width="2" class="data-point" />
            </g>
          </svg>
          <div class="chart-labels">
            <span v-for="(item, i) in statistics.dailyTrend" :key="item.date" class="label-item" :style="{ left: (i / (statistics.dailyTrend.length - 1)) * 100 + '%' }">
              {{ formatDate(item.date) }}
            </span>
          </div>
        </div>
      </div>

      <div class="section trend-section">
        <h3>{{ $t('last6MonthsTrend') }}</h3>
        <div class="chart-container">
          <svg class="line-chart" viewBox="0 0 400 220" preserveAspectRatio="none">
            <defs>
              <linearGradient id="monthlyLineGradient" x1="0%" y1="0%" x2="100%" y2="0%">
                <stop offset="0%" style="stop-color:#4facfe;stop-opacity:1" />
                <stop offset="100%" style="stop-color:#00f2fe;stop-opacity:1" />
              </linearGradient>
              <linearGradient id="monthlyAreaGradient" x1="0%" y1="0%" x2="0%" y2="100%">
                <stop offset="0%" style="stop-color:#4facfe;stop-opacity:0.3" />
                <stop offset="100%" style="stop-color:#4facfe;stop-opacity:0" />
              </linearGradient>
            </defs>
            <path class="grid-lines" d="M 0 40 H 400 M 0 80 H 400 M 0 120 H 400 M 0 160 H 400" />
            <path v-if="statistics.monthlyTrend?.length" :d="monthlyAreaPath" fill="url(#monthlyAreaGradient)" />
            <path v-if="statistics.monthlyTrend?.length" :d="monthlyLinePath" fill="none" stroke="url(#monthlyLineGradient)" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" />
            <g v-for="(item, i) in statistics.monthlyTrend" :key="'monthly-'+i">
              <text :x="getLineX(i, statistics.monthlyTrend.length)" :y="getLineY(monthlyBarHeights[i]) - 12" text-anchor="middle" class="data-label">¥{{ item.salesAmount }}</text>
              <circle :cx="getLineX(i, statistics.monthlyTrend.length)" :cy="getLineY(monthlyBarHeights[i])" r="5" fill="#4facfe" stroke="white" stroke-width="2" class="data-point" />
            </g>
          </svg>
          <div class="chart-labels">
            <span v-for="(item, i) in statistics.monthlyTrend" :key="item.month" class="label-item" :style="{ left: (i / (statistics.monthlyTrend.length - 1)) * 100 + '%' }">
              {{ formatMonth(item.month) }}
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue';

export default {
  name: 'Statistics',
  setup() {
    const statistics = ref({
      order: {},
      goods: {},
      user: {},
      dailyTrend: [],
      weeklyTrend: [],
      monthlyTrend: []
    });

    const stockWarningThreshold = ref(10);
    const isEditingThreshold = ref(false);
    const editThreshold = ref(10);

    const fetchStatistics = async () => {
      try {
        const response = await fetch('http://localhost:8080/api/statistics/all');
        const data = await response.json();
        console.log('API Response:', data);
        
        if (data.code === 200) {
          statistics.value = data.data;
          console.log('Statistics data:', statistics.value);
          console.log('dailyTrend:', statistics.value.dailyTrend);
          if (statistics.value.dailyTrend?.length) {
            console.log('salesAmount values:', statistics.value.dailyTrend.map(i => i.salesAmount));
          }
        }
      } catch (error) {
        console.error('获取统计数据失败:', error);
      }
    };

    const fetchStockWarningThreshold = async () => {
      try {
        const response = await fetch('/api/system/config/stock-warning');
        const data = await response.json();
        if (data.code === 200) {
          stockWarningThreshold.value = data.data.threshold;
          editThreshold.value = data.data.threshold;
        }
      } catch (error) {
        console.error('获取库存预警阈值失败:', error);
      }
    };

    const startEditThreshold = () => {
      editThreshold.value = stockWarningThreshold.value;
      isEditingThreshold.value = true;
    };

    const saveThreshold = async () => {
      if (editThreshold.value < 0) {
        alert('请输入大于等于0的数值');
        return;
      }
      try {
        const response = await fetch('http://localhost:8080/api/config/stock-warning', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ threshold: editThreshold.value })
        });
        const data = await response.json();
        if (data.code === 200) {
          stockWarningThreshold.value = editThreshold.value;
          isEditingThreshold.value = false;
          // 刷新统计数据以显示新阈值下的库存预警商品
          fetchStatistics();
        } else {
          alert('保存失败');
        }
      } catch (error) {
        console.error('保存库存预警阈值失败:', error);
        alert('保存失败');
      }
    };

    const cancelEditThreshold = () => {
      isEditingThreshold.value = false;
    };

    const dailyBarHeights = computed(() => {
      const trend = statistics.value?.dailyTrend || [];
      if (trend.length === 0) return [];
      
      const amounts = trend.map(item => {
        const v = item.salesAmount ?? item.amount ?? item.value;
        return typeof v === 'string' ? parseFloat(v) : Number(v);
      }).filter(n => !isNaN(n) && n >= 0);
      
      const max = amounts.length > 0 ? Math.max(...amounts) : 1;
      
      console.log('daily max:', max);
      console.log('daily amounts:', amounts);
      
      return trend.map(item => {
        const v = item.salesAmount ?? item.amount ?? item.value;
        const num = typeof v === 'string' ? parseFloat(v) : Number(v);
        const pct = isNaN(num) || num < 0 ? 0 : (num / max) * 100;
        const height = Math.max(pct, 5);
        console.log(`date: ${item.date}, value: ${num}, height: ${height}%`);
        return height;
      });
    });

    const monthlyBarHeights = computed(() => {
      const trend = statistics.value?.monthlyTrend || [];
      if (trend.length === 0) return [];
      
      const amounts = trend.map(item => {
        const v = item.salesAmount ?? item.amount ?? item.value;
        return typeof v === 'string' ? parseFloat(v) : Number(v);
      }).filter(n => !isNaN(n) && n >= 0);
      
      const max = amounts.length > 0 ? Math.max(...amounts) : 1;
      
      return trend.map(item => {
        const v = item.salesAmount ?? item.amount ?? item.value;
        const num = typeof v === 'string' ? parseFloat(v) : Number(v);
        const pct = isNaN(num) || num < 0 ? 0 : (num / max) * 100;
        return Math.max(pct, 5);
      });
    });

    const formatDate = (dateStr) => {
      if (!dateStr) return '';
      const date = new Date(dateStr);
      return `${date.getMonth() + 1}/${date.getDate()}`;
    };

    const formatMonth = (monthStr) => {
      if (!monthStr) return '';
      return monthStr.slice(5);
    };

    const getLineX = (index, total) => {
      if (total <= 1) return 200;
      return 30 + (index / (total - 1)) * 340;
    };

    const getLineY = (heightPercent) => {
      return 190 - (heightPercent || 0) * 1.7;
    };

    const dailyLinePath = computed(() => {
      const heights = dailyBarHeights.value;
      if (!heights.length) return '';
      return heights.map((h, i) => {
        const x = getLineX(i, heights.length);
        const y = getLineY(h);
        return `${i === 0 ? 'M' : 'L'} ${x} ${y}`;
      }).join(' ');
    });

    const dailyAreaPath = computed(() => {
      const heights = dailyBarHeights.value;
      if (!heights.length) return '';
      const linePath = heights.map((h, i) => {
        const x = getLineX(i, heights.length);
        const y = getLineY(h);
        return `${i === 0 ? 'M' : 'L'} ${x} ${y}`;
      }).join(' ');
      const lastX = getLineX(heights.length - 1, heights.length);
      return `${linePath} L ${lastX} 190 L 30 190 Z`;
    });

    const monthlyLinePath = computed(() => {
      const heights = monthlyBarHeights.value;
      if (!heights.length) return '';
      return heights.map((h, i) => {
        const x = getLineX(i, heights.length);
        const y = getLineY(h);
        return `${i === 0 ? 'M' : 'L'} ${x} ${y}`;
      }).join(' ');
    });

    const monthlyAreaPath = computed(() => {
      const heights = monthlyBarHeights.value;
      if (!heights.length) return '';
      const linePath = heights.map((h, i) => {
        const x = getLineX(i, heights.length);
        const y = getLineY(h);
        return `${i === 0 ? 'M' : 'L'} ${x} ${y}`;
      }).join(' ');
      const lastX = getLineX(heights.length - 1, heights.length);
      return `${linePath} L ${lastX} 190 L 30 190 Z`;
    });

    onMounted(() => {
      fetchStatistics();
      fetchStockWarningThreshold();
    });

    return {
      statistics,
      stockWarningThreshold,
      isEditingThreshold,
      editThreshold,
      dailyBarHeights,
      monthlyBarHeights,
      dailyLinePath,
      dailyAreaPath,
      monthlyLinePath,
      monthlyAreaPath,
      getLineX,
      getLineY,
      formatDate,
      formatMonth,
      startEditThreshold,
      saveThreshold,
      cancelEditThreshold
    };
  }
};
</script>

<style scoped>
.statistics-page {
  padding: 20px;
}

.page-title {
  font-size: 24px;
  font-weight: 600;
  color: #333;
  margin-bottom: 24px;
}

.summary-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 20px;
  margin-bottom: 24px;
}

.card {
  background: white;
  border-radius: 12px;
  padding: 20px;
  display: flex;
  align-items: center;
  gap: 16px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.card-icon {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.orders-icon {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.sales-icon {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.goods-icon {
  background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
}

.users-icon {
  background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
}

.card-content {
  flex: 1;
}

.card-value {
  font-size: 28px;
  font-weight: 700;
  color: #333;
}

.card-label {
  font-size: 14px;
  color: #666;
  margin-top: 4px;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 20px;
}

.section {
  background: white;
  border-radius: 12px;
  padding: 20px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.section h3 {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #eee;
}

.warning-threshold {
  font-size: 12px;
  font-weight: 400;
  color: #e74c3c;
  background: #fef5f5;
  padding: 2px 8px;
  border-radius: 4px;
  margin-left: 8px;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid #eee;
}

.section-header h3 {
  font-size: 16px;
  font-weight: 600;
  color: #333;
  margin-bottom: 0;
  padding-bottom: 0;
  border-bottom: none;
}

.threshold-edit {
  display: flex;
  align-items: center;
  gap: 8px;
}

.threshold-label {
  font-size: 14px;
  color: #666;
}

.threshold-value {
  font-size: 14px;
  font-weight: 600;
  color: #e74c3c;
  background: #fef5f5;
  padding: 4px 12px;
  border-radius: 4px;
}

.threshold-input {
  width: 80px;
  padding: 4px 8px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 14px;
  text-align: center;
}

.threshold-input:focus {
  outline: none;
  border-color: #667eea;
}

.edit-btn,
.save-btn,
.cancel-btn {
  padding: 4px 12px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.edit-btn {
  background: #667eea;
  color: white;
}

.edit-btn:hover {
  background: #5a6fd6;
}

.save-btn {
  background: #27ae60;
  color: white;
}

.save-btn:hover {
  background: #219a52;
}

.cancel-btn {
  background: #95a5a6;
  color: white;
}

.cancel-btn:hover {
  background: #7f8c8d;
}

.today-grid {
  display: flex;
  gap: 20px;
}

.today-item {
  flex: 1;
  text-align: center;
  padding: 16px;
  background: #f8f9fa;
  border-radius: 8px;
}

.today-label {
  display: block;
  font-size: 14px;
  color: #666;
  margin-bottom: 8px;
}

.today-value {
  font-size: 24px;
  font-weight: 700;
  color: #333;
}

.distribution-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.distribution-item {
  display: flex;
  align-items: center;
  gap: 12px;
}

.dist-label {
  width: 80px;
  font-size: 14px;
  color: #666;
}

.dist-bar-wrap {
  flex: 1;
  height: 8px;
  background: #f0f0f0;
  border-radius: 4px;
  overflow: hidden;
}

.dist-bar {
  height: 100%;
  background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
  border-radius: 4px;
  transition: width 0.3s ease;
}

.dist-bar.payment {
  background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
}

.dist-value {
  width: 80px;
  text-align: right;
  font-size: 14px;
  color: #666;
}

.user-stats {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.user-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px;
  background: #f8f9fa;
  border-radius: 8px;
}

.user-label {
  font-size: 14px;
  color: #666;
}

.user-value {
  font-size: 20px;
  font-weight: 700;
}

.user-value.admin {
  color: #e74c3c;
}

.user-value.normal {
  color: #3498db;
}

.user-value.unvalidated {
  color: #f39c12;
}

.category-list {
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.category-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 12px;
  background: #f8f9fa;
  border-radius: 6px;
}

.category-name {
  font-size: 14px;
  color: #333;
}

.category-count {
  font-size: 14px;
  font-weight: 600;
  color: #667eea;
}

.stock-table {
  width: 100%;
  border-collapse: collapse;
}

.stock-table th,
.stock-table td {
  padding: 10px;
  text-align: left;
  border-bottom: 1px solid #eee;
  font-size: 14px;
}

.stock-table th {
  background: #f8f9fa;
  font-weight: 600;
}

.low-stock {
  color: #e74c3c;
  font-weight: 600;
}

.empty-message {
  text-align: center;
  padding: 20px;
  color: #999;
  font-size: 14px;
}

.trend-section {
  grid-column: span 2;
}

.debug-info {
  padding: 10px;
  background: #fff3cd;
  border-radius: 6px;
  font-size: 12px;
  color: #856404;
  margin-bottom: 10px;
}

.debug-item {
  margin-right: 12px;
}

.debug-max {
  font-weight: 600;
  color: #d63384;
}

.chart-container {
  padding: 20px;
  height: 280px;
  position: relative;
}

.line-chart {
  width: 100%;
  height: 220px;
  background: #fff;
  border-radius: 8px;
}

.grid-lines {
  stroke: #e0e0e0;
  stroke-width: 1;
  stroke-dasharray: 4 4;
}

.data-point {
  cursor: pointer;
  transition: r 0.2s;
}

.data-point:hover {
  r: 8;
}

.data-label {
  font-size: 11px;
  font-weight: 600;
  fill: #667eea;
  pointer-events: none;
}

.chart-labels {
  display: flex;
  justify-content: space-between;
  padding: 0 20px;
  margin-top: 10px;
}

.label-item {
  font-size: 12px;
  color: #666;
}

@media (max-width: 768px) {
  .stats-grid {
    grid-template-columns: 1fr;
  }
  
  .trend-section {
    grid-column: span 1;
  }
  
  .summary-cards {
    grid-template-columns: repeat(2, 1fr);
  }
  
  .today-grid {
    flex-direction: column;
  }
  
  .bar {
    width: 20px;
  }
}
</style>