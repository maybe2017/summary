### React.useEffect(()=>{}, [])
1. 第二个参数, 表示监控的状态变量；如果省略不设置，那么第一个函数参数中的逻辑会在`组件挂载`、`组件更新(任意状态变量变化都会驱动组件更新)`时均触发！
2. 组件挂载后执行一次: React.useEffect(()=>{挂载后执行的逻辑}, []) 
3. 组件卸载前执行一次: 需要第一个函数参数返回一个函数，这个函数里面写componentWillUnmount的逻辑
    ```
    const App = () => {
        const [userList, setUserList] = useState([]);
        useEffect(()=>{
            // 组件挂载后 获取后台数据
            async function getList() {
                const res = await fetch(url);
                const jsonDataList = await res.json();
                setUserList(jsonDataList);
            }
            getList();

            // 组件卸载前 清除定时器等资源
            return () => {
                clearInterval(timer);
            }
        }, []);
    }


    ```
4. 第二个数组参数有值[某一状态变量]的时候，表示第一个函数参数中的逻辑会在`组件挂载`、`指定状态变量变化的时候`被调用。

### React.useRef() 创建一个容器存放Dom元素
1. 创建: const xxxContainer = React.useRef(null);
2. 使用: <input ref={xxxContainer} type="text"/>;  const inputValue = xxxContainer.current.value;

### 封装自定义Hook
1. 将可复用的逻辑代码抽取出来，放在一个自定义的useXxx函数中，并返回 被使用的状态变量、及回调函数(以对象或数组的形式)。
    ```
    let useToggle = () => {
        const [value, setValue] = useState(true);
        const toggle = () => setValue(!value);

        return {value, toggle}
    }

    // 使用时，将状态、回调函数解构出来使用即可
    const {value, toggle} = useToggle();
    ...
    ```
