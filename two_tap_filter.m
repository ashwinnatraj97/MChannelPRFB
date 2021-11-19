function [h] = two_tap_filter()
    h = [1,1];
    h = h./sqrt(2);
end