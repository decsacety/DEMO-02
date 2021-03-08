# DEMO-02
PBR光照实现
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/4.png)
实现了基于Cook-Torrance BRDF的PBR光照模型，可以通过调整菲涅尔系数freh和粗糙度rough来模拟各种材质
贴图采用的是帧缓冲写入的模拟实时屏幕映射，用来模拟玻璃的质感。

解决了帧缓冲后绘制实例化物体的深度缓冲问题

可以进行实时的光照调整，同时支持自行编辑实例化物体的分布和光照的自动变化

在30000个球同时渲染时在2060上的帧率稳定在27帧

附上部分效果图

