unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  PairSplitter, Unit3, Windows, Messages, sendkeys;

//Function fpSendKeys(SendKeysString : PChar; Wait : Boolean) : Boolean;
//function AppActivate(WindowName : PChar) : boolean;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    BackSpace_: TButton;
    Button11: TButton;
    Button12: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Plus_Butt: TButton;
    Apply_Butt: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Splitter10: TSplitter;
    Splitter11: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Splitter8: TSplitter;
    Splitter9: TSplitter;
    procedure BackSpace_Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Plus_ButtClick(Sender: TObject);
    procedure Apply_ButtClick(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private

  public
    //Function fpSendKeys(SendKeysString : PChar; Wait : Boolean) : Boolean;
    //function EnumWindowsProc(WHandle: HWND; lParam: LPARAM): BOOL; export; stdcall;
    //function AppActivate(WindowName : PChar) : boolean;
    procedure NumberToText_Caculator(Target: Tedit; N_:integer);
  end;

//const
//  WorkBufLen = 40;
//
var
  Form3: TForm3;
//  WorkBuf : array[0..WorkBufLen] of Char;

implementation

//type
//  THKeys = array[0..pred(MaxLongInt)] of byte;
//var
//  AllocationSize : integer;
//  WindowHandle : HWND;

{$R *.lfm}

{ TForm3 }

procedure TForm3.NumberToText_Caculator(Target: Tedit; N_:integer);
var
  TemStr:string;
  Tem_Float:extended;
  Sel_S:integer;

  SS:integer;
  SL:integer;
  CursorAtFront:boolean;
begin

  Sel_S:=Length(Edit1.Text);
  TemStr:=Edit1.Caption;
  SS:=Edit1.SelStart;
  SL:=Edit1.SelLength;
  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;
  CursorAtFront:=false;

  //showmessage(Edit1.SelStart.ToString + '/' + Edit1.SelLength.ToString+'/'+Length(Edit1.Text).ToString);
  //{$I %LINE%}
  memo1.Clear;
  memo1.Append('SelStart='+Edit1.SelStart.ToString);
  memo1.Append('SelLength='+Edit1.SelLength.ToString);
  memo1.Append('Length='+Length(Edit1.Text).ToString);
  if Edit1.Focused then memo1.Append('Forgus=true');
  if not Edit1.Focused then memo1.Append('Forgus=false');

  //Case no highlight text
  if Edit1.SelLength = 0 then
  begin
    memo1.Append({$I %LINE%}+' Case no highlight text Edit1.SelLength='+Edit1.SelLength.ToString);

    if ((Pos('-', TemStr) >0) and (SS=0)) then
    begin
      memo1.Append({$I %LINE%}+' Case cursor front of negative');
      exit;
    end;

    //Case no cursor position
    if ((SS = 0) and (Length(Edit1.Text)>0)) then
    begin
      memo1.Append({$I %LINE%}+' Case no cursor position');
      Sel_S:=0;
      CursorAtFront:=true;
    end;
    //Case found cursor some where
    if ((SS > 0) and (Length(Edit1.Text)>0)) then
    begin
      memo1.Append({$I %LINE%}+' Case found cursor some where');
      Sel_S:=Edit1.SelStart+1;
    end;
  end;

  //Case highlight text
  if Edit1.SelLength > 0 then
  begin
    memo1.Append({$I %LINE%}+' Case highlight text Edit1.SelLength='+Edit1.SelLength.ToString);
    Sel_S:=Edit1.SelStart+1;
    TemStr:=Edit1.Caption;
    Delete(TemStr, Edit1.SelStart+1, Edit1.SelLength);
    Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));
    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      memo1.Append({$I %LINE%}+' Case lower minimum  Tem_Float='+Tem_Float.ToString);
      label3.Font.Color:=clRed;
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      memo1.Append({$I %LINE%}+' Case over maximum  Tem_Float='+Tem_Float.ToString);
      label1.Font.Color:=clRed;
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Edit1.Caption:=TemStr;
  end;

  //Case no text
  if (length(edit1.Caption)=0)then begin memo1.Append({$I %LINE%}+' Case no text');  Sel_S:=1; end;

  //AppActivate('Notepad');
  //fpSendKeys('abcdefg',false);

  //Case found '.'
  if (Pos('.', TemStr) > 0) then
  begin
    memo1.Append({$I %LINE%}+' Case found . TemStr='+TemStr);
    //Case have 2 digits after '.'
    if (length(TemStr)-(Pos('.', TemStr))>=2) then
    begin
      memo1.Append({$I %LINE%}+' Case have 2 digits after . TemStr='+TemStr);

      //Case cursor position at end position
      if (Sel_S>Length(TemStr)) then
      begin
        memo1.Append({$I %LINE%}+' Case cursor position at end position Sel_S='+Sel_S.ToString);
        memo1.Append({$I %LINE%}+' Case cursor position at end position Length(TemStr)='+Length(TemStr).ToString);
        Edit1.SetFocus;
        Edit1.SelStart:=Sel_S;
        exit;
      end;
      //Case cursor position after '.'
      if (Sel_S>Pos('.', TemStr)) then
      begin
        memo1.Append({$I %LINE%}+' Case cursor position after . Sel_S='+Sel_S.ToString);
        memo1.Append({$I %LINE%}+' Case cursor position after . Pos(., TemStr)='+Pos('.', TemStr).ToString);
        Delete(TemStr, Length(TemStr), 1);
      end;
    end;
  end;

  //Insert Number
  memo1.Append({$I %LINE%}+' Insert 2 Sel_S='+Sel_S.ToString);
  Insert(N_.ToString, TemStr, Sel_S);
  memo1.Append({$I %LINE%}+' Insert 2 TemStr='+TemStr);
  //TemStr:=edit1.Caption+'2';

  //Convert string to float
  Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));
  memo1.Append({$I %LINE%}+' Convert string to float Tem_Float='+Tem_Float.ToString);

  //if (Tem_Float=0) then exit;

  //Case lower minimum
  if (Tem_Float<unit3.Min_) then
  begin
    label3.Font.Color:=clRed;
    memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
    exit;
  end;
  //Case over maximum
  if (Tem_Float>unit3.Max_) then
  begin
    label1.Font.Color:=clRed;
    memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
    exit;
  end;

  //Case zero at front
  if ((Pos('0', TemStr) =1) and (Pos('.', TemStr)<>2))  then
  begin
    Delete(TemStr, 1, 1);
    memo1.Append({$I %LINE%}+' Case zero at front TemStr='+TemStr);
  end;
  //Case negative and zero at front
  if ((Pos('-', TemStr) =1) and (Pos('0', TemStr) =2) and (Pos('.', TemStr)<>3))  then
  begin
    Delete(TemStr, 2, 1);
    memo1.Append({$I %LINE%}+' Case negative and zero at front TemStr='+TemStr);
  end;

  memo1.Append({$I %LINE%}+' End Sel_S='+Sel_S.ToString);
  edit1.Caption:=TemStr;
  Edit1.SetFocus;
  if not CursorAtFront then Edit1.SelStart:=Sel_S;
  if CursorAtFront then Edit1.SelStart:=Sel_S+1;
end;

//function TForm3.EnumWindowsProc(WHandle: HWND; lParam: LPARAM): BOOL; export; stdcall;
//type
//  TWindowName = array[0..max_path] of char;
//var
//  WindowName : TWindowName;
//begin
//  WindowName :=default(TWindowName);
//  {Can't test GetWindowText's return value since some windows don't have a
//  title}
//  GetWindowText(WHandle,WindowName,MAX_PATH);
//  Result := (StrLIComp(WindowName,PChar(lParam), StrLen(PChar(lParam))) <> 0);
//  If (not Result) then
//    WindowHandle:=WHandle;
//end;
//
//function TForm3.AppActivate(WindowName : PChar) : boolean;
//begin
//  try
//    Result:=true;
//    WindowHandle:=FindWindow(nil,WindowName);
//    If (WindowHandle=0) then
//      EnumWindows(@EnumWindowsProc,PtrInt(PChar(WindowName)));
//    If (WindowHandle<>0) then
//    begin
//      SendMessage(WindowHandle, WM_SYSCOMMAND, SC_HOTKEY, WindowHandle);
//      SendMessage(WindowHandle, WM_SYSCOMMAND, SC_RESTORE, WindowHandle);
//      SetForegroundWindow(WindowHandle);
//    end
//    else
//      Result:=false;
//  except
//    on Exception do Result:=false;
//  end;
//end;
//
//Function TForm3.fpSendKeys(SendKeysString : PChar; Wait : Boolean) : Boolean;
//type
//  WBytes = array[0..pred(SizeOf(Word))] of Byte;
//
//  TSendKey = record
//    Name : ShortString;
//    VKey : Byte;
//  end;
//
//const
//  {Array of keys that SendKeys recognizes.
//  If you add to this list, you must be sure to keep it sorted alphabetically
//  by Name because a binary search routine is used to scan it.}
//
//  MaxSendKeyRecs = 41;
//  SendKeyRecs : array[1..MaxSendKeyRecs] of TSendKey =
//  (
//   (Name:'BACKSPACE';       VKey:VK_BACK),
//   (Name:'BKSP';            VKey:VK_BACK),
//   (Name:'BREAK';           VKey:VK_CANCEL),
//   (Name:'BS';              VKey:VK_BACK),
//   (Name:'CAPSLOCK';        VKey:VK_CAPITAL),
//   (Name:'CLEAR';           VKey:VK_CLEAR),
//   (Name:'DEL';             VKey:VK_DELETE),
//   (Name:'DELETE';          VKey:VK_DELETE),
//   (Name:'DOWN';            VKey:VK_DOWN),
//   (Name:'END';             VKey:VK_END),
//   (Name:'ENTER';           VKey:VK_RETURN),
//   (Name:'ESC';             VKey:VK_ESCAPE),
//   (Name:'ESCAPE';          VKey:VK_ESCAPE),
//   (Name:'F1';              VKey:VK_F1),
//   (Name:'F10';             VKey:VK_F10),
//   (Name:'F11';             VKey:VK_F11),
//   (Name:'F12';             VKey:VK_F12),
//   (Name:'F13';             VKey:VK_F13),
//   (Name:'F14';             VKey:VK_F14),
//   (Name:'F15';             VKey:VK_F15),
//   (Name:'F16';             VKey:VK_F16),
//   (Name:'F2';              VKey:VK_F2),
//   (Name:'F3';              VKey:VK_F3),
//   (Name:'F4';              VKey:VK_F4),
//   (Name:'F5';              VKey:VK_F5),
//   (Name:'F6';              VKey:VK_F6),
//   (Name:'F7';              VKey:VK_F7),
//   (Name:'F8';              VKey:VK_F8),
//   (Name:'F9';              VKey:VK_F9),
//   (Name:'HELP';            VKey:VK_HELP),
//   (Name:'HOME';            VKey:VK_HOME),
//   (Name:'INS';             VKey:VK_INSERT),
//   (Name:'LEFT';            VKey:VK_LEFT),
//   (Name:'NUMLOCK';         VKey:VK_NUMLOCK),
//   (Name:'PGDN';            VKey:VK_NEXT),
//   (Name:'PGUP';            VKey:VK_PRIOR),
//   (Name:'PRTSC';           VKey:VK_PRINT),
//   (Name:'RIGHT';           VKey:VK_RIGHT),
//   (Name:'SCROLLLOCK';      VKey:VK_SCROLL),
//   (Name:'TAB';             VKey:VK_TAB),
//   (Name:'UP';              VKey:VK_UP)
//  );
//
//  {Extra VK constants missing from Delphi's Windows API interface}
//  VK_NULL=0;
//  VK_SemiColon=186;
//  VK_Equal=187;
//  VK_Comma=188;
//  VK_Minus=189;
//  VK_Period=190;
//  VK_Slash=191;
//  VK_BackQuote=192;
//  VK_LeftBracket=219;
//  VK_BackSlash=220;
//  VK_RightBracket=221;
//  VK_Quote=222;
//  VK_Last=VK_Quote;
//
//  ExtendedVKeys : set of byte =
//  [VK_Up,
//   VK_Down,
//   VK_Left,
//   VK_Right,
//   VK_Home,
//   VK_End,
//   VK_Prior,  {PgUp}
//   VK_Next,   {PgDn}
//   VK_Insert,
//   VK_Delete];
//
//const
//  INVALIDKEY = $FFFF {Unsigned -1};
//  VKKEYSCANSHIFTON = $01;
//  VKKEYSCANCTRLON = $02;
//  VKKEYSCANALTON = $04;
//  UNITNAME_ = 'SendKeys';
//var
//  UsingParens, ShiftDown, ControlDown, AltDown, FoundClose : Boolean;
//  PosSpace : Byte;
//  I, L : Integer;
//  NumTimes, MKey : Word;
//  KeyString : String[20];
//
//procedure DisplayMessage(Message : PChar);
//begin
//  MessageBox(0,Message,UNITNAME_,0);
//end;
//
//function BitSet(BitTable, BitMask : Byte) : Boolean;
//begin
//  Result:=ByteBool(BitTable and BitMask);
//end;
//
//procedure SetBit(var BitTable : Byte; BitMask : Byte);
//begin
//  BitTable:=BitTable or Bitmask;
//end;
//
//Procedure KeyboardEvent(VKey, ScanCode : Byte; Flags : Longint);
//var
//  KeyboardMsg : TMsg;
//begin
//  keybd_event(VKey, ScanCode, Flags,0);
//  If (Wait) then
//    While (PeekMessage(KeyboardMsg,0,WM_KEYFIRST, WM_KEYLAST, PM_REMOVE)) do
//    begin
//      TranslateMessage(KeyboardMsg);
//      DispatchMessage(KeyboardMsg);
//    end;
//end;
//
//Procedure SendKeyDown(VKey: Byte; NumTimes : Word; GenUpMsg : Boolean);
//var
//  Cnt : Word;
//  ScanCode : Byte;
//  NumState : Boolean;
//  KeyBoardState : TKeyboardState;
//begin
//  if (VKey=VK_NUMLOCK) then
//  begin
//    NumState:=ByteBool(GetKeyState(VK_NUMLOCK) and 1);
//    GetKeyBoardState(KeyBoardState);
//    If NumState then
//      KeyBoardState[VK_NUMLOCK]:=(KeyBoardState[VK_NUMLOCK] and not 1)
//    else
//      KeyBoardState[VK_NUMLOCK]:=(KeyBoardState[VK_NUMLOCK] or 1);
//    SetKeyBoardState(KeyBoardState);
//    Exit;
//  end;
//
//  ScanCode:=Lo(Byte(MapVirtualKey(VKey,0)));
//  For Cnt:=1 to NumTimes do
//    If (VKey in ExtendedVKeys) then
//    begin
//      KeyboardEvent(VKey, ScanCode, KEYEVENTF_EXTENDEDKEY);
//      If (GenUpMsg) then
//        KeyboardEvent(VKey, ScanCode, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP)
//    end
//    else
//    begin
//      KeyboardEvent(VKey, ScanCode, 0);
//      If (GenUpMsg) then KeyboardEvent(VKey, ScanCode, KEYEVENTF_KEYUP);
//    end;
//end;
//
//Procedure SendKeyUp(VKey: Byte);
//var
//  ScanCode : Byte;
//begin
//  ScanCode:=Lo(Byte(MapVirtualKey(VKey,0)));
//  If (VKey in ExtendedVKeys)then
//    KeyboardEvent(VKey, ScanCode, KEYEVENTF_EXTENDEDKEY and KEYEVENTF_KEYUP)
//  else
//    KeyboardEvent(VKey, ScanCode, KEYEVENTF_KEYUP);
//end;
//
//Procedure SendKey(MKey: Word; NumTimes : Word; GenDownMsg : Boolean);
//begin
//  If (BitSet(Hi(MKey),VKKEYSCANSHIFTON)) then
//    SendKeyDown(VK_SHIFT,1,False);
//  If (BitSet(Hi(MKey),VKKEYSCANCTRLON)) then
//    SendKeyDown(VK_CONTROL,1,False);
//  If (BitSet(Hi(MKey),VKKEYSCANALTON)) then
//    SendKeyDown(VK_MENU,1,False);
//  SendKeyDown(Lo(MKey), NumTimes, GenDownMsg);
//  If (BitSet(Hi(MKey),VKKEYSCANSHIFTON)) then
//    SendKeyUp(VK_SHIFT);
//  If (BitSet(Hi(MKey),VKKEYSCANCTRLON)) then
//    SendKeyUp(VK_CONTROL);
//  If (BitSet(Hi(MKey),VKKEYSCANALTON)) then
//    SendKeyUp(VK_MENU);
//end;
//
//{Implements a simple binary search to locate special key name strings}
//
//Function StringToVKey(KeyString : ShortString) : Word;
//var
//  Found, Collided : Boolean;
//  Bottom, Top, Middle : Byte;
//begin
//  Result:=INVALIDKEY;
//  Bottom:=1;
//  Top:=MaxSendKeyRecs;
//  Found:=false;
//  Middle:=(Bottom+Top) div 2;
//  Repeat
//    Collided:=((Bottom=Middle) or (Top=Middle));
//    If (KeyString=SendKeyRecs[Middle].Name) then
//    begin
//       Found:=True;
//       Result:=SendKeyRecs[Middle].VKey;
//    end
//    else
//    begin
//       If (KeyString>SendKeyRecs[Middle].Name) then
//        Bottom:=Middle
//       else
//        Top:=Middle;
//       Middle:=(Succ(Bottom+Top)) div 2;
//    end;
//  Until (Found or Collided);
//  If (Result=INVALIDKEY) then
//    DisplayMessage('Invalid Key Name');
//end;
//
//procedure PopUpShiftKeys;
//begin
//  If (not UsingParens) then
//  begin
//    If ShiftDown then SendKeyUp(VK_SHIFT);
//    If ControlDown then SendKeyUp(VK_CONTROL);
//    If AltDown then SendKeyUp(VK_MENU);
//    ShiftDown:=false;
//    ControlDown:=false;
//    AltDown:=false;
//  end;
//end;
//
//begin
//  AllocationSize:=MaxInt;
//  Result:=false;
//  UsingParens:=false;
//  ShiftDown:=false;
//  ControlDown:=false;
//  AltDown:=false;
//  I:=0;
//  L:=StrLen(SendKeysString);
//  If (L>AllocationSize) then L:=AllocationSize;
//  If (L=0) then Exit;
//
//  While (I<L) do
//  begin
//    case SendKeysString[I] of
//    '(' : begin
//            UsingParens:=True;
//            Inc(I);
//          end;
//    ')' : begin
//            UsingParens:=False;
//            PopUpShiftKeys;
//            Inc(I);
//          end;
//    '%' : begin
//             AltDown:=True;
//             SendKeyDown(VK_MENU,1,False);
//             Inc(I);
//          end;
//    '+' :  begin
//             ShiftDown:=True;
//             SendKeyDown(VK_SHIFT,1,False);
//             Inc(I);
//           end;
//    '^' :  begin
//             ControlDown:=True;
//             SendKeyDown(VK_CONTROL,1,False);
//             Inc(I);
//           end;
//    '{' : begin
//            NumTimes:=1;
//            If (SendKeysString[Succ(I)]='{') then
//            begin
//              MKey:=VK_LEFTBRACKET;
//              SetBit(Wbytes(MKey)[1],VKKEYSCANSHIFTON);
//              SendKey(MKey,1,True);
//              PopUpShiftKeys;
//              Inc(I,3);
//              Continue;
//            end;
//            KeyString:='';
//            FoundClose:=False;
//            While (I<=L) do
//            begin
//              Inc(I);
//              If (SendKeysString[I]='}') then
//              begin
//                FoundClose:=True;
//                Inc(I);
//                Break;
//              end;
//              KeyString:=KeyString+Upcase(SendKeysString[I]);
//            end;
//            If (Not FoundClose) then
//            begin
//              DisplayMessage('No Close');
//              Exit;
//            end;
//            If (SendKeysString[I]='}') then
//            begin
//              MKey:=VK_RIGHTBRACKET;
//              SetBit(Wbytes(MKey)[1],VKKEYSCANSHIFTON);
//              SendKey(MKey,1,True);
//              PopUpShiftKeys;
//              Inc(I);
//              Continue;
//            end;
//            PosSpace:=Pos(' ',KeyString);
//            If (PosSpace<>0) then
//            begin
//              NumTimes := StrToInt(
//                Copy(KeyString,Succ(PosSpace),Length(KeyString)-PosSpace)
//              );
//              KeyString:=Copy(KeyString,1,Pred(PosSpace));
//            end;
//            If (Length(KeyString)=1) then
//              MKey:=vkKeyScan(KeyString[1])
//            else
//              MKey:=StringToVKey(KeyString);
//            If (MKey<>INVALIDKEY) then
//            begin
//              SendKey(MKey,NumTimes,True);
//              PopUpShiftKeys;
//              Continue;
//            end;
//          end;
//    '~' : begin
//            SendKeyDown(VK_RETURN,1,True);
//            PopUpShiftKeys;
//            Inc(I);
//          end;
//    else
//      begin
//        MKey:=vkKeyScan(SendKeysString[I]);
//        if (MKey<>INVALIDKEY) then
//        begin
//          SendKey(MKey,1,True);
//          PopUpShiftKeys;
//        end
//        else
//          DisplayMessage('Invalid KeyName');
//        Inc(I);
//      end;
//    end;
//  end;
//  Result:=true;
//  PopUpShiftKeys;
//end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Label1.Caption:='Max: ' + Ext.StrFloatToStr(unit3.Max_.ToString);
  Label2.Caption:='Org: '+Ext.StrFloatToStr(N_K_String);
  Label3.Caption:='Min: '+ Ext.StrFloatToStr(unit3.Min_.ToString);
  edit1.Caption:=Ext.StrFloatToStr(N_K_String);
  Apply_Butt.Caption:='Apply'+#13#10+' And '+#13#10+' Exit';
end;

procedure TForm3.FormShow(Sender: TObject);
var
  TemFload:extended;
begin
  if (unit3.Min_>unit3.Max_) then
  begin
    TemFload:=unit3.Min_;
    unit3.Min_:=unit3.Max_;
    unit3.Max_:=TemFload;
  end;
  edit1.SetFocus;
  edit1.SelectAll;
end;

procedure TForm3.Label1Click(Sender: TObject);
begin
  //edit1.SetFocus;
  //edit1.SelStart:=0;
  //edit1.SelLength:=Length(edit1.Text);
  //edit1.SelectAll;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,1);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,2);
end;

procedure TForm3.Button3Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,3);
end;

procedure TForm3.Button4Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,4);
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,5);
end;

procedure TForm3.Button6Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,6);
end;

procedure TForm3.Button7Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,7);
end;

procedure TForm3.Button8Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,8);
end;

procedure TForm3.Button9Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,9);
end;

procedure TForm3.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //showmessage(Key.ToString);
  if Key = 8 then
  begin
    BackSpace_Click(Sender);
  end;
  if Key = 27 then self.Close;
  if Key = 13 then
  begin
    Apply_ButtClick(Sender);
  end;
  exit
end;

procedure TForm3.Button16Click(Sender: TObject);
var
  TemStr:string;
  Tem_Float:extended;
  Sel_S:integer;

  SS:integer;
  SL:integer;
begin

  Sel_S:=Length(Edit1.Text);
  TemStr:=Edit1.Caption;
  SS:=Edit1.SelStart;
  SL:=Edit1.SelLength;
  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;

  Memo1.Clear;
  TemStr:=Edit1.Caption;

  if Edit1.SelLength > 0 then
  begin
    memo1.Append({$I %LINE%}+' Case HeighLight SelLength='+Edit1.SelLength.ToString);

    Delete(TemStr, Edit1.SelStart+1, Edit1.SelLength);
    Insert('.', TemStr, SS+1);
    Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      label1.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;

    if (Length(TemStr)>3) then
    begin
      if((Length(TemStr)-Pos('.', TemStr))>2) then
      begin
        memo1.Append({$I %LINE%}+' Case over 2 digit after point');
        TemStr:=LeftStr(TemStr,Pos('.', TemStr)+2);
      end;
    end;

    if (Pos('.', TemStr) = 1) then
    begin
      memo1.Append({$I %LINE%}+' Case . at front');
      Insert('0', TemStr, 0);
      Edit1.Text:=TemStr;
      SS:=2;
      edit1.SetFocus;
      edit1.SelStart:=SS;
      exit;
    end;

    Edit1.Text:=TemStr;
    edit1.SetFocus;
    edit1.SelStart:=SS+1;
    exit;
  end;

  if (Pos('.', TemStr) > 0) then
  begin
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
    exit;
  end;

  memo1.Append({$I %LINE%}+' Insert .');
  Insert('.', TemStr, SS+1);
  SS:=SS+1;
  Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      label1.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;

    if (Length(TemStr)>3) then
    begin
      if((Length(TemStr)-Pos('.', TemStr))>2) then
      begin
        memo1.Append({$I %LINE%}+' Case over 2 digit after point');
        TemStr:=LeftStr(TemStr,Pos('.', TemStr)+2);
      end;
    end;

    if (Pos('.', TemStr) = 1) then
    begin
      memo1.Append({$I %LINE%}+' Case . at front');
      Insert('0', TemStr, 0);
      Edit1.Text:=TemStr;
      SS:=2;
      edit1.SetFocus;
      edit1.SelStart:=SS;
      exit;
    end;

    Edit1.Text:=TemStr;
    edit1.SetFocus;
    edit1.SelStart:=SS+1;
end;

procedure TForm3.Button17Click(Sender: TObject);
begin

  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;

  edit1.Caption:='';
  edit1.SetFocus;
  Edit1.SelStart:=Length(Edit1.Caption);

end;

procedure TForm3.BackSpace_Click(Sender: TObject);
var
  TemStr:string;
  Tem_Float:extended;
  Sel_S:integer;

  SS:integer;
  SL:integer;
begin

  Sel_S:=Length(Edit1.Text);
  TemStr:=Edit1.Caption;
  SS:=Edit1.SelStart;
  SL:=Edit1.SelLength;
  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;

  memo1.Clear;
  memo1.Append('SelStart='+Edit1.SelStart.ToString);
  memo1.Append('SelLength='+Edit1.SelLength.ToString);
  memo1.Append('Length='+Length(Edit1.Text).ToString);
  if Edit1.Focused then memo1.Append('Forgus=true');
  if not Edit1.Focused then memo1.Append('Forgus=false');

  if Edit1.SelLength > 0 then
  begin
    memo1.Append({$I %LINE%}+' Case HeighLight SelLength='+Edit1.SelLength.ToString);

    Delete(TemStr, Edit1.SelStart+1, Edit1.SelLength);
    Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      label1.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;


    Edit1.Caption:=TemStr;
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    exit
  end;

  if (Edit1.SelStart=0) then
  begin
    memo1.Append({$I %LINE%}+' Case nothing to backspace SelStart='+Edit1.SelStart.ToString);
    exit;
  end;

  Delete(TemStr, Edit1.SelStart, 1);
  Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

  Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      label1.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;

  Edit1.Caption:=TemStr;
  Edit1.SetFocus;
  Edit1.SelStart:=SS-1;

  //if (Length(edit1.Caption) >= 1) then edit1.Caption:=LeftStr(edit1.Caption,Length(edit1.Caption)-1);

end;

procedure TForm3.Button11Click(Sender: TObject);
begin
  self.Close;
end;

procedure TForm3.Button12Click(Sender: TObject);
var
  TemStr:string;
  Tem_Float:extended;
  Sel_S:integer;

  SS:integer;
  SL:integer;
begin

  Sel_S:=Length(Edit1.Text);
  TemStr:=Edit1.Caption;
  SS:=Edit1.SelStart;
  SL:=Edit1.SelLength;
  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;

  memo1.Clear;
  memo1.Append('SelStart='+Edit1.SelStart.ToString);
  memo1.Append('SelLength='+Edit1.SelLength.ToString);
  memo1.Append('Length='+Length(Edit1.Text).ToString);
  if Edit1.Focused then memo1.Append('Forgus=true');
  if not Edit1.Focused then memo1.Append('Forgus=false');

  if (Pos('-', TemStr) > 0) then
  begin
    memo1.Append({$I %LINE%}+' Case already in negative');
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
    exit;
  end;

  memo1.Append({$I %LINE%}+' Case add negative');
  TemStr:='-'+TemStr;

  Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      label1.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;

  Edit1.Text:=TemStr;
  Edit1.SetFocus;
  Edit1.SelStart:=SS+1;
  Edit1.SelLength:=SL;
end;

procedure TForm3.Plus_ButtClick(Sender: TObject);
var
  TemStr:string;
  Tem_Float:extended;
  Sel_S:integer;

  SS:integer;
  SL:integer;
begin

  Sel_S:=Length(Edit1.Text);
  TemStr:=Edit1.Caption;
  SS:=Edit1.SelStart;
  SL:=Edit1.SelLength;
  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;

  memo1.Clear;
  memo1.Append('SelStart='+Edit1.SelStart.ToString);
  memo1.Append('SelLength='+Edit1.SelLength.ToString);
  memo1.Append('Length='+Length(Edit1.Text).ToString);
  if Edit1.Focused then memo1.Append('Forgus=true');
  if not Edit1.Focused then memo1.Append('Forgus=false');

  //showmessage(Pos('-', edit1.Caption).ToString);
  if (Pos('-', TemStr) > 0) then
  begin
    memo1.Append({$I %LINE%}+' Remove negative');
    TemStr:=RightStr(TemStr,length(TemStr)-1);
    SS:=SS-1;
  end;

  Tem_Float:=StrToFloat(Ext.StrFloatToStr(TemStr));

    //Case lower minimum
    if (Tem_Float<unit3.Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>unit3.Max_) then
    begin
      label1.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;

    Edit1.Text:=TemStr;
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
end;

procedure TForm3.Apply_ButtClick(Sender: TObject);
begin
  N_K_String:=edit1.Caption;
  N_K_String:=Ext.StrFloatToStr(N_K_String);
  N_K_Int:=StrToInt(Ext.StrIntToStr(N_K_String));
  N_K_Float:=StrToFloat(Ext.StrFloatToStr(N_K_String));

  //if (N_K_Float<unit3.Min_) then
  //begin
  //  N_K_Float:=unit3.Min_;
  //  N_K_String:=Ext.StrFloatToStr(N_K_Float.ToString);
  //  N_K_Int:=StrToInt(Ext.StrIntToStr(N_K_String));
  //  N_K_Float:=StrToFloat(Ext.StrFloatToStr(N_K_String));
  //end;
  //if (N_K_Float>unit3.Max_) then
  //begin
  //  N_K_Float:=unit3.Max_;
  //  N_K_String:=Ext.StrFloatToStr(N_K_Float.ToString);
  //  N_K_Int:=StrToInt(Ext.StrIntToStr(N_K_String));
  //  N_K_Float:=StrToFloat(Ext.StrFloatToStr(N_K_String));
  //end;
  self.Close;
end;

procedure TForm3.Button15Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,0);

end;

end.

