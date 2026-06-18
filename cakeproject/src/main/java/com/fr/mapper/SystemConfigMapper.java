package com.fr.mapper;

import com.fr.entity.SystemConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface SystemConfigMapper {
    SystemConfig getByKey(@Param("configKey") String configKey);

    int updateValue(@Param("configKey") String configKey, @Param("configValue") String configValue);

    int insert(SystemConfig systemConfig);
}