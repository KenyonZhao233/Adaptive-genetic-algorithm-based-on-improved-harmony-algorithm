%% 进化过程
function [X, best,average,bestx] = HS_evolve(X,HMCR,PAR,BW, best,bestx)
    x = Create(X,HMCR,PAR,BW);
    [X, best,average,bestx] = update(X,x, best,bestx);
end

%% 生成一个新的和声
function x = Create(X,HMCR,PAR,BW)
    s = size(X);
    r1 = rand(1);
    % 从和声记忆库抽取
    if r1 < HMCR
        x = X(ceil(rand(1) * s(1)),:);
        r2 = rand(1);
        if r2 < PAR
            r3 = rand(s(2), 1);
            [r, ~] = find(r3 < BW);
            for i = 1 : length(r)
                b = 0;
                a = mod(r(i) ,256) ;
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
                x(r(i)) = maxn;
            end
        end
    else
        for i = 1 : s(2)
            b = 0;
            a = mod(i ,256) ;
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
            x(i) = maxn;
        end
    end
end

%% 更新和声记忆库
function  [X, best,average,bestx] = update(X,x,best,bestx)
    score = [];
    s = size(X);
    score = [];
    for i = 1 : s(1)
        score = [score, fitness(X(i, :))];
    end
    [score,num] = sort(score);
    new_score = fitness(x);
    if score(1) < new_score
        for i = 1 : s(1)
            if num(i) == 1
                X(i,:) = x;
            end
        end
    end
    if score(s(1)) > best
        best = score(s(1));
        bestx = [bestx; X(num(s(1)),:)];
    end
    average = mean(score);
end
