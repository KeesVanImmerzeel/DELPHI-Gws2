object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Gws2'
  ClientHeight = 281
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object SingleESRImvGrid: TSingleESRIgrid
    Left = 80
    Top = 64
  end
  object aTriwacoGrid: TtriwacoGrid
    Left = 160
    Top = 64
  end
  object RealAdoSet1: TRealAdoSet
    Left = 232
    Top = 64
  end
  object SingleESRIgridclsElmsf: TSingleESRIgrid
    Left = 80
    Top = 128
  end
  object GWSESRIgrid: TSingleESRIgrid
    Left = 72
    Top = 208
  end
end
