unit conect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf, FireDAC.Stan.Def, event,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TQuery = class(TForm)
    DBGrid1: TDBGrid;
    Query: TFDQuery;
    dsSql: TDataSource;
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    gbPedidos: TGroupBox;
    lbCodPedido: TLabel;
    edPedido: TEdit;
    btnBuscaReceita: TBitBtn;
    stName: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure btnBuscaReceitaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    fOnCodigoExit      : TOnExit;

    procedure plSair;
  public
    property OnCodigoExit       : TOnExit        read fOnCodigoExit      write fOnCodigoExit;
  end;

var
  Query: TQuery;

implementation

{$R *.dfm}

{ TQuery }

procedure TQuery.btnBuscaReceitaClick(Sender: TObject);
begin
  if  Query.Active then
      Query.Close;

  Query.SQL.Clear;
  Query.SQL.Add('SELECT * FROM PEDIDOS_DADOS_GERAIS S');
  if  edPedido.Text <> EmptyStr then
      Query.SQL.Add(' WHERE S.NUMERO_PEDIDO = :PEDIDO');

  Query.ParamByName('PEDIDO').AsInteger := StrToInt(edPedido.Text);
  Query.Open;
end;

procedure TQuery.plSair;
begin
  close;
end;

procedure TQuery.DBGrid1DblClick(Sender: TObject);
begin
  if  edPedido.Text <> EmptyStr then
      begin
        if   Assigned(fOnCodigoExit) then
             OnCodigoExit(StrToIntDef(edPedido.Text,0));

        plSair;
      end;
end;

procedure TQuery.FormShow(Sender: TObject);
begin
  if  Query.Active then
      Query.Close;

  Query.SQL.Clear;
  Query.SQL.Add('SELECT * FROM PEDIDOS_DADOS_GERAIS');
  Query.Open;
end;

end.
