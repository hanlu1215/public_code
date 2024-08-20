hll
Vol = 24;

file_names = {'RigolDS1','RigolDS2','RigolDS3','RigolDS4','RigolDS5','RigolDS6'};
n = length(file_names);
figure
Ps = zeros(n,1);
fs = zeros(n,1);
% P_times = [1 1 1 1 1 10 10 10];
P_times = [10 10 10 10 10 10 10 10];%r如果单位为50mV/A则需要乘以十，因为处理的I是500mV/A
for k = 1:n
    Ps(k) = P_times(k)*pro_data_and_plot(file_names{k},k,n,Vol);
    disp(file_names{k})
    fprintf('P = %fW\n',Ps(k));
    num_str = regexp(file_names{k},'\d*\.?\d*','match');
    fs(k) = str2double(num_str{1});

end

% Ps = 
% 保存数据
csv_save_file_path = 'P_24.xls';
if exist(csv_save_file_path,'file')~=0
    delete(csv_save_file_path);
end
save_mat = {'f/Hz','P'};
writecell(save_mat,csv_save_file_path)
save_mat = [fs,Ps];
writematrix(save_mat,csv_save_file_path,'WriteMode','append')

function P = pro_data_and_plot(file_name,k,n,Vol)
subplot(n,1,k)
data=xlsread([file_name,'.csv']);

Is = data(:,2);
Ts = data(:,1);
Ts = Ts - Ts(1);
Is = Is*1000/500;%单位换算 将测量的V按照500mV/A换算为A

plot(Ts,Is,'.-')
W = trapz(Ts,Vol*Is);
P = abs(W/Ts(end));
title_str = strcat(file_name, '  P = ', string(P) ,' W');
title(title_str)
xlabel("t/s")
ylabel("I/A")
xlim([0,2]);

end

