function mkdir_han(folderName)
    % createFolderIfNotExists 创建文件夹，如果已存在则不创建
    %
    % 使用方法:
    % createFolderIfNotExists(folderName)
    %
    % 输入参数:
    %   folderName - 字符串，表示文件夹的名称

    % 检查文件夹是否存在
    if ~exist(folderName, 'dir')
        % 如果文件夹不存在，创建文件夹
        mkdir(folderName);
        disp(['文件夹 "' folderName '" 已创建。']);
    else
        disp(['文件夹 "' folderName '" 已存在。']);
    end
end
