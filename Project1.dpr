program Project1;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  SitemasPedido in 'SitemasPedido.pas' {Sistema};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Aqua Light Slate');
  Application.CreateForm(TSistema, Sistema);
  Application.CreateForm(TSistema, Sistema);
  Application.Run;
end.
