unit DAO.Aluno;

interface


uses
  Model.Aluno,
  System.SysUtils,
  bsonUtils,
  mongoWire;

const
  COLLECTION = 'universidade.alunos'; { database e a coleção(tabelas) }

type
  TDAOAluno = class
  public
    procedure Salvar(const AModelCliente: TModelAluno);
    procedure Excluir(const AID: Integer);
    function Pesquisar(const AID: Integer): TModelAluno;
    function ListarTodos(): TModelListaAlunos;

    function ToJSON(): string;
  end;

implementation

{ TQueryMongoDB }

uses Conn.MongoDB, bsonDoc, mongoID, System.Variants;

{ TDAOAluno }

procedure TDAOAluno.Excluir(const AID: Integer);
var
  Document: IBSONDocument;

begin
  Document:= BSON( [ 'codigo', AID ] );

  TConnMongoDB.GetCurrentConnection().Delete( COLLECTION, Document );
end;



function TDAOAluno.ListarTodos: TModelListaAlunos;
var
  WireQuery: TMongoWireQuery;
  Document: IBSONDocument;
  Aluno: TModelAluno;

begin
  Result:= TModelListaAlunos.Create();

  Document:= BSON;

  WireQuery:= TMongoWireQuery.Create( TConnMongoDB.GetCurrentConnection() );
  try
    WireQuery.Query( COLLECTION, Document );

    while WireQuery.Next( Document ) do
    begin
      Aluno:= TModelAluno.Create();

      Aluno.Codigo:= StrToInt( VarToStr( Document[ 'codigo' ] ) );
      Aluno.Nome:= VarToStr( Document[ 'nome' ] );

      Result.Add( Aluno );
    end;

  finally
    FreeAndNil( WireQuery );
  end;

end;



function TDAOAluno.Pesquisar(const AID: Integer): TModelAluno;
var
  WireQuery: TMongoWireQuery;
  Document: IBSONDocument;

begin
  Result:= TModelAluno.Create();
  // {TODO implemetnar o IsEmpty no IBSONDocument }

  Document := BSON( [ 'codigo' , AID ] );
  WireQuery := TMongoWireQuery.Create( TConnMongoDB.GetCurrentConnection( ) );
  try
    WireQuery.Query( COLLECTION ,Document );
    if WireQuery.Next( Document ) then
    begin

      Result.Codigo:= StrToInt( VarToStr( Document[ 'codigo' ] ) );
      Result.Nome:= VarToStr( Document[ 'nome' ] );

    end;
  finally
    FreeAndNil( WireQuery );
  end;

end;



procedure TDAOAluno.Salvar(const AModelCliente: TModelAluno);
var
  Document: IBSONDocument;
  
begin
  Document:= TConnMongoDB.GetCurrentConnection().Get( COLLECTION, BSON(['codigo', AModelCliente.Codigo ]) );
  if ( Document <> nil ) then
    TConnMongoDB.GetCurrentConnection().Update(
      COLLECTION, Document ,
        BSON( [
        'id', Document['id'] ,
        'codigo', AModelCliente.Codigo ,
        'nome', AModelCliente.Nome
      ] ) )
  else
    TConnMongoDB.GetCurrentConnection().Insert(
      COLLECTION, BSON( [
        'id', mongoObjectId,
        'codigo', AModelCliente.Codigo,
        'nome', AModelCliente.Nome
      ] ) );

end;



function TDAOAluno.ToJSON: string;
var
  Document: IBSONDocument;
begin
  {
  Document:= BSON([]);
  Result:= BsonToJson( TConnMongoDB.GetCurrentConnection().Get( COLLECTION, Document ) );
  }
end;

end.
