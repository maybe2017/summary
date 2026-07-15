## Qwen3-ASR-0.6B本地部署

### 硬件环境
1. 至少8GB内存（建议16GB+）
2. 支持CUDA的NVIDIA显卡（计算能力≥7.0）
3. 至少50GB可用磁盘空间

### 启用虚拟化功能
1. 控制面板->”程序”→”启用或关闭Windows功能”->
2. 勾选以下组件：
    Hyper-V（提供虚拟机管理服务）
    Windows虚拟机监控程序平台（硬件虚拟化支持）
    适用于Linux的Windows子系统（WSL2核心组件）
### WLS2环境
1. 查看是否已经安装了wls2，`wls -l -v`，如果version为2，表示已安装。
    ```
    // 如果为1，下载WSL2并安装默认的Ubuntu系统
    wsl --install

    // 如果为2，但没有安装Liunx环境【会默认安装到C盘，占用2G左右】
    wsl --install Ubuntu
    wsl --set-default-version 2
    ``` 
2. 安装ubuntu完成后，重启电脑，在终端输入
    ```
    // 进入ubuntu系统
    wsl -d Ubuntu

    // wins查看ubuntu系统中文件
    文件管理器地址栏输入 \\wsl$\Ubuntu
    ```
### NVIDIA 驱动【Qwen3-ASR-0.6B仅需要确保CUDA 版本在 11.8 以上，并且驱动能支持，不低于 525.60.11】
1. 在 Ubuntu 终端中，执行 `nvidia-smi` 查看驱动版本，可以看到当前驱动支持的 CUDA 最高版本。【vLLM最新版本需要cuda工具包13.0版本】
    ```
    // 或者直接在win环境中查看
    任务管理器->性能->左侧GPU
    右键->NVIDIA控制面板->系统信息
    ```
2. 驱动升级
    ```
    1. 访问 NVIDIA 官网手动驱动搜索页面
    2. 选择：GeForce → GeForce RTX 30 Series → GeForce RTX 3090 → Windows 10 64-bit → Game Ready Driver
    3. 下载并安装驱动版本 610.62（发布日期 2026-06-16）
    4. 安装完成后重启电脑
    5. WSL2 中执行 wsl --shutdown 后重新进入，确认 nvidia-smi 显示新 CUDA 版本
    ```
3. 驱动更新后刷新WSL     
    ```
    wsl --shutdown 后重新进入
    ```
### 安装Docker Desktop
1. 安装 Docker Desktop，Settings → Resources → 勾选WSL integration；
2. 在发行版列表中勾选当前使用的 WSL 发行版；然后 Apply & restart
