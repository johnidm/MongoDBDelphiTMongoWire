unit Conn.MongoDB;

interface

uses
  mongoWire, SysUtils;

type
  // Factory para a criação de um objeto que representa a conexão com o servidor MongoDB
  TConnMongoDB = class
    strict private class var MongoWire: TMongoWire;

    strict private class function GetConnection( const AServer: string = 'localhost';
       const APort: Integer = 27017 ): TMongoWire;

    public class procedure CreateConnection();
    public class procedure CloseConnection();

    public class function GetCurrentConnection(): TMongoWire;
    public class function ExistsConnection(): Boolean;
  end;


implementation

{ TConnMongoDB }

class procedure TConnMongoDB.CloseConnection;
begin
  if ( MongoWire <> nil ) then
    FreeAndNil( MongoWire );
end;

class procedure TConnMongoDB.CreateConnection;
begin
  MongoWire:= GetConnection();
end;

class function TConnMongoDB.ExistsConnection: Boolean;
begin
  Result:= ( GetCurrentConnection <> nil );
end;


class function TConnMongoDB.GetConnection(const AServer: string;
  const APort: Integer): TMongoWire;
begin
  if ( ExistsConnection() ) then
    GetCurrentConnection().Close();

  // Cria uma nova conexão
  Result:= TMongoWire.Create();
  Result.Open( AServer, APort );
end;


class function TConnMongoDB.GetCurrentConnection: TMongoWire;
begin
  Result:= MongoWire;
end;

initialization

finalization
  TConnMongoDB.CloseConnection();

end.
