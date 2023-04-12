program MolpixAppTemplate;

{$R *.res}

{$R *.dres}

uses
  Molpix.App in '..\..\Common\Molpix.App.pas',
  Molpix.Platform in '..\..\Common\Molpix.Platform.pas',
  App in 'App.pas',
  Molpix.Classes in '..\..\Common\Molpix.Classes.pas',
  Controller in 'Controller.pas';

begin
  RunApp(TMolpixApp, 800,600,'Title');
end.
