function Replay %通关回放
global x;
set(findobj(x.f2,'style','pushbutton'),'enable','on');
set(findobj(x.f2,'tag','wait'),'enable','off');
for i=1:length(x.log)
    x.pos=[x.log(i,1),x.log(i,2)];
    MapDraw(CurMap);
    pause(0.15)
    if x.step~=1.4
        break;
    end
end
end