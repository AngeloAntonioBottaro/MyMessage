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
    FButtonFocus: TButtonFocus;
    FMsgType: TMessageType;
    FComponent: TWinControl;
    FModalResult: Integer;

    function ShowMensagem: Boolean;
  protected
    function Title(AValue: string): IMyMessage; overload;
    function Title: string; overload;
    function MessageContent(AValue: string): IMyMessage; overload;
    function MessageContent: string; overload;
    function CompleteMessageContent(AValue: string): IMyMessage; overload;
    function CompleteMessageContent: string; overload;
    function FocusOnYes: IMyMessage;
    function FocusOnNo: IMyMessage;
    function Componente(AValue: TWinControl): IMyMessage;

    function Option1(AValue: string): IMyMessage; overload;
    function Option1: string; overload;
    function Option2(AValue: string): IMyMessage; overload;
    function Option2: string; overload;
    function Option3(AValue: string): IMyMessage; overload;
    function Option3: string; overload;

    function InformationMessage: Boolean; overload;
    function AlertMessage: Boolean; overload;
    function ErrorMessage: Boolean; overload;
    function RequiredFieldMessage: Boolean; overload;
    function QuestionMessage: Boolean; overload;
    function OptionMessage: Integer;
  public
    class function New: IMyMessage;
    constructor Create;
    destructor Destroy; override;
  end;
{$ENDREGION 'TMyMessage'}

{$REGION 'ShowMessage'}
function ShowInformation(AMessage: string): Boolean; overload;
function ShowInformation(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowInformation(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowInformation(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowAlert(AMessage: string): Boolean; overload;
function ShowAlert(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowAlert(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowAlert(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowError(AMessage: string): Boolean; overload;
function ShowError(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowError(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowError(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowRequiredField(AMessage: string): Boolean; overload;
function ShowRequiredField(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowRequiredField(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowRequiredField(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionYes(AMessage: string): Boolean; overload;
function ShowQuestionYes(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowQuestionYes(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionYes(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionNo(AMessage: string): Boolean; overload;
function ShowQuestionNo(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowQuestionNo(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionNo(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowOption(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOption(AMessage, AMsgCompleta, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
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
   FButtonFocus      := TButtonFocus.ok;
   FMsgType          := TMessageType.Information;
   FComponent        := nil;
   FModalResult      := 0;
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

function TMyMessage.MessageContent(AValue: string): IMyMessage;
begin
   Result    := Self;
   FMensagem := AValue.Trim;
end;

function TMyMessage.MessageContent: string;
begin
   Result := FMensagem;
end;

function TMyMessage.CompleteMessageContent(AValue: string): IMyMessage;
begin
   Result            := Self;
   FMensagemCompleta := AValue.Trim;
end;

function TMyMessage.CompleteMessageContent: string;
begin
   if(FMensagemCompleta = EmptyStr)then
     Self.CompleteMessageContent(Self.MessageContent);

   Result := FMensagemCompleta;
end;

function TMyMessage.Option1(AValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao1 := AValue.Trim;
end;

function TMyMessage.Option1: string;
begin
   Result := FMsgOpcao1;
end;

function TMyMessage.Option2(AValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao2 := AValue.Trim;
end;

function TMyMessage.Option2: string;
begin
   Result := FMsgOpcao2;
end;

function TMyMessage.Option3(AValue: string): IMyMessage;
begin
   Result     := Self;
   FMsgOpcao3 := AValue.Trim;
end;

function TMyMessage.Option3: string;
begin
   Result := FMsgOpcao3;
end;

function TMyMessage.FocusOnYes: IMyMessage;
begin
   Result       := Self;
   FButtonFocus := TButtonFocus.Yes;
end;

function TMyMessage.FocusOnNo: IMyMessage;
begin
   Result       := Self;
   FButtonFocus := TButtonFocus.No;
end;

function TMyMessage.Componente(AValue: TWinControl): IMyMessage;
begin
   Result     := Self;
   FComponent := AValue;
end;

function TMyMessage.InformationMessage: Boolean;
begin
   FMsgType := TMessageType.Information;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.AlertMessage: Boolean;
begin
   FMsgType := TMessageType.Alert;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.ErrorMessage: Boolean;
begin
   FMsgType := TMessageType.Error;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.QuestionMessage: Boolean;
begin
   FMsgType := TMessageType.Question;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.RequiredFieldMessage: Boolean;
begin
   FMsgType := TMessageType.RequiredField;
   Result   := Self.ShowMensagem;
end;

function TMyMessage.OptionMessage: Integer;
begin
   FMsgType := TMessageType.Option;
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
    MyMessageView.lbMensagem.Caption := Self.MessageContent;
    MyMessageView.FMensagemCompleta  := Self.CompleteMessageContent;

    //IMAGEM
    MyMessageView.FImage := FMsgType;

    //BOTOES
    if(FMsgType = TMessageType.Option)then
    begin
       MyMessageView.ButtonOpcao1.Visible := (Self.Option1 <> EmptyStr);
       MyMessageView.ButtonOpcao1.Caption := Self.Option1;
       MyMessageView.ButtonOpcao2.Visible := (Self.Option2 <> EmptyStr);
       MyMessageView.ButtonOpcao2.Caption := Self.Option2;
       MyMessageView.ButtonOpcao3.Visible := (Self.Option3 <> EmptyStr);
       MyMessageView.ButtonOpcao3.Caption := Self.Option3;
    end;

    MyMessageView.ButtonSim.Visible := FMsgType = TMessageType.Question;
    MyMessageView.ButtonNao.Visible := FMsgType = TMessageType.Question;

    MyMessageView.ButtonOk.Visible := not ((FMsgType = TMessageType.Question)or(FMsgType = TMessageType.Option));

    case(FButtonFocus)of
     TButtonFocus.Yes: try MyMessageView.ButtonSim.SetFocus except end;
     TButtonFocus.No: try MyMessageView.ButtonNao.SetFocus; except end;
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
//INFORMATION
function ShowInformation(AMessage: string): Boolean;
begin
   Result := ShowInformation(AMessage, '');
end;

function ShowInformation(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowInformation(AMessage, ACompleteMessage, nil);
end;

function ShowInformation(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowInformation(AMessage, '', AComponente);
end;

function ShowInformation(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).InformationMessage;
end;

//ALERT
function ShowAlert(AMessage: string): Boolean;
begin
   Result := ShowAlert(AMessage, '');
end;

function ShowAlert(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowAlert(AMessage, ACompleteMessage, nil);
end;

function ShowAlert(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowAlert(AMessage, '', AComponente);
end;

function ShowAlert(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).AlertMessage;
end;

//ERROR
function ShowError(AMessage: string): Boolean;
begin
   Result := ShowError(AMessage, '');
end;

function ShowError(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowError(AMessage, ACompleteMessage, nil);
end;

function ShowError(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowError(AMessage, '', AComponente);
end;

function ShowError(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ErrorMessage;
end;

//REQUIRED FIELD
function ShowRequiredField(AMessage: string): Boolean;
begin
   Result := ShowRequiredField(AMessage, '');
end;

function ShowRequiredField(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowRequiredField(AMessage, ACompleteMessage, nil);
end;

function ShowRequiredField(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowRequiredField(AMessage, '', AComponente);
end;

function ShowRequiredField(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).RequiredFieldMessage;
end;

//QUESTION YES
function ShowQuestionYes(AMessage: string): Boolean;
begin
   Result := ShowQuestionYes(AMessage, '');
end;

function ShowQuestionYes(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowQuestionYes(AMessage, ACompleteMessage, nil);
end;

function ShowQuestionYes(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowQuestionYes(AMessage, '', AComponente);
end;

function ShowQuestionYes(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).FocusOnYes.QuestionMessage;
end;

//QUESTION NO
function ShowQuestionNo(AMessage: string): Boolean;
begin
   Result := ShowQuestionNo(AMessage, '');
end;

function ShowQuestionNo(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowQuestionNo(AMessage, ACompleteMessage, nil);
end;

function ShowQuestionNo(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowQuestionNo(AMessage, '', AComponente);
end;

function ShowQuestionNo(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).FocusOnNo.QuestionMessage;
end;

//OPTION
function ShowOption(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := ShowOption(AMessage, '', AOpcao1, AOpcao2, AOpcao3);
end;

function ShowOption(AMessage, AMsgCompleta, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := TMyMessage.New
              .MessageContent(AMessage)
              .CompleteMessageContent(AMsgCompleta)
              .Option1(AOpcao1)
              .Option2(AOpcao2)
              .Option3(AOpcao3)
              .OptionMessage;
end;
{$ENDREGION 'ShowMessage'}

end.
