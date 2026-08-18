package com.fr.mapper;

import com.fr.entity.Type;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TypeMapper {
    List<Type> getAll();

    List<Type> getAllAsc();

    int insert(Type type);

    int update(Type type);

    int deleteById(int id);
}