object fmTextGene: TfmTextGene
  Left = 277
  Top = 284
  Width = 553
  Height = 391
  Caption = 'Text Gene'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 120
  TextHeight = 16
  object Label6: TLabel
    Left = 224
    Top = 136
    Width = 24
    Height = 16
    Caption = #27493#38271
  end
  object PageControl1: TPageControl
    Left = 16
    Top = 8
    Width = 521
    Height = 297
    ActivePage = ts3
    TabOrder = 0
    OnChange = PageControl1Change
    object ts3: TTabSheet
      Caption = #24635#35745#37197#32622
      object lbl3: TLabel
        Left = 50
        Top = 94
        Width = 36
        Height = 16
        Caption = #24635#34892#25968
      end
      object Label1: TLabel
        Left = 50
        Top = 129
        Width = 36
        Height = 16
        Caption = #20998#21106#31526
      end
      object Label2: TLabel
        Left = 50
        Top = 56
        Width = 36
        Height = 16
        Caption = #24635#21015#25968
      end
      object edtRows: TEdit
        Left = 152
        Top = 90
        Width = 121
        Height = 24
        TabOrder = 0
        Text = '10'
      end
      object edtSep: TEdit
        Left = 152
        Top = 125
        Width = 121
        Height = 24
        TabOrder = 1
        Text = ','
      end
      object edtColumns: TEdit
        Left = 152
        Top = 56
        Width = 121
        Height = 24
        TabOrder = 2
        Text = '2'
      end
    end
    object ts4: TTabSheet
      Caption = #21015#37197#32622
      ImageIndex = 1
      object Label4: TLabel
        Left = 224
        Top = 96
        Width = 24
        Height = 16
        Caption = #24320#22987
      end
      object Label5: TLabel
        Left = 224
        Top = 136
        Width = 24
        Height = 16
        Caption = #27493#38271
      end
      object Label7: TLabel
        Left = 262
        Top = 192
        Width = 3
        Height = 16
      end
      object lbl2: TLabel
        Left = 188
        Top = 168
        Width = 60
        Height = 16
        Caption = #26159#21542#23450#38271#65311
      end
      object lbl1: TLabel
        Left = 212
        Top = 62
        Width = 36
        Height = 16
        Caption = #23383#31526#20018
      end
      object Label3: TLabel
        Left = 212
        Top = 16
        Width = 36
        Height = 16
        Caption = #21015#31867#22411
      end
      object Label8: TLabel
        Left = 200
        Top = 192
        Width = 48
        Height = 16
        Caption = #23450#38271#38271#24230
      end
      object lstColumnList: TListBox
        Left = 24
        Top = 16
        Width = 161
        Height = 193
        ItemHeight = 16
        TabOrder = 0
        OnClick = lstColumnListClick
      end
      object edtBegin: TEdit
        Left = 272
        Top = 96
        Width = 121
        Height = 24
        TabOrder = 1
        Text = '0'
        OnExit = edtStringExit
      end
      object edtStep: TEdit
        Left = 272
        Top = 136
        Width = 121
        Height = 24
        TabOrder = 2
        Text = '1'
        OnExit = edtStringExit
      end
      object chkFixLen: TCheckBox
        Left = 272
        Top = 168
        Width = 97
        Height = 17
        TabOrder = 3
        OnExit = edtStringExit
      end
      object edtString: TEdit
        Left = 272
        Top = 58
        Width = 121
        Height = 24
        TabOrder = 4
        OnExit = edtStringExit
      end
      object cbbColumnType: TComboBox
        Left = 272
        Top = 16
        Width = 121
        Height = 24
        ItemHeight = 16
        ItemIndex = 0
        TabOrder = 5
        Text = #31616#21333
        OnChange = cbbColumnTypeChange
        Items.Strings = (
          #31616#21333
          #24207#21015)
      end
      object edtFixLen: TEdit
        Left = 272
        Top = 192
        Width = 121
        Height = 24
        TabOrder = 6
        Text = '1'
        OnExit = edtStringExit
      end
      object btn1: TButton
        Left = 24
        Top = 224
        Width = 75
        Height = 25
        Caption = #29983#25104
        TabOrder = 7
        OnClick = btn1Click
      end
    end
    object ts5: TTabSheet
      Caption = 'ts5'
      ImageIndex = 2
      TabVisible = False
      object mmo1: TMemo
        Left = 24
        Top = 16
        Width = 561
        Height = 289
        Lines.Strings = (
          'mmo1')
        TabOrder = 0
      end
    end
  end
  object Button1: TButton
    Left = 216
    Top = 320
    Width = 75
    Height = 25
    Caption = #36864#20986
    TabOrder = 1
    OnClick = Button1Click
  end
end
