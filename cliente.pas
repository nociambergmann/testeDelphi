unit Cliente;

interface

  Type
    TCliente = class
    private
      Fcodigo : Integer;
      Fnome   : String;
      Fcidade : String;
      Fuf     : String;
    public
      constructor Create(const iCodigo: Integer; const sNome, sCidade, sUF : String);
      property Codigo  : Integer read Fcodigo write Fcodigo;
      property Nome    : String  read Fnome   write Fnome;
      property Cidade  : String  read Fcidade write Fcidade;
      property UF      : String  read Fuf     write Fuf;
  end;

implementation

{ TCliente }

constructor TCliente.Create(const iCodigo: Integer; const sNome, sCidade, sUF: String);
begin
  Fcodigo := iCodigo;
  Fnome   := sNome;
  Fcidade := sCidade;
  Fuf     := sUF;
end;

end.
