package com.fr.mapper;

import com.fr.entity.Goods;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface GoodsMapper {
    List<Goods> getAll();

    List<Goods> findByName(@Param("name") String name);

    List<Goods> findHot();

    List<Goods> findNow();

    List<Goods> findHome();

List<Goods> findHomeByType(@Param("typeId") int typeId);

    List<Goods> findRecommend();

List<Goods> findRecommendByType(@Param("type") int type);

    int insert(Goods goods);

    int update(Goods goods);

    int deleteById(int id);

Goods getById(int id);

int reduceStock(@Param("id") int id, @Param("amount") int amount);
}