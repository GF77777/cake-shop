package com.fr.common;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class AjaxResult<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private int code;
    private String message;
    private T data;
    private String timestamp;

    public AjaxResult() {
        this.timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public AjaxResult(int code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
        this.timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public static <T> AjaxResult<T> success() {
        return new AjaxResult<>(200, "操作成功", null);
    }

    public static <T> AjaxResult<T> success(T data) {
        return new AjaxResult<>(200, "操作成功", data);
    }

    public static <T> AjaxResult<T> success(String message, T data) {
        return new AjaxResult<>(200, message, data);
    }

    public static <T> AjaxResult<T> error() {
        return new AjaxResult<>(500, "操作失败", null);
    }

    public static <T> AjaxResult<T> error(String message) {
        return new AjaxResult<>(500, message, null);
    }

    public static <T> AjaxResult<T> error(int code, String message) {
        return new AjaxResult<>(code, message, null);
    }

    public static <T> AjaxResult<T> fail() {
        return new AjaxResult<>(400, "请求失败", null);
    }

    public static <T> AjaxResult<T> fail(String message) {
        return new AjaxResult<>(400, message, null);
    }

    public static <T> AjaxResult<T> unauthorized() {
        return new AjaxResult<>(401, "未授权", null);
    }

    public static <T> AjaxResult<T> forbidden() {
        return new AjaxResult<>(403, "禁止访问", null);
    }

    public static <T> AjaxResult<T> notFound() {
        return new AjaxResult<>(404, "资源不存在", null);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}