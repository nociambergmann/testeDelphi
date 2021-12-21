unit frmClientePedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, event, Vcl.DBGrids,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,conect,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.Mask;

type
  TClientePedidos = class(TForm)
    pnlCliente: TPanel;
    lbCodigo: TLabel;
    edCodigo: TEdit;
    Panel2: TPanel;
    stName: TStaticText;
    gbPedidos: TGroupBox;
    btnBuscaReceita: TBitBtn;
    lbCodPedido: TLabel;
    edCodProduto: TEdit;
    edQtde: TEdit;
    lbQtde: TLabel;
    lbValor: TLabel;
    ListView1: TListView;
    edValor: TEdit;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    stTotal: TStaticText;
    btCarrega: TBitBtn;
    stPedido: TStaticText;
    btExcluir: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnBuscaReceitaClick(Sender: TObject);
    procedure edCodProdutoExit(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure ListView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn3Click(Sender: TObject);
    procedure btCarregaClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
  private
    FOnShow            : TOnShow;
    fOnCodigoExit      : TOnExit;
    fOnCodigoExitProdt : TOnExit;
    fOnInserir         : TOnButtonClick;
    fOnCarrega         : TOnButtonClick;
    fOnExcluir         : TOnButtonClick;
    fOnGravar          : TOnButtonClick;
    fOnLimpa           : TOnButtonClick;
    fOnKeyPress        : TOnKeyPress;
  public
    property OnShow             : TOnShow        read FOnShow            write FOnShow;
    property OnCodigoExit       : TOnExit        read fOnCodigoExit      write fOnCodigoExit;
    property OnCodigoExitProdt  : TOnExit        read fOnCodigoExitProdt write fOnCodigoExitProdt;
    property OnInserir          : TOnButtonClick read fOnInserir         write fOnInserir;
    property OnCarrega          : TOnButtonClick read fOnCarrega         write fOnCarrega;
    property OnExcluir          : TOnButtonClick read fOnExcluir         write fOnExcluir;
    property OnGravar           : TOnButtonClick read fOnGravar          write fOnGravar;
    property OnLimpa            : TOnButtonClick read fOnLimpa           write fOnLimpa;
    property OnKeyPress         : TOnKeyPress    read fOnKeyPress        write fOnKeyPress;
  end;

var
  ClientePedidos: TClientePedidos;

implementation

{$R *.dfm}

procedure TClientePedidos.BitBtn3Click(Sender: TObject);
begin
 if   Assigned(fOnGravar) then
       OnGravar;
end;

procedure TClientePedidos.btExcluirClick(Sender: TObject);
begin
 if   Assigned(fOnExcluir) then
       OnExcluir;
end;

procedure TClientePedidos.btCarregaClick(Sender: TObject);
begin
 if   Assigned(fOnCarrega) then
       OnCarrega;
end;

procedure TClientePedidos.btnBuscaReceitaClick(Sender: TObject);
begin
 if   Assigned(fOnInserir) then
       OnInserir;
end;

procedure TClientePedidos.btnLimparClick(Sender: TObject);
begin
  if   Assigned(fOnLimpa) then
       OnLimpa;
end;

procedure TClientePedidos.btnSairClick(Sender: TObject);
begin
   close;
end;

procedure TClientePedidos.edCodigoExit(Sender: TObject);
begin
  if   Assigned(fOnCodigoExit) then
       OnCodigoExit(StrToIntDef(edCodigo.Text,0));
end;

procedure TClientePedidos.edCodProdutoExit(Sender: TObject);
begin
  if   Assigned(fOnCodigoExitProdt) then
       OnCodigoExitProdt(StrToIntDef(edCodProduto.Text,0));
end;

procedure TClientePedidos.FormShow(Sender: TObject);
begin
  if   Assigned(FOnShow) then
       OnShow;
end;

procedure TClientePedidos.ListView1KeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
 if   Assigned(fOnKeyPress) Then
      OnKeyPress(Key);
end;

end.
