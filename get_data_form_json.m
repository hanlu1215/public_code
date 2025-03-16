function data = get_data_form_json(filename)
%UNTITLED2 此处提供此函数的摘要
%   此处提供详细说明
    fileID = fopen(filename, 'r', 'n', 'UTF-8');% 打开文件
    raw = fread(fileID, inf, '*char')';  % 读取整个文件内容为字符串
    fclose(fileID);% 关闭文件
    data = jsondecode(raw);% 解码 JSON 内容
end