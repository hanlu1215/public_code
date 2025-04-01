function [max_min_force_s, temp, xs, ys] = pro_layaji_data(file_name, plot_flag)
    if nargin < 2
        plot_flag = true; % 默认绘图
    end
    temp = [];
    disp(['Processing file: ' char(file_name)]);
    data = readtable(file_name);
    % 根据第一列的数据对数据进行分类
    groups = unique(data.num);
    sorted_data = cell(length(groups), 1);
    max_min_force_s = cell(length(groups), 1);
    xs = cell(length(groups), 1);
    ys = cell(length(groups), 1);

    if plot_flag
        temp = figure;
    end

    % 遍历每个组
    for i = 1:length(groups)
        group_data = data(data.num == groups(i), :);
        % 按照。。。从小到大排序
        sorted_data{i} = sortrows(group_data, 4);
        if plot_flag
            plot(sorted_data{i}{:,3}, sorted_data{i}{:,2}, '-','DisplayName',...
            ['',num2str(groups(i))],'LineWidth',3);
            hold on;
        end
        xs{i} = sorted_data{i}{:,3};
        ys{i} = sorted_data{i}{:,2};
        
        % 获取当前曲线的最大值及其对应的位移
        [max_force, ~] = max(sorted_data{i}{:,2});
        [min_force, ~] = min(sorted_data{i}{:,2});
        max_min_force_s{i} = [max_force,min_force];
    end

    if plot_flag
        title(file_name,'Interpreter', 'none','FontName','Arial');
        set(gca,'FontSize',24);
        xlabel('Displacement(mm)');
        ylabel('Force(N)');
        lgd = legend('show', 'Location', 'best', 'NumColumns', 5, 'Box', 'off', 'Color', 'none');
        lgd.ItemTokenSize = [15, 50]; % Reduce the legend line length (default is [30, 18])
        [~, file_name_no_ext, ~] = fileparts(file_name);
        figure_name = ['./result/Force vs Displacement for ',char(file_name_no_ext)];
        saveas(gcf, [figure_name,'.png']); % 保存图像为PNG文件
    end
end
