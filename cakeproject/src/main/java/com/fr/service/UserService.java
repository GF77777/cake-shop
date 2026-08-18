package com.fr.service;

import com.fr.common.PageResult;
import com.fr.entity.User;

public interface UserService {
    PageResult<User> getAllUsers(int pageNum, int pageSize);

    User login(String username, String password);

    int register(User user);

    int update(User user);

    int updatePassword(int id, String password);

    int addUser(User user);

    int delete(int id);
}