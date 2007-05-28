object fmTools: TfmTools
  Left = 344
  Top = 292
  Width = 468
  Height = 341
  Caption = 'Tools'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lst1: TListBox
    Left = 24
    Top = 16
    Width = 313
    Height = 241
    ItemHeight = 16
    TabOrder = 0
  end
  object btnExit: TButton
    Left = 368
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 1
    OnClick = btnExitClick
  end
  object btnProp: TButton
    Left = 368
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Property'
    TabOrder = 2
    OnClick = btnPropClick
  end
  object btnNew: TButton
    Left = 368
    Top = 96
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 3
    OnClick = btnNewClick
  end
  object btnDel: TButton
    Left = 368
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = btnDelClick
  end
  object btnRun: TButton
    Left = 368
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Run'
    TabOrder = 5
    OnClick = btnRunClick
  end
end
