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
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  MyMessage;

procedure TViewMain.Button1Click(Sender: TObject);
begin
   showInformacao('Informação');
end;

procedure TViewMain.Button2Click(Sender: TObject);
begin
   showAlert('Alert');
end;

procedure TViewMain.Button3Click(Sender: TObject);
begin
   showErro('Erro');
end;

procedure TViewMain.Button4Click(Sender: TObject);
begin
   if(showPerguntaS('Question?'))then
     showInformacao('Sim')
   else
     showInformacao('Nao');
end;

procedure TViewMain.Button5Click(Sender: TObject);
begin
   showCampoObrigatorio('Edit1 Required');
end;

procedure TViewMain.Button6Click(Sender: TObject);
begin
   case(showOpcao('Selecione uma das seguintes opções',
                  'TESTANDO MENSAGEM COMPLETA',
                  'Opção 01',
                  'Opção 02',
                  'Opção 03 teste de tamanho muito grande'))
   of
    1: showInformacao('Opção 01');
    2: showInformacao('Opção 02');
    3: showInformacao('Opção 03');
   else
     raise Exception.Create('Nenhuma opção selecionada');
   end;
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := True;
end;

end.
