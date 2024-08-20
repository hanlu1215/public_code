%% 数据处理函数定义：
function [x_v,y_v,v] = pro_trkd_data_auto(file_path,m_sub,n_sub,title_str,save_if,result_save_path,fig_position)
%% 获取数据
% data = uiimport(file_path);
data = importdata(file_path);
data_headers = data.colheaders;
% data_headers = {'t','x','y','v_x','v_y','v'};
id_t = find(ismember(data_headers, 't' ));
t = data.data(:,id_t);
id_v = find(ismember(data_headers, 'v' ));
data_v = data.data(:,id_v);
fig_temp = figure();
plot(t,data_v)
xlabel(data_headers{id_t}+" (s)")
ylabel(data_headers{id_v}+" (m/s)")
if nargin == 7
    fig_temp.Position = fig_position;
end
drawnow;
t_point1 = input("t1:");
t_point2 = input("t2:");
close(fig_temp);
% t_point2 = max(t)-1;
% t_point1 = t_point2-3;

if exist("t_point1","var")==1
    t_near = abs(t-t_point1);
    data_t1 = find(t_near == min(t_near));
    save_if = true;
else
    data_t1 = 1;
end
if exist("t_point2","var")==1
    t_near = abs(t-t_point2);
    data_t2 = find(t_near == min(t_near));
else
    data_t2 = size(data.data,1);
end


% data_t1 = 1;
% data_t2 = size(data.data,1);
%% 拆解数据
t = data.data(data_t1:data_t2,id_t);
id_x = find(ismember(data_headers, 'x' ));
data_x = data.data(data_t1:data_t2,id_x);
data_x = data_x - data_x(1);
id_y = find(ismember(data_headers, 'y' ));
data_y = data.data(data_t1:data_t2,id_y);
data_y = data_y - data_y(1);
data_v = data.data(data_t1:data_t2,id_v);

%% 绘图
line_width = 2;
fig = figure();
if nargin == 7
    fig.Position = fig_position;
end
subplot(m_sub,n_sub,1)
plot(t,data_x,'LineWidth',line_width)
% title(title_str)
xlabel(data_headers{id_t}+" (s)")
ylabel(data_headers{id_x}+" (m)")
p1 = polyfit(t,data_x,1);
x_v = abs(p1(1,1));
% x_d = p1(1,2);
% disp("v_x:"+num2str(x_v));
set(gca,'FontSize',12,'FontName','Times New Roman');
subplot(m_sub,n_sub,2)
plot(t,data_y,'LineWidth',line_width)
% title(title_str)
xlabel(data_headers{id_t}+" (s)")
ylabel(data_headers{id_y}+" (m)")
p2 = polyfit(t,data_y,1);
y_v = abs(p2(1,1));
% y_d = p2(1,2);
% disp("v_y:"+num2str(y_v));
v = sqrt(x_v^2+y_v^2);
% disp("v_v:"+num2str(v));
set(gca,'FontSize',12,'FontName','Times New Roman');
subplot(m_sub,n_sub,3)
plot(data_x,data_y,'LineWidth',line_width)
% title(title_str+" - Track")
xlabel(data_headers{id_x}+" (m)")
ylabel(data_headers{id_y}+" (m)")
axis equal
set(gca,'FontSize',12,'FontName','Times New Roman');
subplot(m_sub,n_sub,4)
% data_v = smoothdata(data_v);
plot(t,data_v,'LineWidth',line_width)
% title(title_str)
xlabel(data_headers{id_t}+" (s)")
ylabel(data_headers{id_v}+" (m/s)")
set(gca,'FontSize',12,'FontName','Times New Roman');
if m_sub == 3
    subplot(m_sub,n_sub,[5,6])
    txt = ["v_x : "+num2str(x_v)+"m/s" ,"v_y : " + num2str(y_v)+"m/s", "v_v : "+num2str(v)+"m/s",...
        title_str];
    text(0.5,0.5,txt,'HorizontalAlignment','center')
    disp(txt)
    axis off
end
set(gca,'FontSize',12,'FontName','Times New Roman');
%% 保持数据：
if exist(result_save_path, "dir")==0
    % 如果文件夹不存在，使用mkdir函数创建文件夹
    mkdir (result_save_path);
    disp ( 'mkdir result_save_path' );
end
if save_if
    print(fig,result_save_path+title_str+".pdf",'-dpdf','-bestfit')
    saveas(fig,result_save_path+title_str+".fig","fig")
    csv_save_file_path = result_save_path+'all_vel.xls';
    num_str = regexp(title_str,'\d*\.?\d*','match');
    fi = str2double(num_str{1});
    if exist(csv_save_file_path,'file')==0
        save_mat = {'f','x_v','y_v','v','P'};
        writecell(save_mat,csv_save_file_path)
    end
    save_mat = [fi,x_v,y_v,v];
    writematrix(save_mat,csv_save_file_path,'WriteMode','append')
end

end