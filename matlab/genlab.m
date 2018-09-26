function varargout = genlab(varargin)
% GENLAB M-file for genlab.fig
%      GENLAB, by itself, creates a new GENLAB or raises the existing
%      singleton*.
%
%      H = GENLAB returns the handle to a new GENLAB or the handle to
%      the existing singleton*.
%
%      GENLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENLAB.M with the given input arguments.
%
%      GENLAB('Property','Value',...) creates a new GENLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before genlab_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to genlab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help genlab

% Last Modified by GUIDE v2.5 12-Feb-2010 14:50:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @genlab_OpeningFcn, ...
                   'gui_OutputFcn',  @genlab_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before genlab is made visible.
function genlab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to genlab (see VARARGIN)

% Choose default command line output for genlab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
Handlers=guihandles(hObject);


set(Handlers.NIND,'String',20);
set(Handlers.MAXGEN,'String',50);
set(Handlers.ggap,'String',0.8);
set(Handlers.mutpr,'String',0.001);
set(Handlers.rrate,'String',0.5);



setappdata(hObject,'CurrentGen',0);
setappdata(hObject,'ActiveRun',0);
setappdata(hObject,'OBJ_F','djng');
set(Handlers.CurrentGen,'string',0);
set(handles.StopButton,'enable','off');
setappdata(handles.figure1,'Running',0);
setappdata(handles.figure1,'Limits',[-512 -512; 512 512]);
reset_fig(handles);
% UIWAIT makes genlab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = genlab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function NIND_Callback(hObject, eventdata, handles)
% hObject    handle to NIND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NIND as text
%        str2double(get(hObject,'String')) returns contents of NIND as a double
setappdata(handles.figure1,'ActiveRun',0);
set(handles.CurrentGen,'String',0);
reset_fig(handles);


% --- Executes during object creation, after setting all properties.
function NIND_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NIND (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ggap_Callback(hObject, eventdata, handles)
% hObject    handle to ggap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ggap as text
%        str2double(get(hObject,'String')) returns contents of ggap as a double

if (str2double(get(hObject,'String'))>1)||(str2double(get(hObject,'String'))<0)
    set(hObject,'String',0);
end;



% --- Executes during object creation, after setting all properties.
function ggap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ggap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mutpr_Callback(hObject, eventdata, handles)
% hObject    handle to mutpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mutpr as text
%        str2double(get(hObject,'String')) returns contents of mutpr as a double

if (str2double(get(hObject,'String'))>1)||(str2double(get(hObject,'String'))<0)
    set(hObject,'String',0);
end;

% --- Executes during object creation, after setting all properties.
function mutpr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mutpr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rrate_Callback(hObject, eventdata, handles)
% hObject    handle to rrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rrate as text
%        str2double(get(hObject,'String')) returns contents of rrate as a double
if (str2double(get(hObject,'String'))>1)||(str2double(get(hObject,'String'))<0)
    set(hObject,'String',0);
end;

% --- Executes during object creation, after setting all properties.
function rrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_param_button.
function reset_param_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_param_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(handles.figure1,'ActiveRun',0);
set(handles.CurrentGen,'String',0);
set(handles.NIND,'String',20);
set(handles.MAXGEN,'String',50);
set(handles.ggap,'String',0.7);
%set(handles.MutationScale,'String',0.01);
set(handles.mutpr,'String',0.001);
set(handles.rrate,'String',0.5);
reset_fig(handles);

% --- Executes on button press in start_button.
function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

step_num=0;
MAXGEN=str2num(get(handles.MAXGEN,'String'));
setappdata(handles.figure1,'Running',1);
set(handles.StopButton,'enable','on');
set(handles.step_button,'enable','off');
set(handles.reset_run_button,'enable','off');
set(handles.start_button,'enable','off');
while (step_num<MAXGEN)&(getappdata(handles.figure1,'Running')==1)
    step_opt(handles);
    step_num=step_num+1;
end;
setappdata(handles.figure1,'Running',0);
set(handles.step_button,'enable','on');
set(handles.reset_run_button,'enable','on');
set(handles.start_button,'enable','on');
set(handles.StopButton,'enable','off');
    
% end of startbutton callback function



function MAXGEN_Callback(hObject, eventdata, handles)
% hObject    handle to MAXGEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MAXGEN as text
%        str2double(get(hObject,'String')) returns contents of MAXGEN as a double


% --- Executes during object creation, after setting all properties.
function MAXGEN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MAXGEN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on mouse press over axes background.
function axes_3d_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)










function CurrentGen_Callback(hObject, eventdata, handles)
% hObject    handle to CurrentGen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CurrentGen as text
%        str2double(get(hObject,'String')) returns contents of CurrentGen as a double


% --- Executes during object creation, after setting all properties.
function CurrentGen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CurrentGen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in step_button.
function step_button_Callback(hObject, eventdata, handles)
% hObject    handle to step_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

step_opt(handles);



% --- Executes on button press in reset_run_button.
function reset_run_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_run_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reset_fig(handles);





% --------------------------------------------------------------------
function objfun_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to objfun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if get(handles.dejong,'Value')==1
    setappdata(handles.figure1,'OBJ_F','djng');
    setappdata(handles.figure1,'Limits',getlimits('djng'));
end;

if get(handles.rosenbrock,'Value')==1
    setappdata(handles.figure1,'OBJ_F','rsnbrck');
    setappdata(handles.figure1,'Limits',getlimits('rsnbrck'));
end;

if get(handles.rastrigin,'Value')==1
    setappdata(handles.figure1,'OBJ_F','rstrgn');
    setappdata(handles.figure1,'Limits',getlimits('rstrgn'));
end;
    
if get(handles.schwefel,'Value')==1
    setappdata(handles.figure1,'OBJ_F','schwfl');
    setappdata(handles.figure1,'Limits',getlimits('schwfl'));
end;

reset_fig(handles);
setappdata(handles.figure1,'ActiveRun',0);





% --- Executes on button press in BestButton.
function BestButton_Callback(hObject, eventdata, handles)
% hObject    handle to BestButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(4);
hold on;
OBJ_F=getappdata(handles.figure1,'OBJ_F');
bests=getappdata(handles.figure1,'bests');
%limits=feval(OBJ_F,[],[]);
limit=max(abs(bests(:)));
%x=linspace(limits(1,1),limits(2,1),100);
%y=linspace(limits(1,2),limits(2,2),100);
x=linspace(-limit,limit,200);
y=linspace(-limit,limit,200);
for i=1:length(x)
   ObjVs(:,i) = feval(OBJ_F,[repmat(x(i),length(y),1) y']);
end;
mesh(x,y,ObjVs);  

for i=1:length(bests)
    plot3(ones(1,2)*bests(i,1), ones(1,2)*bests(i,2), [0 feval(OBJ_F,bests(i,:))],'Color','Red','LineWidth',2);
    plot3(ones(1,2)*bests(i,1), ones(1,2)*bests(i,2), [0 max(max(ObjVs))],'Color','Red','LineStyle','--');
end;
view(127.5,30);
hold off;

% --- Executes on button press in ErrorButton.
function ErrorButton_Callback(hObject, eventdata, handles)
% hObject    handle to ErrorButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(5);
errors=getappdata(handles.figure1,'errors');
fig_handle=semilogy([1:length(errors)],errors,'*r');
axis([1 length(errors) 0 max(errors)]);

% - Function for getting objective function limits

function limits=getlimits(objfun)

if strcmp(objfun,'djng')
    limits=[-512 -512;512 512];
end;
if strcmp(objfun,'rsnbrck')
    limits=[-2 -2;2 2];
end;
if strcmp(objfun,'rstrgn')
    limits=[-512 -512;512 512];
end;
if strcmp(objfun,'schwfl')
    limits=[-500 -500;500 500];
end;

function opt=getopt(objfun)
if strcmp(objfun,'djng')
    opt=[0 0];
end;
if strcmp(objfun,'rsnbrck')
    opt=[1 1];
end;
if strcmp(objfun,'rstrgn')
	opt=[0 0];
end;
if strcmp(objfun,'schwfl')
    opt=[420.9687,420.9687];
end;

% - Function for resetting the figure
function reset_fig(handles)
    OBJ_F=getappdata(handles.figure1,'OBJ_F');
    limits=getlimits(OBJ_F);
    x=linspace(limits(1,1),limits(2,1),100);
    y=linspace(limits(1,2),limits(2,2),100);
    for i=1:length(x)
       ObjVs(:,i) = feval(OBJ_F,[repmat(x(i),length(y),1) y']);
    end;

    mesh(x,y,ObjVs);  
    %127.5
    view(127.5,30); 
    setappdata(handles.figure1,'ActiveRun',0);
    set(handles.CurrentGen,'string',0);
    setappdata(handles.figure1,'CurrentGen',0);
    set(handles.EditBest1,'string','');
    set(handles.EditBest2,'string','');
    set(handles.EditBestVal,'string','');


% --- Executes on button press in NewWindowButton.
function NewWindowButton_Callback(hObject, eventdata, handles)
% hObject    handle to NewWindowButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OBJ_F=getappdata(handles.figure1,'OBJ_F');

if getappdata(handles.figure1,'ActiveRun')==1
    % ActiveRun 
    
    
    Pop_Vars=getappdata(handles.figure1,'final_pop');
    
    limits=getlimits(OBJ_F);
    opt=getopt(OBJ_F);
    diff=abs(Pop_Vars-ones(size(Pop_Vars,1),1)*opt);
    Limit=max(diff(:));

    xmin=max(limits(1,1),opt(1)-Limit);
    xmax=min(limits(2,1),opt(1)+Limit);
    ymin=max(limits(1,2),opt(2)-Limit);
    ymax=min(limits(2,2),opt(2)+Limit);

    x=linspace(xmin,xmax,100);
    y=linspace(ymin,ymax,100);
    
    
    for i=1:length(x)
        ObjVs(:,i) = feval(OBJ_F,[repmat(x(i),length(y),1) y']);
    end;
    vals=getappdata(handles.figure1,'final_vals');

    figure(3);
    caxis auto;
%    axes_handle=axes;
    hold on;
    
    mesh(x,y,double(ObjVs));  
    [best,bi]=min(vals);
    for i=1:length(Pop_Vars)
          plot3(ones(1,2)*Pop_Vars(i,1),ones(1,2)*Pop_Vars(i,2),[0 vals(i)],'Color','blue','LineWidth',2);
    end;               
    plot3(ones(1,2)*Pop_Vars(bi,1),ones(1,2)*Pop_Vars(bi,2),[0 vals(bi)],'Color','red','LineWidth',2);
    plot3(ones(1,2)*Pop_Vars(bi,1),ones(1,2)*Pop_Vars(bi,2),[0 max(max(ObjVs))],'Color','red','LineWidth',1,'LineStyle','--');
    axes_handle=gca;
     

    set(handles.axes_3d,'XLim',[xmin-eps xmax+eps]);
    set(handles.axes_3d,'YLim',[ymin-eps ymax+eps]);
    set(handles.axes_3d,'Zlim',[0 2*max(vals)+eps]);     
    
    view(127.5,30);
    hold off;
    
else
    limits=getlimits(OBJ_F);
    x=linspace(limits(1,1),limits(2,1),500);
    y=linspace(limits(1,2),limits(2,2),500);
    for i=1:length(x)
        ObjVs(:,i) = feval(OBJ_F,[repmat(x(i),length(y),1) y']);
    end;
    figure(3);
    mesh(x,y,ObjVs);  
    view(127.5,30);
end;

function step_opt(Handles)
% One step of optimization

NIND=str2double(get(Handles.NIND,'String'));
ggap=str2double(get(Handles.ggap,'String'));
mutpr=str2double(get(Handles.mutpr,'String'));
rrate=str2double(get(Handles.rrate,'String'));
OBJ_F=getappdata(Handles.figure1,'OBJ_F');

limits=getlimits(OBJ_F);
if getappdata(Handles.figure1,'ActiveRun')==1
    Init_Chrom=getappdata(Handles.figure1,'final_chrom');
else

    Init_Chrom=[limits(1,1)+(limits(2,1)-limits(1,1))*rand(str2double(get(Handles.NIND,'String')),1) limits(1,2)+(limits(2,2)-limits(1,2))*rand(str2double(get(Handles.NIND,'String')),1)];
end;

final_chrom=mysga(Init_Chrom,1,OBJ_F,ggap,mutpr,rrate);
final_chrom(find(final_chrom(:,1)<limits(1,1)),1)=limits(1,1);
final_chrom(find(final_chrom(:,1)>limits(2,1)),1)=limits(2,1);
final_chrom(find(final_chrom(:,2)<limits(1,2)),2)=limits(1,2);
final_chrom(find(final_chrom(:,2)>limits(2,2)),2)=limits(2,2);

final_vals=feval(OBJ_F,final_chrom);
[mv,mi]=min(final_vals);
bests=final_chrom(mi,:);
error=feval(getappdata(Handles.figure1,'OBJ_F'),bests);
setappdata(Handles.figure1,'final_pop',final_chrom);
if getappdata(Handles.figure1,'ActiveRun')==1
    setappdata(Handles.figure1,'bests',[getappdata(Handles.figure1,'bests'); bests]);
    setappdata(Handles.figure1,'errors',[getappdata(Handles.figure1,'errors'); error]);
else
    setappdata(Handles.figure1,'bests',bests);
    setappdata(Handles.figure1,'errors',error);
end;
setappdata(Handles.figure1,'final_vals',final_vals);
setappdata(Handles.figure1,'final_chrom',final_chrom);
setappdata(Handles.figure1,'ActiveRun',1);

set(Handles.EditBest1,'String',num2str(bests(1),3));
set(Handles.EditBest2,'String',num2str(bests(2),3));
set(Handles.EditBestVal,'String',num2str(feval(getappdata(Handles.figure1,'OBJ_F'),bests),3));

% Updating 3D plot
axes(Handles.axes_3d);

cla;
hold on;
opt=getopt(OBJ_F);
diff=abs(final_chrom-ones(size(final_chrom,1),1)*opt);
Limit=max(diff(:));
% SCHWEFEL!

xmin=max(limits(1,1),opt(1)-Limit);
xmax=min(limits(2,1),opt(1)+Limit);
ymin=max(limits(1,2),opt(2)-Limit);
ymax=min(limits(2,2),opt(2)+Limit);

x=linspace(xmin,xmax,100);
y=linspace(ymin,ymax,100);


ObjVs=zeros(length(x),length(x));
for i=1:length(x)
    ObjVs(:,i) = feval(OBJ_F,[repmat(x(i),length(y),1) y']);
end;
caxis auto;
%mesh(x,y,ones(length(x),length(x)));
mesh(x,y,ObjVs);

for i=1:size(final_chrom,1)

    plot3(ones(1,2)*final_chrom(i,1),ones(1,2)*final_chrom(i,2),[0 final_vals(i)],'b');

end;

plot3(ones(1,2)*bests(1),ones(1,2)*bests(2),[0 error],'Color','red','LineWidth',2);
plot3(ones(1,2)*bests(1),ones(1,2)*bests(2),[0 max(final_vals)],'Color','red');
set(Handles.axes_3d,'XLim',[xmin-eps xmax+eps]);
set(Handles.axes_3d,'YLim',[ymin-eps ymax+eps]);
set(Handles.axes_3d,'Zlim',[0 2*max(final_vals)+eps]);
view(127.5,30);
hold off;

% Updating step counter

set(Handles.CurrentGen,'string',str2double(get(Handles.CurrentGen,'string'))+1);

% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    setappdata(handles.figure1,'Running',0);
    set(handles.StopButton,'enable','off');



function EditBest1_Callback(hObject, eventdata, handles)
% hObject    handle to EditBest1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBest1 as text
%        str2double(get(hObject,'String')) returns contents of EditBest1 as a double


% --- Executes during object creation, after setting all properties.
function EditBest1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBest1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditBest2_Callback(hObject, eventdata, handles)
% hObject    handle to EditBest2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBest2 as text
%        str2double(get(hObject,'String')) returns contents of EditBest2 as a double


% --- Executes during object creation, after setting all properties.
function EditBest2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBest2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditBestVal_Callback(hObject, eventdata, handles)
% hObject    handle to EditBestVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBestVal as text
%        str2double(get(hObject,'String')) returns contents of EditBestVal as a double


% --- Executes during object creation, after setting all properties.
function EditBestVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBestVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function MutationScale_Callback(hObject, eventdata, handles)
% hObject    handle to MutationScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MutationScale as text
%        str2double(get(hObject,'String')) returns contents of MutationScale as a double


% --- Executes during object creation, after setting all properties.
function MutationScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MutationScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in rosenbrock.
function rosenbrock_Callback(hObject, eventdata, handles)
% hObject    handle to rosenbrock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rosenbrock


