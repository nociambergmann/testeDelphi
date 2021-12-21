unit USistemaPedido;

interface
  uses Classes,
       Forms,
       frmClientePedido,
       Dialogs,
       FireDAC.Comp.Client,
       FireDAC.Stan.Param,
       Cliente,
       Controls,
       Winapi.Windows,
       Produtos,
       Vcl.ComCtrls,
       Vcl.StdCtrls,
       SysUtils,
       event,
       DB,
       conect,
       System.Generics.Collections
       ;

  type
    TCli           = TObjectList<TCliente>;
    TProdut        = TObjectList<TProdutos>;

    TUSistemaPedido= class(TClientePedidos)
    private
      FListaCliente  : TCli;
      FListaProdutos : TProdut;
      FEnumCliente   : TEnumerator<TCliente>;
      FEnumProduto   : TEnumerator<TProdutos>;
      FQuery         : TQuery;

      procedure plOnShow;
      procedure plCarregaListaCliente;
      procedure plCarregaProdutos;
      procedure plInserePedido;
      procedure plLimpa;
      procedure plOnKeyPress(var key : Word);
      procedure plAltera;
      procedure plExclui;
      procedure plGravar;
      procedure plCarrega;
      procedure plExcluir;

      function plValidaCliente(const codigo:integer):boolean;
      function plValidaProduto(const codigo:integer):boolean;
      function plRetornaDescProduto(const codigo:integer):String;
      function flOnExit(const cInt : Integer) : String;
      function flOnExitProdut(const cInt : Integer) : String;
      function flSomaClick:Double;
      function flOnCarregaPedido(const cInt : Integer) : String;
      function flOnExcluirPedido(const cInt : Integer) : String;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
  end;

  Procedure ChamaTela_Pedido;
implementation

procedure  ChamaTela_Pedido;
var loPedido: TUSistemaPedido;
begin
  loPedido:= TUSistemaPedido.Create(Application);
  try
    loPedido.ShowModal;
    loPedido.WindowState   := wsMaximized;
    loPedido.BringToFront;
  except
    loPedido.Release;// = Free, todos os eventos, metodos do formulario seja executado e finaliazado antes que o formulário seja liberado
  end;
end;

constructor TUSistemaPedido.Create(AOwner: TComponent);
begin
  inherited;
  FQuery            := tQuery.Create(AOwner);

  OnShow            := plOnShow;
  OnCodigoExit      := flOnExit;
  OnCodigoExitProdt := flOnExitProdut;
  OnInserir         := plInserePedido;
  OnLimpa           := plLimpa;
  OnKeyPress        := plOnKeyPress;
  OnGravar          := plGravar;
  OnCarrega         := plCarrega;
  OnExcluir         := plExcluir;

  FListaCliente     := TCli.Create();
  FListaProdutos    := TProdut.Create();
end;

destructor TUSistemaPedido.Destroy;
begin
  FListaCliente.Free;
  FListaProdutos.Free;
  FQuery.Free;

  inherited;
end;

function TUSistemaPedido.flOnExit(const cInt: Integer): String;
begin
   try
     stName.caption:=EmptyStr;

     if  (cInt <> 0) then
         begin
           if not plValidaCliente(cInt) then
               raise Exception.Create('Código de cliente inexistente.');

           stName.caption:= FEnumCliente.Current.Nome +'\'+
                            FEnumCliente.Current.Cidade+'\'+
                            FEnumCliente.Current.UF ;
         end;

     gbPedidos.Enabled  := True;
     ListView1.Enabled  := True;
     pnlCliente.Enabled := False;
     btCarrega.Enabled  := edCodigo.Text = EmptyStr;
     btExcluir.Enabled  := edCodigo.Text = EmptyStr;
   Except
    on e:Exception do
       ShowMessage(e.Message);
   End;
end;

function TUSistemaPedido.flOnExitProdut(const cInt: Integer): String;
begin
   try
     if  (cInt <> 0) then
         begin
           if not plValidaProduto(cInt) then
               raise Exception.Create('Código de produto não cadastrado.');

           edValor.Text := FormatFloat('#0.00', FEnumProduto.Current.Preco_Venda);
         end;
   Except
    on e:Exception do
       ShowMessage(e.Message);
   End;
end;

function TUSistemaPedido.flSomaClick: Double;
var i : integer;
begin
  Result:=0;
  for i := 0 to ListView1.Items.Count - 1 do begin
    Result := Result + StrToFloatDef( ListView1.Items[ i ].SubItems[3], 0 );
  end
end;

procedure TUSistemaPedido.plCarrega;
var loPedido: TQuery;
begin
  loPedido:= TQuery.Create(Application);
  try
    loPedido.OnCodigoExit  := flOnCarregaPedido;
    loPedido.ShowModal;
    loPedido.WindowState   := wsMaximized;
    loPedido.BringToFront;
  except
    loPedido.Release;// = Free, todos os eventos, metodos do formulario seja executado e finaliazado antes que o formulário seja liberado
  end;
end;

procedure TUSistemaPedido.plCarregaListaCliente;
begin
  if  FQuery.Query.Active then
      FQuery.Query.Close;

  FQuery.Query.SQL.Clear;
  FQuery.Query.SQL.Add('SELECT * FROM CLIENTES');
  FQuery.Query.Open;
  while not FQuery.Query.Eof do
       begin
         FListaCliente.Add(TCliente.Create(FQuery.Query.FieldByName('Codigo').AsInteger,
                                           FQuery.Query.FieldByName('Nome').AsString,
                                           FQuery.Query.FieldByName('Cidade').AsString,
                                           FQuery.Query.FieldByName('UF').AsString)
                          );
         FQuery.Query.Next;
       end;

  FQuery.Query.Close;
end;

procedure TUSistemaPedido.plCarregaProdutos;
begin
  if  FQuery.Query.Active then
      FQuery.Query.Close;

  FQuery.Query.SQL.Clear;
  FQuery.Query.SQL.Add('SELECT * FROM PRODUTOS');
  FQuery.Query.Open;
  while not FQuery.Query.Eof do
       begin
         FListaProdutos.Add(TProdutos.Create(FQuery.Query.FieldByName('Codigo').AsInteger,
                                             FQuery.Query.FieldByName('Descricao').AsString,
                                             FQuery.Query.FieldByName('Preco_Venda').AsFloat)
                            );
         FQuery.Query.Next;
       end;

  FQuery.Query.Close;
end;

procedure TUSistemaPedido.plExclui;
begin
  if  (Listview1.ItemIndex <> -1)
  and (MessageDlg('Você tem certeza que deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      Listview1.DeleteSelected
end;

procedure TUSistemaPedido.plGravar;
var i,
    Numero_Pedido: integer;
begin
  try
    if   ListView1.Items.Count <= 0 then
         raise Exception.Create('Não a itens no pedido.');

    if  not FQuery.FDConnection1.InTransaction then
        FQuery.FDConnection1.StartTransaction;

    FQuery.Query.Close;
    FQuery.Query.SQL.Clear;
    FQuery.Query.SQL.Text:= 'insert into PEDIDOS_DADOS_GERAIS (Data_Emissao, Codigo_Cliente, Valor_Total) values (:Data_Emissao, :Codigo_Cliente,:Valor_Total)';
    FQuery.Query.ParamByName('Data_Emissao').AsDate      := trunc(now);
    FQuery.Query.ParamByName('Codigo_Cliente').AsInteger := StrToInt(edCodigo.Text);
    FQuery.Query.ParamByName('Valor_Total').AsFloat    := StrToFloat(stTotal.Caption);
    FQuery.Query.Execute;

    FQuery.Query.Close;
    FQuery.Query.SQL.Clear;
    FQuery.Query.SQL.Add('SELECT (last_insert_id()) VALOR from PEDIDOS_DADOS_GERAIS limit 1');
    FQuery.Query.Open;

    if not FQuery.Query.IsEmpty then
       Numero_Pedido:= FQuery.Query.FieldByName('VALOR').AsInteger;

    for i := 0 to ListView1.Items.Count - 1 do begin
      FQuery.Query.Close;
      FQuery.Query.SQL.Clear;
      FQuery.Query.SQL.add('insert into PEDIDOS_PRODUTO(Numero_Pedido, Codigo_Produto, Quantidade, Valor_Unit, Valor_Total) ');
      FQuery.Query.SQL.add('values (:Numero_Pedido, :Codigo_Produto, :Quantidade, :Valor_Unit, :Valor_Total)');
      FQuery.Query.ParamByName('Numero_Pedido').AsInteger := Numero_Pedido;
      FQuery.Query.ParamByName('Codigo_Produto').AsInteger := StrToInt(ListView1.Items[ i ].Caption);
      FQuery.Query.ParamByName('Quantidade').AsInteger     := StrToInt(ListView1.Items[ i ].SubItems[1]);
      FQuery.Query.ParamByName('Valor_Unit').AsFloat       := StrToFloat(ListView1.Items[ i ].SubItems[2]);
      FQuery.Query.ParamByName('Valor_Total').AsFloat      := StrToFloat(ListView1.Items[ i ].SubItems[3]);
      FQuery.Query.Execute;
    end;

    FQuery.FDConnection1.Commit;
    ShowMessage('Pedido inserido com sucesso');
    btnLimparClick(nil);
  Except
    on e:Exception do
       begin
         FQuery.FDConnection1.Rollback;
         ShowMessage(e.Message);
       end;
  end;
end;

procedure TUSistemaPedido.plAltera;
begin
  if Listview1.ItemIndex <> -1 then
  begin
    edCodProduto.Text:= Listview1.ItemFocused.Caption;
    edCodProduto.Enabled:= False;

    edQtde.Text  := Listview1.ItemFocused.SubItems[1];
    edValor.Text := Listview1.ItemFocused.SubItems[2];
  end
end;

procedure TUSistemaPedido.plInserePedido;
var
  ListItem: TListItem;
  valor   : double;
  cInt    : Integer;
begin
   try
     cInt:= StrToIntDef(edCodProduto.Text, 0);
     if  (cInt <> 0) then
         begin
           if   edCodProduto.Enabled then
                begin
                  if not plValidaProduto(cInt) then
                      raise Exception.Create('Código de produto não cadastrado.');

                  if StrToIntDef(edQtde.Text, 0) <= 0 then
                     raise Exception.Create('Quantidade informada invalida.');

                  ListItem := ListView1.Items.Add;
                  ListItem.Caption := edCodProduto.Text;
                  ListItem.SubItems.Add(plRetornaDescProduto(StrToInt(edCodProduto.Text)));
                  ListItem.SubItems.Add(edQtde.Text);
                  valor:=StrToFloat(edValor.Text);

                  ListItem.SubItems.Add(FormatFloat('#0.00', valor));
                  ListItem.SubItems.Add(FormatFloat('#0.00', StrToInt(edQtde.Text)* valor));
                end
           else
                begin
                  with ListView1.Items[ListView1.ItemFocused.Index] do
                  begin
                    edCodProduto.Text:= Listview1.ItemFocused.Caption;
                    ListView1.Items[ListView1.ItemFocused.Index].SubItems[1]:= edQtde.Text;

                    valor:=StrToFloat(edValor.Text);
                    ListView1.Items[ListView1.ItemFocused.Index].SubItems[2]:= FormatFloat('#0.00', valor);
                    ListView1.Items[ListView1.ItemFocused.Index].SubItems[3]:= FormatFloat('#0.00', StrToInt(edQtde.Text)* valor);

                    edCodProduto.Enabled:= true;
                  end;
                end;

           edCodProduto.Clear;
           edQtde.Clear;
           edValor.Clear;
           stTotal.caption:= FloatToStr(flSomaClick);
         end;
   Except
    on e:Exception do
       ShowMessage(e.Message);
   End;
end;

procedure TUSistemaPedido.plLimpa;
var i: integer;

begin
  gbPedidos.Enabled  := False;
  ListView1.Enabled  := False;
  pnlCliente.Enabled := True;

  ListView1.Clear;
  stName.Caption := EmptyStr;

  for i := 0 to self.ComponentCount - 1 do
  begin
    if  (Self.Components[i] is TEdit)  then
        TEdit(Self.Components[i]).Text := EmptyStr;
  end;

  btCarrega.Enabled  := edCodigo.Text = EmptyStr;
  btExcluir.Enabled  := edCodigo.Text = EmptyStr;
end;

procedure TUSistemaPedido.plOnKeyPress(var key: Word);
begin
  case Key  of
    VK_RETURN: plAltera;
    VK_DELETE: plExclui;
  end;

  stTotal.caption:= FloatToStr(flSomaClick);
end;

procedure TUSistemaPedido.plOnShow;
begin
  btCarrega.Enabled  := edCodigo.Text = EmptyStr;
  btExcluir.Enabled  := edCodigo.Text = EmptyStr;

   plCarregaListaCliente;
   plCarregaProdutos;
end;

function TUSistemaPedido.plRetornaDescProduto(const codigo: integer): String;
begin
  result:= EmptyStr;
  FEnumProduto := FListaProdutos.GetEnumerator;
  while (result = EmptyStr)
  and   (FEnumProduto.MoveNext) do
        if  FEnumProduto.Current.codigo = codigo then
            result := FEnumProduto.Current.Descricao;
end;

function TUSistemaPedido.plValidaCliente(const codigo:integer):boolean;
begin
  result:= False;
  FEnumCliente := FListaCliente.GetEnumerator;
  while (not result)
  and   (FEnumCliente.MoveNext) do
        result := FEnumCliente.Current.codigo = codigo;
end;

function TUSistemaPedido.plValidaProduto(const codigo: integer): boolean;
begin
  result:= False;
  FEnumProduto := FListaProdutos.GetEnumerator;
  while (not result)
  and   (FEnumProduto.MoveNext) do
        result := FEnumProduto.Current.codigo = codigo;
end;

function TUSistemaPedido.flOnCarregaPedido(const cInt: Integer): String;
var
  ListItem: TListItem;
  valor   : double;
begin
  if  FQuery.Query.Active then
      FQuery.Query.Close;

  FQuery.Query.SQL.Clear;
  FQuery.Query.SQL.Add('SELECT * FROM PEDIDOS_DADOS_GERAIS S WHERE S.NUMERO_PEDIDO = :PEDIDO');
  FQuery.Query.ParamByName('PEDIDO').AsInteger := cInt;
  FQuery.Query.Open;
  if not FQuery.Query.Eof then
     begin
       edCodigo.Text    := IntToStr(FQuery.Query.FieldByName('Codigo_Cliente').AsInteger);
       flOnExit(StrToInt(edCodigo.Text ));
       stPedido.Caption := IntToStr(cInt);
     end;

  FQuery.Query.SQL.Clear;
  FQuery.Query.SQL.Add('SELECT * FROM PEDIDOS_PRODUTO S WHERE S.NUMERO_PEDIDO = :PEDIDO');
  FQuery.Query.ParamByName('PEDIDO').AsInteger := cInt;
  FQuery.Query.Open;
  while not FQuery.Query.Eof do
       begin
         ListView1.Clear;

         ListItem := ListView1.Items.Add;
         ListItem.Caption := IntToStr(FQuery.Query.FieldByName('Codigo_Produto').AsInteger);
         ListItem.SubItems.Add(plRetornaDescProduto(FQuery.Query.FieldByName('Codigo_Produto').AsInteger));
         ListItem.SubItems.Add(IntToStr(FQuery.Query.FieldByName('Quantidade').AsInteger));
         ListItem.SubItems.Add(FormatFloat('#0.00', FQuery.Query.FieldByName('Valor_Unit').AsFloat));
         ListItem.SubItems.Add(FormatFloat('#0.00', FQuery.Query.FieldByName('Valor_Total').AsFloat));

         FQuery.Query.Next;
       end;

  stTotal.caption:= FloatToStr(flSomaClick);
  FQuery.Query.Close;
end;

procedure TUSistemaPedido.plExcluir;
var loPedido: TQuery;
begin
  loPedido:= TQuery.Create(Application);
  try
    loPedido.OnCodigoExit  := flOnExcluirPedido;
    loPedido.ShowModal;
    loPedido.WindowState   := wsMaximized;
    loPedido.BringToFront;
  except
    loPedido.Release;// = Free, todos os eventos, metodos do formulario seja executado e finaliazado antes que o formulário seja liberado
  end;
end;

function TUSistemaPedido.flOnExcluirPedido(const cInt: Integer): String;
begin
  if  (MessageDlg('Você tem certeza que deseja excluir esse pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      try
        if  not FQuery.FDConnection1.InTransaction then
            FQuery.FDConnection1.StartTransaction;

        FQuery.Query.Close;
        FQuery.Query.SQL.Clear;
        FQuery.Query.SQL.Text:= 'delete from PEDIDOS_PRODUTO p where p.Numero_Pedido = :PEDIDO';
        FQuery.Query.ParamByName('PEDIDO').AsInteger := cInt;
        FQuery.Query.Execute;

        FQuery.Query.Close;
        FQuery.Query.SQL.Clear;
        FQuery.Query.SQL.Text:= 'delete from PEDIDOS_DADOS_GERAIS p where p.Numero_Pedido = :PEDIDO';
        FQuery.Query.ParamByName('PEDIDO').AsInteger := cInt;
        FQuery.Query.Execute;

        FQuery.FDConnection1.Commit;
        ShowMessage('Pedido excluido com sucesso');
        btnLimparClick(nil);
      Except
        on e:Exception do
           begin
             FQuery.FDConnection1.Rollback;
             ShowMessage(e.Message);
           end;
      end;
end;

end.
