unit DAO.Aluno;

interface


uses
  Dialogs,
  Rtti,
  Model.Aluno,
  SysUtils,
  bsonUtils,
  mongoWire;

const
  COLLECTION = 'universidade.alunos'; { database e a coleção(tabelas) }

type
  TDAOAluno = class
  public
    procedure Inserir( const AModelCliente: TModelAluno );
    procedure Atualizar( const AModelCliente: TModelAluno );

    procedure Excluir(const AID: Integer);
    function Pesquisar(const ACodigo: Integer): TModelAluno;
    function ListarTodos(): TModelListaAlunos;

    function ToJSON(): string;
  end;

implementation

{ TQueryMongoDB }

uses
  REST.JSON,
  Conn.MongoDB, bsonDoc, mongoID, Variants;

{ TDAOAluno }

procedure TDAOAluno.Atualizar(const AModelCliente: TModelAluno);
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
    Inserir( AModelCliente );
end;

procedure TDAOAluno.Excluir(const AID: Integer);
var
  Document: IBSONDocument;

begin
  Document:= BSON( [ 'codigo', AID ] );

  TConnMongoDB.GetCurrentConnection().Delete( COLLECTION, Document );
end;



procedure TDAOAluno.Inserir(const AModelCliente: TModelAluno);
var
  d: IBSONDocument;
begin
  d:= JsonToBson( TJson.ObjectToJsonString(AModelCliente) );

  TConnMongoDB.GetCurrentConnection().Insert(
    COLLECTION, d);



  {
  TConnMongoDB.GetCurrentConnection().Insert(
    COLLECTION, BSON( [
      'id', mongoObjectId,
      'codigo', AModelCliente.Codigo,
      'nome', AModelCliente.Nome
  ] ) );
  }
end;

function TDAOAluno.ListarTodos: TModelListaAlunos;
var
  WireQuery: TMongoWireQuery;
  Document: IBSONDocument;
  Aluno: TModelAluno;
  Value: TValue;

begin
  Result:= TModelListaAlunos.Create();

  Document:= BSON;

  WireQuery:= TMongoWireQuery.Create( TConnMongoDB.GetCurrentConnection() );
  try
    WireQuery.Query( COLLECTION, Document );

    while WireQuery.Next( Document ) do
    begin
      Aluno:= TModelAluno.Create();

      {
      Value:=  Document[ 'codigo' ];
      if (VarIsOrdinal( Value )) then
        ShowMessage( 'Cardinal' );
      }
      Aluno.Codigo:= StrToInt( VarToStr( Document[ 'codigo' ] ) );

      {
      Value:= Document[ 'nome' ];
      if (VarIsStr( Value )) then
        ShowMessage( 'Str' );
      }
      Aluno.Nome:= VarToStr( Document[ 'nome' ] );

      Result.Add( Aluno );
    end;

  finally
    FreeAndNil( WireQuery );
  end;

end;



function TDAOAluno.Pesquisar(const ACodigo: Integer): TModelAluno;
var
  WireQuery: TMongoWireQuery;
  Document: IBSONDocument;

begin
  Document:= TConnMongoDB.GetCurrentConnection().Get( COLLECTION, BSON(['codigo', ACodigo ]) );
  Result:=  TJson.JsonToObject<TModelAluno>( BSONTOJSON( Document ) );
  (*
  Result:= TModelAluno.Create();
  // {TODO implemetnar o IsEmpty no IBSONDocument }

  if Document <> nil then
  begin
    Result.Codigo:= StrToInt( VarToStr( Document[ 'codigo' ] ) );
    Result.Nome:= VarToStr( Document[ 'nome' ] );
  end else
    Result.Codigo:= 0;

   *)
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
