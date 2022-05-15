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

