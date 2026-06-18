package com.fr.mapper;

import com.fr.entity.GoodsSales;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SalesMapper {
    List<GoodsSales> getSalesRanking();
}