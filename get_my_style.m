function my_line_style = get_my_style(nnn)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
line_styles = {'-', '--', ':', '-.', '-'};
% line_styles = {':', '-.', '-', '--', '-'};
marker_styles = {'o', '+', '*', 'x', 's', 'd', '^', 'v', '>'};
% 定义颜色集合（使用MATLAB默认颜色顺序）
colors = [0.4940    0.1840    0.5560;    % 紫色
          0.4660    0.6740    0.1880;    % 绿色
          0.3010    0.7450    0.9330;    % 浅蓝
          0.9290    0.6940    0.1250;    % 黄色
          0    0.4470    0.7410;    % 蓝色
          0.8500    0.3250    0.0980;    % 橙色
          0.6350    0.0780    0.1840];   % 红色
my_line_style = cell(1,nnn);
for index_n = 1:1:nnn
    line_style = line_styles{mod(index_n,size(line_styles,2))+1};
    marker_style = marker_styles{mod(index_n,size(marker_styles,2))+1};
    color = colors(mod(index_n-1, size(colors,1))+1, :);
    % 存储所有样式信息到结构体
    my_line_style{index_n} = struct(...
        'LineStyle', line_style, ...
        'Marker', marker_style, ...
        'Color', color);
%     my_line_style{index_n} = [line_style,marker_style];

end
end