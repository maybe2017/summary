package com.iflytek.obu.operate.common.config.dm;

import cn.hutool.extra.spring.SpringUtil;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.github.pagehelper.autoconfigure.PageHelperProperties;
import dm.jdbc.driver.DmDriver;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.Resource;
import java.util.Objects;

@Configuration
public class MybatisPlusConfig {

    @Resource
    private DataSourceProperties dataSourceProperties;

    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        if (Objects.nonNull(dataSourceProperties) && DmDriver.class.getName().equals(dataSourceProperties.getDriverClassName())) {
            interceptor.addInnerInterceptor(new DM8Interceptor());
            // spring已经识别出要用dm驱动，所以此处不用显示指定分页dbType为dm
            // 但是需要指定Reasonable参数
            // 解决分页插件适配的问题
            SpringUtil.getBean(PageHelperProperties.class).setReasonable("true");
        }
        return interceptor;
    }
}
