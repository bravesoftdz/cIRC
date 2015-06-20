object FormMain: TFormMain
  Left = 353
  Top = 157
  Width = 800
  Height = 500
  Caption = 'cIRC'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Courier New'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter
    Left = 100
    Top = 0
    Height = 435
    AutoSnap = False
    MinSize = 100
  end
  object Splitter2: TSplitter
    Left = 689
    Top = 0
    Height = 435
    Align = alRight
    AutoSnap = False
    MinSize = 100
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 435
    Width = 792
    Height = 19
    Panels = <>
  end
  object Panel2: TPanel
    Left = 692
    Top = 0
    Width = 100
    Height = 435
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 100
    Height = 435
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 100
      Height = 14
      Align = alTop
      Caption = 'Channels'
    end
    object ListBox1: TListBox
      Left = 0
      Top = 14
      Width = 100
      Height = 421
      Align = alClient
      ItemHeight = 14
      TabOrder = 0
    end
  end
  object Panel4: TPanel
    Left = 103
    Top = 0
    Width = 586
    Height = 435
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object MemoTraffic: TMemo
      Left = 0
      Top = 14
      Width = 586
      Height = 399
      Align = alClient
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object Panel5: TPanel
      Left = 0
      Top = 413
      Width = 586
      Height = 22
      Align = alBottom
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        586
        22)
      object EditSend: TEdit
        Left = 0
        Top = 0
        Width = 530
        Height = 22
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnKeyDown = EditSendKeyDown
      end
      object ButtonSend: TButton
        Left = 533
        Top = 0
        Width = 53
        Height = 22
        Anchors = [akTop, akRight]
        Caption = 'Send'
        TabOrder = 1
        OnClick = ButtonSendClick
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 586
      Height = 14
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 2
      object Label2: TLabel
        Left = 0
        Top = 0
        Width = 544
        Height = 14
        Align = alClient
        Caption = 'Label2'
      end
      object Label3: TLabel
        Left = 544
        Top = 0
        Width = 42
        Height = 14
        Align = alRight
        Caption = 'Label3'
      end
    end
  end
  object MainMenu: TMainMenu
    Left = 45
    Top = 76
    object MenuFile: TMenuItem
      Caption = '&File'
      object MenuItemExit: TMenuItem
        Caption = 'E&xit'
        OnClick = MenuItemExitClick
      end
    end
    object MenuTools: TMenuItem
      Caption = '&Tools'
      object MenuItemRunTests: TMenuItem
        Caption = '&Run Tests'
        OnClick = MenuItemRunTestsClick
      end
    end
  end
end
