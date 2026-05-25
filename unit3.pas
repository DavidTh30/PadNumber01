unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, windows, Messages;

type
  Ext = class(TObject)
  public
    class procedure DoPrint(const A: array of string); static;
    class function StrIntToStr(Sender: string): string;
    class function StrFloatToStr(Sender: string): string;
    class function StrFloatToStr3(Sender: string): string;
    class function SendStringViaHWND(TargetHandle: HWND; const MsgString: string): Boolean;
  end;

var
  N_K_String: string;
  N_K_Int: integer;
  N_K_Float:extended;
  Min_:extended;
  Max_:extended;
  C_K:string;

implementation

class function Ext.SendStringViaHWND(TargetHandle: HWND; const MsgString: string): Boolean;
var
  CopyData: TCopyDataStruct;
begin
  Result := False;

  if TargetHandle = 0 then Exit;

  // Prepare the structure
  CopyData.dwData := 0; // Identifier (can be used to specify message type)
  CopyData.cbData := (Length(MsgString) + 1) * SizeOf(Char); // String length in bytes
  CopyData.lpData := PChar(MsgString);                       // Pointer to the string

  // Send the message synchronously
  // Note: Use SendMessageTimeout to prevent your app from freezing if the target app hangs
  if SendMessage(TargetHandle, WM_COPYDATA, 0, LPARAM(@CopyData)) <> 0 then
    Result := True;
end;

class procedure Ext.DoPrint(const A: array of string);
var
  Item: string;
begin
  for Item in A do
    Write(Item, ',');
  Writeln;
end;

generic procedure printTArr<T>(sarr: T);   //specialize printTArr<integer>([1,2,3]);
  var item: T; // BUT WHAT TO PUT HERE INSTEAD OF STRING?
  begin
    for item in sarr do write(item, ',');
    writeln;
  end;

class function Ext.StrIntToStr(Sender: string): string;
var
  i:integer;
begin
  i:=0;
  Try
    i:=StrToInt(Sender);
  except
    On E : EConvertError do
      i:=0;
  end;
  result:= IntToStr(i);
end;

class function Ext.StrFloatToStr(Sender: string): string;     // 2 digits after point
var
  i:double;
begin
  i:=0;
  Try
    i:=StrToFloat(Sender);
  except
    On E : EConvertError do
      i:=0.00;
  end;
  result:= FormatFloat('0.00', i);  //FloatToStr(i)
end;

class function Ext.StrFloatToStr3(Sender: string): string;  //3 digits after point
var
  i:double;
begin
  i:=0;
  Try
    i:=StrToFloat(Sender);
  except
    On E : EConvertError do
      i:=0.000;
  end;
  result:= FormatFloat('0.000', i);  //FloatToStr(i)
end;

end.

