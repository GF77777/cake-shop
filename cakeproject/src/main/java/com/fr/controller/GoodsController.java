package com.fr.controller;

import com.fr.common.AjaxResult;
import com.fr.entity.Goods;
import com.fr.entity.Recommend;
import com.fr.mapper.RecommendMapper;
import com.fr.service.GoodsService;
import com.fr.service.OperationLogService;
import com.fr.util.LogUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api")
public class GoodsController {

    private static final Logger logger = LoggerFactory.getLogger(GoodsController.class);

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private RecommendMapper recommendMapper;

    @Autowired
    private OperationLogService operationLogService;

    @GetMapping("/goods")
    public AjaxResult<List<Goods>> getAllGoods() {
        logger.info("接收到查询所有商品请求");
        try {
            List<Goods> goodsList = goodsService.getAllGoods();
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询商品列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/byName")
    public AjaxResult<List<Goods>> findByName(@RequestParam String name) {
        logger.info("接收到模糊搜索商品请求: {}", name);
        try {
            List<Goods> goodsList = goodsService.findByName(name);
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("模糊搜索商品失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/findHot")
    public AjaxResult<List<Goods>> findHot() {
        logger.info("接收到查询热销商品请求");
        try {
            List<Goods> goodsList = goodsService.findHot();
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询热销商品失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/findNow")
    public AjaxResult<List<Goods>> findNow() {
        logger.info("接收到查询新品请求");
        try {
            List<Goods> goodsList = goodsService.findNow();
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询新品失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/findHome")
    public AjaxResult<List<Goods>> findHome() {
        logger.info("接收到查询首页横条商品请求");
        try {
            List<Goods> goodsList = goodsService.findHome();
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询首页横条商品失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/findHomeByType")
    public AjaxResult<List<Goods>> findHomeByType(@RequestParam("typeId") int typeId) {
        logger.info("接收到查询首页横条商品请求, typeId={}", typeId);
        try {
            List<Goods> goodsList = goodsService.findHomeByType(typeId);
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询首页横条商品失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/findRecommend")
    public AjaxResult<List<Goods>> findRecommend() {
        logger.info("接收到查询推荐表请求");
        try {
            List<Goods> goodsList = goodsService.findRecommend();
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询推荐表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/findRecommendByType")
    public AjaxResult<List<Goods>> findRecommendByType(@RequestParam("type") int type) {
        logger.info("接收到查询推荐表请求, type={}", type);
        try {
            List<Goods> goodsList = goodsService.findRecommendByType(type);
            return AjaxResult.success("查询成功", goodsList);
        } catch (Exception e) {
            logger.error("查询推荐表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @GetMapping("/recommendList")
    public AjaxResult<List<Map<String, Object>>> getRecommendList() {
        logger.info("接收到查询推荐列表请求");
        try {
            List<Map<String, Object>> list = recommendMapper.getAllWithGoodsName();
            return AjaxResult.success("查询成功", list);
        } catch (Exception e) {
            logger.error("查询推荐列表失败", e);
            return AjaxResult.error("查询失败");
        }
    }

    @PostMapping("/addGoods")
    public AjaxResult<Integer> addGoods(@RequestBody Goods goods) {
        logger.info("接收到添加商品请求: {}", goods.getName());
        logger.info("cover: {}, length: {}", goods.getCover(), goods.getCover() != null ? goods.getCover().length() : 0);
        logger.info("image1: {}, length: {}", goods.getImage1(), goods.getImage1() != null ? goods.getImage1().length() : 0);
        try {
            int result = goodsService.addGoods(goods);
            if (result > 0) {
                LogUtils.log(operationLogService, "ADD", "商品管理", "添加商品: " + goods.getName());
                return AjaxResult.success("添加成功", result);
            } else {
                return AjaxResult.error("添加失败");
            }
        } catch (Exception e) {
            logger.error("添加商品失败", e);
            return AjaxResult.error("添加失败");
        }
    }

    @PostMapping("/updateGoods")
    public AjaxResult<Integer> updateGoods(@RequestBody Goods goods) {
        logger.info("接收到修改商品请求: {}", goods.getId());
        try {
            int result = goodsService.updateGoods(goods);
            if (result > 0) {
                LogUtils.log(operationLogService, "UPDATE", "商品管理", "修改商品 ID: " + goods.getId() + ", 名称: " + goods.getName());
                return AjaxResult.success("修改成功", result);
            } else {
                return AjaxResult.error("修改失败");
            }
        } catch (Exception e) {
            logger.error("修改商品失败", e);
            return AjaxResult.error("修改失败");
        }
    }

    @PostMapping("/addRecommend")
    public AjaxResult<Integer> addRecommend(@RequestBody Recommend recommend) {
        logger.info("接收到添加推荐请求: type={}, goodId={}", recommend.getType(), recommend.getGoodId());
        try {
            int result = recommendMapper.insert(recommend);
            if (result > 0) {
                return AjaxResult.success("添加成功", result);
            } else {
                return AjaxResult.error("添加失败");
            }
        } catch (Exception e) {
            logger.error("添加推荐失败", e);
            return AjaxResult.error("添加失败");
        }
    }

    @DeleteMapping("/goods")
    public AjaxResult<Integer> deleteGoods(@RequestParam int id) {
        logger.info("接收到删除商品请求: {}", id);
        try {
            int result = goodsService.deleteGoods(id);
            if (result > 0) {
                LogUtils.log(operationLogService, "DELETE", "商品管理", "删除商品 ID: " + id);
                return AjaxResult.success("删除成功", result);
            } else {
                return AjaxResult.error("删除失败");
            }
        } catch (Exception e) {
            logger.error("删除商品失败", e);
            return AjaxResult.error("删除失败");
        }
    }

    @DeleteMapping("/deleteRecommend")
    public AjaxResult<Integer> deleteRecommend(@RequestParam int id) {
        logger.info("接收到删除推荐请求: {}", id);
        try {
            int result = recommendMapper.deleteById(id);
            if (result > 0) {
                LogUtils.log(operationLogService, "DELETE", "推荐管理", "删除推荐 ID: " + id);
                return AjaxResult.success("删除成功", result);
            } else {
                return AjaxResult.error("删除失败");
            }
        } catch (Exception e) {
            logger.error("删除推荐失败", e);
            return AjaxResult.error("删除失败");
        }
    }

    @PostMapping("/upload")
    public AjaxResult<String> uploadImage(@RequestParam("file") MultipartFile file) {
        logger.info("接收到图片上传请求");
        try {
            if (file.isEmpty()) {
                return AjaxResult.error("请选择要上传的文件");
            }

            // 获取文件原始名称
            String originalFilename = file.getOriginalFilename();
            // 获取文件扩展名
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }

            // 生成唯一文件名
            String newFilename = UUID.randomUUID().toString() + extension;

            // 上传目录 - 使用项目根目录的绝对路径
            String uploadDir = System.getProperty("user.dir") + "/picture/";
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 保存文件
            File dest = new File(uploadDir + newFilename);
            file.transferTo(dest);

            // 返回文件访问路径
            String filePath = "/picture/" + newFilename;
            return AjaxResult.success("上传成功", filePath);
        } catch (IOException e) {
            logger.error("文件上传失败", e);
            return AjaxResult.error("文件上传失败");
        }
    }
}