package com.iflytek.obu.operate.common.config.dm;

import com.baomidou.mybatisplus.core.toolkit.PluginUtils;
import com.baomidou.mybatisplus.extension.parser.JsqlParserSupport;
import com.baomidou.mybatisplus.extension.plugins.inner.InnerInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class DM8Interceptor extends JsqlParserSupport implements InnerInterceptor {

    private final static Map<String, String> NEED_REPLACE_KEYS_MAP = new HashMap<>();
    private static final String NOW_UP_CASE_KEY = "NOW()";
    private static final String NOW_LOW_CASE_KEY = "now()";
    private static final String BACK_QUOTE_KEY = "`";
    private static final String INTERVAL_MINUTE_KEY = "interval ? MINUTE";

    static {
        NEED_REPLACE_KEYS_MAP.put(BACK_QUOTE_KEY, "");
        NEED_REPLACE_KEYS_MAP.put(NOW_UP_CASE_KEY, "sysdate()");
        NEED_REPLACE_KEYS_MAP.put(NOW_LOW_CASE_KEY, "sysdate()");
        NEED_REPLACE_KEYS_MAP.put(INTERVAL_MINUTE_KEY, "interval '?' MINUTE");
    }

    @Override
    public void beforePrepare(StatementHandler sh, Connection connection, Integer transactionTimeout) {
        PluginUtils.MPStatementHandler mpSh = PluginUtils.mpStatementHandler(sh);
        PluginUtils.MPBoundSql mpBs = mpSh.mPBoundSql();
        String sql = mpBs.sql();

        log.info("执行查询前，原始sql：{}", sql);
        for (Map.Entry<String, String> entry : NEED_REPLACE_KEYS_MAP.entrySet()) {
            final String key = entry.getKey();
            if (sql.contains(key)) {
                sql = sql.replace(key, entry.getValue());
            }
        }
        log.info("执行查询后，sql：{}", sql);
        mpBs.sql(sql);
    }
}
