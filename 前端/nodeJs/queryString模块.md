## 引入
## 使用
1. qs.stringify(obj); 是把一个对象，转为 `key=value&key=value` 的字符串形式(称之为urlencoded)。
2. str = "?key=value", qs.parse(str.slice(1)); 是把一个字符串，转为一个对象。