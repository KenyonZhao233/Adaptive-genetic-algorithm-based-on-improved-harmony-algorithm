%% 进化过程
function [X, best,average,bestx] = GA_evolve(X,mc,best,bestx)
    score = [];
    s = size(X);
    score = [];
    for i = 1 : s(1)
        score = [score, fitness(X(i, :))];
    end
    [good,best,average,bestx] = Selection(X,score,best,bestx);
    X = Mutation(Crossover(good), mc);
end

%% 选择
function [good,best,average,bestx] = Selection(X,score,best,bestx)
    [score,num] = sort(score);
    s = size(num);
    s_half = s(2) / 2;
    if score(s(2)) > best
        best = score(s(2));
        bestx = [bestx; X(num(s(2)),:)];
    end
    average = mean(score);
    good = [];
    for i = s_half + 1: s(2)
        good = [good; X(num(i), :)];
    end
end

%% 交叉
function new_c = Crossover(good)
    s = size(good);
    num = s(1);
    num = num * 2;
    new_c = zeros(num, s(2));
    for i = 1 : num
        for j = 1 : s(2)
            new_c(i, j) = good(unidrnd(num / 2), j);
        end
    end
end

%% 变异
function gerneration = Mutation(new_c, mc)
    s = size(new_c);
    p = rand(s(1), s(2));
    [r, c] = find(p <= mc);
    gerneration = new_c;
    for i = 1 : length(r)
            b = 0;
            a = mod(c(i) ,256) ;
            while a > 0
                b = [b, mod(a, 2)];
                if mod(a, 2) == 0
                    a = a / 2;
                else
                    a = (a - 1) / 2;
                end
            end
            b(1) = [];
            b = str2num(reverse(num2str(b)));
            size_b = size(b);
            while(size_b(2) < 8)
                b = [0, b];
                size_b(2) = size_b(2) + 1;
            end
            [~, maxn] = max(b .* rand(1, 8));
            gerneration(r(i), c(i)) = maxn;
    end
end