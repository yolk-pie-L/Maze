function MazeInterface(varargin)
global x ;
if nargin<1 %主界面
    MainMenu
elseif x.step == 1 %开始游戏
    WorkFace %运行界面
    if x.tag==0||x.tag==-2
        SetMenu  %设置界面
    else
        x.step=1.1;
        MazeInterface(x)
    end
elseif x.step==1.1
    if isempty(x.map)
        MapWrite %地图写入
        TimeShow %倒计时
    end
    x.step=1.2;
    MazeInterface(x)
elseif x.step==1.2
    Move;
elseif x.step==1.3
    Solve %地图求解
elseif x.step==1.4
    Replay   %通关回放
elseif x.step==1.5
    PrintMap %输出地图
elseif x.step==2 %游戏介绍
    Explain
elseif x.step==2.1
    Maze1; %生成算法1
elseif x.step==2.2
    Maze2; %生成算法2
elseif x.step==2.3
    Maze3; %生成算法3
elseif x.step==2.4
    Solve1 %求解算法1
elseif x.step==2.5
    Solve2 %求解算法2
else
    Exit %退出游戏
end
end
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
x.f1=figure('Name','迷宫游戏','Numbertitle','off','Menu','none','units','normalize','resize','off','CloseRequestFcn',[]);
imagesc(imread('迷宫\背景.jpg'))
set(gca,'position',[0 0 1 1],'visible','off');
text(0.3,0.77,'MAZE GAME','Units','normalize','FontSize',30,'FontName','Maiandra GD','FontWeight','bold')
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','开始游戏','Fontsize',12,'Position',[0.38 0.5 0.3 0.1],...
    'Callback','global x;delete(x.f1);x.step=1;MazeInterface(x);');
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','游戏介绍','Fontsize',12,'Position',[0.38 0.35 0.3 0.1],...
    'Callback','global x;delete(x.f1);x.step=2;MazeInterface(x);');
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','退出游戏','Fontsize',12,'Position',[0.38 0.2 0.3 0.1],...
    'Callback','global x;x.step=3;MazeInterface(x);');
end
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
        'TimerFcn','global x;set(x.tips,''string'',[''Your Current Time is '' num2str(roundn(toc+x.passtime,-1)) '' s'' ])');
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
function Explain %游戏介绍
global x
if x.tag==0
    x.f2=figure('Name','地图生成演示','Numbertitle','off','Menu','none','position',get(0,'ScreenSize')',...
        'CloseRequestFcn','closereq;global x;delete(x.f2),MazeInterface;','resize','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','返回菜单','Fontsize',12,'Position',[0.01 0.8 0.1 0.08],...
        'Callback','global x;delete([x.f1,x.f2]);MazeInterface;');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','暂停演示','Fontsize',12,'Position',[0.01 0.7 0.1 0.08],...
        'Callback','global x,x.tag=-3;x.step=2;MazeInterface(x);','enable','off','tag','wait');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','生成算法1','Fontsize',12,'Position',[0.01 0.6 0.1 0.08],...
        'Callback','global x,x.tag=-3.1;x.step=2;MazeInterface(x);x.step=2.1;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','生成算法2','Fontsize',12,'Position',[0.01 0.5 0.1 0.08],...
        'Callback','global x,x.tag=-3.2;x.step=2;MazeInterface(x);x.step=2.2;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','生成算法3','Fontsize',12,'Position',[0.01 0.4 0.1 0.08],...
        'Callback','global x,x.tag=-3.3;x.step=2;MazeInterface(x);x.step=2.3;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','求解算法1','Fontsize',12,'Position',[0.01 0.3 0.1 0.08],...
        'Callback','global x,x.tag=-3.4;x.step=2;MazeInterface(x);x.step=2.4;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','求解算法2','Fontsize',12,'Position',[0.01 0.2 0.1 0.08],...
        'Callback','global x,x.tag=-3.5;x.step=2;MazeInterface(x);x.step=2.5;MazeInterface(x);');
    x.tips=uicontrol('parent',x.f2,'style','text','Units','normalize','position',[0.35,0.93,0.3,0.03]);
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

% % 以下三个函数为迷宫生成函数 % %
function map=Maze1(varargin)%深度优先（递归回溯）算法
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','深度优先（递归回溯）算法')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
map(2,1)=1;
map(a-1,b)=1;
p=zeros(1,4);%存放某一步可走的方向
q=zeros(1,a*b);%存放每一步走过的方向
i=2;j=2;
next=0;
while ~isempty(find(map(2:2:a,2:2:b)==0,1))%从第一个格子开始走直到走完所有格子
    if nargin<1
        if x.tag==-3
            while x.tag==-3
                pause(0.3)
            end
            if x.tag>-4
                break;
            end
        end
        if x.tag<-3
            MapDraw(map);
            pause(0.005)
        end
    end
    t=0;
    map(i,j)=1;
    if i>2
        if map(i-2,j)==0
            t=t+1;p(t)=1;
        end
    end
    if i<a-1
        if map(i+2,j)==0
            t=t+1;p(t)=4;
        end
    end
    if j>2
        if map(i,j-2)==0
            t=t+1;p(t)=2;
        end
    end
    if j<b-1
        if map(i,j+2)==0
            t=t+1;p(t)=3;
        end
    end
    if t==0%如果走到某一步无法继续，则返回到上一步，直到能走为止
        q(next)=5-q(next);
    else
        next=next+1;
        q(next)=p(randi(t));%随机选择一个可走的方向
    end
    switch q(next)
        case 1
            i=i-2;map(i+1,j)=1;
        case 4
            i=i+2;map(i-1,j)=1;
        case 2
            j=j-2;map(i,j+1)=1;
        case 3
            j=j+2;map(i,j-1)=1;
    end
    if t==0
        next=next-1;
    end
end
if x.step>2&&x.step<2.4
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end

function map=Maze2(varargin)%随机Prim算法
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','随机Prim算法')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
wall=zeros(2,a*b);%存放未被打通过的墙壁
map(2,1)=1;
map(a-1,b)=1;
i=2;j=2;
wall(:,1)=[2,3];
wall(:,2)=[3,2];
wallnum=2;
while wallnum %直到除了四周外的所有墙壁两面的格子均不封闭为止
    if nargin<1
        if x.tag==-3
            while x.tag==-3
                pause(0.3)
            end
            if x.tag>-4
                break;
            end
        end
        if x.tag<-3
            MapDraw(map);
            pause(0.005)
        end
    end
    map(i,j)=1;
    wa=randi(wallnum);
    wal=wall(:,wa);
    if mod(wal(1),2)>0%选择一面墙使得它的另一面的格子作为新单元;
        if map(wal(1)-1,wal(2))==0
            i=wal(1)-1;j=wal(2);
            map(wal(1),wal(2))=1;
        elseif map(wal(1)+1,wal(2))==0
            i=wal(1)+1;j=wal(2);
            map(wal(1),wal(2))=1;
        else
            wall(:,wa)=[];%如果这面墙两边格子均被打通过则删除此壁
            wallnum=wallnum-1;
            continue;
        end
    else
        if map(wal(1),wal(2)-1)==0
            i=wal(1);j=wal(2)-1;
            map(wal(1),wal(2))=1;
        elseif map(wal(1),wal(2)+1)==0
            i=wal(1);j=wal(2)+1;
            map(wal(1),wal(2))=1;
        else
            wall(:,wa)=[];
            wallnum=wallnum-1;
            continue;
        end
    end
    if i>2 %选择加入该单元的墙到数组里
        wallnum=wallnum+1;
        wall(:,wallnum)=[i-1,j];
    end
    if i<a-1
        wallnum=wallnum+1;
        wall(:,wallnum)=[i+1,j];
    end
    if j>2
        wallnum=wallnum+1;
        wall(:,wallnum)=[i,j-1];
    end
    if j<b-1
        wallnum=wallnum+1;
        wall(:,wallnum)=[i,j+1];
    end
end
if x.step>2&&x.step<2.4
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end

function map=Maze3(varargin)%递归分割法
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','递归分割算法')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
room=zeros(4,a*b);%存放室的两个顶点的坐标
map(2:a-1,2:b-1)=1;
map(2,1)=1;
map(a-1,b)=1;
room(:,1)=[1,1,a,b];
listnum=1;
while listnum %直到不存在可分割的室为止
    if nargin<1
        if x.tag==-3
            while x.tag==-3
                pause(0.3)
            end
            if x.tag>-4
                break;
            end
        end
        if x.tag<-3
            MapDraw(map);
            pause(0.05)
        end
    end
    roo=randi(listnum);%挑选一个室
    aa=room(1,roo);bb=room(2,roo);cc=room(3,roo);dd=room(4,roo);
    if cc-aa>2&&dd-bb>2%若该室的大小可继续分割
        mm=aa+2:2:cc-2;%在室内选点进行分割
        m=mm(randi(length(mm)));
        nn=bb+2:2:dd-2;
        n=nn(randi(length(nn)));
        map(m,bb:dd)=0;%在室内对该点的横向与纵向生成墙壁
        map(aa:cc,n)=0;
        room(:,listnum+1)=[aa,bb,m,n];
        room(:,listnum+2)=[m,n,cc,dd];
        room(:,listnum+3)=[m,bb,cc,n];
        room(:,listnum+4)=[aa,n,m,dd];%分割成四个小室
        listnum=listnum+4;
        p=randperm(4);
        for i=1:3 %在隔离4个室的墙壁任意3面上打洞使其连通
            switch p(i)
                case 1
                    y=aa+1:2:m;
                    z=y(randi(length(y)));
                    map(z,n)=1;
                case 2
                    y=m+1:2:cc;
                    z=y(randi(length(y)));
                    map(z,n)=1;
                case 3
                    y=bb+1:2:n;
                    z=y(randi(length(y)));
                    map(m,z)=1;
                case 4
                    y=n+1:2:dd;
                    z=y(randi(length(y)));
                    map(m,z)=1;
            end
        end
    end
    room(:,roo)=[];%删除大室
    listnum=listnum-1;
end
if x.step>2&&x.step<2.4
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end

function map=CurMap %当前视角下地图
global x
x.log=[x.log;x.pos(1),x.pos(2)]; %更新操作日志
map=x.map;
[e,f]=size(map);
map(x.pos(1),x.pos(2))=2;
if x.model>1
    left=max(1,x.pos(2)-x.WatchArea);right=min(x.pos(2)+x.WatchArea,f);
    if left==1
        right=left+2*x.WatchArea;
    end
    if right==f
        left=right-2*x.WatchArea;
    end
    up=max(1,x.pos(1)-x.WatchArea);down=min(x.pos(1)+x.WatchArea,e);
    if up==1
        down=up+2*x.WatchArea;
    end
    if down==e
        up=down-2*x.WatchArea;
    end
    switch x.model
        case 2 %第一视角
            map=map(up:down,left:right);
        case 3 %第三视角
            map([1:up-1,down+1:e],:)=0;
            map(:,[1:left-1,right+1:f])=0;
    end
end
end

function Move%控制移动函数
global x;
MapDraw(CurMap)
[e,f]=size(x.map);
if all(x.pos == [e-1,f])
    stop(x.tim)
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'string','通关回放'),'enable','on');
    x.passtime=toc+x.passtime;
    set(x.tips,'string',num2str(['Your Last Time is ' num2str(roundn(x.passtime,-1)) ' s']))
    x.step=0;
    [y,fs]=audioread('迷宫\成功.mp3');
    sound(y,fs)
    return
end
if x.step
    str=get(x.f2,'CurrentCharacter');
    while str==get(x.f2,'CurrentCharacter')
        pause(0.03)
    end
    set(x.f2,'CurrentCharacter','~');
    if x.step~=1.2||x.tag==-1.1
        return;
    end
    if ~isempty(double(x.curprekey))
        switch double(x.curprekey)
            case 30 % up
                if x.map(max(x.pos(1)-1,1),x.pos(2))>0&&x.pos(1)>1
                    x.pos(1)=x.pos(1)-1;
                end
            case 31 % down
                if x.map(min(x.pos(1)+1,e),x.pos(2))>0&&x.pos(1)<e
                    x.pos(1)=x.pos(1)+1;
                end
            case 28 % left
                if x.map(x.pos(1),max(x.pos(2)-1,1))>0&&x.pos(2)>1
                    x.pos(2)=x.pos(2)-1;
                end
            case 29 % right
                if x.map(x.pos(1),min(x.pos(2)+1,f))>0&&x.pos(2)<f
                    x.pos(2)=x.pos(2)+1;
                end
        end
    end
    if x.tag
        set(findobj(x.f2,'tag','wait'),'enable','on');
        x.tag=0;
    end
    Move;
end
end

function MapWrite %随机更新迷宫
global x
if x.model==3
    x.WatchArea=x.diffcult*5;
elseif x.model==2
    x.WatchArea=5;
end
len=10*2^x.diffcult+1;
wid=20*2^x.diffcult+1;
switch randi(3)
    case 1
        x.map=Maze1(len,wid);
    case 2
        x.map=Maze2(len,wid);
    case 3
        x.map=Maze3(len,wid);
end
end

function MapDraw(map) %绘制迷宫
imagesc(map);
set(gca,'visible','off')
end

function Solve1
global x
if isempty(x.map)
    x.model=2;
    map=Maze2(41,81);
    set(x.tips,'string','经典求解算法：深度搜索算法')
else
    map=x.map;
end
orimap=map;
[e,f]=size(map);
curpos=[2,1];
map(2,1)=3;
path=zeros(e*f,2);
path(1,:)=[2,1];
num=1;
while ~all(curpos==[e-1,f])
    t=0;
    if map(curpos(1),min(curpos(2)+1,f))==1
        curpos(2)=min(curpos(2)+1,f);
        t=1;
    elseif map(min(curpos(1)+1,e),curpos(2))==1
        curpos(1)=min(curpos(1)+1,e);
        t=1;
    elseif map(curpos(1),max(curpos(2)-1,1))==1
        curpos(2)=max(curpos(2)-1,1);
        t=1;
    elseif map(max(curpos(1)-1,1),curpos(2))==1
        curpos(1)=max(curpos(1)-1,1);
        t=1;
    end
    if t
        num=num+1;
        path(num,:)=curpos;
    else
        curpos=path(num,:);
        map(curpos(1),curpos(2))=2;
        path(num,:)=[];
        num=num-1;
        curpos=path(num,:);
    end
    map(curpos(1),curpos(2))=3;
    if x.tag==-3
        while x.tag==-3
            pause(0.3)
        end
        if x.tag>-4
            return;
        end
    end
    if x.tag<-3
        MapDraw(map);
        pause(0.01)
    end
end
if x.tag
    map=map==3;
    if x.step<2
        orimap(x.pos(1),x.pos(2))=2;
    end
    MapDraw(orimap+map)
end
if x.step>2
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end

function Solve2 %地图求解
global x
if isempty(x.map)
    map=Maze2(41,81);
    set(x.tips,'string','自创求解算法：不断剔除始末点外端点来得到可行路径')
else
    map=x.map;
end
orimap=map;
h=zeros(3);
h([2,4,6,8])=1;
t=0;
while 1
    if x.tag==-3
        while x.tag==-3
            pause(0.3)
        end
        if x.tag>-4
            break;
        end
    end
    if x.tag<-3
        MapDraw(map);
        pause(0.05)
    end
    sample=conv2(map,h,'same');
    sample(sample==1)=0;
    sample([2,end-1])=1;
    sample=sample>0;
    map(sample~=map)=0;%抛去除始末点以外所有端点
    if t==length(find(map>0))%直到抛完为止
        break;
    else
        t=length(find(map>0));
    end
end
if x.tag
    if x.step<2
        orimap(x.pos(1),x.pos(2))=2;
    end
    MapDraw(orimap+map)
end
if x.step>2
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end

function Solve %随机更新迷宫
switch randi(2)
    case 1
        Solve1
    case 2
        Solve2
end
end

function Replay %通关回放
global x;
set(findobj(x.f2,'style','pushbutton'),'enable','on');
set(findobj(x.f2,'tag','wait'),'enable','off');
for i=1:length(x.log)
    x.pos=[x.log(i,1),x.log(i,2)];
    MapDraw(CurMap);
    pause(0.15)
    if x.step~=1.4
        break;
    end
end
end

function PrintMap %输出地图
global x
printm=figure('Name','迷宫地图','Numbertitle','off','Menu','none','visible','off');
set(gcf,'position',get(0,'ScreenSize'));
axis off
set(gca,'YDir','reverse')
[e,f]=size(x.map);
for i=1:e
    for j=1:f
        if x.map(i,j)==0%0代表未被打通的墙壁
            if(mod(i,2)>mod(j,2))
                line([max(j-1,1),min(j+1,f)],[i,i]);
            elseif(mod(i,2)<mod(j,2))
                line([j,j],[max(i-1,1),min(i+1,e)]);
            end
        end
    end
end
[name,dir]=uiputfile('迷宫打印图.jpg');
if dir
    saveas(printm,fullfile(dir,name));
    h=dialog('name','','units','normalize','position',[0.42,0.42,0.2,0.2],'CloseRequestFcn','beep');
    uicontrol('parent',h,'style','text','string','保存成功！','fontsize',15,'units','normalize',...
        'position',[0.33,0.6,0.4,0.2])
    uicontrol('parent',h,'style','pushbutton','string','确定','fontsize',12,'units','normalize',...
        'position',[0.35,0.2,0.3,0.2],'callback','delete(gcbf)')
end
delete(printm)
end

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

function Exit %退出游戏
beep
h=dialog('name','请选择','Units','normalized','position',[0.375 0.42 0.25 0.2],'CloseRequestFcn','beep');
uicontrol('parent',h,'style','text','string','是否退出迷宫？',...
    'Units','normalized','position',[0.1 0.6 0.85 0.2],'fontsize',13);
uicontrol('parent',h,'style','pushbutton','Units','normalized',...
    'position',[0.15 0.2 0.3 0.2],'string','不好意思点错了','callback','delete(gcbf);');
uicontrol('parent',h,'style','pushbutton','Units','normalized',...
    'position',[0.55 0.2 0.3 0.2],'string','玩够了想歇一会','callback','delete(gcbf),global x,delete(x.f1);clear global x');
end
