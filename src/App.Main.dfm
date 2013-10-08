object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 420
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Insert: TButton
    Left = 166
    Top = 30
    Width = 75
    Height = 25
    Caption = 'Insert'
    TabOrder = 0
    OnClick = InsertClick
  end
  object Desconect: TButton
    Left = 400
    Top = 61
    Width = 75
    Height = 25
    Caption = 'Desconect'
    TabOrder = 1
    OnClick = DesconectClick
  end
  object Conect: TButton
    Left = 400
    Top = 30
    Width = 75
    Height = 25
    Caption = 'Conect'
    TabOrder = 2
    OnClick = ConectClick
  end
  object LabeledEdit1: TLabeledEdit
    Left = 32
    Top = 32
    Width = 65
    Height = 21
    EditLabel.Width = 33
    EditLabel.Height = 13
    EditLabel.Caption = 'C'#243'digo'
    TabOrder = 3
  end
  object LabeledEdit2: TLabeledEdit
    Left = 32
    Top = 76
    Width = 185
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome'
    TabOrder = 4
  end
  object Button1: TButton
    Left = 166
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Find'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 400
    Top = 118
    Width = 179
    Height = 43
    Caption = 'DAOAluno.Teste'
    TabOrder = 6
    OnClick = Button2Click
  end
end
