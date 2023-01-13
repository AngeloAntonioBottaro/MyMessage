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
  MyMessage,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
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
    Button10: TButton;
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
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button10Click(Sender: TObject);
begin
   MyMsg
    .Mensagem('Except obrigatorio')
    .Componente(Edit1)
    .ExceptCampoObrigatorio;

   Edit1.Text := 'TESTE ABORT';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   MyMsg.Mensagem('Informação').MsgInformacao;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   MyMsg.Mensagem('Warning').MsgAlert;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
   MyMsg.Mensagem('Erro').MsgErro;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
   if(MyMsg.Mensagem('Question?').MsgPergunta)then
     MyMsg.Mensagem('Sim').MsgInformacao
   else
     MyMsg.Mensagem('Nao').MsgInformacao;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
   MyMsg
    .Mensagem('Edit1 Required')
    .Componente(Edit1)
    .MsgCampoObrigatorio;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
   case(MyMsg
         .Mensagem('Selecione uma das seguintes opções')
         .MensagemCompleta('TESTANDO MENSAGEM COMPLETA')
         .MensagemOpcao1('Opção 01')
         .MensagemOpcao2('Opção 02')
         .MensagemOpcao3('Opção 03 teste de tamanho muito grande')
         .MsgOpcao)
   of
    1: MyMsg.Mensagem('Opção 01').MsgInformacao;
    2: MyMsg.Mensagem('Opção 02').MsgInformacao;
    3: MyMsg.Mensagem('Opção 03').MsgInformacao;
   else
     raise Exception.Create('Nenhuma opção selecionada');
   end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
   MyMsg
    .Mensagem('Except info')
    .Componente(Edit1)
    .ExceptInformacao;

   Edit1.Text := 'TESTE ABORT';
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
   MyMsg
    .Mensagem('Except warning')
    .Componente(Edit1)
    .ExceptAlert;

   Edit1.Text := 'TESTE ABORT';
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
   MyMsg
    .Mensagem('Except error')
    .Componente(Edit1)
    .ExceptErro;

   Edit1.Text := 'TESTE ABORT';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := True;
end;

end.
