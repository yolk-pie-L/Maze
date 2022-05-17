function Solve3
global x
if isempty(x.map)
    x.model=2;
    map=Maze2(41,81);
    set(x.tips,'string','广度优先搜索算法')
else
    map=x.map;
end
orimap=map;
[e,f]=size(map);
curpos=[2,1];
map(2,1)=3;
path(1,:)=[2,1];
num=1;
head=1;
tail=1; 
q=zeros(1,e*f*2);
pre=zeros(1,e*f);
q(tail)=2;
q(tail+1)=1;
tail=tail+2;
while head~=tail
    curpos=[q(head),q(head+1)];
    if curpos(1)==e-1 && curpos(2)==f % 如果走到终点就跳出循环
        break;
    end
    if map(curpos(1),min(curpos(2)+1,f))==1
        q(tail)=curpos(1);
        q(tail+1)=min(curpos(2)+1,f);
        pre(tail)=head;
        tail=tail+2;
    end
    if map(min(curpos(1)+1,e),curpos(2))==1
        q(tail)=min(curpos(1)+1,e);
        q(tail+1)=curpos(2);
        pre(tail)=head;
        tail=tail+2;
    end
    if map(curpos(1),max(curpos(2)-1,1))==1
        q(tail)=curpos(1);
        q(tail+1)=max(curpos(2)-1,1);
        pre(tail)=head;
        tail=tail+2;
    end
    if map(max(curpos(1)-1,1),curpos(2))==1
        q(tail)=max(curpos(1)-1,1);
        q(tail+1)=curpos(2);
        pre(tail)=head;
        tail=tail+2;
    end
    head=head+2;
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

cur=head;
orimap(2,1)=3;
orimap(e-1,f)=3;
while cur~=1
    locatx=q(cur);
    locaty=q(cur+1);
    orimap(locatx,locaty)=3;
    cur=pre(cur);
end


if x.tag
    map=map==3;
    if x.step<2
        orimap(x.pos(1),x.pos(2))=2;
    end
    MapDraw(orimap)
end
if x.step>2
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end