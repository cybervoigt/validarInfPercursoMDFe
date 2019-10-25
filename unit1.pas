// 2017-03-31 - RicardoVoigt
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  CheckLst, Buttons, ExtCtrls, LCLType, uUFClass;

type

  { TForm1 }

  TForm1 = class(TForm)
    BTNUFPRABAIXO: TSpeedButton;
    BTNUFPRACIMA: TSpeedButton;
    CheckListBoxUFPERCURSO: TCheckListBox;
    ComboBoxUFINI: TComboBox;
    ComboBoxUFFIM: TComboBox;
    ImageMAPA: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBoxORDEMPERCURSO: TListBox;
    PanelRESULTADO: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure BTNUFPRABAIXOClick(Sender: TObject);
    procedure BTNUFPRACIMAClick(Sender: TObject);
    procedure CheckListBoxUFPERCURSOItemClick(Sender: TObject; Index: integer);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure clicaNaUFdoMapa(Sender: TObject);
  private
    { private declarations }

    listaUF: TListaUF;

    copiaMapa: TPicture;

  public
    { public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i : Integer;
  labelUF: TLabel;
begin

  // guarda uma copia da imagem original do mapa
  copiaMapa := TPicture.Create;
  copiaMapa.Assign(ImageMAPA.Picture);


  // num vetor a lista das 27 UF do Brasil
  SetLength(listaUF, 27);

  listaUF[ 0] := TUF.Create('AC');
  listaUF[ 1] := TUF.Create('AL');
  listaUF[ 2] := TUF.Create('AM');
  listaUF[ 3] := TUF.Create('AP');
  listaUF[ 4] := TUF.Create('BA');
  listaUF[ 5] := TUF.Create('CE');
  listaUF[ 6] := TUF.Create('DF');
  listaUF[ 7] := TUF.Create('ES');
  listaUF[ 8] := TUF.Create('GO');
  listaUF[ 9] := TUF.Create('MA');
  listaUF[10] := TUF.Create('MG');
  listaUF[11] := TUF.Create('MS');
  listaUF[12] := TUF.Create('MT');
  listaUF[13] := TUF.Create('PA');
  listaUF[14] := TUF.Create('PB');
  listaUF[15] := TUF.Create('PE');
  listaUF[16] := TUF.Create('PI');
  listaUF[17] := TUF.Create('PR');
  listaUF[18] := TUF.Create('RJ');
  listaUF[19] := TUF.Create('RN');
  listaUF[20] := TUF.Create('RO');
  listaUF[21] := TUF.Create('RR');
  listaUF[22] := TUF.Create('RS');
  listaUF[23] := TUF.Create('SC');
  listaUF[24] := TUF.Create('SE');
  listaUF[25] := TUF.Create('SP');
  listaUF[26] := TUF.Create('TO');

  // carrega os componentes da tela (CheckListBox e ComboBox)
  ComboBoxUFINI.Items.Clear;
  ComboBoxUFFIM.Items.Clear;
  CheckListBoxUFPERCURSO.Items.Clear;
  for i:= low(listaUF) to high(listaUF) do
  begin
    ComboBoxUFINI.Items.Add(listaUF[i].Sigla);
    ComboBoxUFFIM.Items.Add(listaUF[i].Sigla);
    CheckListBoxUFPERCURSO.Items.Add(listaUF[i].Sigla);

    labelUF            := TLabel.Create(Self);
    labelUF.Parent     := Self;
    labelUF.Top        := ImageMAPA.Top + listaUF[i].Ponto.y;
    labelUF.Left       := ImageMAPA.Left + listaUF[i].Ponto.x;
    labelUF.Caption    := listaUF[i].Sigla;
    labelUF.Font.Size  := 11;
    labelUF.Font.Style := labelUF.Font.Style + [fsBold];
    labelUF.Tag        := integer(listaUF[i]);
    labelUF.OnClick    := @clicaNaUFdoMapa;
    labelUF.BringToFront;

  end;

  // Sugerindo percurso de testes, do RS até o AC :-)
  ComboBoxUFINI.ItemIndex := 22;
  ComboBoxUFFIM.ItemIndex := 0;

end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
VAR
  ufIni,ufFim,ufAux,ufAux1: TUF;
  i, qtdeUFPercurso: Integer;
  ListaUFPercurso: TStringList;
begin
  // Validações SEM percurso:
  // 1) UF ini e UF fim são iguais
  // -> não deve selecionar nenhuma UF de percurso
  // 2) UF ini e UF fim são diferentes e fazem divisa
  // -> não deve selecionar nenhuma UF de percurso

  // Validações COM percurso:
  // 3) nem UF ini nem UF fim devem estar selecionadas no percurso!
  // 4) a primeira UF da lista deve fazer divisa com a UF inicial (carregamento)
  // 5) entre as UF selecionadas, cada UF deve fazer divisa
  //    com a UF seguinte, na ordem de cima para baixo.
  // 6) a ultima UF da lista deve fazer divisa com a UF final (descarregamento)


  ufIni := TUF.Create(ComboBoxUFINI.Text);
  ufFim := TUF.Create(ComboBoxUFFIM.Text);

  ListaUFPercurso := TStringList.Create;
  try
    ListaUFPercurso.Text := ListBoxORDEMPERCURSO.Items.Text;

    try

      // qtde de UF selecionadas
      qtdeUFPercurso := ListaUFPercurso.Count;

      // 1) UF ini e UF fim são iguais
      if (ufIni.Sigla = ufFim.Sigla) and (qtdeUFPercurso > 0) then
      begin
        raise Exception.Create('Para viagem dentro da mesma UF não é necessária informação do Percurso.');
      end;

      if (ufIni.Sigla <> ufFim.Sigla) then
      begin
        // 2) UF ini(1) e UF fim(2) são diferentes
        //    testa se fazem divisa:

        if ufIni.FazDivisaCom(ufFim.Sigla) then
        begin
          if (qtdeUFPercurso > 0) then
          begin
            raise Exception.Create('A UF inicial ('+ufIni.Sigla+') e UF final ('+ufFim.Sigla+') fazem divisa entre si,'+
              ' NÃO sendo necessário informar o Percurso.');
          end;
        end
        else
        begin
          if (qtdeUFPercurso = 0) then
          begin
            raise Exception.Create('A UF inicial ('+ufIni.Sigla+') e UF final ('+ufFim.Sigla+') NÃO fazem divisa entre si,'+
              ' sendo necessário informar o Percurso.');
          end;
        end;

        // Validações COM percurso:
        if (qtdeUFPercurso > 0) then
        begin

          // 3) nem UF ini nem UF fim devem estar selecionadas no percurso!
          if ListaUFPercurso.IndexOf(ufIni.Sigla) > -1 then
          begin
            raise Exception.Create('UF Inicial (' + ufIni.Sigla + ') não pode ser informada no Percurso.');
          end;
          if ListaUFPercurso.IndexOf(ufFim.Sigla) > -1 then
          begin
            raise Exception.Create('UF Final (' + ufFim.Sigla + ') não pode ser informada no Percurso.');
          end;

          // 4) a primeira UF da lista deve fazer divisa com a UF inicial (carregamento)
          ufAux := TUF.Create(ListaUFPercurso[0]);
          if (not ufIni.FazDivisaCom(ufAux.Sigla)) then
          begin
            raise Exception.Create('A UF inicial (' + ufIni.Sigla + ') NÃO faz divisa com a primeira UF (' + ufAux.Sigla + ') do Percurso.');
          end;

          // 5) entre as UF selecionadas, não pode haver uma UF "ilhada", isto é,
          //    sem fazer divisa com a UF anterior ou com a UF seguinte na ordem.
          for i:= 0 to ListaUFPercurso.Count - 2 do
          begin
            ufAux := TUF.Create(ListaUFPercurso[i]);
            ufAux1 := TUF.Create(ListaUFPercurso[i+1]);
            if (not ufAux.FazDivisaCom(ufAux1.Sigla)) then
            begin
              raise Exception.Create('A UF (' + ufAux.Sigla + ') NÃO faz divisa com a próxima UF (' + ufAux1.Sigla + ') no Percurso.');
            end;

          end;

          // 6) a ultima UF da lista deve fazer divisa com a UF final (descarregamento)
          ufAux := TUF.Create(ListaUFPercurso[ListaUFPercurso.Count-1]);
          if (not ufFim.FazDivisaCom(ufAux.Sigla)) then
          begin
            raise Exception.Create('A UF final (' + ufFim.Sigla + ') NÃO faz divisa com a última UF (' + ufAux.Sigla + ') do Percurso.');
          end;

        end;

      end; // if (ufIni <> ufFim) then


      PanelRESULTADO.Caption := 'O Percurso informado é VÁLIDO !';
      PanelRESULTADO.Font.Color:= clGreen;


      // Faz o desenho no mapa ao lado...

      // Exemplo da estrela:
      //ImageMAPA.Canvas.Pen.Color := clBlue;
      //ImageMAPA.Canvas.Polyline([Point(40, 10), Point(20, 60), Point(70, 30),
      //  Point(10, 30), Point(60, 60), Point(40, 10)]);
      // Fonte:
      // http://docs.embarcadero.com/products/rad_studio/delphiAndcpp2009/HelpUpdate2/EN/html/delphivclwin32/Graphics_TCanvas_Pen.html

      // volta para a imagem original, sem a linha vermelha...
      ImageMAPA.Picture.Clear;
      ImageMAPA.Picture.Assign(copiaMapa);

      // define a configuraçao da linha
      ImageMAPA.Canvas.Pen.Width := 4;
      ImageMAPA.Canvas.Pen.Color := clRed;

      // basicamente, para fazer o percurso no mapa, precisa
      // posicionar no ponto de partida desejado usando MoveTo
      // e fazer a linha com LineTo até o ponto de destino.
      ImageMAPA.Canvas.MoveTo( ufIni.Ponto );
      for i := 0 to ListBoxORDEMPERCURSO.Count-1 do
      begin
        ufAux := TUF.Create(ListBoxORDEMPERCURSO.Items[i]);
        ImageMAPA.Canvas.LineTo( ufAux.Ponto );
        ImageMAPA.Canvas.MoveTo( ufAux.Ponto );
      end;
      ImageMAPA.Canvas.LineTo( ufFim.Ponto );


    except
      on E: Exception do
      begin
        PanelRESULTADO.Caption := E.Message;
        PanelRESULTADO.Font.Color:= clRed;

        // volta para a imagem original, sem a linha vermelha...
        ImageMAPA.Picture.Clear;
        ImageMAPA.Picture.Assign(copiaMapa);
      end;
    end;

  finally
    ListaUFPercurso.Free;
  end;

end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  i : Integer;
begin

  if Application.MessageBox('Confirma Limpar o Percurso selecionado ?',
     'Confirmação', MB_ICONQUESTION + MB_YESNO + MB_DEFBUTTON2) = IDYES then
  begin

    // Limpa as UF selecionadas e ordem definida
    for i:= 0 to CheckListBoxUFPERCURSO.Count-1 do
    begin
      CheckListBoxUFPERCURSO.Checked[i] := False;
    end;
    ListBoxORDEMPERCURSO.Clear;


    // volta a imagem original
    ImageMAPA.Picture.Clear;
    ImageMAPA.Picture.Assign(copiaMapa);

  end;

end;

procedure TForm1.clicaNaUFdoMapa(Sender: TObject);
begin

  if (Sender is TLabel) then
  begin



  end;

end;

procedure TForm1.CheckListBoxUFPERCURSOItemClick(Sender: TObject; Index: integer);
var
  ufclicada: String;
begin
  ufclicada := CheckListBoxUFPERCURSO.Items[Index];

  IF CheckListBoxUFPERCURSO.Checked[Index] then
  begin
    // Adiciona na lista de UF do percurso
    if ListBoxORDEMPERCURSO.Items.IndexOf( ufclicada ) = -1 then
    begin
      ListBoxORDEMPERCURSO.Items.Add( ufclicada );
    end;
  end
  else
  begin
    // Remove na lista de UF do percurso
    if ListBoxORDEMPERCURSO.Items.IndexOf( ufclicada ) > -1 then
    begin
      ListBoxORDEMPERCURSO.Items.Delete( ListBoxORDEMPERCURSO.Items.IndexOf(ufclicada) );
    end;
  end;

end;

procedure TForm1.BTNUFPRACIMAClick(Sender: TObject);
VAR
  indice : Integer;
begin
  // move uma posição para CIMA
  indice := ListBoxORDEMPERCURSO.ItemIndex;
  if indice > 0 then
  begin
    ListBoxORDEMPERCURSO.Items.Insert( indice - 1, ListBoxORDEMPERCURSO.Items[indice]);
    ListBoxORDEMPERCURSO.Items.Delete( indice + 1 );
    ListBoxORDEMPERCURSO.ItemIndex := indice - 1;
  end;
end;

procedure TForm1.BTNUFPRABAIXOClick(Sender: TObject);
var
  indice: Integer;
begin
  // move uma posição para BAIXO
  indice := ListBoxORDEMPERCURSO.ItemIndex;
  if indice < ListBoxORDEMPERCURSO.Count-1 then
  begin
    ListBoxORDEMPERCURSO.Items.Insert( indice+2, ListBoxORDEMPERCURSO.Items[indice]);
    ListBoxORDEMPERCURSO.Items.Delete( indice );
    ListBoxORDEMPERCURSO.ItemIndex := indice+1;
  end;
end;

end.

