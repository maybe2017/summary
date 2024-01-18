// 导入fs文件操作模块
const fs = require('fs');
/**
 * 读取文件
 * 参数：路径，编码，回调函数(读取报错信息，读取内容)
 * 读取失败 err为错误对象，data值为undefined
 */
fs.readFile('./测试文件.log', "utf-8", function (err, data) {
    if (err) {
        return console.log("读取失败!" + err);
    }
    console.log(data);
    const arrOld = data.split("，");
    const arrNew = [];
    arrOld.forEach(item => arrNew.push(item.replace("=", "：")));

    const newStr = arrNew.join("\n");
    fs.writeFile("./测试文件.log", newStr, "utf-8", function (err, data) {
        if (err) {
            return console.log("写入内容失败!" + err);
        }
        console.log("写入内容成功!");
    })
})