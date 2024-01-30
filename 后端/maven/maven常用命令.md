// 在项目根目录下执行 注意idea中maven的配置 用自己安装配置的maven 不要用idea自带的 否则可能报环境(jdk)错误等
// 打包
mvn clean package - pl europa - rule - am - DskipTests
// 发布
mvn clean deploy - pl europa - rule - am - DskipTests



mvn clean package - Ptest - pl jupiter - middle / jupiter - rule - am - DskipTests dockerfile: build dockerfile: push

mvn clean package - Ptest dockerfile: build - DskipTests dockerfile: push

// Jupiter
// rule模块
mvn clean package - Ptest - pl jupiter - middle / jupiter - rule - am - DskipTests dockerfile: build dockerfile: push

// parent目录下 打包镜像 并推到镜像服务器
mvn clean package - Ptest - pl jupiter - middle / jupiter - business - am - DskipTests dockerfile: build dockerfile: push

git remote update origin--prune