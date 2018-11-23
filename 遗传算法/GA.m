%% 遗传算法模式
% 两种模式：普通遗传算法（normal），以及改进后的模型（pro）
GA_mode = "normal"; % (or "pro")

%% 初始化种群
initpop = Init(20); % 种群大小，请填写偶数
fprintf("Init is done!\n");

%% 修改组别与任务类型

%  在 fitness.m 中修改

%% 遗传算法优化
epoch = 50; % 循环轮数
mc = 0.1;
best = 0;
bestx = []; bestlist = [];averagelist = [];
X = initpop;
for i = 1 : epoch
    if GA_mode == "normal"
        [X, best,average,bestx] = GA_evolve_pro(X,best,bestx);
    else
        [X, best,average,bestx] = GA_evolve(X,mc,best,bestx);
    end
    bestlist = [bestlist, best];
    averagelist = [averagelist, average];
    fprintf("epoch %d      best : %d    average:%d  \n", i, best, average);
end

%% 保存最优解
name = "x"; % 可以更改
name = name+'.mat';  
s = size(bestx);
bestx = bestx(s(1), :);
save(name, 'bestx');