function Exit %退出游戏
beep
h=dialog('name','请选择','Units','normalized','position',[0.375 0.42 0.25 0.2]);
uicontrol('parent',h,'style','text','string','是否退出迷宫？',...
    'Units','normalized','position',[0.1 0.6 0.85 0.2],'fontsize',13);
uicontrol('parent',h,'style','pushbutton','Units','normalized',...
    'position',[0.55 0.2 0.3 0.2],'string','否','callback','delete(gcbf);');
uicontrol('parent',h,'style','pushbutton','Units','normalized',...
    'position',[0.15 0.2 0.3 0.2],'string','是','callback','delete(gcbf),global x,delete(x.f1);clear global x');
end
