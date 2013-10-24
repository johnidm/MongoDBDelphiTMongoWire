object Form2: TForm2
  Left = 0
  Top = 0
  ActiveControl = EdtCodigo
  Caption = 'Form2'
  ClientHeight = 417
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 304
    Top = 319
    Width = 40
    Height = 13
    Caption = 'Total : 0'
  end
  object Label2: TLabel
    Left = 24
    Top = 284
    Width = 45
    Height = 13
    Caption = 'Tempo  : '
  end
  object Label3: TLabel
    Left = 304
    Top = 338
    Width = 45
    Height = 13
    Caption = 'Tempo  : '
  end
  object Insert: TButton
    Left = 24
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 0
    OnClick = InsertClick
  end
  object Button1: TButton
    Left = 105
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 186
    Top = 157
    Width = 75
    Height = 25
    Caption = 'Excluir'
    TabOrder = 2
    OnClick = Button2Click
  end
  object EdtCodigo: TLabeledEdit
    Left = 24
    Top = 87
    Width = 57
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'digo'
    TabOrder = 3
  end
  object EdtNome: TLabeledEdit
    Left = 104
    Top = 87
    Width = 157
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 4
  end
  object DBGrid1: TDBGrid
    Left = 304
    Top = 46
    Width = 237
    Height = 267
    DataSource = DataSource1
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Caption = 'C'#243'digo'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Nome'
        Width = 145
        Visible = True
      end>
  end
  object Button3: TButton
    Left = 304
    Top = 15
    Width = 237
    Height = 25
    Caption = 'Listar todos'
    TabOrder = 6
    OnClick = Button3Click
  end
  object btn1: TButton
    Left = 119
    Top = 247
    Width = 75
    Height = 25
    Caption = 'Popular'
    TabOrder = 7
    OnClick = btn1Click
  end
  object Edit1: TEdit
    Left = 24
    Top = 249
    Width = 89
    Height = 21
    TabOrder = 8
    Text = '5'
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 120
    Top = 8
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 64
    Top = 8
    object ClientDataSet1Codigo: TIntegerField
      FieldName = 'Codigo'
    end
    object ClientDataSet1Nome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
  end
end
