
function PrintMap %输出地图
global x
printm=figure('Name','迷宫地图','Numbertitle','off','Menu','none','visible','off');
set(gcf,'position',get(0,'ScreenSize'));
axis off
set(gca,'YDir','reverse')
[e,f]=size(x.map);
for i=1:e
    for j=1:f
        if x.map(i,j)==0%0代表未被打通的墙壁
            if(mod(i,2)>mod(j,2))
                line([max(j-1,1),min(j+1,f)],[i,i]);
            elseif(mod(i,2)<mod(j,2))
                line([j,j],[max(i-1,1),min(i+1,e)]);
            end
        end
    end
end
[name,dir]=uiputfile('迷宫打印图.jpg');
if dir
    saveas(printm,fullfile(dir,name));
    h=dialog('name','','units','normalize','position',[0.42,0.42,0.2,0.2],'CloseRequestFcn','beep');
    uicontrol('parent',h,'style','text','string','保存成功！','fontsize',15,'units','normalize',...
        'position',[0.33,0.6,0.4,0.2])
    uicontrol('parent',h,'style','pushbutton','string','确定','fontsize',12,'units','normalize',...
        'position',[0.35,0.2,0.3,0.2],'callback','delete(gcbf)')
end
delete(printm)
end