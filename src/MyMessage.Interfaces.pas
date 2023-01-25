unit MyMessage.Interfaces;

interface

uses
  Vcl.Controls,
  MyMessage.Types;

type
  IMyMessage = interface
   ['{4B40C142-130C-41B3-A661-A6DC6B15A44C}']
   function InformationMessage: Boolean; overload;
   function AlertMessage: Boolean; overload;
   function ErrorMessage: Boolean; overload;
   function RequiredFieldMessage: Boolean; overload;
   function QuestionMessage: Boolean; overload;
   function OptionMessage: Integer;

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
  end;

implementation

end.
