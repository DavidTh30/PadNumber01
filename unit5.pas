unit Unit5;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Unit3, windows, Messages;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Apply_Butt: TButton;
    ApplyAndExit_Butt: TButton;
    ESC_Butt: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Splitter3: TSplitter;
    Splitter14: TSplitter;
    Splitter15: TSplitter;
    Splitter4: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Splitter7: TSplitter;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
    Splitter12: TSplitter;
    Splitter11: TSplitter;
    Splitter10: TSplitter;
    Splitter9: TSplitter;
    Splitter8: TSplitter;
    Splitter13: TSplitter;
    procedure Apply_ButtClick(Sender: TObject);
    procedure ApplyAndExit_ButtClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ESC_ButtClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
    procedure NumberToText_Caculator(Target: Tedit; N_:Extended);
  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }
procedure TForm4.NumberToText_Caculator(Target: Tedit; N_:Extended);
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
  Tem_Float:= StrToFloat(Ext.StrFloatToStr3(TemStr));
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

  //Insert Number
  Tem_Float:= Tem_Float+N_;
  TemStr:=Ext.StrFloatToStr3(Tem_Float.ToString);
  memo1.Append({$I %LINE%}+' Insert 1 TemStr='+TemStr);

  //Case lower minimum
  if (Tem_Float<Self_Min_) then
  begin
    Tem_Float:= Self_Min_;
    TemStr:=Ext.StrFloatToStr3(Tem_Float.ToString);
    label3.Font.Color:=clRed;
    memo1.Append({$I %LINE%}+' Case lower minimum Tem_Float='+Tem_Float.ToString);
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
  end;
  //Case over maximum
  if (Tem_Float>Self_Max_) then
  begin
    Tem_Float:= Self_Max_;
    TemStr:=Ext.StrFloatToStr3(Tem_Float.ToString);
    label1.Font.Color:=clRed;
    memo1.Append({$I %LINE%}+' Case over maximum Tem_Float='+Tem_Float.ToString);
    Edit1.SetFocus;
    Edit1.SelStart:=SS;
    Edit1.SelLength:=SL;
  end;

  memo1.Append({$I %LINE%}+' End Sel_S='+Sel_S.ToString);
  edit1.Caption:=TemStr;
  Edit1.SetFocus;
  if not CursorAtFront then Edit1.SelStart:=Sel_S;
  if CursorAtFront then Edit1.SelStart:=Sel_S+1;
end;

procedure TForm4.Update_();
var
  TemFload:extended;
begin
  Label1.Caption:='Max: ' + Ext.StrFloatToStr3(Self_Max_.ToString);
  Label2.Caption:='Org: '+Ext.StrFloatToStr3(Self_N_K_String);
  Label3.Caption:='Min: '+ Ext.StrFloatToStr3(Self_Min_.ToString);
  edit1.Caption:=Ext.StrFloatToStr3(Self_N_K_String);
  if (Self_Min_>Self_Max_) then
  begin
    TemFload:=Self_Min_;
    Self_Min_:=Self_Max_;
    Self_Max_:=TemFload;
  end;
  edit1.SetFocus;
  edit1.SelectAll;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  Label1.Caption:='Max: ' + Ext.StrFloatToStr3(Self_Max_.ToString);
  Label2.Caption:='Org: '+Ext.StrFloatToStr3(Self_N_K_String);
  Label3.Caption:='Min: '+ Ext.StrFloatToStr3(Self_Min_.ToString);
  edit1.Caption:=Ext.StrFloatToStr3(Self_N_K_String);
  //ApplyAndExit_Butt.Caption:='Apply'+#13#10+' And '+#13#10+' Exit';
end;

procedure TForm4.FormDestroy(Sender: TObject);
begin
  FreeAndNil(self);
end;

procedure TForm4.ESC_ButtClick(Sender: TObject);
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

procedure TForm4.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
    //showmessage(Key.ToString);
  if Key = 8 then
  begin
    //BackSpace_Click(Sender);
  end;
  if Key = 27 then ESC_ButtClick(Sender);
  if Key = 13 then
  begin
    ApplyAndExit_ButtClick(Sender);
  end;
  exit
end;

procedure TForm4.ApplyAndExit_ButtClick(Sender: TObject);
begin
  //Self_N_K_String:='8765';

  Self_N_K_String:=edit1.Caption;
  Self_N_K_String:=Ext.StrFloatToStr3(Self_N_K_String);
  Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Self_N_K_String));
  Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr3(Self_N_K_String));

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

procedure TForm4.Button10Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,10.0);
end;

procedure TForm4.Button11Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,1.0);
end;

procedure TForm4.Button12Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,0.1);
end;

procedure TForm4.Button13Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,0.01);
end;

procedure TForm4.Button14Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,0.001);
end;

procedure TForm4.Button15Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-10000.0);
end;

procedure TForm4.Button16Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-1000.0);
end;

procedure TForm4.Button17Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-100.0);
end;

procedure TForm4.Button18Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-10.0);
end;

procedure TForm4.Button19Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-1.0);
end;

procedure TForm4.Button20Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-0.1);
end;

procedure TForm4.Button21Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-0.01);
end;

procedure TForm4.Button22Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,-0.001);
end;

procedure TForm4.Button7Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,10000.0);
end;

procedure TForm4.Button8Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,1000.0);
end;

procedure TForm4.Button9Click(Sender: TObject);
begin
  NumberToText_Caculator(Edit1,100.0);
end;

procedure TForm4.Apply_ButtClick(Sender: TObject);
var
  dd:boolean;
begin
  //Self_N_K_String:='5678';
  //showmessage(myHwnd.ToString);

  Self_N_K_String:=edit1.Caption;
  Self_N_K_String:=Ext.StrFloatToStr3(Self_N_K_String);
  Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Self_N_K_String));
  Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr3(Self_N_K_String));

  if myHwnd <> 0 then
  SendMessage(myHwnd, WM_SETTEXT, 0, LPARAM(PChar(Self_N_K_String)));
end;

end.

