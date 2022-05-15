function SetMenu %设置菜单
global x
x.map=[];
h=dialog('Name','迷宫游戏','Units','normalize','Position',[0.32 0.32 0.35 0.51],...
    'CloseRequestFcn','closereq,global x,delete(x.f2),MazeInterface;');
uicontrol('Parent',h,'Style','Text','Units','normalize','String','游戏模式','FontSize',18,'Position',[0.25 0.7 0.5 0.2]);
S1=uibuttongroup('units','normalize',...
    'position',[0.28 0.6 0.5 0.2]);
radgroup(1,1)=uicontrol(S1,'style','rad', 'units','normalize','string','上帝视角','position',[0.28 0.6 0.5 0.15],...
    'Callback','global x;x.model=1;');
radgroup(1,2)=uicontrol(S1,'style','rad', 'units','normalize','string','第一视角','position',[0.28 0.4 0.5 0.15],...
    'Callback','global x;x.model=2;');
radgroup(1,3)=uicontrol(S1,'style','rad', 'units','normalize','string','第三视角','position',[0.28 0.2 0.5 0.15],...
    'Callback','global x;x.model=3;');
uicontrol('Parent',h,'Style','Text','Units','normalize','String','地图大小','FontSize',18,'Position',[0.25 0.38 0.5 0.2]);
S2=uibuttongroup('units','normalize',...
    'position',[0.28 0.3 0.5 0.2]);
radgroup(2,1)=uicontrol(S2,'style','rad', 'units','normalize','string','难度一','position',[0.28 0.5 0.5 0.15],...
    'Callback','global x;x.diffcult = 1;');
radgroup(2,2)=uicontrol(S2,'style','rad', 'units','normalize','string','难度二','position',[0.28 0.3 0.5 0.15],...
    'Callback','global x;x.diffcult = 2;');
radgroup(2,3)=uicontrol(S2,'style','rad', 'units','normalize','string','难度三','position',[0.28 0.1 0.5 0.15],...
    'Callback','global x;x.diffcult = 3;');
uicontrol('Parent',h,'Style','pushbutton','Units','normalize','String','设置完毕','Fontsize',12,'Position',[0.28 0.1 0.4 0.1],...
    'Callback','delete(gcbf);global x;x.step=1.1;MazeInterface(x);');
if x.model&&x.diffcult
    set(radgroup(1,x.model),'value',1);
    set(radgroup(2,x.diffcult),'value',1);
else
    x.model=1;
    x.diffcult=1;
end
end
