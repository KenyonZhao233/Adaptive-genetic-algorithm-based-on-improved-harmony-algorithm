%% 故障列表(故障在子函数中设置)
error_list = [0, 0, 0,0];

%% 初始化任务
choose_case = 1; % 选择参数组数（1，2或者3）
use = 1; % 任务类型(物料加工所需工序数目，1或者2)
global mode;
mode = "Random"; % 选择模式:"Random","GA"

%% 初始化车间
RGV = 1; % 初始化小车位置（1，2，3，4）
RGV_load = 1; %两道工序专有属性（1为携带生料， 2为携带半熟品）
RGV_num = [0, 1];
% CNC(:, 1) 表示CNC工作状态（0为不工作，否则则为其剩余工作时间）
% CNC(:, 2) 表示CNC处能完成的工序（1为第一道工序，2为第二道工序）
% CNC(:, 3) 表示CNC处物料编号
CNC = zeros(8,3);
%CNC(:, 2) = [1, 2, 1, 2, 1, 2, 1, 2];
CNC(:, 2) = [1, 1, 2, 2, 1, 1, 2, 2];
time = 0; % 时间初始化

%% 初始化动作
Case = zeros(3,3,3);
Case(:, :,1) = [20, 33, 46; 560, 400, 378; 28, 31 25];
Case(:, :,2) = [23, 41, 59; 580, 280, 500; 30, 35, 30];
Case(:, :,3) = [18, 32, 46; 545, 455, 182; 27, 32, 25];

%% 初始化结果
Ans = zeros(1,6);
num = 0;
finished_num = 0;

%% 模拟过程
while time <= 28800    % 8小时等于28800分钟
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
    % 更新CNC状态
    for i = 1 : 8
        if CNC(i, 1) > 0
            if CNC(i, 1) > cost
                CNC(i , 1) = CNC(i , 1) - cost;
            else
                CNC(i , 1) = 0;
            end
        end
    end   
    % 一道工序的结果更新
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
    % 两道工序的结果更新
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
    % 更新小车位置
    RGV = ceil(2 \ target);
    % 更新时间
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