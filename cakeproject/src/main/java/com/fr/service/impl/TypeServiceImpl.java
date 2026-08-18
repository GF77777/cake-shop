package com.fr.service.impl;

import com.fr.common.PageResult;
import com.fr.entity.Type;
import com.fr.mapper.TypeMapper;
import com.fr.service.TypeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TypeServiceImpl implements TypeService {

    private static final Logger logger = LoggerFactory.getLogger(TypeServiceImpl.class);

    @Autowired
    private TypeMapper typeMapper;

    @Override
    public List<Type> getAllTypes() {
        logger.info("查询所有类型");
        return typeMapper.getAll();
    }

    @Override
    public PageResult<Type> getAllTypesByPage(int pageNum, int pageSize) {
        logger.info("分页查询类型, pageNum={}, pageSize={}", pageNum, pageSize);
        PageHelper.startPage(pageNum, pageSize);
        List<Type> list = typeMapper.getAllAsc();
        PageInfo<Type> pageInfo = new PageInfo<>(list);
        return new PageResult<Type>(pageNum, pageSize, pageInfo.getTotal(), pageInfo.getPages(), pageInfo.getList());
    }

    @Override
    public int addType(Type type) {
        logger.info("添加类型: {}", type.getName());
        return typeMapper.insert(type);
    }

    @Override
    public int updateType(Type type) {
        logger.info("修改类型: {}", type.getId());
        return typeMapper.update(type);
    }

    @Override
    public int deleteType(int id) {
        logger.info("删除类型: {}", id);
        return typeMapper.deleteById(id);
    }
}