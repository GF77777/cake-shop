package com.fr.mapper;

import com.fr.entity.Message;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MessageMapper {
    /**
     * 获取骑手消息列表
     * @param riderId 骑手ID
     * @param type 消息类型（可选）
     * @return 消息列表
     */
    List<Message> getMessagesByRiderId(@Param("riderId") Integer riderId, @Param("type") String type);

    /**
     * 添加消息
     * @param message 消息对象
     * @return 影响行数
     */
    int insert(Message message);

    /**
     * 标记消息为已读
     * @param id 消息ID
     * @return 影响行数
     */
    int markAsRead(@Param("id") Integer id);

    /**
     * 获取未读消息数量
     * @param riderId 骑手ID
     * @return 未读数量
     */
    int countUnread(@Param("riderId") Integer riderId);
}