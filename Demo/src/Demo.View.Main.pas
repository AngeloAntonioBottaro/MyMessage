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
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
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
   ShowInformation('Informação');
end;

procedure TViewMain.Button2Click(Sender: TObject);
begin
   ShowWarning('Warning');
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

procedure TViewMain.Button9Click(Sender: TObject);
begin
   if(ShowQuestionNo('Question?'))then
     ShowInformation('Sim')
   else
     ShowInformation('Nao');
end;

procedure TViewMain.Button5Click(Sender: TObject);
begin
   ShowRequiredField('Edit1 Required');
   ShowRequiredField;
end;

procedure TViewMain.Button6Click(Sender: TObject);
begin
   case(ShowOption3('Selecione uma das seguintes opções(Foco2)',
                  'TESTANDO MENSAGEM COMPLETA',
                  'Opção 01',
                  'Opção 02',
                  'Opção 03 teste de tamanho muito grande'))
   of
    1: ShowInformation('Opção 01');
    2: ShowInformation('Opção 02');
    3: ShowInformation('Opção 03');
   else
     raise Exception.Create('Nenhuma opção selecionada');
   end;
end;

procedure TViewMain.Button7Click(Sender: TObject);
begin
   ShowInformation(Edit1.Text, 'Msg completa: ' + Edit1.Text, Edit1);
end;

procedure TViewMain.Button8Click(Sender: TObject);
begin
   ShowPrinter('Printer');
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := True;
end;

end.
