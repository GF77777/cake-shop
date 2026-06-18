package com.fr.mapper;

import com.fr.entity.Rider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RiderMapper {
    Rider login(@Param("userName") String userName, @Param("passWord") String passWord);

    Rider getById(int id);

    Rider getByUserName(String userName);

    List<Rider> getAll();

    int addRider(Rider rider);

    int updateRider(Rider rider);

    int updateRiderProfile(Rider rider);

    int updatePassword(int id, String password);

    int updateStatus(@Param("id") int id, @Param("status") int status);

    int deleteRider(int id);
}