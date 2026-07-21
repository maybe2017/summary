
##
sudo docker compose up -d

## minio 手动创建buket
 
http://10.1.248.14:9001/ 
minioroot
minioroot1

###
1. sudo docker pull minio/mc
2. sudo docker run --rm --network host -v mc-config:/root/.mc minio/mc alias set myminio http://127.0.0.1:9000 minioroot minioroot1
3. 界面手动创建 oss-zhibanzhishou
4. docker run --rm --network host -v mc-config:/root/.mc minio/mc anonymous set download myminio/oss-zhibanzhishou

### 倒库
mysqldump \
--host=127.0.0.1 --port=3306 -uroot -prootroot \
--default-character-set=utf8mb4 \
--single-transaction \
--set-gtid-purged=OFF \
--routines --triggers \
zbzs | \
mysql \
--host=10.1.248.14 --port=3306 -uroot -prootroot \
--default-character-set=utf8mb4 \
zbzs