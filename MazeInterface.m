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















