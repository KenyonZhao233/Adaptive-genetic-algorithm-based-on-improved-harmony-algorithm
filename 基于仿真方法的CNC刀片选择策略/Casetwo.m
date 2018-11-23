%% Case2 £º Á½µÀ¹¤Ðò
function  [target, cost, road] = Casetwo(RGV,RGV_num,CNC,Case)
    global mode;
    active_cnc = find(CNC(:, 1) == 0 & RGV_num(2) == CNC(:, 2) );
    if mode == "Random"
        target = Random(active_cnc);
    elseif mode == "GA"
        target = GA_two(active_cnc, RGV);
    end
    target = Random(active_cnc);
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
end
