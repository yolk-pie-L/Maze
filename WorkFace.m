function WorkFace %运行界面
global x
if x.tag==0
    x.f2=figure('Name','迷宫游戏','Numbertitle','off','Menu','none','position',get(0,'ScreenSize'),...
        'KeyPressFcn','global x;x.curprekey=get(x.f2,''currentcharacter'');','resize','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','返回菜单','Fontsize',12,'Position',[0.01 0.8 0.1 0.08],...
        'Callback','global x;delete([x.f1,x.f2]);MazeInterface;','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','暂停游戏','Fontsize',12,'Position',[0.01 0.7 0.1 0.08],...
        'Callback','global x;x.tag=-1.1;x.step=1;MazeInterface(x);','tag','wait','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','重新开始','Fontsize',12,'Position',[0.01 0.6 0.1 0.08],...
        'Callback','global x;x.tag=-1;x.passtime=0;x.step=1;x.log=[];x.pos=[2,1];MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','更新地图','Fontsize',12,'Position',[0.01 0.5 0.1 0.08],...
        'Callback','global x;x.tag=-2;x.passtime=0;x.step=1;x.log=[];x.pos=[2,1];MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','求解地图','Fontsize',12,'Position',[0.01 0.4 0.1 0.08],...
        'Callback','global x;x.step=1.3;x.tag=1;MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','通关回放','Fontsize',12,'Position',[0.01 0.3 0.1 0.08],...
        'Callback','global x;x.step=1.4;MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','输出迷宫','Fontsize',12,'Position',[0.01 0.2 0.1 0.08],...
        'Callback','global x;x.step=1.5;MazeInterface(x);','enable','off');
    x.tips=uicontrol('parent',x.f2,'style','text','Units','normalize','position',[0.35,0.93,0.3,0.03]);
    x.tim=timer('Period',0.05,'executionmode','fixeddelay',...
        'TimerFcn','global x;set(x.tips,''string'',[''Your Current Time is '' num2str(roundn(toc+x.passtime,-1),''%.1f'') '' s'' ])');
elseif x.tag==-1.1 %暂停游戏时触发
    stop(x.tim)
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'string','通关回放'),'enable','off');
    set(findobj(x.f2,'tag','wait'),'string','继续游戏',...
        'Callback','global x;x.tag=-1.2;x.step=1;MazeInterface(x);');
    x.passtime=toc+x.passtime;
else %继续游戏及其他操作时触发
    if x.tag==-1
    clear sound
    [y,fs]=audioread('迷宫\背景音乐.mp3');
    sound(y,fs);
    end
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'tag','wait'),'string','暂停游戏','value',0,...
        'Callback','global x;x.tag=-1.1;x.step=1;MazeInterface(x);');
    tic
    if x.tag~=-2
        start(x.tim)
    end
    set(x.f2,'CurrentCharacter','~');
end
end
