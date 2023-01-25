unit MyMessage.Helpers.TMemo;

interface

uses
 Vcl.StdCtrls,
 Vcl.Dialogs,
 Vcl.Clipbrd,
 System.SysUtils,
 System.UITypes,
 Winapi.Messages,
 Winapi.Windows;

type
 TMemoHelper = class helper for TMemo
   procedure TextVerticalCenter(aNumLinhasMostrando: integer; aTxt: string);
   procedure ScrollUpDown(aDirection: Integer);
   function SaveToFile(aPathPadrao: string = ''): String;
   procedure SaveToClipboard;
 end;

implementation

procedure TMemoHelper.SaveToClipboard;
begin
   Clipboard.AsText := Self.Lines.Text;
end;

function TMemoHelper.SaveToFile(aPathPadrao: string = ''): String;
var
 vSaveDialog: TSaveDialog;
begin
   Result := '';
   vSaveDialog := TSaveDialog.Create(nil);
   try
     vSaveDialog.Title      := 'MyMessage - Salvar em arquivo';
     vSaveDialog.DefaulText := '*.txt';
     vSaveDialog.Filter     := 'Arquivos TXT (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*';
     vSaveDialog.FileName   := FormatDateTime('yyyyMMdd-hhnnss', now) + '.txt';

     if(not aPathPadrao.IsEmpty)then
     begin
        vSaveDialog.InitialDir := ExtractFileDir(aPathPadrao);
        vSaveDialog.FileName   := ExtractFileName(aPathPadrao);
     end;

     if(vSaveDialog.Execute)then
     begin
        Self.Lines.SaveToFile(vSaveDialog.FileName);
        Result := vSaveDialog.FileName;
     end;
   finally
      vSaveDialog.Free;
   end;
end;

procedure TMemoHelper.TextVerticalCenter(aNumLinhasMostrando: integer; aTxt: string);
var
 vStr: string;
 i: integer;
 vLinesCount: Integer;
begin
   vStr            := Trim(aTxt);
   Self.Lines.Text := vStr;
   vLinesCount     := Self.Lines.Count;

   Self.ScrollBars := System.UITypes.TScrollStyle.ssVertical;
   if(vLinesCount < aNumLinhasMostrando)then
   begin
      Self.ScrollBars := System.UITypes.TScrollStyle.ssNone;
      Self.Lines.Clear;
      for i := 1 to  Trunc((aNumLinhasMostrando - vLinesCount) / 2) do
        Self.Lines.Add(' ');

      Self.Lines.Add(vStr);
   end;

   Self.ScrollUpDown(SB_LINEUP);
end;

procedure TMemoHelper.ScrollUpDown(aDirection: Integer);
var
 vScrollMessage: TWMVScroll;
 I: Integer;
begin
   vScrollMessage.Msg := WM_VSCROLL;
   Self.Lines.BeginUpdate;
   try
     for I := 0 to Self.Lines.Count do
     begin
        vScrollMessage.ScrollCode := aDirection;
        vScrollMessage.Pos        := 0;
        Self.Dispatch(vScrollMessage);
     end;
   finally
     Self.Lines.EndUpdate;
   end;
end;

end.
