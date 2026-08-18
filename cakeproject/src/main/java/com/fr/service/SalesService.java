package com.fr.service;

import com.fr.entity.GoodsSales;

import java.util.List;

public interface SalesService {
    List<GoodsSales> getSalesRanking();
}