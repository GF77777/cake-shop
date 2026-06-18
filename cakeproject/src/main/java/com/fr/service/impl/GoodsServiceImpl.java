package com.fr.service.impl;

import com.fr.entity.Goods;
import com.fr.mapper.GoodsMapper;
import com.fr.service.GoodsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {

    private static final Logger logger = LoggerFactory.getLogger(GoodsServiceImpl.class);

    @Autowired
    private GoodsMapper goodsMapper;

    @Override
    public List<Goods> getAllGoods() {
        logger.info("查询所有商品列表");
        List<Goods> goodsList = goodsMapper.getAll();
        logger.info("查询到商品数量: {}", goodsList.size());
        return goodsList;
    }

    @Override
    public List<Goods> findByName(String name) {
        logger.info("模糊搜索商品: {}", name);
        List<Goods> goodsList = goodsMapper.findByName(name);
        logger.info("搜索到商品数量: {}", goodsList.size());
        return goodsList;
    }

    @Override
    public List<Goods> findHot() {
        logger.info("查询热销商品");
        return goodsMapper.findHot();
    }

    @Override
    public List<Goods> findNow() {
        logger.info("查询新品");
        return goodsMapper.findNow();
    }

    @Override
    public List<Goods> findHome() {
        logger.info("查询首页横条商品");
        return goodsMapper.findHome();
    }

    @Override
    public List<Goods> findHomeByType(int typeId) {
        logger.info("查询首页横条商品, typeId={}", typeId);
        return goodsMapper.findHomeByType(typeId);
    }

    @Override
    public List<Goods> findRecommend() {
        logger.info("查询推荐表商品");
        return goodsMapper.findRecommend();
    }

    @Override
    public List<Goods> findRecommendByType(int type) {
        logger.info("查询推荐表商品, type={}", type);
        return goodsMapper.findRecommendByType(type);
    }

    @Override
    public int addGoods(Goods goods) {
        logger.info("添加商品: {}", goods.getName());
        return goodsMapper.insert(goods);
    }

    @Override
    public int updateGoods(Goods goods) {
        logger.info("修改商品: {}", goods.getId());
        return goodsMapper.update(goods);
    }

    @Override
    public int deleteGoods(int id) {
        logger.info("删除商品: {}", id);
        return goodsMapper.deleteById(id);
    }
}