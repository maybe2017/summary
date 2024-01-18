## ECMA
1. 严格模式: 禁止自定义的全局普通函数中的this指向window对象 !!
2. 类中是默认在方法中开启了严格模式，普通方法由类实例调用时，this指向类的实例，方法由外侧调用时，this是undifined
3. 在构造函数中，this就是实例对象
4. 调用this.newFunc = xxFunc.bind(this)会重新生成一个新函数，可赋值给this实例对象上的某一新属性
5. 类中方法是放在类的原型对象上的; 实例对象调用函数时，先在自身找，然后会沿着原型链找..
6. 类中属性是每一个实例对象都有的..

## 普通函数的this
1. 普通函数中的this是谁，得看它是被谁调用的，如果是对象实例，那么this就指向实例对象；也可能是window或undifined..
2. 普通函数作为参数传递的时候，this可能会`隐式丢失`，此时可以在传递做参数时绑定需要的this对象，xxFunc.bind(this|obj) 【xxFunc.apply(newThisObj)或者xxFunc.call(newThisObj)也可以更改函数里的this指向】

## 箭头函数的this
1. 箭头函数的this是静态的，不能被修改。写在对象中时，this为对象的父级；写在类中的时候，this是对象实例【理解将属性在构造函数里初始化的】。
2. 用箭头函数替代普通函数时，需要考虑他的this是不是受影响

## ...展开运算符(也称为rest参数)
1. 用于展开数组元素，或连接多个数组，eg: log(...arr); let newArr = [...arr1, ...arr2]
2. 字面量对象的拷贝(浅拷贝)，let newObj = {...oldObj, name:"Mayu"}, 属性是覆盖及合并行为！

## 待做
js数值的基本操作，map，reduce，filter等（注意遍历生成li的时候，要给key={id}）
复习Node express，启动一个服务
后端服务没有配置cros时，需要前端脚手架中配置代理？src/setupProxy，注意可以用不同的前缀 代理 不同的拥有前缀地址集合的请求，axios发送请求的url可以省略ip及端口？？
拆分组件，每个组件放一个文件夹，文件夹名称大写标识是存放组件，里面放index.jsx，index.css，那么引入的时候只用到文件夹这个层级