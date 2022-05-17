function map=Maze3(varargin)%递归分割法
global x
if ~nargin
    a=41;
    b=81;
    set(x.tips,'string','递归分割算法')
else
    a=varargin{1};
    b=varargin{2};
end
map=zeros(a,b);
room=zeros(4,a*b);%存放室的两个顶点的坐标
map(2:a-1,2:b-1)=1;
map(2,1)=75;
map(a-1,b)=75;
room(:,1)=[1,1,a,b];
listnum=1;
while listnum %直到不存在可分割的室为止
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
    roo=randi(listnum);%挑选一个室
    aa=room(1,roo);bb=room(2,roo);cc=room(3,roo);dd=room(4,roo);
    if cc-aa>2&&dd-bb>2%若该室的大小可继续分割
        mm=aa+2:2:cc-2;%在室内选点进行分割
        m=mm(randi(length(mm)));
        nn=bb+2:2:dd-2;
        n=nn(randi(length(nn)));
        map(m,bb:dd)=0;%在室内对该点的横向与纵向生成墙壁
        map(aa:cc,n)=0;
        room(:,listnum+1)=[aa,bb,m,n];
        room(:,listnum+2)=[m,n,cc,dd];
        room(:,listnum+3)=[m,bb,cc,n];
        room(:,listnum+4)=[aa,n,m,dd];%分割成四个小室
        listnum=listnum+4;
        p=randperm(4);
        for i=1:3 %在隔离4个室的墙壁任意3面上打洞使其连通
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
    room(:,roo)=[];%删除大室
    listnum=listnum-1;
end
if x.step>2&&x.step<2.4
    set(findobj(x.f2,'style','pushbutton'),'enable','on');
    set(findobj(x.f2,'tag','wait'),'enable','off');
end
end
