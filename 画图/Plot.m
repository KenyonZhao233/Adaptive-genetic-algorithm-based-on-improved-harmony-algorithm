load('plot.mat');

createfigure_old(old);
createfigure_new(new);

function createfigure_old(Y1)
%CREATEFIGURE(Y1)
%  Y1:  y ���ݵ�����

%  �� MATLAB �� 16-Sep-2018 14:17:24 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� plot
plot(Y1);

% ���� ylabel
ylabel({'��Ӧ��'});

% ���� xlabel
xlabel({'��������'});

% ���� title
title({'��ͨ�Ŵ��㷨����Ӧ������������ı仯'});

box(axes1,'on');
end

function createfigure_new(Y1)
%CREATEFIGURE(Y1)
%  Y1:  y ���ݵ�����

%  �� MATLAB �� 16-Sep-2018 14:17:24 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� plot
plot(Y1);

% ���� ylabel
ylabel({'��Ӧ��'});

% ���� xlabel
xlabel({'��������'});

% ���� title
title({'����Ӧ�Ŵ��㷨����Ӧ������������ı仯'});

box(axes1,'on');

end