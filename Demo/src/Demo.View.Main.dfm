object ViewMain: TViewMain
  Left = 0
  Top = 0
  Caption = 'Demo'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 8
    Width = 100
    Height = 25
    Caption = 'Info'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 39
    Width = 100
    Height = 25
    Caption = 'Alert'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 70
    Width = 100
    Height = 25
    Caption = 'Error'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 101
    Width = 100
    Height = 25
    Caption = 'Question'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 132
    Width = 100
    Height = 25
    Caption = 'Required'
    TabOrder = 4
    OnClick = Button5Click
  end
  object Edit1: TEdit
    Left = 216
    Top = 10
    Width = 121
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
  object Button6: TButton
    Left = 16
    Top = 192
    Width = 100
    Height = 25
    Caption = 'Op'#231'oes'
    TabOrder = 6
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 216
    Top = 48
    Width = 121
    Height = 25
    Caption = 'long'
    TabOrder = 7
    OnClick = Button7Click
  end
end
