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
    function Title(AValue: string): IMyMessage; overload;
    function Title: string; overload;
    function Mensagem(AValue: string): IMyMessage; overload;
    function Mensagem: string; overload;
    function MensagemCompleta(AValue: string): IMyMessage; overload;
    function MensagemCompleta: string; overload;
    function FocoSim: IMyMessage;
    function FocoNao: IMyMessage;
    function Componente(AValue: TWinControl): IMyMessage;

    function Opcao1(AValue: string): IMyMessage; overload;
    function Opcao1: string; overload;
    function Opcao2(AValue: string): IMyMessage; overload;
    function Opcao2: string; overload;
    function Opcao3(AValue: string): IMyMessage; overload;
    function Opcao3: string; overload;

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

{$REGION 'ShowMessage'}
function ShowInformacao(AMessage: string): Boolean; overload;
function ShowInformacao(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowAlert(AMessage: string): Boolean; overload;
function ShowAlert(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowErro(AMessage: string): Boolean; overload;
function ShowErro(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowCampoObrigatorio(AMessage: string): Boolean; overload;
function ShowCampoObrigatorio(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowPerguntaS(AMessage: string): Boolean; overload;
function ShowPerguntaS(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowPerguntaN(AMessage: string): Boolean; overload;
function ShowPerguntaN(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowOpcao(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOpcao(AMessage, AMsgCompleta, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
{$ENDREGION 'ShowMessage'}

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

function TMyMessage.Title(AValue: string): IMyMessage;
begin
   Result := Self;
   FTitle := AValue.Trim;
end;

function TMyMessage.Title: string;
begin
   if(FTitle = EmptyStr)then
      Title('Mensagem do sistema');

   Result := FTitle;
end;

function TMyMessage.Mensagem(AValue: string): IMyMessage;
begin
   Result    := Self;
   FMensagem := AValue.Trim;
end;

function TMyMessage.Mensagem: string;
begin
   Result := FMensagem;
end;

function TMyMessage.MensagemCompleta(AValue: string): IMyMessage;
begin
   Result            := Self;
   FMensagemCompleta := AValue.Trim;
end;

function TMyMessage.MensagemCompleta: string;
begin
   if(FMensagemCompleta = EmptyStr)then
     Self.MensagemCompleta(Self.Mensagem);

   Result := FMensagemCompleta;
end;

function TMyMessage.Opcao1(AValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao1 := AValue.Trim;
end;

function TMyMessage.Opcao1: string;
begin
   Result := FMsgOpcao1;
end;

function TMyMessage.Opcao2(AValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao2 := AValue.Trim;
end;

function TMyMessage.Opcao2: string;
begin
   Result := FMsgOpcao2;
end;

function TMyMessage.Opcao3(AValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao3 := AValue.Trim;
end;

function TMyMessage.Opcao3: string;
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

function TMyMessage.Componente(AValue: TWinControl): IMyMessage;
begin
   Result     := Self;
   FComponent := AValue;
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
    if(FMsgtype = TMsgType.MsgOpcao)then
    begin
       MyMessageView.ButtonOpcao1.Visible := (Self.Opcao1 <> EmptyStr);
       MyMessageView.ButtonOpcao1.Caption := Self.Opcao1;
       MyMessageView.ButtonOpcao2.Visible := (Self.Opcao2 <> EmptyStr);
       MyMessageView.ButtonOpcao2.Caption := Self.Opcao2;
       MyMessageView.ButtonOpcao3.Visible := (Self.Opcao3 <> EmptyStr);
       MyMessageView.ButtonOpcao3.Caption := Self.Opcao3;
    end;

    MyMessageView.ButtonSim.Visible := FMsgtype = TMsgType.MsgPergunta;
    MyMessageView.ButtonNao.Visible := FMsgtype = TMsgType.MsgPergunta;

    MyMessageView.ButtonOk.Visible := not ((FMsgtype = TMsgType.MsgPergunta)or(FMsgtype = TMsgType.MsgOpcao));

    case(FFoco)of
     TFoco.FocoBotaoSim: try MyMessageView.ButtonSim.SetFocus except on E: Exception do end;
     TFoco.FocoBotaoNao: try MyMessageView.ButtonNao.SetFocus; except on E: Exception do end;
    else
     try MyMessageView.ButtonOk.SetFocus; except end;
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

{$REGION 'ShowMessage'}
function ShowInformacao(AMessage: string): Boolean;
begin
   Result := ShowInformacao(AMessage, nil);
end;

function ShowInformacao(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.Mensagem(AMessage).Componente(AComponente).MsgInformacao;
end;

function ShowAlert(AMessage: string): Boolean;
begin
   Result := ShowAlert(AMessage, nil);
end;

function ShowAlert(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.Mensagem(AMessage).Componente(AComponente).MsgAlert;
end;

function ShowErro(AMessage: string): Boolean;
begin
   Result := ShowErro(AMessage, nil);
end;

function ShowErro(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.Mensagem(AMessage).Componente(AComponente).MsgErro;
end;

function ShowCampoObrigatorio(AMessage: string): Boolean;
begin
   Result := ShowCampoObrigatorio(AMessage, nil);
end;

function ShowCampoObrigatorio(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.Mensagem(AMessage).Componente(AComponente).MsgCampoObrigatorio;
end;

function ShowPerguntaS(AMessage: string): Boolean;
begin
   Result := ShowPerguntaS(AMessage, nil);
end;

function ShowPerguntaS(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.Mensagem(AMessage).Componente(AComponente).FocoSim.MsgPergunta;
end;

function ShowPerguntaN(AMessage: string): Boolean;
begin
   Result := ShowPerguntaN(AMessage, nil);
end;

function ShowPerguntaN(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.Mensagem(AMessage).Componente(AComponente).FocoNao.MsgPergunta;
end;

function ShowOpcao(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := showOpcao(AMessage, '', AOpcao1, AOpcao2, AOpcao3);
end;

function ShowOpcao(AMessage, AMsgCompleta, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := TMyMessage.New
              .Mensagem(AMessage)
              .MensagemCompleta(AMsgCompleta)
              .Opcao1(AOpcao1)
              .Opcao2(AOpcao2)
              .Opcao3(AOpcao3)
              .MsgOpcao;
end;
{$ENDREGION 'ShowMessage'}

end.
