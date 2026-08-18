package com.fr.common;

import com.github.pagehelper.PageInfo;

import java.io.Serializable;
import java.util.List;

public class PageResult<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private int pageNum;
    private int pageSize;
    private long total;
    private int pages;
    private List<T> list;

    public PageResult() {
    }

    public PageResult(int pageNum, int pageSize, long total, int pages, List<T> list) {
        this.pageNum = pageNum;
        this.pageSize = pageSize;
        this.total = total;
        this.pages = pages;
        this.list = list;
    }

    public static <T> PageResult<T> of(List<T> list) {
        PageInfo<T> pageInfo = new PageInfo<>(list);
        return new PageResult<>(
                pageInfo.getPageNum(),
                pageInfo.getPageSize(),
                pageInfo.getTotal(),
                pageInfo.getPages(),
                pageInfo.getList()
        );
    }

    public static <T> PageResult<T> of(PageInfo<T> pageInfo) {
        return new PageResult<>(
                pageInfo.getPageNum(),
                pageInfo.getPageSize(),
                pageInfo.getTotal(),
                pageInfo.getPages(),
                pageInfo.getList()
        );
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}