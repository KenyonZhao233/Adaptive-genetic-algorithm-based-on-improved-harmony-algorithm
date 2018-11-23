%% �Ŵ��㷨ģʽ
% ����ģʽ����ͨ�Ŵ��㷨��normal�����Լ��Ľ����ģ�ͣ�pro��
GA_mode = "normal"; % (or "pro")

%% ��ʼ����Ⱥ
initpop = Init(20); % ��Ⱥ��С������дż��
fprintf("Init is done!\n");

%% �޸��������������

%  �� fitness.m ���޸�

%% �Ŵ��㷨�Ż�
epoch = 50; % ѭ������
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

%% �������Ž�
name = "x"; % ���Ը���
name = name+'.mat';  
s = size(bestx);
bestx = bestx(s(1), :);
save(name, 'bestx');