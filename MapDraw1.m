function MapDraw(map) %绘制迷宫
global colour
map1=map;
[r,c] = size(map1);    
for i = 1:r       
    for k = 1:c
        if map1(i,k)==0
            map1(i,k)=colour.wall;
        else 
            if map1(i,k)==1
                map1(i,k)=colour.way;
            else
                map1(i,k)=colour.stand;
            end
        end
    end
end
map1(2,1)=colour.sae;
map1(r-1,c)=colour.sae;
imagesc(map1);
set(gca,'visible','off')
end