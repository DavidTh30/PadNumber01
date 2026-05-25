unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Unit2, Unit3, Unit4, Unit5, windows, Messages;

type
  { TForm1 }

  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    IdleTimer1: TIdleTimer;
    Label1: TLabel;
    procedure Edit1Click(Sender: TObject);
    procedure Edit2Click(Sender: TObject);
    procedure Edit3Click(Sender: TObject);
    procedure Edit4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Loop_:  boolean;
  HeapStat: THeapStatus;
  MemStatus: TFPCHeapStatus;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.Edit1Click(Sender: TObject);
begin

  unit3.Min_:=-10.10;
  unit3.Max_:=1000.01;

  //showmessage('['+unit3.N_K_String+']');
  Form3 := TForm3.Create(Nil);
  //if Form3.ShowModal = mrNone then
  //begin

  //end;

  try
    Form3.Width:=round(Form3.Width*1.5);
    Form3.Height:=round(Form3.Height*1.5);
    Form3.ShowModal; // Use Show() if you want it to be non-modal
  finally
    Form3.Free;
  end;
  //showmessage(unit3.N_K_String);
  //showmessage(unit3.N_K_Int.ToString);
  //showmessage(unit3.N_K_Float.ToString);
  Edit1.Text:=unit3.N_K_String;
end;

procedure TForm1.Edit2Click(Sender: TObject);
var
  Form0: TForm2;
begin

  if Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    try
      //FreeAndNil(Form0);
      //Form0.Free;
      Form0:=nil;
    finally
    end;
  end;

  if not Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    Form0 := TForm2.Create(Nil);
    //Application.CreateForm(TForm2, Form0);
  end;

  if Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    Form0.Width:=round(Form0.Width*1.5);
    Form0.Height:=round(Form0.Height*1.5);
    Form0.myHwnd:=edit2.Handle;
    Form0.AWindowHandle:=self.Handle;
    Form0.Show;
    Form0.Self_Min_:=-15.10;
    Form0.Self_Max_:=1050.01;
    Form0.Self_N_K_String:=edit2.Text;
    Form0.Self_N_K_String:=Ext.StrFloatToStr(Form0.Self_N_K_String);
    Form0.Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Form0.Self_N_K_String));
    Form0.Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr(Form0.Self_N_K_String));
    Form0.Update_();
  end;
end;

procedure TForm1.Edit3Click(Sender: TObject);
var
  Form0: TForm2;
begin

  if Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    try
      //FreeAndNil(Form0);
      //Form0.Free;
      Form0:=nil;
    finally
    end;
  end;

  if not Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    Form0 := TForm2.Create(Nil);
    //Application.CreateForm(TForm2, Form0);
  end;

  if Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    Form0.Width:=round(Form0.Width*1.5);
    Form0.Height:=round(Form0.Height*1.5);
    Form0.myHwnd:=edit3.Handle;
    Form0.AWindowHandle:=self.Handle;
    Form0.Show;
    Form0.Self_Min_:=-10.10;
    Form0.Self_Max_:=1000.01;
    Form0.Self_N_K_String:=edit3.Text;
    Form0.Self_N_K_String:=Ext.StrFloatToStr(Form0.Self_N_K_String);
    Form0.Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Form0.Self_N_K_String));
    Form0.Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr(Form0.Self_N_K_String));
    Form0.Update_();
  end;
end;

procedure TForm1.Edit4Click(Sender: TObject);
var
  Form0: TForm4;
begin

  if Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    try
      //FreeAndNil(Form0);
      //Form0.Free;
      Form0:=nil;
    finally
    end;
  end;

  if not Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    Form0 := TForm4.Create(Nil);
    //Application.CreateForm(TForm4, Form0);
  end;

  if Assigned(Form0) then
  begin
    //showmessage({$I %LINE%});
    Form0.Width:=round(Form0.Width*1);
    Form0.Height:=round(Form0.Height*1);
    Form0.myHwnd:=edit4.Handle;
    Form0.AWindowHandle:=self.Handle;
    Form0.Show;
    Form0.Self_Min_:=-10.10;
    Form0.Self_Max_:=1000.01;
    Form0.Self_N_K_String:=edit4.Text;
    Form0.Self_N_K_String:=Ext.StrFloatToStr(Form0.Self_N_K_String);
    Form0.Self_N_K_Int:=StrToInt(Ext.StrIntToStr(Form0.Self_N_K_String));
    Form0.Self_N_K_Float:=StrToFloat(Ext.StrFloatToStr(Form0.Self_N_K_String));
    Form0.Update_();
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Loop_:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Loop_:=True;
  Label1.Caption:= 'Total Allocated Memory: '+ sLineBreak + 'Total Free Memory: ';
  Label1.Caption:= Label1.Caption + #13#10 + 'Total Decommitted Heap Size: ';
  Label1.Caption:= Label1.Caption + #13#10 + 'Currently Used Heap Memory: ';
  Label1.Caption:= Label1.Caption + LineEnding + 'Currently Free Heap Memory: ';
end;

procedure TForm1.IdleTimer1Timer(Sender: TObject);
begin
  IdleTimer1.AutoEnabled:=False;
  IdleTimer1.Enabled:=False;
  //sLineBreak
  //#13#10
  //LineEnding
  while Loop_=True do
  begin
    Application.ProcessMessages;
    HeapStat := GetHeapStatus;
    Label1.Caption:= 'Total Allocated Memory: '+ HeapStat.TotalAllocated.ToString + ' bytes' + sLineBreak + 'Total Free Memory: ' + HeapStat.TotalFree.ToString +  ' bytes';

    MemStatus := GetFPCHeapStatus;
    Label1.Caption:= Label1.Caption + #13#10 + 'Total Decommitted Heap Size: ' + MemStatus.CurrHeapSize.ToString +' bytes';
    Label1.Caption:= Label1.Caption + #13#10 + 'Currently Used Heap Memory: ' + MemStatus.CurrHeapUsed.ToString + ' bytes';
    Label1.Caption:= Label1.Caption + LineEnding + 'Currently Free Heap Memory: ' + MemStatus.CurrHeapFree.ToString + ' bytes';
    //Edit2.Text:=Unit3.Self_N_K_String;
    Application.ProcessMessages;
  end;

end;

end.

