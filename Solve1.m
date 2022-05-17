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
        map(curpos(1),curpos(2))=4;
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
