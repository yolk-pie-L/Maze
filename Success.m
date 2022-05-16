function Success %游戏成功
clear sound;
[y,fs]=audioread('迷宫\成功.wav');
sound(y,fs)
global bgm;
bgm='迷宫\背景音乐.mp3';
h=dialog('name','游戏成功！','Units','normalized','position',[0.375 0.42 0.25 0.2],...
    'CloseRequestFcn','closereq; clear sound; global bgm; [y,fs]=audioread(bgm); sound(y,fs)');
uicontrol('parent',h,'style','text','string','游戏通关！',...
    'Units','normalized','position',[0.1 0.6 0.85 0.2],'fontsize',13);
end
