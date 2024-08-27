function P = get_P_24(file_name,Current_range,Vol,fig_n,show_flag,fig_position)
if ~ismember(Current_range, [50,500])
    disp('不是指定量程');
    return;
end
if nargin < 4
    fig_n=100; % 默认值为 100
    show_flag = true;
elseif nargin < 5
    show_flag = true;
elseif nargin < 6
    fig_position = [];
end

data=xlsread(file_name);
Is = data(:,2);
Ts = data(:,1);
Ts = Ts - Ts(1);
Is = Is*1000/Current_range;%单位换算 将测量的V按照50mV/A或者500mV/A换算为A
W = trapz(Ts,Vol*Is);
P = abs(W/Ts(end));

if show_flag
    fig = figure(fig_n);
    plot(Ts,Is,'.-')
    % cleanedFilePath = regexprep(file_name, '[\u4e00-\u9fa5]', '');
    cleanedFilePath = file_name;
    title_str = strcat(cleanedFilePath, '  P = ', string(P) ,' W');
    disp("量程为： "+num2str(Current_range)+"mV/A，电压为： "+num2str(Vol)+"V, "+"P = "+num2str(P)+"W");
    title_str = hanzi2pinyin(title_str);
    title(title_str)
    xlabel("t/s")
    ylabel("I/A")
    xlim([0,2]);
    if ~isempty(fig_position)
        fig.Position = fig_position;
    end
end
end