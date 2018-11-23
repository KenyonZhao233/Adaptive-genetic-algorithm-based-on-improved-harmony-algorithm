%% Case2 �� ��������
function  [target, cost, road,error_list] = Casetwo_error(RGV,RGV_num,CNC,Case,error_list,time)
    active_cnc = find(CNC(:, 1) == 0 & RGV_num(2) == CNC(:, 2) );
    active_num = length(active_cnc);
    target = mod(round(rand(1) * 1000), active_num) + 1;
    target = active_cnc(target);
    road_length = abs(ceil(2 \ target) - RGV);
    if  road_length == 0
        road = 0;
    else
        road = Case(1, road_length);
    end
    if mod(target, 2) == 0
        cost  = road + Case(3,2);
    else
        cost = road + Case(3,1);
    end
    Lucky = rand(1);
    if Lucky <= 0.01 % ���ϸ���
        error_begin = round(time + cost * Lucky * 100);
        error_end = round(error_begin + rand(1) * 600) + 600; % ����ʱ��10-20����
        error_target = target;
        error_list = [error_list;[0, error_target, error_begin, error_end]];
    end
end