program App;

uses
  Vcl.Forms,
  App.Main in '..\src\App.Main.pas' {Form2},
  bsonDoc in '..\src\TMongoWire\bsonDoc.pas',
  bsonUtils in '..\src\TMongoWire\bsonUtils.pas',
  mongoAuth in '..\src\TMongoWire\mongoAuth.pas',
  mongoID in '..\src\TMongoWire\mongoID.pas',
  mongoStream in '..\src\TMongoWire\mongoStream.pas',
  mongoWire in '..\src\TMongoWire\mongoWire.pas',
  VBScript_RegExp_55_TLB in '..\src\TMongoWire\VBScript_RegExp_55_TLB.pas',
  Conn.MongoDB in '..\src\Conn.MongoDB.pas',
  DAO.Aluno in '..\src\DAO.Aluno.pas',
  Model.Aluno in '..\src\Model.Aluno.pas',
  DAO.Base in 'F:\DelphiExemploDAO\fontes\persistencia\DAO.Base.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown:= True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
