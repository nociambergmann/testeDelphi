unit SitemasPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Data.FMTBcd, Data.DB, Data.SqlExpr, Data.Win.ADODB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, USistemaPedido;

  type
    TSistema = class(TForm)
    MainMenu1: TMainMenu;
    Cliente1: TMenuItem;
    procedure Cliente1Click(Sender: TObject);
  private
  public
  end;

var
  Sistema: TSistema;

implementation

{$R *.dfm}

procedure TSistema.Cliente1Click(Sender: TObject);
begin
  ChamaTela_Pedido;
end;

end.
