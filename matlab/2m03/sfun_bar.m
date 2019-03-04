function sfun_bar(block)
% Level 2 m-function for barrier simulation

    setup(block);
end

function setup(block)

    block.NumDialogPrms=0; % no tunable parameters
    block.NumInputPorts=1; % motor
    block.NumOutputPorts=4; % ir, limit switch bottom, limit switch top, remote
    
    block.SetPreCompInpPortInfoToDynamic;
    block.SetPreCompOutPortInfoToDynamic;

    block.InputPort(1).Dimensions=1;
    
    block.InputPort(1).DirectFeedthrough=false;
    
    block.OutputPort(1).Dimensions=1;
    block.OutputPort(2).Dimensions=1;
    block.OutputPort(3).Dimensions=1;
    block.OutputPort(4).Dimensions=1;    
    
    block.SampleTimes=[0 0];
    
    block.NumContStates=1; % theta

    block.RegBlockMethod('InitializeConditions',@InitCond);
    block.RegBlockMethod('Outputs',@Output);
    block.RegBlockMethod('Derivatives',@Derivatives);
     
    block.RegBlockMethod('SetInputPortSamplingMode', @SetInpPortFrameData);
end

function InitCond(block)
    % Initialize

    block.ContStates.Data=[0];

    % INITIALIZE GUI
    if isempty(findobj('Tag','fig_barrier'))
        initGui();
    end
end

function Output(block)
    
    phi=min(max(block.ContStates.Data(1),0),pi/2);
    block.ContStates.Data(1)=phi;
    [IR,Remote]=getGuiStatus(phi,block.InputPort(1).Data);
    block.OutputPort(3).Data=real(IR);% IR
    block.OutputPort(1).Data=real(block.ContStates.Data(1)==0);
    block.OutputPort(2).Data=real(block.ContStates.Data(1)==pi/2);
    block.OutputPort(4).Data=Remote;% Remote
end

function Derivatives(block)
    Speed=0.5;
    phi=min(max(block.ContStates.Data(1),0),pi/2);
    [IR,Remote]=getGuiStatus(phi,block.InputPort(1).Data);
    block.Derivatives.Data(1)=block.InputPort(1).Data*Speed;
end

function SetInpPortFrameData(block, idx, fd)
  
  block.InputPort(idx).SamplingMode = fd;
  block.OutputPort(1).SamplingMode  = fd;
  block.OutputPort(2).SamplingMode  = fd;
  block.OutputPort(3).SamplingMode  = fd;
  block.OutputPort(4).SamplingMode  = fd;
end
  
function initGui()
    hfig=figure(1);
    setappdata(hfig,'remotePressed',0);
    set(hfig,'Tag','fig_barrier','MenuBar','none','Color','w','CloseRequestFcn',@closeGui);
    set(hfig,'Position',[0 0 400 400],'Name','Barrier model','NumberTitle','off');
    set(hfig,'WindowButtonUpFcn',@toggleRemote);

    % Remote
    axesRemote=axes('Position',[0.05 0.45 0.2 0.15],'Color','none','XColor','w','YColor','w');
    set(axesRemote,'NextPlot','add');
    fill([0.2 0.2 0.8 0.8],[0 1 1 0],[0.5 0.5 0.5]);
    fill([0.25 0.25 0.75 0.75],[0.2 0.7 0.7 0.2],[0.8 0.8 0.8],'ButtonDownFcn',@toggleRemote);
    fill([0.6 0.6 0.75 0.75],[0.75 0.95 0.95 0.75],'r','Tag','remoteLED'); 
    set(axesRemote,'XLim',[0 1],'YLim',[0 1],'XTick',[],'YTick',[]);  


    % Barrier
    axesBarrier=axes('Position',[0.3 0.2 0.6 0.8],'Color','none','XColor','w','YColor','w');
    set(axesBarrier,'NextPlot','add');

    % Trunks and arrows
    fill([0.2 0.2 0.1 0.1],[0 0.3 0.3 0],[0.3 0.3 0.3]);
    fill([1 1  0.9 0.9],[0 0.3 0.3 0],[0.3 0.3 0.3]);
    fill([0.13 0.13 0.11 0.15 0.19 0.17 0.17],[0.12 0.17 0.17 0.2 0.17 0.17 0.12],'g','Tag','MotorUp','Visible','off');
    fill([0.13 0.13 0.11 0.15 0.19 0.17 0.17],[0.1 0.05 0.05 0.02 0.05 0.05 0.1],'g','Tag','MotorDown','Visible','off');
    hBar=line([0.15 0.9],[0.25 0.25],'LineWidth',9,'Color',[0.6 0.6 0.6],'Tag','Bar');
    phi=0;

    set(axesBarrier,'XLim',[0 1],'YLim',[0 1.33],'XTick',[],'YTick',[]);  
    line([0.25 0.9],[0.1 0.1],'Tag','IRline','ButtonDownFcn',@toggleIR,'Color','r','LineWidth',4);
    fill([0.2 0.25 0.25 0.2],[0.05 0.09 0.11 0.15],'r','ButtonDownFcn',@toggleIR);
    fill([0 0 0.05 0.05],[1 0.95 0.95 1],'r','Tag','LimitSwitchTop');
    fill([0 0 0.05 0.05],[0.3 0.25 0.25 0.3],'r','Tag','LimitSwitchBottom');
end

function toggleIR(varargin)

    hIR=findobj('Tag','IRline');
    if strcmp(get(hIR,'Visible'),'on')
        set(hIR,'Visible','off');
    else
        set(hIR,'Visible','on');
    end
    
end

function [IR,Remote]=getGuiStatus(phi,motor)

    hIR=findobj('Tag','IRline');
    IR=strcmp(get(hIR,'Visible'),'on');
    hBar=findobj('Tag','Bar');
    set(hBar,'YData',[0.25 0.25+sin(phi)*0.75],'XData',[0.15 0.15+cos(phi)*0.75]);

    hLimitSwitchTop=findobj('Tag','LimitSwitchTop');
    hLimitSwitchBottom=findobj('Tag','LimitSwitchBottom');

    if (phi==pi/2)
        set(hLimitSwitchTop,'FaceColor','g');
    else
        set(hLimitSwitchTop,'FaceColor','r');
    end
    if (phi==0)
        set(hLimitSwitchBottom,'FaceColor','g');
    else
        set(hLimitSwitchBottom,'FaceColor','r');
    end

    Remote=getappdata(findobj('Tag','fig_barrier'),'remotePressed');
    
    if (motor==-1)
        set(findobj('Tag','MotorDown'),'Visible','on');
    else
        set(findobj('Tag','MotorDown'),'Visible','off');
    end

    if (motor==1)
        set(findobj('Tag','MotorUp'),'Visible','on');
    else
        set(findobj('Tag','MotorUp'),'Visible','off');
    end  
end
    
function toggleRemote(varargin)
    hRemoteLED=findobj('Tag','remoteLED');
    hfig=findobj('Tag','fig_barrier');
    if (strcmpi(varargin{2}.EventName,'WindowMouseRelease'))
        setappdata(hfig,'remotePressed',0);
        set(hRemoteLED,'FaceColor','r');
    else
        setappdata(hfig,'remotePressed',1);
        set(hRemoteLED,'FaceColor','g');
    end
end

function closeGui(varargin)

    if strcmp(gcs,'eml_lib')
        delete(gcf);
    else
        try
            if (strcmp(get_param(gcs,'SimulationStatus'),'stopped'))
                delete(gcf);
            end
        catch
            delete(gcf);
        end
    end
end