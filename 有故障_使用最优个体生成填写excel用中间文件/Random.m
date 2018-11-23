%% Ëæ»úÑ¡Ôñº¯Êý
function target = Random(active_cnc)
    active_num = length(active_cnc);
    target = mod(round(rand(1) * 1000), active_num) + 1;
    target = active_cnc(target);
end