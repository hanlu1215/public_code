function plot_ax2(BL_LEN,front_size,ax1,fig0)
%% 绘制双坐标轴
% 检查是否存在右侧坐标轴（ax2），如果存在则删除
existingAx2 = findobj(fig0, 'Type', 'axes', 'YAxisLocation', 'right');
if ~isempty(existingAx2)
    delete(existingAx2);
end
% 创建右侧的坐标轴
ax2 = axes('Position', ax1.Position, ...
           'YAxisLocation', 'right', ...
           'Color', 'none', ...
           'XColor', 'none', ...
           'YColor', 'b'); % 设置右侧Y轴颜色为红色
set(ax2,'FontSize',front_size);
leftYTicks = ax1.YTick;
rightYTicks = leftYTicks*BL_LEN;
% 设置右侧Y轴的刻度和标签
ax2.YTick = rightYTicks;
ax2.YTickLabel = arrayfun(@(x) sprintf('%.1f', x), rightYTicks, 'UniformOutput', false);
% 同步左右Y轴的范围
ax2.YLim = ax1.YLim *BL_LEN;
% 设置右侧Y轴标签
ylabel(ax2,"{\itv}(m/s) [BL= "+num2str(BL_LEN)+"m]")
axes(ax1);
end