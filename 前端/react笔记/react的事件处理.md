### 表单里面的标签 绑定回调函数，以获取用户输入
#### 非受控组件(不归state管理)
1. 现用现取(现在输入标签上加ref，利用ref回调将当前标签绑定到this实例上；最后使用的时候，在this实例上取标签里的值)，叫非受控组件
2. form表单提交时，会默认进行跳转，提交函数中用event.preventDefault()来阻止表单提交，提交数据用ajax等其他方式。

#### 受控组件(归state管理)
1. 将输入内容维护到react中的state里面，叫受控组件，【建议这样用，可避免使用ref】
2. 给每个输入标签的onChange事件绑定一个回调函数，回调逻辑里面将每个用户输入内容写入state状态对象里面；最后使用的时候又从state里面读取（双向绑定，就相当于VUE中的v-model）

#### 传递回调函数的问题
1. 表单里面有多个输入标签，怎么解决每一个标签里的onChange事件都要绑定一个回调函数的问题呢？
   ```
   两种解决方法:
   1. 函数的柯里化: 函数的返回值是另一个函数
   虽然绑定的都是一个同名回调函数，但是这个函数根据参数的不同，返回了不同的函数；其实真正的给react的回调是返回的函数!

    saveFormData(inputType) {
        return (event) {
          console.log(inputType, event.target.value);
          this.setState({[inputType]:event.target.value});
        }
    }

   2. 内连函数写法: event由react调用时候传入，saveFormData函数中就可以直接写入 state就行了
   onChange={(event)=>{this.saveFormData('userName'), event.target.value}}
   ```