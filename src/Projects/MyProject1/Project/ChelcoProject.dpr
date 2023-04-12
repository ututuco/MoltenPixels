program ChelcoProject;

{$R *.res}

{$R *.dres}

uses
  Chelco.App in '..\Common\Chelco.App.pas',
  App in 'App.pas',
  Chelco.Classes in '..\Common\Chelco.Classes.pas',
  Unit1 in 'Unit1.pas' {Form1},
  Chelco.Common in '..\Common\Chelco.Common.pas',
  Chelco.Platform in '..\Common\Chelco.Platform.pas';

begin
  RunApp(TChelcoApp, 800, 600, 'App Title');
end.
