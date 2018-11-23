%% Case1 �� һ������
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
    % �������
    Lucky = rand(1);
    if Lucky <= 0.01 % ���ϸ���
        error_begin = round(time + cost * Lucky * 100);
        error_end = round(error_begin + rand(1) * 600) + 100; % ����ʱ��10-20����
        error_target = target;
        error_list = [error_list; [0, error_target, error_begin, error_end]];
    end
end