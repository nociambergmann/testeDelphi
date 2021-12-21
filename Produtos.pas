unit Produtos;

interface

  Type
    TProdutos = class
    private
      FCodigo      : Integer;
      FDescricao   : String;
      FPreco_Venda : Double;
    public
      constructor Create(const iCodigo: Integer; const sDescricao : String; dPreco_Venda: Double);
      property Codigo      : Integer read FCodigo      write FCodigo;
      property Descricao   : String  read FDescricao   write FDescricao;
      property Preco_Venda : Double  read FPreco_Venda write FPreco_Venda;
  end;

implementation

constructor TProdutos.Create(const iCodigo: Integer; const sDescricao: String; dPreco_Venda: Double);
begin
  FCodigo      :=  iCodigo;
  FDescricao   :=  sDescricao;
  FPreco_Venda :=  dPreco_Venda;
end;

end.
