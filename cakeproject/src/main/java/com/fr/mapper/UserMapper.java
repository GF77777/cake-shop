package com.fr.mapper;

import com.fr.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {
    /*查询所有用户列表*/
    List<User> getAll();

    /*用户登录*/
    User login(@Param("userName") String username, @Param("passWord") String password);

    /*用户注册*/
    int register(User user);

    /*修改用户(管理员)*/
    int update(User user);

    /*重置密码*/
    int updatePassword(@Param("id") int id, @Param("passWord") String password);

    /*添加用户(管理员)*/
    int addUser(User user);

    /*删除用户*/
    int delete(@Param("id") int id);
}
