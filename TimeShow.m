function TimeShow %倒计时
global x
clear sound
[y,fs]=audioread('迷宫\背景音乐.mp3');
sound(y,fs);
set(x.tips,'string','（提示：本游戏使用方向键操作，如需关闭游戏请先暂停游戏）')
set(findobj(x.f2,'style','pushbutton'),'value',0,'enable','off');
f{1}=imread('迷宫\s1.jpg');
f{2}=imread('迷宫\s2.jpg');
f{3}=imread('迷宫\s3.jpg');
set(x.f2,'CloseRequestFcn','');
for i=3:-1:1
    imagesc(f{i})
    set(gca,'visible','off')
    pause(1)
end
set(x.f2,'CloseRequestFcn','global x;stop(x.tim);delete(x.f2),MazeInterface;');
set(findobj(x.f2,'tag','wait'),'enable','on');
tic
start(x.tim)
end