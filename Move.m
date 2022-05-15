function Move%控制移动函数
global x;
MapDraw(CurMap)
[e,f]=size(x.map);
if all(x.pos == [e-1,f])
    stop(x.tim)
    set(findobj(x.f2,'style','pushbutton'),'enable','off');
    set(findobj(x.f2,'string','通关回放'),'enable','on');
    x.passtime=toc+x.passtime;
    set(x.tips,'string',num2str(['Your Last Time is ' num2str(roundn(x.passtime,-1)) ' s']))
    x.step=0;
    [y,fs]=audioread('迷宫\成功.mp3');
    sound(y,fs)
    return
end
if x.step
    str=get(x.f2,'CurrentCharacter');
    while str==get(x.f2,'CurrentCharacter')
        pause(0.03)
    end
    set(x.f2,'CurrentCharacter','~');
    if x.step~=1.2||x.tag==-1.1
        return;
    end
    if ~isempty(double(x.curprekey))
        switch double(x.curprekey)
            case 30 % up
                if x.map(max(x.pos(1)-1,1),x.pos(2))>0&&x.pos(1)>1
                    x.pos(1)=x.pos(1)-1;
                end
            case 31 % down
                if x.map(min(x.pos(1)+1,e),x.pos(2))>0&&x.pos(1)<e
                    x.pos(1)=x.pos(1)+1;
                end
            case 28 % left
                if x.map(x.pos(1),max(x.pos(2)-1,1))>0&&x.pos(2)>1
                    x.pos(2)=x.pos(2)-1;
                end
            case 29 % right
                if x.map(x.pos(1),min(x.pos(2)+1,f))>0&&x.pos(2)<f
                    x.pos(2)=x.pos(2)+1;
                end
        end
    end
    if x.tag
        set(findobj(x.f2,'tag','wait'),'enable','on');
        x.tag=0;
    end
    Move;
end
end
