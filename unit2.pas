unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Unit3, windows, Messages;

type

  { TForm2 }

  TForm2 = class(TForm)
    ApplyAndExit_Butt: TButton;
    Apply_Butt: TButton;
    Button1: TButton;
    BackSpace_: TButton;
    ESC_Butt: TButton;
    Button12: TButton;
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
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Plus_Butt: TButton;
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
    procedure Apply_ButtClick(Sender: TObject);
    procedure ApplyAndExit_ButtClick(Sender: TObject);
    procedure BackSpace_Click(Sender: TObject);
    procedure ESC_ButtClick(Sender: TObject);
    procedure Button12Click(Sender: TObject);
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
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Plus_ButtClick(Sender: TObject);
  private

  public
    myHwnd: HWND;
    AWindowHandle: HWND;
    Self_N_K_String: string;
    Self_N_K_Int: integer;
    Self_N_K_Float:extended;
    Self_Min_:extended;
    Self_Max_:extended;

    procedure Update_();
    procedure NumberToText_Caculator(Target: Tedit; N_:integer);
  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }
procedure TForm2.NumberToText_Caculator(Target: Tedit; N_:integer);
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
    if (Tem_Float<Self_Min_) then
    begin
      memo1.Append({$I %LINE%}+' Case lower minimum  Tem_Float='+Tem_Float.ToString);
      label3.Font.Color:=clRed;
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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
  if (Tem_Float<Self_Min_) then
  begin
    label3.Font.Color:=clRed;
    memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
    exit;
  end;
  //Case over maximum
  if (Tem_Float>Self_Max_) then
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

procedure TForm2.Update_();
var
  TemFload:extended;
begin
  Label1.Caption:='Max: ' + Ext.StrFloatToStr(Self_Max_.ToString);
  Label2.Caption:='Org: '+Ext.StrFloatToStr(Self_N_K_String);
  Label3.Caption:='Min: '+ Ext.StrFloatToStr(Self_Min_.ToString);
  edit1.Caption:=Ext.StrFloatToStr(Self_N_K_String);
  if (Self_Min_>Self_Max_) then
  begin
    TemFload:=Self_Min_;
    Self_Min_:=Self_Max_;
    Self_Max_:=TemFload;
  end;
  edit1.SetFocus;
  edit1.SelectAll;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Label1.Caption:='Max: ' + Ext.StrFloatToStr(Self_Max_.ToString);
  Label2.Caption:='Org: '+Ext.StrFloatToStr(Self_N_K_String);
  Label3.Caption:='Min: '+ Ext.StrFloatToStr(Self_Min_.ToString);
  edit1.Caption:=Ext.StrFloatToStr(Self_N_K_String);
  ApplyAndExit_Butt.Caption:='Apply'+#13#10+' And '+#13#10+' Exit';
end;

procedure TForm2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //CloseAction := caFree;

end;

procedure TForm2.Apply_ButtClick(Sender: TObject);
var
  dd:boolean;
begin
  //Self_N_K_String:='5678';
  //showmessage(myHwnd.ToString);

  Self_N_K_String:=edit1.Caption;
  Self_N_K_String:=Ext.StrFloatToStr(Self_N_K_String);
  Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Self_N_K_String));
  Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr(Self_N_K_String));

  if myHwnd <> 0 then
  SendMessage(myHwnd, WM_SETTEXT, 0, LPARAM(PChar(Self_N_K_String)));
end;

procedure TForm2.ApplyAndExit_ButtClick(Sender: TObject);
begin
  //Self_N_K_String:='8765';

  Self_N_K_String:=edit1.Caption;
  Self_N_K_String:=Ext.StrFloatToStr(Self_N_K_String);
  Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Self_N_K_String));
  Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr(Self_N_K_String));

  if myHwnd <> 0 then
  SendMessage(myHwnd, WM_SETTEXT, 0, LPARAM(PChar(Self_N_K_String)));
  Self.Close;

  if IsWindow(AWindowHandle) then
  begin
    // Restores the window if it was minimized
    ShowWindow(AWindowHandle, SW_RESTORE);

    // Brings the window to the front and gives it focus
    SetForegroundWindow(AWindowHandle);
  end;

end;

procedure TForm2.BackSpace_Click(Sender: TObject);
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
    if (Tem_Float<Self_Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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
    if (Tem_Float<Self_Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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

procedure TForm2.ESC_ButtClick(Sender: TObject);
begin
  self.Close;
  if IsWindow(AWindowHandle) then
  begin
    // Restores the window if it was minimized
    ShowWindow(AWindowHandle, SW_RESTORE);

    // Brings the window to the front and gives it focus
    SetForegroundWindow(AWindowHandle);
  end;
end;

procedure TForm2.Button12Click(Sender: TObject);
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
    if (Tem_Float<Self_Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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

procedure TForm2.Button15Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,0);
end;

procedure TForm2.Button16Click(Sender: TObject);
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
    if (Tem_Float<Self_Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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
    if (Tem_Float<Self_Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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

procedure TForm2.Button17Click(Sender: TObject);
begin
  label1.Font.Color:=clBlack;
  label3.Font.Color:=clBlack;

  edit1.Caption:='';
  edit1.SetFocus;
  Edit1.SelStart:=Length(Edit1.Caption);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,1);
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,2);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,3);
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,4);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,5);
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,6);
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,7);
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,8);
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,9);
end;

procedure TForm2.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    //showmessage(Key.ToString);
  if Key = 8 then
  begin
    BackSpace_Click(Sender);
  end;
  if Key = 27 then ESC_ButtClick(Sender);
  if Key = 13 then
  begin
    ApplyAndExit_ButtClick(Sender);
  end;
  exit
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Self);
end;

procedure TForm2.FormShow(Sender: TObject);
var
  TemFload:extended;
begin
  if (Self_Min_>Self_Max_) then
  begin
    TemFload:=Self_Min_;
    Self_Min_:=Self_Max_;
    Self_Max_:=TemFload;
  end;
  edit1.SetFocus;
  edit1.SelectAll;
end;

procedure TForm2.Plus_ButtClick(Sender: TObject);
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
    if (Tem_Float<Self_Min_) then
    begin
      label3.Font.Color:=clRed;
      memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
      Edit1.SetFocus;
      Edit1.SelStart:=SS;
      Edit1.SelLength:=SL;
      exit;
    end;
    //Case over maximum
    if (Tem_Float>Self_Max_) then
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

end.

