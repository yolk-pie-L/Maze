function MazeInterface(varargin)
global x ;
if nargin<1 %������
    MainMenu
elseif x.step == 1 %��ʼ��Ϸ
    WorkFace %���н���
    if x.tag==0||x.tag==-2
        SetMenu  %���ý���
    else
        x.step=1.1;
        MazeInterface(x)
    end
elseif x.step==1.1
    if isempty(x.map)
        MapWrite %��ͼд��
        TimeShow %����ʱ
    end
    x.step=1.2;
    MazeInterface(x)
elseif x.step==1.2
    Move;
elseif x.step==1.3
    Solve %��ͼ���
elseif x.step==1.4
    Replay   %ͨ�ػط�
elseif x.step==1.5
    PrintMap %�����ͼ
elseif x.step==2 %��Ϸ����
    Explain
elseif x.step==2.1
    Maze1; %�����㷨1
elseif x.step==2.2
    Maze2; %�����㷨2
elseif x.step==2.3
    Maze3; %�����㷨3
elseif x.step==2.4
    Solve1 %����㷨1
elseif x.step==2.5
    Solve2 %����㷨2
else
    Exit %�˳���Ϸ
end
end
function MainMenu %���˵�
clear global x
clear sound
global x
x=struct(...
    'f1',[],...������
    'f2',[],...���н���
    'model',0,...��Ϸ�ӽ�
    'tag',0,...��Ǳ���
    'diffcult',0,...��Ϸ�Ѷ�
    'passtime',0,...����ʱ��
    'tim',[],...��ʱ��
    'tips','',...�ı���ʾ
    'WatchArea',0,...��Ϸ��Ұ
    'curprekey','',...��ǰ����
    'pos',[2,1],...��ǰλ��
    'log',[],...������־
    'map',[],...��Ϸ��ͼ
    'step',0); %��ǰ����
x.f1=figure('Name','�Թ���Ϸ','Numbertitle','off','Menu','none','units','normalize','resize','off','CloseRequestFcn',[]);
imagesc(imread('�Թ�\����.jpg'))
set(gca,'position',[0 0 1 1],'visible','off');
text(0.3,0.77,'MAZE GAME','Units','normalize','FontSize',30,'FontName','Maiandra GD','FontWeight','bold')
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','��ʼ��Ϸ','Fontsize',12,'Position',[0.38 0.5 0.3 0.1],...
    'Callback','global x;delete(x.f1);x.step=1;MazeInterface(x);');
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','��Ϸ����','Fontsize',12,'Position',[0.38 0.35 0.3 0.1],...
    'Callback','global x;delete(x.f1);x.step=2;MazeInterface(x);');
uicontrol('Parent',x.f1,'Style','pushbutton','Units','normalize','String','�˳���Ϸ','Fontsize',12,'Position',[0.38 0.2 0.3 0.1],...
    'Callback','global x;x.step=3;MazeInterface(x);');
end
function SetMenu %���ò˵�
global x
x.map=[];
h=dialog('Name','�Թ���Ϸ','Units','normalize','Position',[0.32 0.32 0.35 0.51],...
    'CloseRequestFcn','closereq,global x,delete(x.f2),MazeInterface;');
uicontrol('Parent',h,'Style','Text','Units','normalize','String','��Ϸģʽ','FontSize',18,'Position',[0.25 0.7 0.5 0.2]);
S1=uibuttongroup('units','normalize',...
    'position',[0.28 0.6 0.5 0.2]);
radgroup(1,1)=uicontrol(S1,'style','rad', 'units','normalize','string','�ϵ��ӽ�','position',[0.28 0.6 0.5 0.15],...
    'Callback','global x;x.model=1;');
radgroup(1,2)=uicontrol(S1,'style','rad', 'units','normalize','string','��һ�ӽ�','position',[0.28 0.4 0.5 0.15],...
    'Callback','global x;x.model=2;');
radgroup(1,3)=uicontrol(S1,'style','rad', 'units','normalize','string','�����ӽ�','position',[0.28 0.2 0.5 0.15],...
    'Callback','global x;x.model=3;');
uicontrol('Parent',h,'Style','Text','Units','normalize','String','��ͼ��С','FontSize',18,'Position',[0.25 0.38 0.5 0.2]);
S2=uibuttongroup('units','normalize',...
    'position',[0.28 0.3 0.5 0.2]);
radgroup(2,1)=uicontrol(S2,'style','rad', 'units','normalize','string','�Ѷ�һ','position',[0.28 0.5 0.5 0.15],...
    'Callback','global x;x.diffcult = 1;');
radgroup(2,2)=uicontrol(S2,'style','rad', 'units','normalize','string','�Ѷȶ�','position',[0.28 0.3 0.5 0.15],...
    'Callback','global x;x.diffcult = 2;');
radgroup(2,3)=uicontrol(S2,'style','rad', 'units','normalize','string','�Ѷ���','position',[0.28 0.1 0.5 0.15],...
    'Callback','global x;x.diffcult = 3;');
uicontrol('Parent',h,'Style','pushbutton','Units','normalize','String','�������','Fontsize',12,'Position',[0.28 0.1 0.4 0.1],...
    'Callback','delete(gcbf);global x;x.step=1.1;MazeInterface(x);');
if x.model&&x.diffcult
    set(radgroup(1,x.model),'value',1);
    set(radgroup(2,x.diffcult),'value',1);
else
    x.model=1;
    x.diffcult=1;
end
end
function WorkFace %���н���
global x
if x.tag==0
    x.f2=figure('Name','�Թ���Ϸ','Numbertitle','off','Menu','none','position',get(0,'ScreenSize'),...
        'KeyPressFcn','global x;x.curprekey=get(x.f2,''currentcharacter'');','resize','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','���ز˵�','Fontsize',12,'Position',[0.01 0.8 0.1 0.08],...
        'Callback','global x;delete([x.f1,x.f2]);MazeInterface;','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','��ͣ��Ϸ','Fontsize',12,'Position',[0.01 0.7 0.1 0.08],...
        'Callback','global x;x.tag=-1.1;x.step=1;MazeInterface(x);','tag','wait','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','���¿�ʼ','Fontsize',12,'Position',[0.01 0.6 0.1 0.08],...
        'Callback','global x;x.tag=-1;x.passtime=0;x.step=1;x.log=[];x.pos=[2,1];MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','���µ�ͼ','Fontsize',12,'Position',[0.01 0.5 0.1 0.08],...
        'Callback','global x;x.tag=-2;x.passtime=0;x.step=1;x.log=[];x.pos=[2,1];MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','����ͼ','Fontsize',12,'Position',[0.01 0.4 0.1 0.08],...
        'Callback','global x;x.step=1.3;x.tag=1;MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','ͨ�ػط�','Fontsize',12,'Position',[0.01 0.3 0.1 0.08],...
        'Callback','global x;x.step=1.4;MazeInterface(x);','enable','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','����Թ�','Fontsize',12,'Position',[0.01 0.2 0.1 0.08],...
        'Callback','global x;x.step=1.5;MazeInterface(x);','enable','off');
    x.tips=uicontrol('parent',x.f2,'style','text','Units','normalize','position',[0.35,0.93,0.3,0.03]);
    x.tim=timer('Period',0.05,'executionmode','fixeddelay',...
        'TimerFcn','global x;set(x.tips,''string'',[''Your Current Time is '' num2str(roundn(toc+x.passtime,-1)) '' s'' ])');
elseif x.tag==-1.1 %��ͣ��Ϸʱ����
    stop(x.tim)
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'string','ͨ�ػط�'),'enable','off');
    set(findobj(x.f2,'tag','wait'),'string','������Ϸ',...
        'Callback','global x;x.tag=-1.2;x.step=1;MazeInterface(x);');
    x.passtime=toc+x.passtime;
else %������Ϸ����������ʱ����
    if x.tag==-1
    clear sound
    [y,fs]=audioread('�Թ�\��������.mp3');
    sound(y,fs);
    end
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'tag','wait'),'string','��ͣ��Ϸ','value',0,...
        'Callback','global x;x.tag=-1.1;x.step=1;MazeInterface(x);');
    tic
    if x.tag~=-2
        start(x.tim)
    end
    set(x.f2,'CurrentCharacter','~');
end
end
function Explain %��Ϸ����
global x
if x.tag==0
    x.f2=figure('Name','��ͼ������ʾ','Numbertitle','off','Menu','none','position',get(0,'ScreenSize')',...
        'CloseRequestFcn','closereq;global x;delete(x.f2),MazeInterface;','resize','off');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','���ز˵�','Fontsize',12,'Position',[0.01 0.8 0.1 0.08],...
        'Callback','global x;delete([x.f1,x.f2]);MazeInterface;');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','��ͣ��ʾ','Fontsize',12,'Position',[0.01 0.7 0.1 0.08],...
        'Callback','global x,x.tag=-3;x.step=2;MazeInterface(x);','enable','off','tag','wait');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','�����㷨1','Fontsize',12,'Position',[0.01 0.6 0.1 0.08],...
        'Callback','global x,x.tag=-3.1;x.step=2;MazeInterface(x);x.step=2.1;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','�����㷨2','Fontsize',12,'Position',[0.01 0.5 0.1 0.08],...
        'Callback','global x,x.tag=-3.2;x.step=2;MazeInterface(x);x.step=2.2;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','�����㷨3','Fontsize',12,'Position',[0.01 0.4 0.1 0.08],...
        'Callback','global x,x.tag=-3.3;x.step=2;MazeInterface(x);x.step=2.3;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','����㷨1','Fontsize',12,'Position',[0.01 0.3 0.1 0.08],...
        'Callback','global x,x.tag=-3.4;x.step=2;MazeInterface(x);x.step=2.4;MazeInterface(x);');
    uicontrol('Parent',x.f2,'Style','pushbutton','Units','normalize','String','����㷨2','Fontsize',12,'Position',[0.01 0.2 0.1 0.08],...
        'Callback','global x,x.tag=-3.5;x.step=2;MazeInterface(x);x.step=2.5;MazeInterface(x);');
    x.tips=uicontrol('parent',x.f2,'style','text','Units','normalize','position',[0.35,0.93,0.3,0.03]);
    imagesc(imread('�Թ�\��Ϸ����.jpg'));
    set(gca,'visible','off')
elseif x.tag==-3
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'string','������ʾ','callback','global x,x.tag=-4;x.step=2;MazeInterface(x);');
else
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'tag','wait'),'string','��ͣ��ʾ','enable','on','callback','global x,x.tag=-3;x.step=2;MazeInterface(x);')
end
end

% % ������������Ϊ�Թ����ɺ��� % %
function map=Maze1(varargin)%������ȣ��ݹ���ݣ��㷨
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','������ȣ��ݹ���ݣ��㷨')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
map(2,1)=1;
map(a-1,b)=1;
p=zeros(1,4);%���ĳһ�����ߵķ���
q=zeros(1,a*b);%���ÿһ���߹��ķ���
i=2;j=2;
next=0;
while ~isempty(find(map(2:2:a,2:2:b)==0,1))%�ӵ�һ�����ӿ�ʼ��ֱ���������и���
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
    if t==0%����ߵ�ĳһ���޷��������򷵻ص���һ����ֱ������Ϊֹ
        q(next)=5-q(next);
    else
        next=next+1;
        q(next)=p(randi(t));%���ѡ��һ�����ߵķ���
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

function map=Maze2(varargin)%���Prim�㷨
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','���Prim�㷨')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
wall=zeros(2,a*b);%���δ����ͨ����ǽ��
map(2,1)=1;
map(a-1,b)=1;
i=2;j=2;
wall(:,1)=[2,3];
wall(:,2)=[3,2];
wallnum=2;
while wallnum %ֱ�����������������ǽ������ĸ��Ӿ������Ϊֹ
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
    if mod(wal(1),2)>0%ѡ��һ��ǽʹ��������һ��ĸ�����Ϊ�µ�Ԫ;
        if map(wal(1)-1,wal(2))==0
            i=wal(1)-1;j=wal(2);
            map(wal(1),wal(2))=1;
        elseif map(wal(1)+1,wal(2))==0
            i=wal(1)+1;j=wal(2);
            map(wal(1),wal(2))=1;
        else
            wall(:,wa)=[];%�������ǽ���߸��Ӿ�����ͨ����ɾ���˱�
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
    if i>2 %ѡ�����õ�Ԫ��ǽ��������
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

function map=Maze3(varargin)%�ݹ�ָ
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','�ݹ�ָ��㷨')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
room=zeros(4,a*b);%����ҵ��������������
map(2:a-1,2:b-1)=1;
map(2,1)=1;
map(a-1,b)=1;
room(:,1)=[1,1,a,b];
listnum=1;
while listnum %ֱ�������ڿɷָ����Ϊֹ
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
    roo=randi(listnum);%��ѡһ����
    aa=room(1,roo);bb=room(2,roo);cc=room(3,roo);dd=room(4,roo);
    if cc-aa>2&&dd-bb>2%�����ҵĴ�С�ɼ����ָ�
        mm=aa+2:2:cc-2;%������ѡ����зָ�
        m=mm(randi(length(mm)));
        nn=bb+2:2:dd-2;
        n=nn(randi(length(nn)));
        map(m,bb:dd)=0;%�����ڶԸõ�ĺ�������������ǽ��
        map(aa:cc,n)=0;
        room(:,listnum+1)=[aa,bb,m,n];
        room(:,listnum+2)=[m,n,cc,dd];
        room(:,listnum+3)=[m,bb,cc,n];
        room(:,listnum+4)=[aa,n,m,dd];%�ָ���ĸ�С��
        listnum=listnum+4;
        p=randperm(4);
        for i=1:3 %�ڸ���4���ҵ�ǽ������3���ϴ�ʹ����ͨ
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
    room(:,roo)=[];%ɾ������
    listnum=listnum-1;
end
if x.step>2&&x.step<2.4
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end

function map=CurMap %��ǰ�ӽ��µ�ͼ
global x
x.log=[x.log;x.pos(1),x.pos(2)]; %���²�����־
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
        case 2 %��һ�ӽ�
            map=map(up:down,left:right);
        case 3 %�����ӽ�
            map([1:up-1,down+1:e],:)=0;
            map(:,[1:left-1,right+1:f])=0;
    end
end
end

function Move%�����ƶ�����
global x;
MapDraw(CurMap)
[e,f]=size(x.map);
if all(x.pos == [e-1,f])
    stop(x.tim)
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'string','ͨ�ػط�'),'enable','on');
    x.passtime=toc+x.passtime;
    set(x.tips,'string',num2str(['Your Last Time is ' num2str(roundn(x.passtime,-1)) ' s']))
    x.step=0;
    [y,fs]=audioread('�Թ�\�ɹ�.mp3');
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

function MapWrite %��������Թ�
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

function MapDraw(map) %�����Թ�
imagesc(map);
set(gca,'visible','off')
end

function Solve1
global x
if isempty(x.map)
    x.model=2;
    map=Maze2(41,81);
    set(x.tips,'string','��������㷨����������㷨')
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

function Solve2 %��ͼ���
global x
if isempty(x.map)
    map=Maze2(41,81);
    set(x.tips,'string','�Դ�����㷨�������޳�ʼĩ����˵����õ�����·��')
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
    map(sample~=map)=0;%��ȥ��ʼĩ���������ж˵�
    if t==length(find(map>0))%ֱ������Ϊֹ
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

function Solve %��������Թ�
switch randi(2)
    case 1
        Solve1
    case 2
        Solve2
end
end

function Replay %ͨ�ػط�
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

function PrintMap %�����ͼ
global x
printm=figure('Name','�Թ���ͼ','Numbertitle','off','Menu','none','visible','off');
set(gcf,'position',get(0,'ScreenSize'));
axis off
set(gca,'YDir','reverse')
[e,f]=size(x.map);
for i=1:e
    for j=1:f
        if x.map(i,j)==0%0����δ����ͨ��ǽ��
            if(mod(i,2)>mod(j,2))
                line([max(j-1,1),min(j+1,f)],[i,i]);
            elseif(mod(i,2)<mod(j,2))
                line([j,j],[max(i-1,1),min(i+1,e)]);
            end
        end
    end
end
[name,dir]=uiputfile('�Թ���ӡͼ.jpg');
if dir
    saveas(printm,fullfile(dir,name));
    h=dialog('name','','units','normalize','position',[0.42,0.42,0.2,0.2],'CloseRequestFcn','beep');
    uicontrol('parent',h,'style','text','string','����ɹ���','fontsize',15,'units','normalize',...
        'position',[0.33,0.6,0.4,0.2])
    uicontrol('parent',h,'style','pushbutton','string','ȷ��','fontsize',12,'units','normalize',...
        'position',[0.35,0.2,0.3,0.2],'callback','delete(gcbf)')
end
delete(printm)
end

function TimeShow %����ʱ
global x
clear sound
[y,fs]=audioread('�Թ�\��������.mp3');
sound(y,fs);
set(x.tips,'string','����ʾ������Ϸʹ�÷��������������ر���Ϸ������ͣ��Ϸ��')
set(findobj(x.f2,'style','pushbutton'),'value',0,'enable','off');
f{1}=imread('�Թ�\s1.jpg');
f{2}=imread('�Թ�\s2.jpg');
f{3}=imread('�Թ�\s3.jpg');
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

function Exit %�˳���Ϸ
beep
h=dialog('name','��ѡ��','Units','normalized','position',[0.375 0.42 0.25 0.2],'CloseRequestFcn','beep');
uicontrol('parent',h,'style','text','string','�Ƿ��˳��Թ���',...
    'Units','normalized','position',[0.1 0.6 0.85 0.2],'fontsize',13);
uicontrol('parent',h,'style','pushbutton','Units','normalized',...
    'position',[0.15 0.2 0.3 0.2],'string','������˼�����','callback','delete(gcbf);');
uicontrol('parent',h,'style','pushbutton','Units','normalized',...
    'position',[0.55 0.2 0.3 0.2],'string','�湻����Ъһ��','callback','delete(gcbf),global x,delete(x.f1);clear global x');
end
