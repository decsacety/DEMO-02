# DEMO-02
更新后内容：
添加了另一个副光源，可以自定义多个点光源来模拟全局光照。
增加了实时调控主光源颜色的控件。

<font size="3">PBR光照实现</font><br />
如果需要运行请切换至x86编译， 使用opengl4.6标准编写，如果遇到fail to create GLFW window请检查opengl版本
在场景中wasd移动，鼠标右键加速，x键退出程序。
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/DemoPicture/4.png)
实现了基于Cook-Torrance BRDF的PBR光照模型，可以通过调整菲涅尔系数freh和粗糙度rough来模拟各种材质
贴图采用的是帧缓冲写入的模拟实时屏幕映射，用来模拟玻璃的质感。

解决了帧缓冲后绘制实例化物体的深度缓冲问题

可以进行实时的光照调整，同时支持自行编辑实例化物体的分布和光照的自动变化

在30000个球同时渲染时在2060上的帧率稳定在27帧

附上部分效果图
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/DemoPicture/1.png)
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/DemoPicture/2.png)
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/DemoPicture/3.png)
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/DemoPicture/5.png)
![Image text](https://github.com/decsacety/DEMO-02/blob/main/OpenGL01/source/DemoPicture/6.png)
