%% Case1 ： 一道工序
function  [target, cost,road,error_list] = Caseone_error(RGV,CNC,Case,error_list,time)
    active_cnc = find(CNC(:, 1) == 0);
    active_num = length(active_cnc);
    target = mod(round(rand(1) * 1000), active_num) + 1;
    target = active_cnc(target);
    road = abs(ceil(2 \ target) - RGV);
    if road == 0
        cost = 0;
    else
        cost = Case(1, road);
        road = cost;
    end
    if mod(target, 2) == 0
        cost  = cost + Case(3,2);
    else
        cost = cost + Case(3,1);
    end
    if CNC(target, 2) ~= 0
        cost  = cost + Case(3, 3);
    end
    % 随机故障
    Lucky = rand(1);
    if Lucky <= 0.01 % 故障概率
        error_begin = round(time + cost * Lucky * 100);
        error_end = round(error_begin + rand(1) * 600) + 100; % 故障时间10-20分钟
        error_target = target;
        error_list = [error_list; [0, error_target, error_begin, error_end]];
    end
end