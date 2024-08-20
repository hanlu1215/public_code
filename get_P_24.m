function P = get_P_24(file_name,Current_range,Vol)
if ~ismember(Current_range, [50,500])
    disp('不是指定量程');
    return;
end
data=xlsread(file_name);
Is = data(:,2);
Ts = data(:,1);
Ts = Ts - Ts(1);
Is = Is*1000/Current_range;%单位换算 将测量的V按照50mV/A或者500mV/A换算为A
figure(100)
plot(Ts,Is,'.-')
W = trapz(Ts,Vol*Is);
P = abs(W/Ts(end));
title_str = strcat(file_name, '  P = ', string(P) ,' W');
disp("量程为： "+num2str(Current_range)+"mV/A，电压为： "+num2str(Vol)+"V, "+"P = "+num2str(P)+"W");
title(title_str)
xlabel("t/s")
ylabel("I/A")
xlim([0,2]);

end

