## 是什么？ 管理多个组件共享的状态【强调共享】【理解为Redis】
1. 任意组件间状态共享，不用存在父子或祖孙关系
2. 一个组件中去更改另一个组件的状态，或通过状态变量来实现通信
3. 组件中 `需要共享出去的状态` 交给Redux去统一管理
   
## redux的工作流程
### 角色
1. React组件集【客人】
2. Action Creators: 【服务员】状态更新对象Action创建者; Action动作对象有两个属性，(动作类型type, 动作数据data); 然后通过store.dispatch(action) 去分发动作对象，把action这个动作对象交给了Store
3. Store: 【协调者】，接收到action对象后，会交给Reducers去执行【此时会额外给出之前的状态变量值】
4. Reducers: 【执行者】，执行结束后，把计算完后 `最新状态` 返回给Store


### reducer是一个函数，参数(preState, action) 
1. 用于初始化时，初始化状态变量时，preState[之前的状态值]参数是undifined，action参数[动作类型]值为 `@@init@@`
2. 用于更改状态时，能接收到两个参数(preState[之前的状态值]是存在值的, action对象)
3. 特性: 是一个纯函数(同样的输入，一定是相同的输出；不能改写参数数据)，有两个参数[previousStateObj, action(type, data)], 返回值就是是状态对象。初始化逻辑也是在函数中实现，此时previousStateObj值为undefined，可依据此值为判断条件进行状态的初始化。
4. 写法: 每一个组件对应一个reducer函数，专门服务这个组件的状态更改【countComp_reduces.js文件】
    ```
    const initState = 0;
    export default function countCompReducer(preState = initState, action) {
        const {type, data} = action;
        switch(type){
            case "increment":
                return preState + data;
            case "decrement":
                return preState - data;
            default: 
                // type为undifined时
                return preState;        
        }
    }
    ```

#### store对象，用于存储
1. 全局只能有一个store对象，创建的时候，必须带上reducer作为参数。【store.js文件 - 要暴露出去store对象】
    ```
    export default const store = createStore(countCompReducer);
    ```
2. 【同步action】当action是一个普通对象时，store.dispatch(action)作用是通知reducer执行action去更改状态; 
3. 【异步action，异步动作交给action实现，而不是当前组件】当action的值是一个函数时，store会先执行一下action中的高阶函数，调用时会传给内层返回的函数一个`dispatch`参数，在这个函数里面，异步任务有结果后，最终会调用 `store.dispatch(newActionObj)` 真正的让store交付一个对象给reducer函数执行。
4. 异步action不是必须的，是当延迟的动作不想交给组件时，想交给action才会使用；使用时会用到`applyMiddleAware(react-thunk-pluginName)`方法去注册插件，并配置在store对象上才能使用。

#### 组件里面的使用【注意redux状态改了后，默认不会重新渲染组件】
1. 组件中获取状态用 `store.getState()`
2. 更改状态用 `store.dispatch(newActionObj)`
3. 需要调用下setState({})，用store.subscrib订阅状态变化
   ```
    // 每次状态变量发生变化 触发
    store.subscrib(() => {
        setState({}) 
    })

   ```


#### Action Creators, 其根据传入的type创建不同action对象用于表示要做什么
1. 每一个组件都创建一个xxx_action_create.js文件; 分别暴露表示不同操作的多个action对象; 然后在组件中进行import引用
    ```
    // 返回action对象
    export const createIncrementAction = data => ({type:'increment', data});
    export const createDecrementAction = data => ({type:'decrement', data});

    // 异步action 异步动作交给action实现；【需要返回一个函数，因为只有在函数里面才能开启异步任务】
    // 此时createAsyncIncrementAction就是高阶函数
    export const createAsyncIncrementAction = (data, delayTime) => {
        // store会先进行调用，并会传给内层返回的函数一个`dispatch`参数
        return (dispatch) => {
            setTimeout(() => {
                store.dispatch(createIncrementAction('increment', data))
            }, delayTime)
        }
    }

    ```
#### 其他注意点
1. 在组件中挂载钩子函数中，需要监听redux状态变化，变化了就重新render组件。不变化也没有必要刷新。为解决在过多组件中添加监听代码，可以在入口文件index.js里面添加监听即可，一旦状态变化，重新render所有组件。
2. 特别注意: 变化的判定是对 状态对象的地址进行了 比较(浅比较)，而不是对象内容 !!! 所以最好返回一个新对象，来使判定结果是变化的!! 在reducer中要注意: 如array.unshift(item);

## 不使用单独的redux库， 使用react-redux(官方提供的插件) 来链接 react组件与redux api
#### 重点-UI组件不能使用redux的api 
1. 容器组件: 包裹所有的UI组件，可以使用redux的API; 如store.getState(); store.dispatch(action);
2. UI组件: 被包裹, 不能直接使用redux的API; 只能通过让 父容器组件用props将 redux中保存的状态与操作状态的方法 传递进来，再进行使用。
3. 核心: 容器组件中需要将 redux中维护的`状态、修改状态的方法` 以props方式传递给 子UI组件！！ 要注意对这两个对象，分别给个key，子UI组件才能从props里面取出来使用。
4. 反正记住: 容器组件里拥有redux维护的总状态，子UI对象想要什么，就在connect时，让容器组件进行传递!! 尽量要什么取什么，不要传递总状态对象，没必要!
   
#### 容器组件的创建
1. 单独放在`containers`文件夹中，与一般组件存放的components文件夹平级。也可以把UI组件直接写到 容器组件的jsx中，仅暴露容器组件即可!!
2. 需要引入react-redux中的connect(mapStateToProps, mapDispatchToProps)函数，通过 `connect(function1, function2)(UIComponentName)` 进行连接UI组件, 创建并最后需要导出容器组件。 
3. connect函数的第一个函数参数需要返回一个对象， {key:redux管理的状态}, 而且这个redux管理的状态，已经被react-redux调用时，以state参数传递了，不需要自己再从store获取。
4. connect函数的第二个函数参数需要返回一个对象， {key:param => dispatch(creatAction(param))}, 而且这个dispatch，已经被react-redux调用时，以dispatch参数传递了，不需要自己再从store获取。
5. connect函数的两个函数参数会将 `状态、修改状态的方法` 以props传递的形式 传递给UI组件，在UI组件中直接可以从props中进行读取使用，从而在编码上与redux解耦分离。
6. 特别注意: 容器组件需要store，但是不能用import的方式亲自引用，必须通过在 容器组件的父容器中，通过props进行传入。
7. 优化: connect函数的第二个参数可以是一个对象{key: creatActionName}，当UI子组件调用这个creatActionName函数后(会返回一个action对象)， react-redux会自动调用store.dispatch(action);

#### 优化点
1. 官方插件较原生redux，不必在入口文件index.js里面添加监听，react-redux会自动监听
2. 可以取代在 容器组件的父容器 给容器组件 用标签属性传递store这种方式: 需要在入口文件引入react-redux中的`Provider组件`，目的是让app所有后代`容器组件`都能接收到store对象，如下使用:
   ```
    ReactDOM.render(
        <Provider store={store}>
            <App/>
        </Provider>,
        document.getElementById('root');
    );


   ```
3. 通常项目里redux是一个文件夹，下面有reducers文件夹(index.js用于汇总所有reducers)、actions文件夹、stroe.js，constant.js
4. 有多个reducers时，创建store时，需要引入`combineReducers函数`来进行合并，const allReducers = combineReducers({key1: reducer1, key2: reducer2}); 这个allReducers就是redux里维护的总状态对象!!
5. ReduxDevTools谷歌插件 + 代码里还得安装插件库(现在不需要配置了？)
6. 使用时的Hook函数
   ```
    import {useSelector, useDispatch} from 'react-redux'

    // 使用useSelector 利用插件'react-redux' 去获取 状态变量
    const {countState} = useSelector(state => state.countState)

    // 获取可用于更改状态变量的函数 dispatch
    const dispatch = useDispatch();

    // 使用dispatch函数
    <button onclick = { () => dispatch(createIncrementAction('increment', data)) }/>

   ```