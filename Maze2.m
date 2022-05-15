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
