load('plot.mat');

createfigure_old(old);
createfigure_new(new);

function createfigure_old(Y1)
%CREATEFIGURE(Y1)
%  Y1:  y 数据的向量

%  由 MATLAB 于 16-Sep-2018 14:17:24 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot(Y1);

% 创建 ylabel
ylabel({'适应度'});

% 创建 xlabel
xlabel({'迭代轮数'});

% 创建 title
title({'普通遗传算法下适应度随迭代轮数的变化'});

box(axes1,'on');
end

function createfigure_new(Y1)
%CREATEFIGURE(Y1)
%  Y1:  y 数据的向量

%  由 MATLAB 于 16-Sep-2018 14:17:24 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot(Y1);

% 创建 ylabel
ylabel({'适应度'});

% 创建 xlabel
xlabel({'迭代轮数'});

% 创建 title
title({'自适应遗传算法下适应度随迭代轮数的变化'});

box(axes1,'on');

end