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
    FComponent: TWinControl;
    FModalResult: Integer;
  protected
    function Title(AValue: string): IMyMessage; overload;
    function Title: string; overload;
    function MessageContent(AValue: string): IMyMessage; overload;
    function MessageContent: string; overload;
    function CompleteMessageContent(AValue: string): IMyMessage; overload;
    function CompleteMessageContent: string; overload;
    function Componente(AValue: TWinControl): IMyMessage;

    function Option1(AValue: string): IMyMessage; overload;
    function Option1: string; overload;
    function Option2(AValue: string): IMyMessage; overload;
    function Option2: string; overload;
    function Option3(AValue: string): IMyMessage; overload;
    function Option3: string; overload;

    function ShowMessage(AIcon: TMessageType = TMessageType.None;
                                AButtons: TMessageButtons = TMessageButtons.Ok;
                                AFocus: TButtonFocus = TButtonFocus.None): Boolean;
    function ModalResult: Integer;
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
function ShowWarning(AMessage: string): Boolean; overload;
function ShowWarning(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowWarning(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowWarning(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowError(AMessage: string): Boolean; overload;
function ShowError(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowError(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowError(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowDone(AMessage: string): Boolean; overload;
function ShowDone(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowDone(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowDone(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowRequired: Boolean; overload;
function ShowRequired(AMessage: string): Boolean; overload;
function ShowRequired(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowRequired(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowRequired(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowPrinter(AMessage: string): Boolean; overload;
function ShowPrinter(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowPrinter(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowPrinter(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionYes(AMessage: string): Boolean; overload;
function ShowQuestionYes(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowQuestionYes(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionYes(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionNo(AMessage: string): Boolean; overload;
function ShowQuestionNo(AMessage: string; ACompleteMessage: string): Boolean; overload;
function ShowQuestionNo(AMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowQuestionNo(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
function ShowOption1(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOption1(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOption2(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOption2(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOption3(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
function ShowOption3(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
{$ENDREGION 'ShowMessage'}

implementation

uses
  MyMessage.Consts;

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
   if(FTitle.IsEmpty)then
     Self.Title(DEFAULT_TITLE);

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

function TMyMessage.Componente(AValue: TWinControl): IMyMessage;
begin
   Result     := Self;
   FComponent := AValue;
end;

function TMyMessage.ShowMessage(AIcon: TMessageType = TMessageType.None;
                                AButtons: TMessageButtons = TMessageButtons.Ok;
                                AFocus: TButtonFocus = TButtonFocus.None): Boolean;
begin
  if(MyMessageView = nil)then Application.CreateForm(TMyMessageView, MyMessageView);
  try
    //TITULO
    MyMessageView.Caption := Self.Title;

    //MENSAGEM
    MyMessageView.FMessageContent          := Self.MessageContent;
    MyMessageView.FCompleteMessageContent  := Self.CompleteMessageContent;

    //IMAGEM
    MyMessageView.FImage := AIcon;

    //BOTOES
    if(AButtons = TMessageButtons.Options)then
    begin
       MyMessageView.ButtonOpcao1.Visible := (Self.Option1 <> EmptyStr);
       MyMessageView.ButtonOpcao1.Caption := Self.Option1;
       MyMessageView.ButtonOpcao2.Visible := (Self.Option2 <> EmptyStr);
       MyMessageView.ButtonOpcao2.Caption := Self.Option2;
       MyMessageView.ButtonOpcao3.Visible := (Self.Option3 <> EmptyStr);
       MyMessageView.ButtonOpcao3.Caption := Self.Option3;
    end;

    MyMessageView.ButtonSim.Visible := AButtons = TMessageButtons.YesNo;
    MyMessageView.ButtonNao.Visible := AButtons = TMessageButtons.YesNo;

    MyMessageView.ButtonOk.Visible := not ((AButtons = TMessageButtons.Options)or(AButtons = TMessageButtons.YesNo));

    case(AFocus)of
     TButtonFocus.Yes: try MyMessageView.ButtonSim.SetFocus except end;
     TButtonFocus.No: try MyMessageView.ButtonNao.SetFocus; except end;
     TButtonFocus.Option1: try MyMessageView.ButtonOpcao1.SetFocus; except end;
     TButtonFocus.Option2: try MyMessageView.ButtonOpcao2.SetFocus; except end;
     TButtonFocus.Option3: try MyMessageView.ButtonOpcao3.SetFocus; except end;
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

function TMyMessage.ModalResult: Integer;
begin
   Result := FModalResult;
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
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Information);
end;

//WARNING
function ShowWarning(AMessage: string): Boolean;
begin
   Result := ShowWarning(AMessage, '');
end;

function ShowWarning(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowWarning(AMessage, ACompleteMessage, nil);
end;

function ShowWarning(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowWarning(AMessage, '', AComponente);
end;

function ShowWarning(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Warning);
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
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Error);
end;

//DONE
function ShowDone(AMessage: string): Boolean;
begin
   Result := ShowDone(AMessage, '');
end;

function ShowDone(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowDone(AMessage, ACompleteMessage, nil);
end;

function ShowDone(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowDone(AMessage, '', AComponente);
end;

function ShowDone(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Done);
end;

//REQUIRED FIELD
function ShowRequired: Boolean; overload;
begin
   Result := ShowRequired(EMPTY_REQUIRED_FIELD, '');
end;

function ShowRequired(AMessage: string): Boolean;
begin
   Result := ShowRequired(AMessage, '');
end;

function ShowRequired(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowRequired(AMessage, ACompleteMessage, nil);
end;

function ShowRequired(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowRequired(AMessage, '', AComponente);
end;

function ShowRequired(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.RequiredField);
end;

//PRINTER
function ShowPrinter(AMessage: string): Boolean;
begin
   Result := ShowPrinter(AMessage, '');
end;

function ShowPrinter(AMessage: string; ACompleteMessage: string): Boolean; overload;
begin
   Result := ShowPrinter(AMessage, ACompleteMessage, nil);
end;

function ShowPrinter(AMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := ShowPrinter(AMessage, '', AComponente);
end;

function ShowPrinter(AMessage: string; ACompleteMessage: string; AComponente: TWinControl): Boolean; overload;
begin
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Printer);
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
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Question, TMessageButtons.YesNo, TButtonFocus.Yes);
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
   Result := TMyMessage.New.MessageContent(AMessage).CompleteMessageContent(ACompleteMessage).Componente(AComponente).ShowMessage(TMessageType.Question, TMessageButtons.YesNo, TButtonFocus.No);
end;

//OPTION
function ShowOption(AMessage, AMsgCompleta, AOpcao1, AOpcao2, AOpcao3: string; AFocus: TButtonFocus): Integer;
var
  LMsg: IMyMessage;
begin
   LMsg   := TMyMessage.New;
   LMsg.MessageContent(AMessage).CompleteMessageContent(AMsgCompleta).Option1(AOpcao1).Option2(AOpcao2).Option3(AOpcao3).ShowMessage(TMessageType.Option, TMessageButtons.Options, AFocus);
   Result := LMsg.ModalResult;
end;

function ShowOption1(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := ShowOption(AMessage, '', AOpcao1, AOpcao2, AOpcao3, TButtonFocus.Option1);
end;

function ShowOption1(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
begin
   Result := ShowOption(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3, TButtonFocus.Option1);
end;

function ShowOption2(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := ShowOption(AMessage, '', AOpcao1, AOpcao2, AOpcao3, TButtonFocus.Option2);
end;

function ShowOption2(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
begin
   Result := ShowOption(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3, TButtonFocus.Option2);
end;

function ShowOption3(AMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer;
begin
   Result := ShowOption(AMessage, '', AOpcao1, AOpcao2, AOpcao3, TButtonFocus.Option3);
end;

function ShowOption3(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3: string): Integer; overload;
begin
   Result := ShowOption(AMessage, ACompleteMessage, AOpcao1, AOpcao2, AOpcao3, TButtonFocus.Option3);
end;
{$ENDREGION 'ShowMessage'}

end.
