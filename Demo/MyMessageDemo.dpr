program MyMessageDemo;

uses
  Vcl.Forms,
  Demo.View.Main in 'src\Demo.View.Main.pas' {ViewMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
