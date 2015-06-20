program cIRC;

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  cIRC_Data in 'cIRC_Data.pas',
  cIRC_Test in 'cIRC_Test.pas',
  cIRC_Utils in 'cIRC_Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'cIRC';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.