## 对象的解构赋值
1. 可以直接取出对象中的一个、或多个属性: const {search} = this.props.location
2. 函数参数名称与对象中的key一致时，{key:value} 可以简写为{key}
3. 注意使用对象的简写方式
4. 箭头函数返回一个对象时，可简写为 const simpleFunction = data => ({key:value}); 即用()将对象包裹起来。

## 字符串操作
1. str.slice(start, end)，返回`新对象`，相当于Java的subString; slice针对数组也可以。
2.  方法用于

## 数组操作 https://blog.csdn.net/yingbbai/article/details/128905005
### array.slice(start, end) - 通过索引位置获取新的数组，该方法不会修改原数组，只是返回一个`新的子数组`
1. 索引如果是负数，则表示从数组尾部开始算起 (-1指最后一个元素，-2 指倒数第二个元素，以此类推)

### array.splice(index, count, items..) - 删除、替换或添加数组中的元素
1. index为下标，从0开始
2. 只有 index 和 count 时, count > 0，splice(0, 2) 方法实现删除功能, 同时返回所删除的元素;
3. 参数为 3 个以上，count > 0，splice(0, 2, replaceObj1, replaceObj2) 方法实现替换功能，同时返回所替换的元素;
4. 参数为 3 个以上，count = 0，splice(2, 0, addItem1, addItem1) 方法实现新增功能，添加元素到index=2位置上;


### if判断时
1. 使用布尔类型时，0、空字符串、'0'三者在布尔类型中都代表false【特别注意0也是false】
2. undefined和null被转换为布尔值的时候，两者都为false
3. undefined == null，结果为true都表示一个空值，两者判断值相等上是一样的 【undefined不是关键字，而null是关键字；undefined本质上是window的一个属性，而null是一个对象】
4. 【null表示一个空对象指针，而undefined表示一个未定义的值】使用typeof运算符检查一个null值时，返回的结果是“object”。而如果检查一个未声明的变量时，返回的结果是undefined

### promise
1. 把它理解为一个 异步操作(eg:发请求), 且最终要么有成功值, 要么有失败原因。
2. 认为是一个代理, 代表一个在创建 promise 时不一定已知的值。其内部状态可为:【pending、fulfilled、rejected】
3. 如果创建? 创建的时候，需要传一个称为excutor执行器的函数, 特殊的是, 这个函数必须再包含`resolve, reject`两个参数，这两个参数是JS引擎自动创建的函数，我们无需自己创建，只需将其作为参数传入就好，它们的作用是`用来传递异步操作的结果`。
    ```
    // 创建时，参数为一个函数，函数又带两个参数(参数是js引擎提供) ==>> 固定语法, 不用纠结!
    // resolve, reject函数的作用，是用来修改promise内部对象{state,result} ??
    let promise = new Promise((resolve, reject) => {
        // 函数里面写业务逻辑，比如异步操作: 发送请求
        axios.get(url, {params,...config})
        .then(res => {
            // 成功
            resolve(res.data); 
            console.log(2); // 会执行的，但是resolve加上return，后面的不会再执行了
        })
        .catch(err => {
            // 失败
            reject(err.data);
        })
    })
    ```
4. 一般来说，调用resolve或reject以后，Promise 的使命就完成了，后继操作应该放到then方法里面，而不应该直接写在resolve或reject的后面。所以，最好在它们前面加上return语句，这样就不会有意外。
5. Promise 会吃掉错误。即使没有使用catch()方法指定错误处理的回调函数，Promise对象抛出的错误不会传递到外层代码，即不会影响到外部其他代码逻辑。
6. 那么当这个promise(异步操作执行结束)有最终值时, 可以通过调用then(成功回调, 异常回调)方法来处理; 注意这个`异常回调`函数, 它可以不传, 但是如果写了, 警惕直接吃掉异常, 让逻辑继续向下一个then执行这种情况！
   ```
   fetch('url')
   .then(
    response => response.json(),
    error => {
        // 1. 警惕直接吃掉异常。如果这里返回了立即值, 那么当前then返回的promise状态是`fulfilled`,
        // 就会执行下一个then的`处理正常结果函数`, 这种情况是不符合期望逻辑的!!
        // 2. 如何中断呢？不让再向下走其他的then, 返回一个初始状态的Promise即可 !!
        // return new Promise(()=>{});
    })
   .then(data => console.log(data))

   ```
7. 把`excutor执行器函数` 理解为生产者, then或catch等理解为消费者   
8. 值得注意的是，promise.then( handleFunction ) 中的handleFunction可以返回立即值，也可以返回promise对象。如果返回立即值，则可以直接把结果传入到下一步的.then进行处理，【此时当前then返回的promise结果: {state:fulfilled, result:立即值}】
9. 但是如果返回的是promise对象【就用其作为当前then的返回promise】，那么一定要等到这个返回的promise处理完，拿到结果后，才会进行下一步的.then处理。

### XHR 与 fetch
1. XHR = XmlHttpRequest, 因为其api【不符合关注分离原则】, 所以产生了Jquery(回调地狱)与 基于Promise的 `axios` 两个第三方库。
2. fetch不是第三方库, 是浏览器自带的原生函数，也是Promise风格的。其关注分离体现在: 
   ```
   // 关注点1: fetch返回的promise结果仅表示 是否成功访问服务器, 成功则返回response
   fetch('url')
   // 关注点2: 如果成功访问了服务器, 则执行then中的成功回调, 获取response完整的远程数据并将其解析为json形式(异步)
   // 注意: 【.then返回的response.json()也是一个promise，所以才能继续.then】
   .then(response => response.json())
   // response.json()的成功返回结果作参数传给下一个then的参数data
   .then(data => console.log(data))
   // 关注点3: 如果流程任意异常
   .catch(error => console.log(error));

   ```
3.【.then返回的response.json()也是一个promise，所以才能继续.then】    

### await/async
1. await必须写在async函数中
2. async函数返回的是 Promise 对象, await命令后面，可以是 Promise 对象和原始类型的值(数值、字符串和布尔值会自动转成 resolved 的 Promise 对象)
3. 任何一个await语句后面的 Promise 对象变为reject状态，那么整个async函数都会中断执行;【await只能等到成功的结果】

    ```
    let searchXxx = aysnc() => {
        try{
            const response = await fetch('url');
            const data = await response.json();
        } catch(error) {
            console.log("请求异常", error)
        }
    }
    ```
