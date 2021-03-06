unit untMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ACBrNFe, StdCtrls, ExtCtrls, Grids;

type
  TfrmMenu = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ACBrNFe1: TACBrNFe;
    StringGrid1: TStringGrid;
    StaticText1: TStaticText;
    Panel1: TPanel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    StaticText2: TStaticText;
    StringGrid2: TStringGrid;
    StaticText3: TStaticText;
    StringGrid3: TStringGrid;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure carregaCabecalho;
    procedure carregaItens;
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses pcnNFe;

{$R *.dfm}

procedure TfrmMenu.Button1Click(Sender: TObject);
begin
   if OpenDialog1.Execute then
   begin
      ACBrNFe1.NotasFiscais.Clear;
      Acbrnfe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);
      carregaCabecalho;
      carregaItens;
   end;
end;

procedure TfrmMenu.carregaCabecalho;
var
   i: integer;
begin
   //carrega o emitente;
   StringGrid1.Cells[0,0] := 'CNPJ';
   StringGrid1.Cells[1,0] := 'Nome';
   StringGrid1.Cells[2,0] := 'Fantasia';
   StringGrid1.Cells[3,0] := 'Insc. Estadual';
   StringGrid1.Cells[0,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.CNPJCPF;
   StringGrid1.Cells[1,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.xNome;
   StringGrid1.Cells[2,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.xFant;
   StringGrid1.Cells[3,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Emit.IE;

   //carrega o destinatario;
   StringGrid2.Cells[0,0] := 'CNPJ';
   StringGrid2.Cells[1,0] := 'Nome';
   StringGrid2.Cells[2,0] := 'e-mail';
   StringGrid2.Cells[3,0] := 'Insc. Estadual';
   StringGrid2.Cells[0,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.CNPJCPF;
   StringGrid2.Cells[1,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.xNome;
   StringGrid2.Cells[2,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.Email;
   StringGrid2.Cells[3,1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Dest.IE;
end;

procedure TfrmMenu.carregaItens;
var
   i: integer;
begin
   StringGrid3.Cells[0,0] := 'C�digo';
   StringGrid3.Cells[1,0] := 'Descricao';
   StringGrid3.Cells[2,0] := 'Unidade';
   StringGrid3.Cells[3,0] := 'Valor Total';
   Stringgrid3.RowCount := ACBrNFe1.NotasFiscais.Items[0].NFe.Det.Count+1;
   for i := 0 to ACBrNFe1.NotasFiscais.Items[0].NFe.Det.Count - 1 do
   begin
      StringGrid3.Cells[0,i+1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Det[i].Prod.cProd;
      StringGrid3.Cells[1,i+1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Det[i].Prod.xProd;
      StringGrid3.Cells[2,i+1] := ACBrNFe1.NotasFiscais.Items[0].NFe.Det[i].Prod.uCom;
      StringGrid3.Cells[3,i+1] := FormatFloat('###,###,###0.0000', ACBrNFe1.NotasFiscais.Items[0].NFe.Det[i].Prod.vUnCom);
   end;
end;

end.
