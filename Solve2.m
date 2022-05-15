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