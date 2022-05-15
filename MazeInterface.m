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















