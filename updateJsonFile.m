function updateJsonFile(data, filename)
% updateJsonFile: 更新或添加 JSON 文件中的数据
% 输入:
%   data - 包含要写入数据的结构体
%   filename - JSON 文件的完整路径
% 如果文件中已经存在相同的 file_name，则更新相应的字段
% 如果不存在相同的 file_name，则添加新的条目
state_flag = "";
% 检查文件是否存在
if isfile(filename)
    % 读取现有 JSON 文件内容
    fileID = fopen(filename, 'r');
    raw = fread(fileID, inf, '*char')';
    fclose(fileID);
    % 解码 JSON 内容为 MATLAB 结构数组
    fileData = jsondecode(raw);
    % 检查是否已经存在相同的 file_name
    isUpdated = false;
    for i = 1:length(fileData)
        if strcmp(fileData(i).file_name, data.file_name)
            % 如果存在相同的 file_name，则更新 v 和 f
            fileData(i).v = data.v;
            fileData(i).f = data.f;
            isUpdated = true;
            state_flag = "更新";
            break;
        end
    end
    % 如果没有找到相同的 file_name，则添加新的条目
    if ~isUpdated
        fileData(end+1) = data;
        state_flag = "添加";
    end
else
    % 如果文件不存在，创建一个空的 JSON 文件
    disp('文件不存在，创建新的 JSON 文件。');
    state_flag = "创建并添加";
    fileData = data;
end
% 将更新后的数据编码为 JSON 格式的字符串
jsonStr = jsonencode(fileData);
% 打开文件进行写入（'w' 模式表示写入，如果文件不存在则创建，存在则覆盖）
fileID = fopen(filename, 'w');
fprintf(fileID, '%s', jsonStr);
fclose(fileID);

% 提示用户操作完成
disp("JSON 数据已成功" + state_flag + "到文件：" + filename);
end
