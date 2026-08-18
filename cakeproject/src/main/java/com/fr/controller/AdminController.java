package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.common.PageResult;
import com.fr.entity.Rider;
import com.fr.service.RiderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    private RiderService riderService;

    @GetMapping("/riders")
    public AjaxResult<PageResult<Rider>> getRiders(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) String keyword) {
        logger.info("管理员获取骑手列表, pageNum={}, pageSize={}, keyword={}", pageNum, pageSize, keyword);
        try {
            PageResult<Rider> result = riderService.getRidersWithPage(pageNum, pageSize, keyword);
            return AjaxResult.success("查询成功", result);
        } catch (Exception e) {
            logger.error("获取骑手列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/riders/{id}")
    public AjaxResult<Rider> getRiderById(@PathVariable int id) {
        logger.info("管理员获取骑手详情, id={}", id);
        try {
            Rider rider = riderService.getById(id);
            if (rider != null) {
                return AjaxResult.success("查询成功", rider);
            } else {
                return AjaxResult.fail("骑手不存在");
            }
        } catch (Exception e) {
            logger.error("获取骑手详情失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/riders")
    public AjaxResult<Void> addRider(@RequestBody Rider rider) {
        logger.info("管理员添加骑手, userName={}", rider.getUserName());
        try {
            int result = riderService.addRider(rider);
            if (result > 0) {
                return AjaxResult.success("添加成功", null);
            } else {
                return AjaxResult.fail("添加失败");
            }
        } catch (Exception e) {
            logger.error("添加骑手失败", e);
            return AjaxResult.error("添加失败");
        }
    }

    @PutMapping("/riders/{id}")
    public AjaxResult<Void> updateRider(@PathVariable int id, @RequestBody Rider rider) {
        logger.info("管理员修改骑手, id={}", id);
        try {
            rider.setId(id);
            int result = riderService.updateRider(rider);
            if (result > 0) {
                return AjaxResult.success("修改成功", null);
            } else {
                return AjaxResult.fail("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改骑手失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @DeleteMapping("/riders/{id}")
    public AjaxResult<Void> deleteRider(@PathVariable int id) {
        logger.info("管理员删除骑手, id={}", id);
        try {
            int result = riderService.deleteRider(id);
            if (result > 0) {
                return AjaxResult.success("删除成功", null);
            } else {
                return AjaxResult.fail("删除失败");
            }
        } catch (Exception e) {
            logger.error("删除骑手失败", e);
            return AjaxResult.error("删除失败");
        }
    }

    @PutMapping("/riders/{id}/status")
    public AjaxResult<Void> updateRiderStatus(@PathVariable int id, @RequestBody Map<String, Integer> request) {
        Integer status = request.get("status");
        logger.info("管理员更新骑手状态, id={}, status={}", id, status);
        try {
            int result = riderService.updateStatus(id, status);
            if (result > 0) {
                return AjaxResult.success("更新成功", null);
            } else {
                return AjaxResult.fail("更新失败");
            }
        } catch (Exception e) {
            logger.error("更新骑手状态失败", e);
            return AjaxResult.error("更新失败");
        }
    }
}
