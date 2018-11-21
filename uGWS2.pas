unit uGWS2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTabstractESRIgrid, uTSingleESRIgrid,
  uTriwacoGrid, LargeArrays, AdoSets, uError, AVGRIDIO;

type
  TMainForm = class(TForm)
    SingleESRImvGrid: TSingleESRIgrid;
    aTriwacoGrid: TtriwacoGrid;
    RealAdoSet1: TRealAdoSet;
    SingleESRIgridclsElmsf: TSingleESRIgrid;
    GWSESRIgrid: TSingleESRIgrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
InitialiseLogFile;
InitialiseGridIO;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
FinaliseLogFile;
end;

end.
