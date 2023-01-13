program MyMsgDemo;

uses
  Vcl.Forms,
  Demo.View.Main in 'src\Demo.View.Main.pas' {Form1},
  MyMessage in '..\src\MyMessage.pas',
  MyMessage.Types in '..\src\MyMessage.Types.pas',
  MyMsg.View in '..\src\MyMsg.View.pas' {MyMsgView},
  MyMessage.Interfaces in '..\src\MyMessage.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TMyMsgView, MyMsgView);
  Application.Run;
end.
