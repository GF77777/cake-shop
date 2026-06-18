package com.fr.controller;

import com.fr.entity.Message;
import com.fr.service.MessageService;
import com.fr.common.AjaxResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/message")
public class MessageController {

    private static final Logger logger = LoggerFactory.getLogger(MessageController.class);

    @Resource
    private MessageService messageService;

    /**
     * 获取骑手消息列表
     * @param riderId 骑手ID
     * @param type 消息类型（可选）
     * @return 消息列表
     */
    @GetMapping("/list")
    public AjaxResult<List<Message>> getMessages(
            @RequestParam("riderId") Integer riderId,
            @RequestParam(value = "type", required = false) String type) {
        logger.info("接收到获取骑手消息列表请求, riderId={}, type={}", riderId, type);
        try {
            List<Message> messages = messageService.getMessagesByRiderId(riderId, type);
            return AjaxResult.success("查询成功", messages);
        } catch (Exception e) {
            logger.error("获取消息列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    /**
     * 标记消息为已读
     * @param messageId 消息ID
     * @return 操作结果
     */
    @PutMapping("/read")
    public AjaxResult<Void> markAsRead(@RequestBody Map<String, Integer> request) {
        Integer messageId = request.get("messageId");
        logger.info("接收到标记消息已读请求, messageId={}", messageId);
        try {
            boolean success = messageService.markAsRead(messageId);
            if (success) {
                return AjaxResult.success("标记成功", null);
            } else {
                return AjaxResult.error("标记失败");
            }
        } catch (Exception e) {
            logger.error("标记消息已读失败", e);
            return AjaxResult.error("标记失败");
        }
    }

    /**
     * 获取未读消息数量
     * @param riderId 骑手ID
     * @return 未读数量
     */
    @GetMapping("/unread/count")
    public AjaxResult<Map<String, Integer>> getUnreadCount(@RequestParam("riderId") Integer riderId) {
        logger.info("接收到获取未读消息数量请求, riderId={}", riderId);
        try {
            int count = messageService.countUnread(riderId);
            Map<String, Integer> result = new HashMap<>();
            result.put("count", count);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取未读消息数量失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    /**
     * 添加消息
     * @param message 消息对象
     * @return 操作结果
     */
    @PostMapping("/add")
    public AjaxResult<Void> addMessage(@RequestBody Message message) {
        logger.info("接收到添加消息请求, riderId={}, type={}, title={}", 
                message.getRiderId(), message.getType(), message.getTitle());
        try {
            boolean success = messageService.addMessage(
                    message.getRiderId(), 
                    message.getType(), 
                    message.getTitle(), 
                    message.getContent()
            );
            if (success) {
                return AjaxResult.success("添加成功", null);
            } else {
                return AjaxResult.error("添加失败");
            }
        } catch (Exception e) {
            logger.error("添加消息失败", e);
            return AjaxResult.error("添加失败");
        }
    }

    /**
     * 管理员发布系统公告
     * @param request 包含title和content
     * @return 操作结果
     */
    @PostMapping("/announcement")
    public AjaxResult<Void> publishAnnouncement(@RequestBody Map<String, String> request) {
        String title = request.get("title");
        String content = request.get("content");
        logger.info("接收到发布系统公告请求, title={}", title);
        try {
            boolean success = messageService.sendToAllRiders("system", title, content);
            if (success) {
                return AjaxResult.success("发布成功", null);
            } else {
                return AjaxResult.error("发布失败");
            }
        } catch (Exception e) {
            logger.error("发布系统公告失败", e);
            return AjaxResult.error("发布失败");
        }
    }
}