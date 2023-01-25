unit Demo.View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls;

type
  TViewMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
  public
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  MyMessage;

procedure TViewMain.Button1Click(Sender: TObject);
begin
   ShowInformation('Informa��o');
end;

procedure TViewMain.Button2Click(Sender: TObject);
begin
   ShowAlert('Alert');
end;

procedure TViewMain.Button3Click(Sender: TObject);
begin
   ShowError('Erro');
end;

procedure TViewMain.Button4Click(Sender: TObject);
begin
   if(ShowQuestionYes('Question?'))then
     ShowInformation('Sim')
   else
     ShowInformation('Nao');
end;

procedure TViewMain.Button5Click(Sender: TObject);
begin
   ShowRequiredField('Edit1 Required');
end;

procedure TViewMain.Button6Click(Sender: TObject);
begin
   case(ShowOption('Selecione uma das seguintes op��es',
                  'TESTANDO MENSAGEM COMPLETA',
                  'Op��o 01',
                  'Op��o 02',
                  'Op��o 03 teste de tamanho muito grande'))
   of
    1: ShowInformation('Op��o 01');
    2: ShowInformation('Op��o 02');
    3: ShowInformation('Op��o 03');
   else
     raise Exception.Create('Nenhuma op��o selecionada');
   end;
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := True;
end;

end.
