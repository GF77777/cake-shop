package com.fr.service.impl;

import com.fr.entity.GoodsSales;
import com.fr.mapper.SalesMapper;
import com.fr.service.SalesService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalesServiceImpl implements SalesService {

    private static final Logger logger = LoggerFactory.getLogger(SalesServiceImpl.class);

    @Autowired
    private SalesMapper salesMapper;

    @Override
    public List<GoodsSales> getSalesRanking() {
        logger.info("查询商品销量排行");
        return salesMapper.getSalesRanking();
    }
}