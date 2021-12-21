object Sistema: TSistema
  Left = 585
  Top = 384
  ClientHeight = 102
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 19
  object MainMenu1: TMainMenu
    Left = 48
    Top = 24
    object Cliente1: TMenuItem
      Caption = 'Cliente'
      OnClick = Cliente1Click
    end
  end
end
