package com.fr.service.impl;

import com.fr.common.PageResult;
import com.fr.entity.User;
import com.fr.mapper.UserMapper;
import com.fr.service.UserService;
import com.github.pagehelper.PageHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

    @Autowired
    private UserMapper userMapper;

    @Override
    public PageResult<User> getAllUsers(int pageNum, int pageSize) {
        logger.info("查询所有用户列表, pageNum={}, pageSize={}", pageNum, pageSize);
        PageHelper.startPage(pageNum, pageSize);
        List<User> users = userMapper.getAll();
        logger.info("查询到用户数量: {}", users.size());
        return PageResult.of(users);
    }

    @Override
    public User login(String username, String password) {
        logger.info("用户登录, username={}", username);
        User user = userMapper.login(username, password);
        if (user != null) {
            logger.info("用户登录成功, userId={}, userName={}", user.getId(), user.getName());
        } else {
            logger.warn("用户登录失败, username={}", username);
        }
        return user;
    }

    @Override
    public int register(User user) {
        logger.info("用户注册, username={}", user.getUserName());
        int result = userMapper.register(user);
        logger.info("用户注册结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    public int update(User user) {
        logger.info("修改用户信息, userId={}", user.getId());
        int result = userMapper.update(user);
        logger.info("修改用户结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    public int updatePassword(int id, String password) {
        logger.info("重置密码, userId={}", id);
        int result = userMapper.updatePassword(id, password);
        logger.info("重置密码结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    public int addUser(User user) {
        logger.info("添加用户, username={}", user.getUserName());
        int result = userMapper.addUser(user);
        logger.info("添加用户结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }

    @Override
    public int delete(int id) {
        logger.info("删除用户, userId={}", id);
        int result = userMapper.delete(id);
        logger.info("删除用户结果: {}", result > 0 ? "成功" : "失败");
        return result;
    }
}