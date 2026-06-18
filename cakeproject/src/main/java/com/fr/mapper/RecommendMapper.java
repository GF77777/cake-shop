package com.fr.mapper;

import com.fr.entity.Recommend;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface RecommendMapper {
    List<Recommend> getAll();

    List<Map<String, Object>> getAllWithGoodsName();

    int insert(Recommend recommend);

    int deleteById(int id);
}