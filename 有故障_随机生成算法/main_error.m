%% �����б�(�������Ӻ���������)
error_list = [0, 0, 0,0];

%% ��ʼ������
choose_case = 1; % ѡ�����������1��2����3��
use = 1; % ��������(���ϼӹ����蹤����Ŀ��1����2)
global mode;
mode = "Random"; % ѡ��ģʽ:"Random","GA"

%% ��ʼ������
RGV = 1; % ��ʼ��С��λ�ã�1��2��3��4��
RGV_load = 1; %��������ר�����ԣ�1ΪЯ�����ϣ� 2ΪЯ������Ʒ��
RGV_num = [0, 1];
% CNC(:, 1) ��ʾCNC����״̬��0Ϊ��������������Ϊ��ʣ�๤��ʱ�䣩
% CNC(:, 2) ��ʾCNC������ɵĹ���1Ϊ��һ������2Ϊ�ڶ�������
% CNC(:, 3) ��ʾCNC�����ϱ��
CNC = zeros(8,3);
%CNC(:, 2) = [1, 2, 1, 2, 1, 2, 1, 2];
CNC(:, 2) = [1, 1, 2, 2, 1, 1, 2, 2];
time = 0; % ʱ���ʼ��

%% ��ʼ������
Case = zeros(3,3,3);
Case(:, :,1) = [20, 33, 46; 560, 400, 378; 28, 31 25];
Case(:, :,2) = [23, 41, 59; 580, 280, 500; 30, 35, 30];
Case(:, :,3) = [18, 32, 46; 545, 455, 182; 27, 32, 25];

%% ��ʼ�����
Ans = zeros(1,6);
num = 0;
finished_num = 0;

%% ģ�����
while time <= 28800    % 8Сʱ����28800����
    active_cnc = find(CNC(:, 1) == 0 & RGV_num(2) == CNC(:, 2) );
    active_num = length(active_cnc);
    if active_num == 0
        time = time + 1;
        CNC(:, 1) = CNC(:, 1) - ones(8,1);
        if use == 2
            for i = 1:8
                if CNC(i, 1) < 0
                    CNC(i, 1) = 0;
                end
            end
        end
        continue;
    end
    if use == 1
        [target, cost,road,error_list] = Caseone_error(RGV,CNC,Case(:, :,choose_case),error_list,time);
    else
        [target, cost, road,error_list] = Casetwo_error(RGV,RGV_num,CNC,Case(:,:,choose_case),error_list,time);
    end
    if time + cost > 28800
        break;
    end 
    % ����CNC״̬
    for i = 1 : 8
        if CNC(i, 1) > 0
            if CNC(i, 1) > cost
                CNC(i , 1) = CNC(i , 1) - cost;
            else
                CNC(i , 1) = 0;
            end
        end
    end   
    % һ������Ľ������
    if use == 1
        s = size(error_list);
        if error_list(s(1), 1) == 0 && s(1) > 1
            CNC(target , 2) = 0;
            CNC(target, 1) = error_list(s(1), 4) - time;
            num = num + 1;
            CNC(target, 3) = num;
            Ans = [Ans; [target, time, 0,0,0,0]];
            error_list(s(1), 1) = num;
        else
            if CNC(target , 2) < use
                CNC(target , 2) = CNC(target , 2) + 1;
            else
                Ans(CNC(target, 3) + 1, 3) = time;
                CNC(target , 2) = 1;
                finished_num = finished_num + 1;
            end
            CNC(target, 1) = Case(2, 1,choose_case);
            num = num + 1;
            CNC(target, 3) = num;
            Ans = [Ans; [target, time, 0,0,0,0]];
        end
    % ��������Ľ������
    else
        s = size(error_list);
        if error_list(s(1), 1) == 0 && s(1) > 1
            CNC(target , 2) = 0;
            CNC(target, 1) = error_list(s(1), 4) - time;
            num = num + 1;
            CNC(target, 3) = num;
            Ans = [Ans; [target, time, 0,0,0,0]];
            error_list(s(1), 1) = num;
        else
            if CNC(target , 2) == 1
                CNC(target, 1) = Case(2, 2,choose_case);
                Ans = [Ans; [target, time + road, 0,0,0,0]];    
                if CNC(target, 3) ~= 0
                    RGV_num = [CNC(target, 3), 2];
                    Ans(CNC(target, 3) + 1 ,3) = time + road;
                else
                    RGV_num = [0, 1];
                end
                num = num + 1;
                CNC(target, 3) = num; 
            else
                CNC(target, 1) = Case(2, 3,choose_case);
                if CNC(target, 3) ~= 0
                    Ans(CNC(target, 3) + 1, 6) = time + road;
                end
                CNC(target, 3) = RGV_num(1);
                RGV_num = [0, 1];
                Ans(CNC(target, 3) + 1 ,5) = time + road;
                Ans(CNC(target, 3) + 1, 4) = target;      
                finished_num = finished_num + 1;
            end
        end    
    end
    % ����С��λ��
    RGV = ceil(2 \ target);
    % ����ʱ��
    time = time + cost;
end
Ans(1, :) = [];
if use == 1
    Ans = Ans(:,1:3);
end
error_list(1,:) = [];
s = size(error_list);
fprintf("finished_num : %d\n", finished_num);
fprintf("error_num : %d\n", s(1));