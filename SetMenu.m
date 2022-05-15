function SetMenu %设置菜单
global x
x.map=[];
h=dialog('Name','迷宫游戏','Units','normalize','Position',[0.32 0.32 0.35 0.51],...
    'CloseRequestFcn','closereq,global x,delete(x.f2),MazeInterface;');
imagesc(imread('迷宫/背景2.jpg'))
set(gca,'position',[0 0 1 1],'visible','off');
uicontrol('Parent',h,'Style','Text','Units','normalize','String','游戏模式','FontSize',30,'Position',[0.3 0.72 0.4 0.2]);
S1=uibuttongroup(h,'units','normalize',...
    'position',[0.3 0.62 0.4 0.2]);
radgroup(1,1)=uicontrol(S1,'style','rad', 'units','normalize','string','上帝视角','FontSize',18,'position',[0.28 0.68 0.5 0.3],...
    'Callback','global x;x.model=1;');
radgroup(1,2)=uicontrol(S1,'style','rad', 'units','normalize','string','第一视角','FontSize',18,'position',[0.28 0.36 0.5 0.3],...
    'Callback','global x;x.model=2;');
radgroup(1,3)=uicontrol(S1,'style','rad', 'units','normalize','string','第三视角','FontSize',18,'position',[0.28 0.04 0.5 0.3],...
    'Callback','global x;x.model=3;');
uicontrol('Parent',h,'Style','Text','Units','normalize','String','地图大小','FontSize',30,'Position',[0.3 0.40 0.4 0.2]);
S2=uibuttongroup(h,'units','normalize',...
    'position',[0.3 0.3 0.4 0.2]);
radgroup(2,1)=uicontrol(S2,'style','rad', 'units','normalize','string','难度一','FontSize',18,'position',[0.28 0.68 0.5 0.3],...
    'Callback','global x;x.diffcult = 1;');
radgroup(2,2)=uicontrol(S2,'style','rad', 'units','normalize','string','难度二','FontSize',18,'position',[0.28 0.36 0.5 0.3],...
    'Callback','global x;x.diffcult = 2;');
radgroup(2,3)=uicontrol(S2,'style','rad', 'units','normalize','string','难度三','FontSize',18,'position',[0.28 0.04 0.5 0.3],...
    'Callback','global x;x.diffcult = 3;');
uicontrol('Parent',h,'Style','pushbutton','Units','normalize','String','设置完毕','Fontsize',20,'Position',[0.30 0.1 0.4 0.1],...
    'Callback','delete(gcbf);global x;x.step=1.1;MazeInterface(x);'); 
if x.model&&x.diffcult
    set(radgroup(1,x.model),'value',1);
    set(radgroup(2,x.diffcult),'value',1);
else
    x.model=1;
    x.diffcult=1;
end
end
