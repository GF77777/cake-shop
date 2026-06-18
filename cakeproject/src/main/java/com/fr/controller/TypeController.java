package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.common.PageResult;
import com.fr.entity.Type;
import com.fr.service.OperationLogService;
import com.fr.service.TypeService;
import com.fr.util.LogUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class TypeController {

    private static final Logger logger = LoggerFactory.getLogger(TypeController.class);

    @Autowired
    private TypeService typeService;

    @Autowired
    private OperationLogService operationLogService;

    @GetMapping("/types")
    public AjaxResult<List<Type>> getAllTypes() {
        logger.info("接收到查询所有类型请求");
        try {
            List<Type> typeList = typeService.getAllTypes();
            return AjaxResult.success("查询成功", typeList);
        } catch (Exception e) {
            logger.error("查询类型列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/types/page")
    public AjaxResult<PageResult<Type>> getTypesByPage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        logger.info("接收到分页查询类型请求, pageNum={}, pageSize={}", pageNum, pageSize);
        try {
            PageResult<Type> result = typeService.getAllTypesByPage(pageNum, pageSize);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("分页查询类型列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/types")
    public AjaxResult<Integer> addType(@RequestBody Type type) {
        logger.info("接收到添加类型请求: {}", type.getName());
        try {
            int result = typeService.addType(type);
            if (result > 0) {
                LogUtils.log(operationLogService, "ADD", "分类管理", "添加分类: " + type.getName());
                return AjaxResult.success("添加成功", result);
            } else {
                return AjaxResult.error("添加失败");
            }
        } catch (Exception e) {
            logger.error("添加类型失败", e);
            return AjaxResult.error("添加失败");
        }
    }

    @PostMapping("/updateTypes")
    public AjaxResult<Integer> updateType(@RequestBody Type type) {
        logger.info("接收到修改类型请求: {}", type.getId());
        try {
            int result = typeService.updateType(type);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "分类管理", "修改分类 ID: " + type.getId() + ", 名称: " + type.getName());
                return AjaxResult.success("修改成功", result);
            } else {
                return AjaxResult.error("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改类型失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @DeleteMapping("/types")
    public AjaxResult<Integer> deleteType(@RequestParam int id) {
        logger.info("接收到删除类型请求: {}", id);
        try {
            int result = typeService.deleteType(id);
            if (result > 0) {
                LogUtils.log(operationLogService, "DELETE", "分类管理", "删除分类 ID: " + id);
                return AjaxResult.success("删除成功", result);
            } else {
                return AjaxResult.error("删除失败");
            }
        } catch (Exception e) {
            logger.error("删除类型失败", e);
            return AjaxResult.error("删除失败");
        }
    }
}