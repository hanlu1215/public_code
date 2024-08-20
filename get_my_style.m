function my_line_style = get_my_style(nnn)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
line_styles = {'-', '--', ':', '-.', '-'};
marker_styles = {'o', '+', '*', 'x', 's', 'd', '^', 'v', '>'};
my_line_style = cell(1,nnn);
for index_n = 1:1:nnn
    line_style = line_styles{mod(index_n,size(line_styles,2))+1};
    marker_style = marker_styles{mod(index_n,size(marker_styles,2))+1};
    my_line_style{index_n} = [line_style,marker_style];
end
end