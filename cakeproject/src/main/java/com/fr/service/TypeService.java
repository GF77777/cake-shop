package com.fr.service;

import com.fr.common.PageResult;
import com.fr.entity.Type;

import java.util.List;

public interface TypeService {
    List<Type> getAllTypes();

    PageResult<Type> getAllTypesByPage(int pageNum, int pageSize);

    int addType(Type type);

    int updateType(Type type);

    int deleteType(int id);
}