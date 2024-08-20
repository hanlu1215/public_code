function v = get_datav_from_fig(fig_path)
%UNTITLED 此处提供此函数的摘要
%   此处提供详细说明
    fig0 = openfig(fig_path,'invisible');
    axesHandles = findall(fig0, 'type', 'axes');
    textHandles = findall(axesHandles(1), 'type', 'text');
    texts = textHandles(1).String;
    close(fig0);
    disp(texts);
    msg_v = texts{3};
    % msg_f = texts{4};
    numbers = regexp(msg_v, '\d+(\.\d+)?', 'match');
    v = str2double(numbers{1});
end