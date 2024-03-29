unit MyMessage.View;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.ImageList,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.ExtCtrls,
  Vcl.Clipbrd,
  Vcl.ImgList,
  Vcl.Buttons,
  Vcl.Menus,
  MyMessage.Types,
  MyMessage.Helpers.TMemo;

const
 BUTTON_MARGEM   = 40;
 PIXEL_POR_LETRA = 5;
 SHOW_COMPLETE_MESSAGE = 'Mostrar mais >>';
 HIDE_COMPLETE_MESSAGE = '<< Mostrar menos';
 HEIGHT_COMP_MESSAGE   = 150;

type
  TMyMessageView = class(TForm)
    ImageListButtons: TImageList;
    PopupMenuCompleteMessage: TPopupMenu;
    Copiartexto1: TMenuItem;
    GroupBoxBotton: TPanel;
    ButtonOk: TButton;
    ButtonSim: TButton;
    ButtonNao: TButton;
    pnTela: TPanel;
    ButtonOpcao1: TButton;
    ButtonOpcao2: TButton;
    ButtonOpcao3: TButton;
    ImageListIcon: TImageList;
    pnImage: TPanel;
    imgAlert: TImage;
    imgError: TImage;
    imgInformation: TImage;
    imgOption: TImage;
    imgQuestion: TImage;
    imgRequiredField: TImage;
    pnTop: TPanel;
    pnBotton: TPanel;
    mmMessage: TMemo;
    imgPrinter: TImage;
    imgDone: TImage;
    pnCompleteMessage: TPanel;
    mmCompleteMessage: TMemo;
    pnlbShowCompleteMessage: TPanel;
    lbShowCompleteMessage: TLabel;
    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonSimClick(Sender: TObject);
    procedure ButtonNaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Copiartexto1Click(Sender: TObject);
    procedure ButtonOpcao1Click(Sender: TObject);
    procedure ButtonOpcao2Click(Sender: TObject);
    procedure ButtonOpcao3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbShowCompleteMessageClick(Sender: TObject);
  private
    FOriginalHeight: Integer;
    procedure ConfForm;
    procedure LoadImage;
    procedure ConfButtons;
    procedure LoadMessage;
    procedure LoadCompleteMessage;
  public
    FMessageContent: string;
    FCompleteMessageContent: string;
    FImage: TMessageType
  end;

var
  MyMessageView: TMyMessageView;

implementation

{$R *.dfm}

procedure TMyMessageView.ButtonNaoClick(Sender: TObject);
begin
   Self.Close;
   Self.ModalResult := mrNo;
end;

procedure TMyMessageView.ButtonOkClick(Sender: TObject);
begin
   Self.Close;
   Self.ModalResult := mrOk;
end;

procedure TMyMessageView.ButtonOpcao1Click(Sender: TObject);
begin
   Self.Close;
   Self.ModalResult := 1;
end;

procedure TMyMessageView.ButtonOpcao2Click(Sender: TObject);
begin
   Self.Close;
   Self.ModalResult := 2;
end;

procedure TMyMessageView.ButtonOpcao3Click(Sender: TObject);
begin
   Self.Close;
   Self.ModalResult := 3;
end;

procedure TMyMessageView.ButtonSimClick(Sender: TObject);
begin
   Self.Close;
   Self.ModalResult := mrYes;
end;

procedure TMyMessageView.Copiartexto1Click(Sender: TObject);
begin
   try
     Clipboard.AsText := FCompleteMessageContent;
   except
   end;
end;

procedure TMyMessageView.FormCreate(Sender: TObject);
begin
   Constraints.MinWidth  := Self.Width;
   Constraints.MinHeight := Self.Height;
   FOriginalHeight       := Self.Height;
end;

procedure TMyMessageView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   case(Key)of
    VK_F4: if(ssAlt in Shift)then Key := 0;
    VK_Escape:
    begin
       if(Shift = [])then
       begin
          if(ButtonNao.Visible)and(ButtonNao.Enabled)then ButtonNao.Click
          else if(ButtonOk.Visible)and(ButtonOk.Enabled)then ButtonOk.Click;
       end;
    end;
    VK_NUMPAD1, 53, 83:
    begin
       if(Shift = [])then
       begin
          if(ButtonSim.Visible)and(ButtonSim.Enabled)then ButtonSim.Click;
       end;
    end;
    VK_NUMPAD2, 78:
    begin
       if(Shift = [])then
       begin
          if(ButtonNao.Visible)and(ButtonNao.Enabled)then ButtonNao.Click;
       end;
    end;
   end;
end;

procedure TMyMessageView.FormShow(Sender: TObject);
begin
   Self.ConfForm;
end;

procedure TMyMessageView.lbShowCompleteMessageClick(Sender: TObject);
var
  LCaption: string;
begin
   mmCompleteMessage.Lines.Clear;
   Self.Height := FOriginalHeight;
   LCaption    := lbShowCompleteMessage.Caption;
   lbShowCompleteMessage.Caption := SHOW_COMPLETE_MESSAGE;

   if(LCaption.Equals(SHOW_COMPLETE_MESSAGE))then
   begin
      Self.LoadCompleteMessage;
      lbShowCompleteMessage.Caption := HIDE_COMPLETE_MESSAGE;
      Self.Height := Self.Height + HEIGHT_COMP_MESSAGE;
   end;
end;

procedure TMyMessageView.ConfForm;
begin
   pnTela.Color := clBtnFace;
   Self.ConfButtons;
   Self.LoadImage;
   Self.LoadMessage;
   pnlbShowCompleteMessage.Visible := not FCompleteMessageContent.IsEmpty;
   lbShowCompleteMessage.Caption := SHOW_COMPLETE_MESSAGE;
   mmCompleteMessage.Lines.Clear;
end;

procedure TMyMessageView.ConfButtons;
begin
   if(ButtonOpcao1.Visible)then
     ButtonOpcao1.Width := BUTTON_MARGEM + (Length(ButtonOpcao1.Caption) * PIXEL_POR_LETRA);

   if(ButtonOpcao1.Width > 150)then
     ButtonOpcao1.Width := 150;

   if(ButtonOpcao2.Visible)then
     ButtonOpcao2.Width := BUTTON_MARGEM + (Length(ButtonOpcao2.Caption) * PIXEL_POR_LETRA);

   if(ButtonOpcao2.Width > 150)then
     ButtonOpcao2.Width := 150;

   if(ButtonOpcao3.Visible)then
     ButtonOpcao3.Width := BUTTON_MARGEM + (Length(ButtonOpcao3.Caption) * PIXEL_POR_LETRA);

   if(ButtonOpcao3.Width > 150)then
     ButtonOpcao3.Width := 150;

   ButtonOpcao1.Align := alLeft;
   ButtonOpcao2.Align := alLeft;
   ButtonOpcao3.Align := alLeft;
   ButtonOpcao1.Align := alRight;
   ButtonOpcao2.Align := alRight;
   ButtonOpcao3.Align := alRight;
end;

procedure TMyMessageView.LoadImage;
begin
   imgInformation.Visible   := FImage = TMessageType.Information;
   imgAlert.Visible         := FImage = TMessageType.Warning;
   imgError.Visible         := FImage = TMessageType.Error;
   imgDone.Visible          := FImage = TMessageType.Done;
   imgRequiredField.Visible := FImage = TMessageType.RequiredField;
   imgPrinter.Visible       := FImage = TMessageType.Printer;
   imgQuestion.Visible      := FImage = TMessageType.Question;
   imgOption.Visible        := FImage = TMessageType.Option;
end;

procedure TMyMessageView.LoadMessage;
begin
   mmMessage.TextVerticalCenter(MyMessageView.mmMessage.Tag, FMessageContent);
end;

procedure TMyMessageView.LoadCompleteMessage;
begin
   mmCompleteMessage.Lines.Add(FCompleteMessageContent);
end;

end.
