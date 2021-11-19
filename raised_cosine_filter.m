function [h] = raised_cosine_filter(N, beta)
    n = -N/2:(N/2-1);
    n = n+0.5;
    h = 2*beta*cos((1+beta)*pi*n/2)./(pi*(1-4*beta^2*n.^2));
    h = h+sin((1-beta)*pi*n/2)./(pi*(n-4*beta^2*n.^3));
    h = h*sqrt(2);
end