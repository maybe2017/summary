let promise = new Promise(function (resolve, reject) {
    resolve("done");
    reject(new Error("…")); // ignored
    setTimeout(() => resolve("…")); // ignored
});

promise
    .then(result => resultHandle(result), error => errorHandle(error))
    .then(result => resultHandle(result), error => errorHandle(error))
    .then(result => resultHandle(result), error => errorHandle(error))
    .catch(error => errorHandle(error))
    .finally(finalHandle);

// then()接收2个函数，一个用来处理正常结果result，一个用来处理error
// catch的范围？
// catch处理后，代码下一句定位在哪里？    
// finally清理操作，比如发起网络请求后，可以停止loading显示