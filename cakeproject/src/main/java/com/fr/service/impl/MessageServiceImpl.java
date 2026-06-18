package com.fr.service.impl;

import com.fr.entity.Message;
import com.fr.entity.Rider;
import com.fr.mapper.MessageMapper;
import com.fr.mapper.RiderMapper;
import com.fr.service.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service
public class MessageServiceImpl implements MessageService {

    private static final Logger logger = LoggerFactory.getLogger(MessageServiceImpl.class);

    @Resource
    private MessageMapper messageMapper;

    @Resource
    private RiderMapper riderMapper;

    @Override
    public List<Message> getMessagesByRiderId(Integer riderId, String type) {
        logger.info("获取骑手消息列表, riderId={}, type={}", riderId, type);
        return messageMapper.getMessagesByRiderId(riderId, type);
    }

    @Override
    public boolean addMessage(Integer riderId, String type, String title, String content) {
        logger.info("添加消息, riderId={}, type={}, title={}", riderId, type, title);
        try {
            Message message = new Message();
            message.setRiderId(riderId);
            message.setType(type);
            message.setTitle(title);
            message.setContent(content);
            message.setIsRead(0);
            message.setCreateTime(new Date());
            messageMapper.insert(message);
            return true;
        } catch (Exception e) {
            logger.error("添加消息失败", e);
            return false;
        }
    }

    @Override
    public boolean markAsRead(Integer messageId) {
        logger.info("标记消息已读, messageId={}", messageId);
        try {
            messageMapper.markAsRead(messageId);
            return true;
        } catch (Exception e) {
            logger.error("标记消息已读失败", e);
            return false;
        }
    }

    @Override
    public int countUnread(Integer riderId) {
        return messageMapper.countUnread(riderId);
    }

    @Override
    public boolean sendToAllRiders(String type, String title, String content) {
        logger.info("发送消息给所有骑手, type={}, title={}", type, title);
        try {
            List<Rider> riders = riderMapper.getAll();
            for (Rider rider : riders) {
                Message message = new Message();
                message.setRiderId(rider.getId());
                message.setType(type);
                message.setTitle(title);
                message.setContent(content);
                message.setIsRead(0);
                message.setCreateTime(new Date());
                messageMapper.insert(message);
            }
            return true;
        } catch (Exception e) {
            logger.error("发送消息给所有骑手失败", e);
            return false;
        }
    }
}