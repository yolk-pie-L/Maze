function MainMenu %主菜单
clear global x
clear sound
global x
x=struct(...
    'f1',[],...主界面
    'f2',[],...运行界面
    'model',0,...游戏视角
    'tag',0,...标记变量
    'diffcult',0,...游戏难度
    'passtime',0,...运行时间
    'tim',[],...计时器
    'tips','',...文本提示
    'WatchArea',0,...游戏视野
    'curprekey','',...当前按键
    'pos',[2,1],...当前位置
    'log',[],...操作日志
    'map',[],...游戏地图
    'step',0); %当前步骤
x.f1=figure('Name','迷宫游戏','Numbertitle','off','Menu','none','units','normalize','resize','off','CloseRequestFcn','Exit');
imagesc(imread('迷宫\背景.jpg'))
set(gca,'position',[0 0 1 1],'visible','off');
text(0.27,0.77,'MAZE GAME','Units','normalize','FontSize',35,'FontName','Maiandra GD','FontWeight','bold')
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','开始游戏','Fontsize',12,'Position',[0.38 0.4 0.3 0.1],...
    'Callback','global x;delete(x.f1);x.step=1;MazeInterface(x);');
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','游戏介绍','Fontsize',12,'Position',[0.38 0.25 0.3 0.1],...
    'Callback','global x;delete(x.f1);x.step=2;MazeInterface(x);');
end
