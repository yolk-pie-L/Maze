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
