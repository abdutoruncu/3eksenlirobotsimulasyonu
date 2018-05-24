function varargout = robotik(varargin)
% ROBOTIK MATLAB code for robotik.fig
%      ROBOTIK, by itself, creates a new ROBOTIK or raises the existing
%      singleton*.
%
%      H = ROBOTIK returns the handle to a new ROBOTIK or the handle to
%      the existing singleton*.
%
%      ROBOTIK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROBOTIK.M with the given input arguments.
%
%      ROBOTIK('Property','Value',...) creates a new ROBOTIK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before robotik_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to robotik_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help robotik

% Last Modified by GUIDE v2.5 19-May-2018 22:47:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @robotik_OpeningFcn, ...
                   'gui_OutputFcn',  @robotik_OutputFcn, ...
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


% --- Executes just before robotik is made visible.
function robotik_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to robotik (see VARARGIN)

% Choose default command line output for robotik
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes robotik wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = robotik_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Aci_1_Callback(hObject, eventdata, handles)
% hObject    handle to Aci_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Aci_1 as text
%        str2double(get(hObject,'String')) returns contents of Aci_1 as a double


% --- Executes during object creation, after setting all properties.
function Aci_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Aci_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Acii_1 = str2double(handles.Aci_1.String)*pi/180;
Acii_2 = str2double(handles.Aci_2.String)*pi/180;
Acii_3 = str2double(handles.Aci_3.String)*pi/180;
L_1 = 20;
L_2 = 50;
L_3 = 40;

L (1) = Link([0 L_1 0 pi/2]);
L (2) = Link([0 0 L_2 0]);
L (3) = Link([0 0 L_3 0]);

Robot = SerialLink(L);
Robot.name = 'ROBOTIK';
Robot.plot([Acii_1 Acii_2 Acii_3]);

T = Robot.fkine([Acii_1 Acii_2 Acii_3]);
handles.Kor_1.String = num2str(floor(T(1,4)));
handles.Kor_2.String = num2str(floor(T(2,4)));
handles.Kor_3.String = num2str(floor(T(3,4)));




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
KorX = str2double(handles.Kor_1.String);
KorY = str2double(handles.Kor_2.String);
KorZ = str2double(handles.Kor_3.String);

L_1 = 20;
L_2 = 50;
L_3 = 40;

L (1) = Link([0 L_1 0 pi/2]);
L (2) = Link([0 0 L_2 0]);
L (3) = Link([0 0 L_3 0]);

Robot = SerialLink(L);
Robot.name = 'ROBOTIK';

T = [ 1 0 0 KorX ;
      0 1 0 KorY ; 
      0 0 1 KorZ ; 
      0 0 0 1];

J = Robot.ikine(T,[0 0 0],[1 1 1 0 0 0])*180/pi;
handles.Aci_1.String = num2str(floor(J(1)));
handles.Aci_2.String = num2str(floor(J(2)));
handles.Aci_3.String = num2str(floor(J(3)));

Robot.plot(J*pi/180);


function Aci_2_Callback(hObject, eventdata, handles)
% hObject    handle to Aci_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Aci_2 as text
%        str2double(get(hObject,'String')) returns contents of Aci_2 as a double


% --- Executes during object creation, after setting all properties.
function Aci_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Aci_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Aci_3_Callback(hObject, eventdata, handles)
% hObject    handle to Aci_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Aci_3 as text
%        str2double(get(hObject,'String')) returns contents of Aci_3 as a double


% --- Executes during object creation, after setting all properties.
function Aci_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Aci_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kor_1_Callback(hObject, eventdata, handles)
% hObject    handle to Kor_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kor_1 as text
%        str2double(get(hObject,'String')) returns contents of Kor_1 as a double


% --- Executes during object creation, after setting all properties.
function Kor_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kor_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kor_2_Callback(hObject, eventdata, handles)
% hObject    handle to Kor_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kor_2 as text
%        str2double(get(hObject,'String')) returns contents of Kor_2 as a double


% --- Executes during object creation, after setting all properties.
function Kor_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kor_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kor_3_Callback(hObject, eventdata, handles)
% hObject    handle to Kor_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kor_3 as text
%        str2double(get(hObject,'String')) returns contents of Kor_3 as a double


% --- Executes during object creation, after setting all properties.
function Kor_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kor_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
