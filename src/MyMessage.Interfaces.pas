unit MyMessage.Interfaces;

interface

uses
  Vcl.Controls,
  MyMessage.Types;

type
  IMyMessage = interface
   ['{4B40C142-130C-41B3-A661-A6DC6B15A44C}']
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
  end;

implementation

end.
