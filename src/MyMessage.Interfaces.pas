unit MyMessage.Interfaces;

interface

uses
  Vcl.Controls,
  MyMessage.Types;

type
  IMyMessage = interface
   ['{4B40C142-130C-41B3-A661-A6DC6B15A44C}']
   function MsgInformacao: Boolean; overload;
   function MsgAlert: Boolean; overload;
   function MsgErro: Boolean; overload;
   function MsgCampoObrigatorio: Boolean; overload;
   function MsgPergunta: Boolean; overload;
   function MsgOpcao: Integer;

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
  end;

implementation

end.
