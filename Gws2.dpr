program Gws2;

uses
  Vcl.Forms,
  uError,
  Vcl.Dialogs,
  opWString,
  uTSingleESRIgrid,
  uTriwacoGrid,
  LargeArrays,
  AdoSets,
  SysUtils,
  AVGRIDIO,
  uPlane,
  uGWS2 in 'uGWS2.pas' {MainForm};
var
  iResult, i, j, elNr: Integer;
  Initiated: Boolean;
  LineNr: LongWord;
  f: TextFile;
  aValue: Double;
  Mv, x,y : Single;
  ExactLocation: T2dPoint;
{$R *.res}

Procedure ShowArgumentsAndTerminate;
begin
  ShowMessage( 'Gws2 AhnESRIgrid FlairsFloFile FlairsSetName TriwacoTEOfile GwsESRIgrid' );
  // for example %DelphiDebug%\Map_Unc map_unc_in.csv map_unc_out.csv
  Application.Terminate;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);

  if not (ParamCount() = 5)   then
   ShowArgumentsAndTerminate;

  AssignFile( f, ParamStr( 2 ) ); Reset( f );
  MainForm.RealAdoSet1 := TRealAdoSet.InitFromOpenedTextFile( f, ParamStr(3), MainForm, LineNr, Initiated );
  CloseFile( f );

  MainForm.aTriwacoGrid := TTriwacoGrid.InitFromTextFile( ParamStr( 4 ), MainForm, Initiated );

  //MainForm.triwacoGrid1.ExportToPEST( MainForm.RealAdoSet1, cNode, 'tmp1.txt' );
  //MainForm.SingleESRIgrid1.ExportToPEST( 'tmp2.txt', false );

  MainForm.aTriwacoGrid.PrepareForLinearInterpolationOnElements(MainForm.RealAdoSet1);

  MainForm.SingleESRIgridclsElmsf := TSingleESRIgrid.InitialiseFromESRIGridFile(
    ExtractFileDir(  ParamStr( 4 ) )  + '\clselmsf', iResult,  MainForm );
  WriteToLogFileFMT( 'nrows=%d ncols=%d', [MainForm.SingleESRImvGrid.NRows,MainForm.SingleESRImvGrid.NCols ]);

  MainForm.SingleESRImvGrid := TSingleESRIgrid.InitialiseFromESRIGridFile( ParamStr(1), iResult,  MainForm );
  //MainForm.GwsESRIgrid.SaveAs('d:\tmp\test');

  MainForm.GwsESRIgrid :=TSingleESRIgrid.Clone(MainForm.SingleESRImvGrid, 'GWS', iresult, MainForm );

        with MainForm.SingleESRImvGrid, MainForm.aTriwacoGrid do begin
//          MaxNod1 := MainForm.aTriwacoGrid.NrOfNodes;
          for i:=1 to MainForm.SingleESRImvGrid.NRows do begin
                for j:=1 to MainForm.SingleESRImvGrid.NCols do begin

                  MainForm.GwsESRIgrid[ i, j ] := MissingSingle;
                  Mv := MainForm.SingleESRImvGrid.GetValue( i, j );

                  if ( Mv <> MissingSingle ) then begin

                    GetCellCentre( i, j, x, y );
                    ExactLocation.X := x; ExactLocation.Y := y;
                    aValue := MainForm.SingleESRIgridclsElmsf.GetValueXY(
                      ExactLocation.X, ExactLocation.Y );
                    elNr := Trunc( aValue );
                    if ( elNr >=1 ) and ( elNr <= MainForm.aTriwacoGrid.NrOfElements ) then begin
//                      Inc( iCellCount );

                      //WriteToLogFileFmt( 'i=%d j=%d Mv=%f elNr', [i,j,Mv,elNr] );
                      MainForm.GwsESRIgrid[ i, j ] := Mv -
                          MainForm.aTriwacoGrid.GetInterpolatedValue( ElNr, ExactLocation );
                    end; {-if}
                  end; {-if}
                end; {-for j}
          end; {-for i}
        end; {-with}

        iResult := MainForm.GwsESRIgrid.SaveAs( 'd:\tmp\gws' );
        WriteToLogFileFMT ('SaveAs iResult= %d', [iResult] );
        MainForm.GwsESRIgrid.ExportToASC(  ParamStr(5)+ '.asc' );

  //Application.Run;

end.
