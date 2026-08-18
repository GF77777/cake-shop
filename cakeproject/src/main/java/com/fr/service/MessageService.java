package com.fr.service;

import com.fr.entity.Message;

import java.util.List;

public interface MessageService {
    /**
     * 获取骑手消息列表
     * @param riderId 骑手ID
     * @param type 消息类型（可选）
     * @return 消息列表
     */
    List<Message> getMessagesByRiderId(Integer riderId, String type);

    /**
     * 添加消息
     * @param riderId 骑手ID
     * @param type 消息类型
     * @param title 消息标题
     * @param content 消息内容
     * @return 是否成功
     */
    boolean addMessage(Integer riderId, String type, String title, String content);

    /**
     * 标记消息为已读
     * @param messageId 消息ID
     * @return 是否成功
     */
    boolean markAsRead(Integer messageId);

    /**
     * 获取未读消息数量
     * @param riderId 骑手ID
     * @return 未读数量
     */
    int countUnread(Integer riderId);

    /**
     * 发送消息给所有骑手
     * @param type 消息类型
     * @param title 消息标题
     * @param content 消息内容
     * @return 是否成功
     */
    boolean sendToAllRiders(String type, String title, String content);
}