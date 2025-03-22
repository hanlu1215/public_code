function color_n = default_color(n)
color_s = {
    [0      0.4470 0.7410]  % 蓝色 (Blue)
    [0.8500 0.3250 0.0980]  % 橙色 (Orange)
    [0.9290 0.6940 0.1250]  % 黄色 (Yellow)
    [0.4940 0.1840 0.5560]  % 紫色 (Purple)
    [0.4660 0.6740 0.1880]  % 绿色 (Green)
    [0.3010 0.7450 0.9330]  % 天蓝色 (Cyan)
    [0.6350 0.0780 0.1840]  % 深红色 (Red)
};
color_n = color_s{mod(n-1, length(color_s))+1};
end