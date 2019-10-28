// 2017-03-31 - RicardoVoigt

unit uUFClass;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TUF }

  TUF = class
  private
    FDivisas: array of String;
    FPonto: TPoint;
    FSigla: String;
    procedure criaDivisas;
    procedure criaPontoXY;
  public
    property Sigla: String read FSigla write FSigla;
    property Ponto: TPoint read FPonto;
    function FazDivisaCom(Auf: String): Boolean;
    constructor Create(ASigla: String);
    destructor Destroy; override;
  end;

  TListaUF = array of TUF;


implementation

{ TUF }

procedure TUF.criaDivisas;
begin

  // monta a lista das divisas da respectiva UF
  setLength(FDivisas,0);

  if FSigla = 'AC' then
  begin
    setLength(FDivisas, 2);
    FDivisas[ 0 ] := 'AM';
    FDivisas[ 1 ] := 'RO';
  end
  else
  if FSigla = 'AL' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'PE';
    FDivisas[ 1 ] := 'BA';
    FDivisas[ 2 ] := 'SE';
  end
  else
  if FSigla = 'AM' then
  begin
    setLength(FDivisas, 5);
    FDivisas[ 0 ] := 'AC';
    FDivisas[ 1 ] := 'RO';
    FDivisas[ 2 ] := 'RR';
    FDivisas[ 3 ] := 'MT';
    FDivisas[ 4 ] := 'PA';
  end
  else
  if FSigla = 'AP' then
  begin
    setLength(FDivisas, 1);
    FDivisas[ 0 ] := 'PA';
  end
  else
  if FSigla = 'BA' then
  begin
    setLength(FDivisas, 8);
    FDivisas[ 0 ] := 'ES';
    FDivisas[ 1 ] := 'MG';
    FDivisas[ 2 ] := 'GO';
    FDivisas[ 3 ] := 'TO';
    FDivisas[ 4 ] := 'PI';
    FDivisas[ 5 ] := 'PE';
    FDivisas[ 6 ] := 'AL';
    FDivisas[ 7 ] := 'SE';
  end
  else
  if FSigla = 'CE' then
  begin
    setLength(FDivisas, 4);
    FDivisas[ 0 ] := 'PI';
    FDivisas[ 1 ] := 'PE';
    FDivisas[ 2 ] := 'PB';
    FDivisas[ 3 ] := 'RN';
  end
  else
  if FSigla = 'DF' then
  begin
    setLength(FDivisas, 1);
    FDivisas[ 0 ] := 'GO';
  end
  else
  if FSigla = 'ES' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'RJ';
    FDivisas[ 1 ] := 'MG';
    FDivisas[ 2 ] := 'BA';
  end
  else
  if FSigla = 'GO' then
  begin
    setLength(FDivisas, 6);
    FDivisas[ 0 ] := 'MT';
    FDivisas[ 1 ] := 'MS';
    FDivisas[ 2 ] := 'MG';
    FDivisas[ 3 ] := 'BA';
    FDivisas[ 4 ] := 'TO';
    FDivisas[ 5 ] := 'DF';
  end
  else
  if FSigla = 'MA' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'PA';
    FDivisas[ 1 ] := 'TO';
    FDivisas[ 2 ] := 'PI';
  end
  else
  if FSigla = 'MG' then
  begin
    setLength(FDivisas, 6);
    FDivisas[ 0 ] := 'ES';
    FDivisas[ 1 ] := 'RJ';
    FDivisas[ 2 ] := 'SP';
    FDivisas[ 3 ] := 'MS';
    FDivisas[ 4 ] := 'GO';
    FDivisas[ 5 ] := 'BA';
  end
  else
  if FSigla = 'MT' then
  begin
    setLength(FDivisas, 6);
    FDivisas[ 0 ] := 'RO';
    FDivisas[ 1 ] := 'AM';
    FDivisas[ 2 ] := 'PA';
    FDivisas[ 3 ] := 'TO';
    FDivisas[ 4 ] := 'GO';
    FDivisas[ 5 ] := 'MS';
  end
  else
  if FSigla = 'MS' then
  begin
    setLength(FDivisas, 5);
    FDivisas[ 0 ] := 'PR';
    FDivisas[ 1 ] := 'SP';
    FDivisas[ 2 ] := 'MG';
    FDivisas[ 3 ] := 'GO';
    FDivisas[ 4 ] := 'MT';
  end
  else
  if FSigla = 'PA' then
  begin
    setLength(FDivisas, 6);
    FDivisas[ 0 ] := 'RR';
    FDivisas[ 1 ] := 'AM';
    FDivisas[ 2 ] := 'MT';
    FDivisas[ 3 ] := 'TO';
    FDivisas[ 4 ] := 'MA';
    FDivisas[ 5 ] := 'AP';
  end
  else
  if FSigla = 'PE' then
  begin
    setLength(FDivisas, 5);
    FDivisas[ 0 ] := 'PB';
    FDivisas[ 1 ] := 'CE';
    FDivisas[ 2 ] := 'PI';
    FDivisas[ 3 ] := 'BA';
    FDivisas[ 4 ] := 'AL';
  end
  else
  if FSigla = 'PI' then
  begin
    setLength(FDivisas, 5);
    FDivisas[ 0 ] := 'MA';
    FDivisas[ 1 ] := 'TO';
    FDivisas[ 2 ] := 'BA';
    FDivisas[ 3 ] := 'PE';
    FDivisas[ 4 ] := 'CE';
  end
  else
  if FSigla = 'PB' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'RN';
    FDivisas[ 1 ] := 'CE';
    FDivisas[ 2 ] := 'PE';
  end
  else
  if FSigla = 'PR' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'SC';
    FDivisas[ 1 ] := 'SP';
    FDivisas[ 2 ] := 'MS';
  end
  else
  if FSigla = 'RJ' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'SP';
    FDivisas[ 1 ] := 'MG';
    FDivisas[ 2 ] := 'ES';
  end
  else
  if FSigla = 'RN' then
  begin
    setLength(FDivisas, 2);
    FDivisas[ 0 ] := 'CE';
    FDivisas[ 1 ] := 'PB';
  end
  else
  if FSigla = 'RO' then
  begin
    setLength(FDivisas, 3);
    FDivisas[ 0 ] := 'AM';
    FDivisas[ 1 ] := 'MT';
    FDivisas[ 2 ] := 'AC';
  end
  else
  if FSigla = 'RR' then
  begin
    setLength(FDivisas, 2);
    FDivisas[ 0 ] := 'AM';
    FDivisas[ 1 ] := 'PA';
  end
  else
  if FSigla = 'RS' then
  begin
    setLength(FDivisas, 1);
    FDivisas[ 0 ] := 'SC';
  end
  else
  if FSigla = 'SC' then
  begin
    setLength(FDivisas, 2);
    FDivisas[ 0 ] := 'RS';
    FDivisas[ 1 ] := 'PR';
  end
  else
  if FSigla = 'SE' then
  begin
    setLength(FDivisas, 2);
    FDivisas[ 0 ] := 'AL';
    FDivisas[ 1 ] := 'BA';
  end
  else
  if FSigla = 'SP' then
  begin
    setLength(FDivisas, 4);
    FDivisas[ 0 ] := 'PR';
    FDivisas[ 1 ] := 'MS';
    FDivisas[ 2 ] := 'MG';
    FDivisas[ 3 ] := 'RJ';
  end
  else
  if FSigla = 'TO' then
  begin
    setLength(FDivisas, 6);
    FDivisas[ 0 ] := 'PA';
    FDivisas[ 1 ] := 'MT';
    FDivisas[ 2 ] := 'GO';
    FDivisas[ 3 ] := 'BA';
    FDivisas[ 4 ] := 'PI';
    FDivisas[ 5 ] := 'MA';
  end;

end;

procedure TUF.criaPontoXY;
begin

  if FSigla = 'AC' then
  begin
    FPonto.x := 60;
    FPonto.y := 220;
  end
  else
  if FSigla = 'AL' then
  begin
    FPonto.x := 590;
    FPonto.y := 235;
  end
  else
  if FSigla = 'AM' then
  begin
    FPonto.x := 160;
    FPonto.y := 140;
  end
  else
  if FSigla = 'AP' then
  begin
    FPonto.x := 340;
    FPonto.y := 60;
  end
  else
  if FSigla = 'BA' then
  begin
    FPonto.x := 490;
    FPonto.y := 270;
  end
  else
  if FSigla = 'CE' then
  begin
    FPonto.x := 530;
    FPonto.y := 150;
  end
  else
  if FSigla = 'DF' then
  begin
    FPonto.x := 400;
    FPonto.y := 300;
  end
  else
  if FSigla = 'ES' then
  begin
    FPonto.x := 510;
    FPonto.y := 400;
  end
  else
  if FSigla = 'GO' then
  begin
    FPonto.x := 360;
    FPonto.y := 340;
  end
  else
  if FSigla = 'MA' then
  begin
    FPonto.x := 440;
    FPonto.y := 150;
  end
  else
  if FSigla = 'MG' then
  begin
    FPonto.x := 445;
    FPonto.y := 360;
  end
  else
  if FSigla = 'MS' then
  begin
    FPonto.x := 290;
    FPonto.y := 380;
  end
  else
  if FSigla = 'MT' then
  begin
    FPonto.x := 270;
    FPonto.y := 270;
  end
  else
  if FSigla = 'PA' then
  begin
    FPonto.x := 330;
    FPonto.y := 160;
  end
  else
  if FSigla = 'PE' then
  begin
    FPonto.x := 580;
    FPonto.y := 210;
  end
  else
  if FSigla = 'PI' then
  begin
    FPonto.x := 470;
    FPonto.y := 200;
  end
  else
  if FSigla = 'PB' then
  begin
    FPonto.x := 580;
    FPonto.y := 190;
  end
  else
  if FSigla = 'PR' then
  begin
    FPonto.x := 340;
    FPonto.y := 450;
  end
  else
  if FSigla = 'RJ' then
  begin
    FPonto.x := 490;
    FPonto.y := 430;
  end
  else
  if FSigla = 'RN' then
  begin
    FPonto.x := 575;
    FPonto.y := 170;
  end
  else
  if FSigla = 'RO' then
  begin
    FPonto.x := 160;
    FPonto.y := 250;
  end
  else
  if FSigla = 'RR' then
  begin
    FPonto.x := 190;
    FPonto.y := 40;
  end
  else
  if FSigla = 'RS' then
  begin
    FPonto.x := 320;
    FPonto.y := 530;
  end
  else
  if FSigla = 'SC' then
  begin
    FPonto.x := 350;
    FPonto.y := 490;
  end
  else
  if FSigla = 'SE' then
  begin
    FPonto.x := 570;
    FPonto.y := 255;
  end
  else
  if FSigla = 'SP' then
  begin
    FPonto.x := 380;
    FPonto.y := 410;
  end
  else
  if FSigla = 'TO' then
  begin
    FPonto.x := 390;
    FPonto.y := 240;
  end;

end;

function TUF.FazDivisaCom(Auf: String): Boolean;
var
  i : Integer;
begin
  Result := False;
  i := low(FDivisas);
  while (i <= high(FDivisas)) and (not Result) do
  begin
    if FDivisas[i] = Auf then
    begin
      Result := True;
    end
    else
    begin
      inc(i);
    end;
  end;
end;

constructor TUF.Create(ASigla: String);
begin
  FSigla := ASigla;
  criaPontoXY;
  criaDivisas;
end;

destructor TUF.Destroy;
begin
  setLength(FDivisas,0);
  inherited Destroy;
end;

end.

