unit MyMessage.Types;

interface

uses
  System.TypInfo;

type
  {$SCOPEDENUMS ON}
  TMessageType    = (None, Information, Warning, Error, Done, RequiredField, Printer, Question, Option);
  TMessageButtons = (Ok, YesNo, Options);
  TButtonFocus    = (None, Ok, Yes, No, Option1, Option2, Option3);
  {$SCOPEDENUMS OFF}

  TMyMessageTypeHelper = record helper for TMessageType
  public
    function ToString: String;
  end;

implementation

function TMyMessageTypeHelper.ToString: String;
begin
   Result := GetEnumName(TypeInfo(TMessageType), Integer(Self));
end;

end.
