unit MyMessage;

interface

uses
  Vcl.Forms,
  Vcl.Controls,
  System.SysUtils,
  MyMessage.Types,
  MyMessage.View,
  MyMessage.Interfaces;

type
{$REGION 'TMyMessage'}
  TMyMessage = class(TInterfacedObject, IMyMessage)
  private
    FTitle: string;
    FMensagem: string;
    FMensagemCompleta: string;
    FMsgOpcao1: string;
    FMsgOpcao2: string;
    FMsgOpcao3: string;
    FFoco: TFoco;
    FMsgtype: TMsgType;
    FComponent: TWinControl;
    FModalResult: Integer;

    function ShowMensagem: Boolean;
  protected
    function Title(aValue: string): IMyMessage; overload;
    function Title: string; overload;
    function Mensagem(aValue: string): IMyMessage; overload;
    function Mensagem: string; overload;
    function MensagemCompleta(aValue: string): IMyMessage; overload;
    function MensagemCompleta: string; overload;
    function FocoSim: IMyMessage;
    function FocoNao: IMyMessage;
    function Componente(aValue: TWinControl): IMyMessage;

    function MensagemOpcao1(aValue: string): IMyMessage; overload;
    function MensagemOpcao1: string; overload;
    function MensagemOpcao2(aValue: string): IMyMessage; overload;
    function MensagemOpcao2: string; overload;
    function MensagemOpcao3(aValue: string): IMyMessage; overload;
    function MensagemOpcao3: string; overload;

    function MsgInformacao: Boolean;
    function MsgAlert: Boolean;
    function MsgErro: Boolean;
    function MsgCampoObrigatorio: Boolean;
    function MsgPergunta: Boolean;
    function MsgOpcao: Integer;
  public
    class function New: IMyMessage;
    constructor Create;
    destructor Destroy; override;
  end;
{$ENDREGION 'TMyMessage'}

function showInformacao(AMsg: string): Boolean;
function showAlert(AMsg: string): Boolean;
function showErro(AMsg: string): Boolean;
function showCampoObrigatorio(AMsg: string): Boolean;
function showPerguntaS(AMsg: string): Boolean;
function showPerguntaN(AMsg: string): Boolean;

implementation

{$REGION 'TMyMessage'}
class function TMyMessage.New: IMyMessage;
begin
   Result := Self.Create;
end;

constructor TMyMessage.Create;
begin
   FTitle            := EmptyStr;
   FMensagem         := EmptyStr;
   FMensagemCompleta := EmptyStr;
   FMsgOpcao1        := EmptyStr;
   FMsgOpcao2        := EmptyStr;
   FMsgOpcao3        := EmptyStr;

   FFoco    := TFoco.FocoNenhum;
   FMsgtype := TMsgType.MsgInformacao;

   FComponent := nil;

   FModalResult := 0;
end;

destructor TMyMessage.Destroy;
begin
   if(Assigned(MyMessageView))then
     FreeAndNil(MyMessageView);

   inherited;
end;

function TMyMessage.Title(aValue: string): IMyMessage;
begin
   Result := Self;
   FTitle := Trim(aValue);
end;

function TMyMessage.Title: string;
begin
   if(FTitle = EmptyStr)then
      Title('Mensagem do sistema');

   Result := FTitle;
end;

function TMyMessage.Mensagem(aValue: string): IMyMessage;
begin
   Result    := Self;
   FMensagem := Trim(aValue);
end;

function TMyMessage.Mensagem: string;
begin
   Result := FMensagem;
end;

function TMyMessage.MensagemCompleta(aValue: string): IMyMessage;
begin
   Result            := Self;
   FMensagemCompleta := Trim(aValue);
end;

function TMyMessage.MensagemCompleta: string;
begin
   if(FMensagemCompleta = EmptyStr)then
      MensagemCompleta(Mensagem);

   Result := FMensagemCompleta;
end;

function TMyMessage.MensagemOpcao1(aValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao1 := Trim(aValue);
end;

function TMyMessage.MensagemOpcao1: string;
begin
   Result := FMsgOpcao1;
end;

function TMyMessage.MensagemOpcao2(aValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao2 := Trim(aValue);
end;

function TMyMessage.MensagemOpcao2: string;
begin
   Result := FMsgOpcao2;
end;

function TMyMessage.MensagemOpcao3(aValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao3 := Trim(aValue);
end;

function TMyMessage.MensagemOpcao3: string;
begin
   Result := FMsgOpcao3;
end;

function TMyMessage.FocoSim: IMyMessage;
begin
   Result := Self;
   FFoco  := TFoco.FocoBotaoSim;
end;

function TMyMessage.FocoNao: IMyMessage;
begin
   Result := Self;
   FFoco  := TFoco.FocoBotaoNao;
end;

function TMyMessage.Componente(aValue: TWinControl): IMyMessage;
begin
   Result     := Self;
   FComponent := aValue;
end;

function TMyMessage.MsgInformacao: Boolean;
begin
   FMsgtype := TMsgType.MsgInformacao;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.MsgAlert: Boolean;
begin
   FMsgtype := TMsgType.MsgAlerta;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.MsgErro: Boolean;
begin
   FMsgtype := TMsgType.MsgErro;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.MsgPergunta: Boolean;
begin
   FMsgtype := TMsgType.MsgPergunta;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.MsgCampoObrigatorio: Boolean;
begin
   FMsgtype := TMsgType.MsgCampoObrigatorio;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.MsgOpcao: Integer;
begin
   FMsgtype := TMsgType.MsgOpcao;
   Self.ShowMensagem;
   Result := FModalResult;
end;

function TMyMessage.ShowMensagem: Boolean;
begin
  if(MyMessageView = nil)then Application.CreateForm(TMyMessageView, MyMessageView);
  try
    //TITULO
    MyMessageView.Caption := Title;

    //MENSAGEM
    MyMessageView.lbMensagem.Caption := Mensagem;
    MyMessageView.FMensagemCompleta  := MensagemCompleta;

    //IMAGEM
    MyMessageView.imgIcon.Picture := nil;
    MyMessageView.ImageListIcon.GetBitmap(Integer(FMsgtype), MyMessageView.imgIcon.Picture.Bitmap);

    //BOTOES
    MyMessageView.ButtonOpcao1.Visible := (FMsgtype = TMsgType.MsgOpcao)and(MensagemOpcao1 <> EmptyStr);
    MyMessageView.ButtonOpcao1.Caption := MensagemOpcao1;
    MyMessageView.ButtonOpcao2.Visible := (FMsgtype = TMsgType.MsgOpcao)and(MensagemOpcao2 <> EmptyStr);
    MyMessageView.ButtonOpcao2.Caption := MensagemOpcao2;
    MyMessageView.ButtonOpcao3.Visible := (FMsgtype = TMsgType.MsgOpcao)and(MensagemOpcao3 <> EmptyStr);
    MyMessageView.ButtonOpcao3.Caption := MensagemOpcao3;

    MyMessageView.ButtonSim.Visible := FMsgtype = TMsgType.MsgPergunta;
    MyMessageView.ButtonNao.Visible := FMsgtype = TMsgType.MsgPergunta;

    MyMessageView.ButtonOk.Visible := not ((FMsgtype = TMsgType.MsgPergunta)or(FMsgtype = TMsgType.MsgOpcao));

    case(FFoco)of
     TFoco.FocoBotaoSim: try MyMessageView.ButtonSim.SetFocus except on E: Exception do end;
     TFoco.FocoBotaoNao: try MyMessageView.ButtonNao.SetFocus; except on E: Exception do end;
    else
     try MyMessageView.ButtonOk.SetFocus; except on E: Exception do end;
    end;

    MyMessageView.ShowModal;

    FModalResult := MyMessageView.ModalResult;
    Result := ((MyMessageView.ModalResult = mrOk)or(MyMessageView.ModalResult = mrYes));

    if(Assigned(FComponent))then
    begin
       if(FComponent.Visible)and(FComponent.Enabled)then
         FComponent.SetFocus;
    end;
  finally
    FreeAndNil(MyMessageView);
  end;
end;
{$ENDREGION 'TMyMessage'}

function showInformacao(AMsg: string): Boolean;
begin
   Result := TMyMessage.New.Mensagem(AMsg).MsgInformacao;
end;

function showAlert(AMsg: string): Boolean;
begin
   Result := TMyMessage.New.Mensagem(AMsg).MsgAlert;
end;

function showErro(AMsg: string): Boolean;
begin
   Result := TMyMessage.New.Mensagem(AMsg).MsgErro;
end;

function showCampoObrigatorio(AMsg: string): Boolean;
begin
   Result := TMyMessage.New.Mensagem(AMsg).MsgCampoObrigatorio;
end;

function showPerguntaS(AMsg: string): Boolean;
begin
   Result := TMyMessage.New.Mensagem(AMsg).FocoSim.MsgPergunta;
end;

function showPerguntaN(AMsg: string): Boolean;
begin
   Result := TMyMessage.New.Mensagem(AMsg).FocoNao.MsgPergunta;
end;

end.
