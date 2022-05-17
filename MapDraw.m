function MapDraw(map) %绘制迷宫
global colour
map1=map;
[r,c] = size(map1);    
for i = 1:r       
    for k = 1:c
        switch(map1(i,k))
            case 0
                map1(i,k)=colour.wall;
            case 1
                map1(i,k)=colour.way;
            case 2
                map1(i,k)=colour.stand;
            case 3
                map1(i,k)=100;
            case 4
                map1(i,k)=25;
            case 75
                map1(i,k)=75;
            otherwise 
                map1(i,k)=6;
        end
    end
end
im=imagesc(map1,[0,100]);
colormap("pink")
set(gca,'visible','off')
end
