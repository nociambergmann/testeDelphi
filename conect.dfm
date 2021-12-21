object Query: TQuery
  Left = 0
  Top = 0
  ClientHeight = 254
  ClientWidth = 690
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 60
    Width = 684
    Height = 191
    Align = alClient
    DataSource = dsSql
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object gbPedidos: TGroupBox
    Left = 0
    Top = 0
    Width = 690
    Height = 57
    Align = alTop
    Caption = 'Pedidos Vendas'
    TabOrder = 1
    ExplicitLeft = -3
    ExplicitTop = -3
    DesignSize = (
      690
      57)
    object lbCodPedido: TLabel
      Left = 14
      Top = 24
      Width = 48
      Height = 19
      Caption = 'Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edPedido: TEdit
      Left = 69
      Top = 20
      Width = 130
      Height = 27
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
    end
    object btnBuscaReceita: TBitBtn
      Left = 206
      Top = 20
      Width = 46
      Height = 27
      Cursor = crHandPoint
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        555555555555555555555555555555555555555555FF55555555555559055555
        55555555577FF5555555555599905555555555557777F5555555555599905555
        555555557777FF5555555559999905555555555777777F555555559999990555
        5555557777777FF5555557990599905555555777757777F55555790555599055
        55557775555777FF5555555555599905555555555557777F5555555555559905
        555555555555777FF5555555555559905555555555555777FF55555555555579
        05555555555555777FF5555555555557905555555555555777FF555555555555
        5990555555555555577755555555555555555555555555555555}
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnBuscaReceitaClick
    end
    object stName: TStaticText
      Left = 258
      Top = 20
      Width = 383
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      BevelInner = bvLowered
      BorderStyle = sbsSingle
      Caption = 'Selecione um item  depois duplo clique na grid'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      TabOrder = 2
    end
  end
  object Query: TFDQuery
    Connection = FDConnection1
    Left = 544
    Top = 8
  end
  object dsSql: TDataSource
    DataSet = Query
    Left = 584
    Top = 3
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=mercado'
      'User_Name=root'
      'Password=123'
      'Server=localhost'
      'DriverID=MySQL')
    Connected = True
    LoginPrompt = False
    Left = 521
    Top = 69
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Program Files\MySQL\MySQL Server 8.0\lib\libmysql.dll'
    Left = 601
    Top = 71
  end
end
