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
map(2,1)=75;
map(a-1,b)=75;
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
