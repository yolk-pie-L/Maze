function Explain %游戏介绍
global x
if x.tag==0
    x.f2=figure('Name','游戏介绍','Numbertitle','off','Menu','none','position',get(0,'ScreenSize')',...
        'CloseRequestFcn','closereq;global x;delete(x.f2),MazeInterface;','resize','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','返回菜单','Fontsize',12,'FontName','幼圆','Position',[0.01 0.82 0.1 0.08],...
        'Callback','global x;delete([x.f1,x.f2]);MazeInterface;');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','暂停演示','Fontsize',12,'FontName','幼圆','Position',[0.01 0.72 0.1 0.08],...
        'Callback','global x,x.tag=-3;x.step=2;MazeInterface(x);','enable','off','tag','wait');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','生成算法1','Fontsize',12,'FontName','幼圆','Position',[0.01 0.62 0.1 0.08],...
        'Callback','global x,x.tag=-3.1;x.step=2;MazeInterface(x);x.step=2.1;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','生成算法2','Fontsize',12,'FontName','幼圆','Position',[0.01 0.52 0.1 0.08],...
        'Callback','global x,x.tag=-3.2;x.step=2;MazeInterface(x);x.step=2.2;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','生成算法3','Fontsize',12,'FontName','幼圆','Position',[0.01 0.42 0.1 0.08],...
        'Callback','global x,x.tag=-3.3;x.step=2;MazeInterface(x);x.step=2.3;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','求解算法1','Fontsize',12,'FontName','幼圆','Position',[0.01 0.32 0.1 0.08],...
        'Callback','global x,x.tag=-3.4;x.step=2;MazeInterface(x);x.step=2.4;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','求解算法2','Fontsize',12,'FontName','幼圆','Position',[0.01 0.22 0.1 0.08],...
        'Callback','global x,x.tag=-3.5;x.step=2;MazeInterface(x);x.step=2.5;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','求解算法3','Fontsize',12,'FontName','幼圆','Position',[0.01 0.12 0.1 0.08],...
        'Callback','global x,x.tag=-3.6;x.step=2;MazeInterface(x);x.step=2.6;MazeInterface(x);');
    x.tips=uicontrol('parent',x.f2,'style','text','Units','normalize','position',[0.35,0.93,0.4,0.03],'Fontsize',12,'FontName','幼圆','FontWeight','bold');
    imagesc(imread('迷宫\游戏介绍.jpg'));
    set(gca,'visible','off')
elseif x.tag==-3
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'string','继续演示','callback','global x,x.tag=-4;x.step=2;MazeInterface(x);');
else
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'tag','wait'),'string','暂停演示','enable','on','callback','global x,x.tag=-3;x.step=2;MazeInterface(x);')
end
end
