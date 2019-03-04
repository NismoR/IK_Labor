function sup2sim

% Import an automaton from a Supremica XML file and create a Stateflow
% chart from it

[FileName,PathName]=uigetfile('*.xml','Select a Supremica XML file');
if FileName~=0
    system=importSupremicaXml([PathName,FileName]);
    if isempty(system)
        errordlg('Error reading Supremica XML file!');
    else
        if iscell(system)
            system=system{1};
        end
        selection=questdlg(['Automaton ',system.name,' has been imported. Click OK to create a Stateflow chart. Attention! All open Simulink windows will be closed!'],'Create Stateflow chart','OK','Cancel','OK');
        if strcmp(selection,'OK')
            createChart(system.name,system);
        end
    end
end
    
function automata=importSupremicaXml(filename)

%
% automata=import_supremica_xml(filename)
%
% Imports systems saved in the xml format used by Supremica to the file
% specified by filename and returns a cell array of the automata.


xml_file=fopen(filename,'r');
if (xml_file==-1)
    error('Error reading file!');
end;
s='';
while (feof(xml_file)~=1)
    s=strcat(s,(fgetl(xml_file)));
end;

try
%extracting each automaton

token='(<Automaton\s*(.*?)</Automaton>)';
[automaton,tok]=regexpi(s,token,'match','tokens');


% parsing automata
for i=1:length(automaton)

    token='<automaton(.*?)>.*';
    [tag,properties]=regexpi(automaton{i},token,'match','tokens');
    properties=char(properties{:});
    token='.*name="(.*?)".*';
    [tag,automaton_label]=regexpi(properties,token,'match','tokens');
    automata{i}.name=char(automaton_label{:});
    % parsing states
    token='<states>\s*(.*?)</states>';
    [tags,statelist]=regexpi(automaton{i},token,'match','tokens');
    statelist=strcat(statelist{:});
    token='<state\s*(.*?)/>';
    [tags,propstrings]=regexpi(statelist{:},token,'match','tokens');
    states=[];
    for j=1:length(propstrings)
        [tag,id]=(regexpi(propstrings{j}{:},'.*id="(.*?)".*','match','tokens'));
        id=int16(str2num(char(id{:})))+1; % Az ID-hez egyet adunk, mert alapbol 0-rol indul!
        [tag,name]=(regexpi(propstrings{j}{:},'.*name="(.*?)".*','match','tokens'));
        automata{i}.state{id}.name=char(name{:});
        [tag,initial]=regexpi(propstrings{j}{:},'.*initial="(.*?)".*','match','tokens');
        
        if (~isempty(initial))&(strcmp(initial{:},'true')==1)
            automata{i}.initial_state=id;
        end;
        % MARKING etc.
    end;

    % parsing events
    token='<events>\s*(.*?)</events>';
    [tags,eventlist]=regexpi(automaton{i},token,'match','tokens');
    eventlist=strcat(eventlist{:});
    token='<event\s*(.*?)/>';
    [tags,propstrings]=regexpi(eventlist{:},token,'match','tokens');
    for j=1:length(propstrings)
        [tag,id]=(regexpi(propstrings{j}{:},'.*id="(.*?)".*','match','tokens'));
        id=int16(str2num(char(id{:})))+1; % Az ID-hez egyet adunk, mert alapbol 0-rol indul!
        [tag,label]=(regexpi(propstrings{j}{:},'.*label="(.*?)".*','match','tokens'));
        automata{i}.event{id}.label=char(label{:});
        [tag,ctrl]=(regexpi(propstrings{j}{:},'.*controllable="(.*?)".*','match','tokens'));
        if (length(ctrl)==0)|(strcmp(ctrl{:},'true')==1)
            automata{i}.event{id}.ctrl=1;
        else
            automata{i}.event{id}.ctrl=0;
        end;
        
        % Observability etc.
    end;

    % parsing transitions
	
    token='<transitions>\s*(.*?)</transitions>';
    [tags,tranlist]=regexpi(automaton{i},token,'match','tokens');
    tranlist=strcat(tranlist{:});
    token='<transition\s*(.*?)/>';
    [tags,propstrings]=regexpi(tranlist{:},token,'match','tokens');
    for j=1:length(propstrings)
        [tag,from]=(regexpi(propstrings{j}{:},'.*source="(.*?)".*','match','tokens'));
        automata{i}.tran{j}.from=int16(str2num(char(from{:})))+1;
        [tag,to]=(regexpi(propstrings{j}{:},'.*dest="(.*?)".*','match','tokens'));
        automata{i}.tran{j}.to=int16(str2num(char(to{:})))+1;
        [tag,event_label]=(regexpi(propstrings{j}{:},'.*event="(.*?)".*','match','tokens'));
        automata{i}.tran{j}.event_label=int16(str2num(char(event_label{:})))+1;

    end;
    %disp(sprintf('Automaton %s has been imported with success (%d states, %d events, %d transitions)',automata{i}.name,length(automata{i}.state),length(automata{i}.event),length(automata{i}.tran)));
end;

catch
    automata=[];
end


function createChart(modelname,system)

%
% create_chart(modelname,system) 
%
% opens a new Simulink model with the name modelname and adds a Stateflow 
% chart to it according to the DES specified by system.  
%
% ATTENTION! The function will close all active Simulink windows!
%

if iscell(system)
    system=system{1};
end;
%disp('closing all windows...');
bdclose('all');
sfnew(modelname);
model_handler=sfroot;
chart_handler=model_handler.find('-isa','Stateflow.Chart');
chart_handler.Name=system.name;
set(chart_handler,'ExecuteAtInitialization',1);
state=system.state;
event=system.event;
tran=system.tran;
initial_state=system.initial_state;
for i=1:length(state)
    state_handler(i)=Stateflow.State(chart_handler);
    if (length(state{i}.name)>10)
        state_handler(i).Name=strcat('s',num2str(i));
        state_handler(i).Description=state{i}.name;
    else
        state_handler(i).Name=state{i}.name;
    end;
    state_handler(i).Position=[mod((i-1),5)*150+70 100+floor((i-1)/5)*150 80 80];
   
end;
for i=1:length(event)
    
    if event{i}.ctrl
        event_handler(i)=Stateflow.Event(chart_handler);
        event_handler(i).Name=event{i}.label;
        data_def=regexpi(event{i}.label,'(?<data_name>[a-zA-Z0-9]+)(\W|_)+(?<data_specifier>dm*)(?<data_value>([0-9]|.)*)','names');
        if length(data_def)>0
            created_data=model_handler.find('-isa','Stateflow.Data','-and','Name',data_def.data_name);
            if isempty(created_data)
                data_handler=Stateflow.Data(chart_handler);
                data_handler.Name=strcat(data_def.data_name);
                data_handler.Scope='output';
            end;
            if strcmpi(data_def.data_specifier,'dm')==1
                event{i}.activity=strcat(data_def.data_name,'=-',data_def.data_value);
            else
                event{i}.activity=strcat(data_def.data_name,'=',data_def.data_value);
            end;
        else
            
            event_handler(i).Scope='Output';
            event_handler(i).Trigger='Either';
            event{i}.activity='';
        end;

    else
        event_handler(i)=Stateflow.Event(chart_handler);
        event_handler(i).Name=event{i}.label;
        event_handler(i).Scope='input';
        if (length(regexpi(event{i}.label,'.*(?=fall)','match'))>0)
            event_handler(i).Trigger='Falling';
        else
            event_handler(i).Trigger='Rising';
        end;
    end;
end;
countclock=zeros(1,length(state));
for i=1:length(tran)
    tran_handler(i)=Stateflow.Transition(chart_handler);
    tran_handler(i).Source=state_handler(tran{i}.from);
    tran_handler(i).Destination=state_handler(tran{i}.to);
    if (event{tran{i}.event_label}.ctrl)
        tran_handler(i).LabelString=strcat(event{tran{i}.event_label}.label,'/{',event{tran{i}.event_label}.activity,';}');
        state_handler(tran{i}.from).LabelString=sprintf('%s\nentry:%s;', state_handler(tran{i}.from).Name,event{tran{i}.event_label}.label);
    else
        tran_handler(i).LabelString=event{tran{i}.event_label}.label;
    end;
    if abs((tran{i}.to-tran{i}.from)<5)
        if (tran{i}.to==tran{i}.from)
            tran_handler(i).SourceOClock=2;
            tran_handler(i).DestinationOClock=4;
        else
            if ((abs(countclock(tran{i}.from))>abs(countclock(tran{i}.to)))&(countclock(tran{i}.from)>0)) || ((abs(countclock(tran{i}.to))>abs(countclock(tran{i}.from)))&(countclock(tran{i}.to)>0))
                tran_handler(i).SourceOClock=0;
                tran_handler(i).DestinationOClock=0;
                countclock(tran{i}.from)=countclock(tran{i}.from)-1;
                countclock(tran{i}.to)=countclock(tran{i}.to)-1;            
            else
               tran_handler(i).SourceOClock=6;
               tran_handler(i).DestinationOClock=6;
               countclock(tran{i}.from)=countclock(tran{i}.from)+1;
               countclock(tran{i}.to)=countclock(tran{i}.to)+1;                       
            end;
        end;
    else
        if abs((tran{i}.to-tran{i}.from)>5)
            tran_handler(i).SourceOClock=6;
            countclock(tran{i}.from)=countclock(tran{i}.from)+1;
            tran_handler(i).DestinationOClock=0;
            countclock(tran{i}.to)=countclock(tran{i}.to)-1;
        else
            tran_handler(i).SourceOClock=0;
            countclock(tran{i}.from)=countclock(tran{i}.from)-1;
            tran_handler(i).DestinationOClock=6;
            countclock(tran{i}.to)=countclock(tran{i}.to)+1;
        end;
    end;

end;

initial_handler=Stateflow.Transition(chart_handler);
initial_handler.Destination=state_handler(initial_state);
initial_handler.DestinationOClock=9;
initial_handler.SourceEndPoint=[state_handler(initial_state).Position(1)-20,state_handler(initial_state).Position(2)+35];
