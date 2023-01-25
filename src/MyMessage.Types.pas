unit MyMessage.Types;

interface

uses
  System.TypInfo;

type
  {$SCOPEDENUMS ON}
  TMessageType = (Information, Alert, Error, Question, RequiredField, Option);
  TButtonFocus = (Ok, Yes, No);
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
