<template>
  <div>
    <div 
      class="ai-avatar" 
      :class="{ 'active': isOpen, 'dragging': isDragging }"
      :style="{ left: avatarPosition.x + 'px', top: avatarPosition.y + 'px' }"
      @mousedown="startDrag"
      @click="handleAvatarClick"
    >
      <img src="/src/assets/女客服图标.png" alt="AI客服" />
      <span class="pulse" v-if="!isOpen"></span>
    </div>

    <div 
      class="chat-container" 
      v-if="isOpen"
      :style="{ 
        left: chatPosition.x + 'px', 
        top: chatPosition.y + 'px',
        width: chatSize.width + 'px',
        maxHeight: chatSize.height + 'px'
      }"
    >
      <div class="chat-header" @mousedown="startChatDrag">
        <div class="avatar-small">
          <img src="/src/assets/女客服图标.png" alt="小甜" />
        </div>
        <div class="header-info">
          <h3>AI客服 - 小甜</h3>
          <p>在线</p>
        </div>
        <div class="header-actions">
          <button class="action-btn" @click="toggleMinimize" title="最小化">
            <svg v-if="!isMinimized" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M6 18L18 6M6 6l12 12"/>
            </svg>
            <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
            </svg>
          </button>
          <button class="action-btn" @click="resizeChat('small')" title="小窗口">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="3" width="7" height="7"/>
            </svg>
          </button>
          <button class="action-btn" @click="resizeChat('medium')" title="中窗口">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="3" width="11" height="11"/>
            </svg>
          </button>
          <button class="action-btn" @click="resizeChat('large')" title="大窗口">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <rect x="3" y="3" width="18" height="18"/>
            </svg>
          </button>
          <button class="close-btn" @click="isOpen = false">×</button>
        </div>
      </div>

      <div class="chat-messages" ref="messagesContainer" :class="{ 'minimized': isMinimized }">
        <div v-if="!isMinimized">
          <div class="message ai-message">
            <div class="message-avatar">
              <img src="/src/assets/女客服图标.png" alt="小甜" />
            </div>
            <div class="message-content">
              <p>你好呀！我是蛋糕店的AI客服小甜 🍰<br/>有什么可以帮你的吗？</p>
            </div>
          </div>

          <div 
            v-for="(msg, index) in messages" 
            :key="index"
            class="message"
            :class="{ 'user-message': msg.isUser, 'ai-message': !msg.isUser }"
          >
            <div class="message-avatar">
              <img 
                v-if="msg.isUser" 
                src="/src/assets/顾客图标.png" 
                alt="用户" />
              <img 
                v-else 
                src="/src/assets/女客服图标.png" 
                alt="小甜" />
            </div>
            <div class="message-content">
              <p v-html="formatMessage(msg.content)"></p>
            </div>
          </div>

          <div v-if="isLoading" class="message ai-message">
            <div class="message-avatar">
              <img src="/src/assets/女客服图标.png" 
                   alt="小甜" />
            </div>
            <div class="message-content">
              <div class="typing-indicator">
                <span></span>
                <span></span>
                <span></span>
              </div>
            </div>
          </div>
        </div>
        <div v-else class="minimized-content">
          <span>点击展开聊天</span>
        </div>
      </div>

      <div class="chat-input" v-if="!isMinimized">
        <input 
          v-model="inputMessage" 
          type="text" 
          placeholder="输入消息..." 
          @keyup.enter="sendMessage"
          :disabled="isLoading"
        />
        <button 
          @click="sendMessage" 
          :disabled="isLoading || !inputMessage.trim()"
        >
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
            <polyline points="22 4 12 14.01 9 11.01"/>
          </svg>
        </button>
      </div>

      <div class="chat-footer" v-if="!isMinimized">
        <span>Powered by 火山引擎 | 豆包API</span>
      </div>

      <!-- 调整大小手柄 -->
      <div class="resize-handle resize-n" @mousedown="(e) => startResize(e, 'n')" title="向上调整"></div>
      <div class="resize-handle resize-s" @mousedown="(e) => startResize(e, 's')" title="向下调整"></div>
      <div class="resize-handle resize-e" @mousedown="(e) => startResize(e, 'e')" title="向右调整"></div>
      <div class="resize-handle resize-w" @mousedown="(e) => startResize(e, 'w')" title="向左调整"></div>
      <div class="resize-handle resize-ne" @mousedown="(e) => startResize(e, 'ne')" title="右上调整"></div>
      <div class="resize-handle resize-nw" @mousedown="(e) => startResize(e, 'nw')" title="左上调整"></div>
      <div class="resize-handle resize-se" @mousedown="(e) => startResize(e, 'se')" title="右下调整"></div>
      <div class="resize-handle resize-sw" @mousedown="(e) => startResize(e, 'sw')" title="左下调整"></div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, onUnmounted } from 'vue'
import axios from 'axios'

const isOpen = ref(false)
const inputMessage = ref('')
const messages = ref([])
const isLoading = ref(false)
const messagesContainer = ref(null)
const isMinimized = ref(false)

const avatarPosition = reactive({ x: window.innerWidth - 80, y: window.innerHeight - 150 })
const chatPosition = reactive({ x: window.innerWidth - 370, y: window.innerHeight - 650 })

const chatSize = reactive({ 
  width: 350, 
  height: 500 
})

const sizePresets = {
  small: { width: 280, height: 350 },
  medium: { width: 350, height: 500 },
  large: { width: 450, height: 650 }
}

const isDragging = ref(false)
const isChatDragging = ref(false)
const isResizing = ref(false)
const dragStart = reactive({ x: 0, y: 0 })
const positionStart = reactive({ x: 0, y: 0 })
const sizeStart = reactive({ width: 0, height: 0 })

const handleAvatarClick = () => {
  if (!isDragging.value) {
    toggleChat()
  }
}

const toggleChat = () => {
  isOpen.value = !isOpen.value
  if (isOpen.value) {
    chatPosition.x = avatarPosition.x
    chatPosition.y = avatarPosition.y + 80
  }
}

const toggleMinimize = () => {
  isMinimized.value = !isMinimized.value
}

const resizeChat = (size) => {
  const preset = sizePresets[size]
  if (preset) {
    chatSize.width = preset.width
    chatSize.height = preset.height
    adjustPositionAfterResize()
  }
}

const adjustPositionAfterResize = () => {
  const maxX = window.innerWidth - chatSize.width
  const maxY = window.innerHeight - chatSize.height
  chatPosition.x = Math.min(maxX, chatPosition.x)
  chatPosition.y = Math.min(maxY, chatPosition.y)
}

const startDrag = (e) => {
  e.preventDefault()
  e.stopPropagation()
  isDragging.value = true
  dragStart.x = e.clientX
  dragStart.y = e.clientY
  positionStart.x = avatarPosition.x
  positionStart.y = avatarPosition.y
  
  document.addEventListener('mousemove', onDrag)
  document.addEventListener('mouseup', stopDrag)
  
  document.body.style.userSelect = 'none'
  document.body.style.cursor = 'grabbing'
}

const onDrag = (e) => {
  if (!isDragging.value) return
  
  requestAnimationFrame(() => {
    const deltaX = e.clientX - dragStart.x
    const deltaY = e.clientY - dragStart.y
    
    const maxX = window.innerWidth - 60
    const maxY = window.innerHeight - 60
    
    avatarPosition.x = Math.max(0, Math.min(maxX, positionStart.x + deltaX))
    avatarPosition.y = Math.max(0, Math.min(maxY, positionStart.y + deltaY))
    
    if (isOpen.value) {
      chatPosition.x = avatarPosition.x
      chatPosition.y = avatarPosition.y + 80
    }
  })
}

const stopDrag = () => {
  isDragging.value = false
  document.removeEventListener('mousemove', onDrag)
  document.removeEventListener('mouseup', stopDrag)
  
  document.body.style.userSelect = ''
  document.body.style.cursor = ''
}

const startChatDrag = (e) => {
  e.preventDefault()
  e.stopPropagation()
  isChatDragging.value = true
  dragStart.x = e.clientX
  dragStart.y = e.clientY
  positionStart.x = chatPosition.x
  positionStart.y = chatPosition.y
  
  document.addEventListener('mousemove', onChatDrag)
  document.addEventListener('mouseup', stopChatDrag)
  
  document.body.style.userSelect = 'none'
  document.body.style.cursor = 'grabbing'
}

const onChatDrag = (e) => {
  if (!isChatDragging.value) return
  
  requestAnimationFrame(() => {
    const deltaX = e.clientX - dragStart.x
    const deltaY = e.clientY - dragStart.y
    
    const maxX = window.innerWidth - chatSize.width
    const maxY = window.innerHeight - chatSize.height
    
    chatPosition.x = Math.max(0, Math.min(maxX, positionStart.x + deltaX))
    chatPosition.y = Math.max(0, Math.min(maxY, positionStart.y + deltaY))
    
    avatarPosition.x = chatPosition.x
    avatarPosition.y = Math.max(0, chatPosition.y - 80)
  })
}

const stopChatDrag = () => {
  isChatDragging.value = false
  document.removeEventListener('mousemove', onChatDrag)
  document.removeEventListener('mouseup', stopChatDrag)
  
  document.body.style.userSelect = ''
  document.body.style.cursor = ''
}

const resizeDirection = ref('')

const startResize = (e, direction) => {
  e.preventDefault()
  e.stopPropagation()
  isResizing.value = true
  resizeDirection.value = direction
  dragStart.x = e.clientX
  dragStart.y = e.clientY
  sizeStart.width = chatSize.width
  sizeStart.height = chatSize.height
  positionStart.x = chatPosition.x
  positionStart.y = chatPosition.y
  
  document.addEventListener('mousemove', onResize)
  document.addEventListener('mouseup', stopResize)
  
  document.body.style.userSelect = 'none'
  
  const cursorMap = {
    'n': 'ns-resize',
    's': 'ns-resize',
    'e': 'ew-resize',
    'w': 'ew-resize',
    'ne': 'nesw-resize',
    'nw': 'nwse-resize',
    'se': 'nwse-resize',
    'sw': 'nesw-resize'
  }
  document.body.style.cursor = cursorMap[direction] || 'se-resize'
}

const onResize = (e) => {
  if (!isResizing.value) return
  
  requestAnimationFrame(() => {
    const deltaX = e.clientX - dragStart.x
    const deltaY = e.clientY - dragStart.y
    const direction = resizeDirection.value
    
    let newWidth = chatSize.width
    let newHeight = chatSize.height
    let newX = chatPosition.x
    let newY = chatPosition.y
    
    const minWidth = 250
    const minHeight = 200
    const maxWidth = window.innerWidth - 40
    const maxHeight = window.innerHeight - 40
    
    if (direction.includes('e')) {
      newWidth = Math.max(minWidth, Math.min(maxWidth, sizeStart.width + deltaX))
    }
    if (direction.includes('w')) {
      newWidth = Math.max(minWidth, Math.min(maxWidth, sizeStart.width - deltaX))
      newX = positionStart.x + deltaX
    }
    if (direction.includes('s')) {
      newHeight = Math.max(minHeight, Math.min(maxHeight, sizeStart.height + deltaY))
    }
    if (direction.includes('n')) {
      newHeight = Math.max(minHeight, Math.min(maxHeight, sizeStart.height - deltaY))
      newY = positionStart.y + deltaY
    }
    
    chatSize.width = newWidth
    chatSize.height = newHeight
    chatPosition.x = Math.max(0, Math.min(window.innerWidth - chatSize.width, newX))
    chatPosition.y = Math.max(0, Math.min(window.innerHeight - chatSize.height, newY))
    
    avatarPosition.x = chatPosition.x
    avatarPosition.y = Math.max(0, chatPosition.y - 80)
  })
}

const stopResize = () => {
  isResizing.value = false
  document.removeEventListener('mousemove', onResize)
  document.removeEventListener('mouseup', stopResize)
  
  document.body.style.userSelect = ''
  document.body.style.cursor = ''
}

const sendMessage = async () => {
  if (!inputMessage.value.trim() || isLoading.value) return

  const userMessage = inputMessage.value.trim()
  messages.value.push({
    content: userMessage,
    isUser: true
  })
  inputMessage.value = ''
  isLoading.value = true

  await new Promise(resolve => setTimeout(resolve, 100))
  scrollToBottom()

  try {
    const history = messages.value.slice(0, -1).map(m => 
      `${m.isUser ? '用户' : 'AI'}: ${m.content}`
    ).join('\n')

    const response = await axios.post('/api/ai/chat', {
      message: userMessage,
      history: history
    })

    messages.value.push({
      content: response.data.data,
      isUser: false
    })
  } catch (error) {
    messages.value.push({
      content: '抱歉，暂时无法回复，请稍后再试。',
      isUser: false
    })
  } finally {
    isLoading.value = false
    await new Promise(resolve => setTimeout(resolve, 100))
    scrollToBottom()
  }
}

const formatMessage = (content) => {
  if (!content) return ''
  return content.replace(/\\n/g, '\n').replace(/\n/g, '<br/>')
}

const scrollToBottom = () => {
  if (messagesContainer.value) {
    messagesContainer.value.scrollTop = messagesContainer.value.scrollHeight
  }
}

const handleResize = () => {
  const maxX = window.innerWidth - 60
  const maxY = window.innerHeight - 60
  avatarPosition.x = Math.min(maxX, avatarPosition.x)
  avatarPosition.y = Math.min(maxY, avatarPosition.y)
  
  const maxChatX = window.innerWidth - chatSize.width
  const maxChatY = window.innerHeight - chatSize.height
  chatPosition.x = Math.min(maxChatX, chatPosition.x)
  chatPosition.y = Math.min(maxChatY, chatPosition.y)
}

onMounted(() => {
  window.addEventListener('resize', handleResize)
})

onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  document.removeEventListener('mousemove', onDrag)
  document.removeEventListener('mouseup', stopDrag)
  document.removeEventListener('mousemove', onChatDrag)
  document.removeEventListener('mouseup', stopChatDrag)
  document.removeEventListener('mousemove', onResize)
  document.removeEventListener('mouseup', stopResize)
})
</script>

<style scoped>
.ai-avatar {
  position: fixed;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  cursor: grab;
  z-index: 1000;
  transition: transform 0.2s ease, box-shadow 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  background: white;
  padding: 2px;
}

.ai-avatar:hover {
  transform: scale(1.1);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.25);
}

.ai-avatar.active {
  transform: scale(1.1);
}

.ai-avatar.dragging {
  cursor: grabbing;
  transform: scale(1.15);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
}

.ai-avatar img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: contain;
}

.pulse {
  position: absolute;
  top: -5px;
  right: -5px;
  width: 15px;
  height: 15px;
  background: #4CAF50;
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    transform: scale(1);
    opacity: 1;
  }
  50% {
    transform: scale(1.2);
    opacity: 0.7;
  }
  100% {
    transform: scale(1);
    opacity: 1;
  }
}

.chat-container {
  position: fixed;
  max-height: 500px;
  background: white;
  border-radius: 16px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
  z-index: 1001;
  display: flex;
  flex-direction: column;
  overflow: hidden;
  transition: box-shadow 0.2s ease, width 0.2s ease, max-height 0.2s ease;
}

.chat-container:hover {
  box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
}

.chat-header {
  background: linear-gradient(135deg, #333 0%, #555 100%);
  padding: 12px 15px;
  display: flex;
  align-items: center;
  gap: 10px;
  cursor: grab;
  flex-shrink: 0;
}

.chat-header:active {
  cursor: grabbing;
}

.avatar-small {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  overflow: hidden;
  background: white;
  border: 1px solid rgba(255, 255, 255, 0.3);
  display: flex;
  align-items: center;
  justify-content: center;
}

.avatar-small img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.header-info {
  flex: 1;
  min-width: 0;
}

.header-info h3 {
  margin: 0;
  color: white;
  font-size: 15px;
  font-weight: 600;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.header-info p {
  margin: 1px 0 0;
  color: rgba(255, 255, 255, 0.8);
  font-size: 11px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 4px;
}

.action-btn {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  width: 26px;
  height: 26px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
  padding: 0;
}

.action-btn:hover {
  background: rgba(255, 255, 255, 0.3);
}

.action-btn svg {
  width: 14px;
  height: 14px;
}

.close-btn {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  width: 26px;
  height: 26px;
  border-radius: 50%;
  font-size: 16px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background 0.2s;
  margin-left: 4px;
}

.close-btn:hover {
  background: rgba(255, 255, 255, 0.3);
}

.chat-messages {
  flex: 1;
  padding: 12px;
  overflow-y: auto;
  min-height: 100px;
}

.chat-messages.minimized {
  min-height: 60px;
}

.minimized-content {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 60px;
  color: #999;
  font-size: 14px;
}

.message {
  display: flex;
  gap: 8px;
  margin-bottom: 12px;
}

.message-avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  flex-shrink: 0;
  overflow: hidden;
  background: white;
  border: 1px solid #e0e0e0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.message-avatar img {
  width: 100%;
  height: 100%;
  object-fit: contain;
  border-radius: 50%;
}

.message-content {
  max-width: 75%;
}

.message-content p {
  margin: 0;
  padding: 8px 12px;
  border-radius: 16px;
  font-size: 13px;
  line-height: 1.5;
}

.ai-message .message-content p {
  background: #f5f5f5;
  color: #333;
  border-radius: 0 16px 16px 16px;
  border: 1px solid #e0e0e0;
}

.user-message {
  flex-direction: row-reverse;
}

.user-message .message-content p {
  background: linear-gradient(135deg, #333 0%, #555 100%);
  color: white;
  border-radius: 16px 0 16px 16px;
}

.typing-indicator {
  display: flex;
  gap: 3px;
  padding: 8px 12px;
}

.typing-indicator span {
  width: 5px;
  height: 5px;
  background: #555;
  border-radius: 50%;
  animation: typing 1.4s infinite ease-in-out;
}

.typing-indicator span:nth-child(1) { animation-delay: 0s; }
.typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
.typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

@keyframes typing {
  0%, 80%, 100% { transform: scale(0.6); opacity: 0.5; }
  40% { transform: scale(1); opacity: 1; }
}

.chat-input {
  display: flex;
  gap: 8px;
  padding: 10px 12px;
  border-top: 1px solid #f0f0f0;
  flex-shrink: 0;
}

.chat-input input {
  flex: 1;
  padding: 8px 12px;
  border: 1px solid #e0e0e0;
  border-radius: 18px;
  font-size: 13px;
  outline: none;
  transition: border-color 0.3s;
}

.chat-input input:focus {
  border-color: #333;
}

.chat-input input:disabled {
  background: #f5f5f5;
  cursor: not-allowed;
}

.chat-input button {
  width: 36px;
  height: 36px;
  background: linear-gradient(135deg, #333 0%, #555 100%);
  border: none;
  border-radius: 50%;
  color: white;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.2s;
}

.chat-input button:hover:not(:disabled) {
  transform: scale(1.05);
}

.chat-input button:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.chat-input button svg {
  width: 16px;
  height: 16px;
}

.chat-footer {
  padding: 6px 12px;
  background: #f8f8f8;
  text-align: center;
  flex-shrink: 0;
}

.chat-footer span {
  font-size: 10px;
  color: #999;
}

.resize-handle {
  position: absolute;
  background: transparent;
  opacity: 0.6;
  transition: opacity 0.2s;
}

.resize-handle:hover {
  opacity: 1;
}

/* 四个边的调整手柄 */
.resize-n {
  top: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 8px;
  cursor: ns-resize;
}

.resize-s {
  bottom: 0;
  left: 50%;
  transform: translateX(-50%);
  width: 100px;
  height: 8px;
  cursor: ns-resize;
}

.resize-e {
  right: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 8px;
  height: 100px;
  cursor: ew-resize;
}

.resize-w {
  left: 0;
  top: 50%;
  transform: translateY(-50%);
  width: 8px;
  height: 100px;
  cursor: ew-resize;
}

/* 四个角的调整手柄 */
.resize-ne {
  top: 0;
  right: 0;
  width: 16px;
  height: 16px;
  cursor: nesw-resize;
}

.resize-nw {
  top: 0;
  left: 0;
  width: 16px;
  height: 16px;
  cursor: nwse-resize;
}

.resize-se {
  bottom: 4px;
  right: 4px;
  width: 16px;
  height: 16px;
  cursor: nwse-resize;
  background: linear-gradient(135deg, #555 0%, #333 100%);
  border-radius: 4px;
}

.resize-sw {
  bottom: 0;
  left: 0;
  width: 16px;
  height: 16px;
  cursor: nesw-resize;
}

.resize-se::after {
  content: '';
  position: absolute;
  right: 3px;
  bottom: 3px;
  width: 6px;
  height: 6px;
  border-right: 2px solid rgba(255, 255, 255, 0.8);
  border-bottom: 2px solid rgba(255, 255, 255, 0.8);
}

@media (max-width: 420px) {
  .chat-container {
    width: calc(100% - 40px) !important;
    left: 20px !important;
    right: 20px;
    max-height: 70vh !important;
  }
  
  .ai-avatar {
    right: 20px;
    left: auto !important;
  }
  
  .header-actions .action-btn:not(:first-child) {
    display: none;
  }
}
</style>
