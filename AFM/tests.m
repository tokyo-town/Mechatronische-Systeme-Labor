function G = sym2tf(f)
    [num, den] = numden(f);
    num = sym2poly(num);
    den = sym2poly(den);
    G = tf(num, den);
end

m = 1;
k = 1;

P = tf(1,[m, 1, k]);

figure;
bode(P), grid, legend
