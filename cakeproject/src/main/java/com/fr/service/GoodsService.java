package com.fr.service;

import com.fr.entity.Goods;

import java.util.List;

public interface GoodsService {
    List<Goods> getAllGoods();

    List<Goods> findByName(String name);

    List<Goods> findHot();

    List<Goods> findNow();

    List<Goods> findHome();

    List<Goods> findHomeByType(int typeId);

    List<Goods> findRecommend();

List<Goods> findRecommendByType(int type);

    int addGoods(Goods goods);

    int updateGoods(Goods goods);

    int deleteGoods(int id);
}