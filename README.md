# An improved genetic algorithm based on harmony algorith
![Image text](https://github.com/KenyonZhao233/An-improved-genetic-algorithm-based-on-harmony-algorithm/blob/master/图片/1.png)
  
  遗传算法是一种借鉴生物界自然选择和自然遗传机制的随机化搜索算法。
  由于其适应不同任务的泛化能力较强，被广泛应用于非线性、多目标、多变量、复杂的自适应系统中。
  但是传统遗传算法收敛速度慢、容易陷入局部最优解，尤其在复杂问题中，收敛时间长且很难得到全局最优解。
  
  为了解决这两个问题，我们采取了两种不同的改进优化方案：自适应遗传算法优化与基于和声算法的遗传算法优化。
  
  1.自适应遗传算法优化，即是通过计算种群中心区域密度，判断种群是否接近或者到达了某个局部最优解区域。
  此时如果种群内部已经相对稳定，难以发生实质进化和走出局部最优解。我们选择设置类似于自然界中的“天灾”设定，一定程度上将旧种群初始化为新的种群，从而走出此处局部最优解，并试图寻找下一个可能的局部最优解，从而使模型更有希望与能力达到全局最优解。
  同时我们也设置在正常的种群中心区域密度下，密度越高时，变异概率也会随之上升，尽量减少种群“灭亡与重生”的次数。
  
![Image text](https://github.com/KenyonZhao233/An-improved-genetic-algorithm-based-on-harmony-algorithm/blob/master/图片/2.png)![Image text](https://github.com/KenyonZhao233/An-improved-genetic-algorithm-based-on-harmony-algorithm/blob/master/图片/3.png)

![Image text](https://github.com/KenyonZhao233/An-improved-genetic-algorithm-based-on-harmony-algorithm/blob/master/图片/4.PNG)

2.基于和声算法的遗传算法优化
（1）和声搜索算法（HS）
  简介：是一种新的启发式全局搜索算法，智能模拟了音乐演奏的原理。
 ![Image text](https://github.com/KenyonZhao233/An-improved-genetic-algorithm-based-on-harmony-algorithm/blob/master/图片/5.png)
 
（2）和声算法的推广
  自适应遗传算法在接近局部最优解区域时存在可能并未达到局部最优解点便被“灭亡与重生”为新的种群，进而错过某个可能的全局最优解。
  而结合和声算法，其记忆库中的优秀和声不断参加迭代，保证着最优解的收敛速度，使种群有能力在“灭亡与重生”前达到局部最优。
  同时其带来的容易陷入局部最优解的劣势可以被自适应遗传算法一定程度上的弥补，二者的结合，使改良后的遗传算法具有更强的寻找全局最优解能力与较快的收敛速度。
