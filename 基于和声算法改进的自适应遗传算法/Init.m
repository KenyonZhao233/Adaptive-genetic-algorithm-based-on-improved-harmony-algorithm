function X =Init(s)
    X = zeros(s, 1024);
    for k = 1 : s
        for i = 1 : 1024    
            b = 0;
            a = mod(i ,256);
            while a > 0
                b = [b, mod(a, 2)];
                if mod(a, 2) == 0
                    a = a / 2;
                else
                    a = (a - 1) / 2;
                end
            end
            if b == 0
                b = [0 0 0 0 0 0 0 0];
            else
                b(1) = [];
                b = str2num(reverse(num2str(b)));
                size_b = size(b);
                while(size_b(2) < 8)
                    b = [0, b];
                    size_b(2) = size_b(2) + 1;
                end
            end
            [~, maxn] = max(b .* rand(1, 8));
            X(k, i) = maxn(1);
        end
    end
    X = uint16(X);
end