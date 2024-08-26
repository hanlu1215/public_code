function result = hanzi2pinyin(str)
% 确保 MATLAB 能调用 Python 并安装了 pypinyin
if count(py.sys.path,'') == 0
    result = str;
    %     insert(py.sys.path,int32(0),'');
else
    % 直接获取拼音首字母风格
    first_letter_style = py.pypinyin.STYLE_FIRST_LETTER;
    % 调用Python的pypinyin库进行拼音首字母转换
    pinyinList = py.pypinyin.pinyin(str, pyargs('style', first_letter_style));
    % 将Python列表转换为MATLAB的字符向量元胞数组，并转换为大写
    pinyinCell = cellfun(@(x) upper(char(x{1})), cell(pinyinList), 'UniformOutput', false);
    % 将元胞数组拼接为一个完整的拼音首字母字符串
    str0 = strjoin(pinyinCell, '');
    str0 = strrep(str0, '/', '-');
    str0 = strrep(str0, '\', '-');
    result = strrep(str0, '_', '-');
end
end