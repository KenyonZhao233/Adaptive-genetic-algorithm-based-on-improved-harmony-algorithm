%% Case1 £º Ò»µÀ¹¤Ðò
function  [target, cost,road] = Caseone(RGV,CNC,Case)
    global mode;
    active_cnc = find(CNC(:, 1) == 0);
    if mode == "Random"
        target = Random(active_cnc);
    elseif mode == "GA"
        target = GA_one(active_cnc, RGV);
    end
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
end
