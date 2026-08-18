package com.fr.entity;

import java.util.Date;

public class Message {
    private Integer id;
    private Integer riderId;
    private String type;
    private String title;
    private String content;
    private Integer isRead;
    private Date createTime;

    public Message() {
    }

    public Message(Integer riderId, String type, String title, String content) {
        this.riderId = riderId;
        this.type = type;
        this.title = title;
        this.content = content;
        this.isRead = 0;
        this.createTime = new Date();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRiderId() {
        return riderId;
    }

    public void setRiderId(Integer riderId) {
        this.riderId = riderId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getIsRead() {
        return isRead;
    }

    public void setIsRead(Integer isRead) {
        this.isRead = isRead;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id=" + id +
                ", riderId=" + riderId +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", isRead=" + isRead +
                ", createTime=" + createTime +
                '}';
    }
}