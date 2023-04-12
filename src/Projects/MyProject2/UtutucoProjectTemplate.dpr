program UtutucoProjectTemplate;

{$R *.res}

{$R *.dres}

uses
  Ututuco.App in '..\..\Common\Ututuco.App.pas',
  Ututuco.Platform in '..\..\Common\Ututuco.Platform.pas',
  App in 'App.pas',
  Ututuco.Classes in '..\..\Common\Ututuco.Classes.pas';

begin
  RunApp(TMyApp, 800, 600, 'Transformations');
end.
