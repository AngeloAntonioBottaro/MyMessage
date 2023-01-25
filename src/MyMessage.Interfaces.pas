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
  end;

implementation

end.
