%% �����㷨ģʽ
% ģʽ����ͨ�����㷨��normal��
HS_mode = "normal"; 

%% ��ʼ�����������
initpop = Init(6);
fprintf("Init is done!\n");

%% �����㷨�Ż�
epoch = 100;
HMCR = 0.1;
PAR = 0.1;
BW = 0.1;
best = 0;
bestx = []; bestlist = [];averagelist = [];
X = initpop;
for i = 1 : epoch

        [X, best,average,bestx] = HS_evolve(X,HMCR,PAR,BW, best,bestx);

    bestlist = [bestlist, best];
    averagelist = [averagelist, average];
    fprintf("epoch %d      best : %d    average:%d  \n", i, best, average);
end
