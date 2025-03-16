function GradBar(x, y, numGradients,text_fontsize)
    % GradBar 绘制具有从下到上的渐变填充的柱状图，并设置 x 轴标签
    % x: 柱子的位置
    % y: 柱子的高度
    % numGradients: 渐变的层数
    startColor = [0, 0, 1]; % 蓝色
    endColor = [1, 0, 0];   % 红色
    
    % 确保 x 和 y 具有相同的长度
    if length(x) ~= length(y)
        error('x 和 y 的长度必须相同');
    end

    % 创建图形
    figure;
    hold on;

    % 计算柱子的宽度
    xRange = max(x) - min(x);
    barWidth = xRange / (length(x) + 1);
    halfWidth = barWidth / 2;

    % 生成渐变颜色
    gradientColors = [linspace(startColor(1), endColor(1), numGradients); ...
                      linspace(startColor(2), endColor(2), numGradients); ...
                      linspace(startColor(3), endColor(3), numGradients)]';
    y_index = linspace(0, max(y), numGradients);

    % 绘制柱子
    for i = 1:length(y)
        % 当前柱子的起始和结束位置
        xPos = [x(i) - halfWidth, x(i) - halfWidth, x(i) + halfWidth, x(i) + halfWidth];
        yPos = [0, y(i), y(i), 0];
        
        % 绘制渐变填充的柱子
        for j = 1:numGradients
            % 计算渐变层的高度
            yStart = (j-1) * y(i) / numGradients;
            yEnd = j * y(i) / numGradients;
            [~, idx] = min(abs(y_index - yEnd));
            patch(xPos, [yStart, yEnd, yEnd, yStart], gradientColors(idx, :), 'EdgeColor', 'none');
        end
        
        % 在柱子顶部显示 y 值
        text(x(i), y(i), num2str(y(i), '%.2f'), ...
            'VerticalAlignment', 'bottom', ...
            'HorizontalAlignment', 'center', ...
            'FontSize', text_fontsize , ...
            'Color', 'black');
    end

    % 设置 x 轴刻度和标签
    set(gca, 'XTick', x); % 设置 x 轴刻度位置
    set(gca, 'XTickLabel', arrayfun(@num2str, x, 'UniformOutput', false)); % 设置 x 轴标签

    % 调整图形的 x 轴范围，使柱子整体居中
    xLim = [min(x) - halfWidth, max(x) + halfWidth];
    set(gca, 'XLim', xLim); % 设置 x 轴限制
    ylim([0, max(y) * 1.1]); % 调整 y 轴范围以容纳柱子
    hold off;
end
