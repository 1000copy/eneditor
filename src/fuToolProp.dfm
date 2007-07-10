object frmToolProp: TfrmToolProp
  Left = 367
  Top = 455
  Width = 312
  Height = 307
  Caption = 'frmToolProp'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object lbl1: TLabel
    Left = 64
    Top = 24
    Width = 26
    Height = 16
    Caption = 'Title'
  end
  object lbl2: TLabel
    Left = 28
    Top = 64
    Width = 62
    Height = 16
    Caption = 'Command'
  end
  object Label1: TLabel
    Left = 27
    Top = 112
    Width = 63
    Height = 16
    Caption = 'Parameter'
  end
  object Label2: TLabel
    Left = 19
    Top = 144
    Width = 71
    Height = 16
    Caption = 'Init directory'
  end
  object Label3: TLabel
    Left = 19
    Top = 184
    Width = 43
    Height = 16
    Caption = 'File Ext'
  end
  object edtTitle: TEdit
    Left = 96
    Top = 24
    Width = 169
    Height = 24
    TabOrder = 0
    Text = 'edtTitle'
  end
  object edtCmd: TEdit
    Left = 96
    Top = 64
    Width = 169
    Height = 24
    TabOrder = 1
    Text = 'edtCmd'
  end
  object edtParams: TEdit
    Left = 96
    Top = 104
    Width = 169
    Height = 24
    TabOrder = 2
    Text = 'edtParams'
  end
  object edtInitDir: TEdit
    Left = 96
    Top = 144
    Width = 169
    Height = 24
    TabOrder = 3
    Text = 'edtInitDir'
  end
  object btnOK: TButton
    Left = 96
    Top = 224
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TButton
    Left = 208
    Top = 223
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object edtExt: TEdit
    Left = 96
    Top = 184
    Width = 169
    Height = 24
    TabOrder = 6
    Text = 'edtExt'
  end
end
