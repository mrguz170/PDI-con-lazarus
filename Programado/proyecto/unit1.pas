unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ExtDlgs, LCLintf, ComCtrls, StdCtrls, Buttons, math;

type

  { TForm1 }

  //tipos propios definidos
  MATRGB=Array of Array of Array of Byte;

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
  private

  public
    procedure grises (var M:MATRGB);
    procedure grises_prom(var M:MATRGB);
  end;

var
  Form1: TForm1;
  BM            : Tbitmap;
  MAT, Maux   : MATRGB;
  ALTO, ANCHO   : Integer;

implementation
uses unit2;
{$R *.lfm}

{ TForm1 }

//procedimientos propios
procedure tform1.grises(var M:MATRGB);
var
  i,j : Integer;
  k   : Byte;
begin
  Label1.Caption := 'Gris por canal';
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      M[i,j,1]:=M[i,j,0];
      M[i,j,2]:=M[i,j,0];

      BM.Canvas.Pixels[i,j]:= RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);

    end;
  end;
  Image1.Picture.Assign(BM);
end;

procedure tform1.grises_prom(var M:MATRGB);
var
  i,j,k  : Integer;
  sum,d  : Integer;
  x,y,z  : Integer;

begin
  d:=3;
  Label1.Caption := 'Gris por promedio';
     for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin

            x := getRvalue(M[i,j,0]);
            y := getGvalue(M[i,j,1]);
            z := getBvalue(M[i,j,2]);

            sum := (x+y+z);

            M[i,j,0] := sum;
            M[i,j,1] := sum;
            M[i,j,2] := sum;

            BM.Canvas.Pixels[i,j]:= RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
        end;
    end;
     //refresh img
  Image1.Picture.Assign(BM);

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
var
  i,j,k   : Integer;
  c     :Tcolor;     //puede ser Tcolor o Integer
begin
  //abrir imagen
  if (OpenPictureDialog1.Execute) then
  begin

    ScrollBox1.Enabled:=True;
    //asignar archivo a BM
    BM.LoadFromFile(OpenPictureDialog1.FileName);
    if (BM.PixelFormat<>pf24bit) then
    begin
    BM.PixelFormat:=pf24bit;
    end;

    Image1.Picture.Assign(BM);

    ALTO:=BM.Height;
    ANCHO:=BM.Width;

    //crear arreglo 3D RGB de ALTOxANCHOx3
    setlength(MAT,ANCHO,ALTO,3);
    setlength(Maux,ANCHO,ALTO,3);

    //leer y copiar RGB de imagen a MAT y MATaux
    for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1 do begin
        c:=BM.Canvas.Pixels[i,j];
        MAT[i,j,0]:=GetRvalue(c);
        MAT[i,j,1]:=GetGvalue(c);
        MAT[i,j,2]:=GetBvalue(c);

        Maux[i,j,0]:=GetRvalue(c);
        Maux[i,j,1]:=GetGvalue(c);
        Maux[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i

  end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
var
i,j : Integer;
k   : Byte;

begin

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      for k:=0 to 2 do begin
        MAT[i,j,k]:=255-MAT[i,j,k];
       // MAT[i,j,k]:=not(MAT[i,j,k]);
      end;
      BM.Canvas.Pixels[i,j]:=RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);

    end; //i
  end;  //j

 //visualizar resultado
 Image1.Picture.Assign(BM);
end;


procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  grises(MAT);

end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  grises_prom(MAT);
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  form2.TrackBar1.Position:=form2.TrackBar1.Min;
  form2.param:=form2.TrackBar1.Position;
  form2.Label1.Caption:=inttostr(form2.param);
  form2.showmodal;

  if Form2.ModalResult=MROK then begin
     //ShowMessage('el valor del parámetro + 5 es: ' + inttostr(form2.param+5));
     form2.param := form2.param;

  end;
end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  BM:=Tbitmap.Create;

end;

//Reload imagen a traves de una matriz auxiliar guardada al abrir la imagen
procedure TForm1.Button1Click(Sender: TObject);
var
i,j :Integer;
begin

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      BM.Canvas.Pixels[i,j]:= RGB(Maux[i,j,0],Maux[i,j,1],Maux[i,j,2]);
      MAT[i,j,0]:=Maux[i,j,0];
      MAT[i,j,1]:=Maux[i,j,1];
      MAT[i,j,2]:=Maux[i,j,2];

    end;
  end;

  //BM.Canvas.Pixels[i,j]:=RGB(MATaux[i,j,0],MATaux[i,j,1],MATaux[i,j,2]);
  Image1.Picture.Assign(BM);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  BM.Destroy;

end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

  //cordenada X,Y cuando el mouse está sobre la imagen
  StatusBar1.Panels[1].Text:=Inttostr(X);
  StatusBar1.Panels[2].Text:=Inttostr(Y);

  //Combinación RGB respecto a la coordenada
  StatusBar1.Panels[4].Text:=Inttostr(MAT[X,Y,0]);
  StatusBar1.Panels[5].Text:=Inttostr(MAT[X,Y,1]);
  StatusBar1.Panels[6].Text:=Inttostr(MAT[X,Y,2]);



end;

procedure TForm1.MenuItem13Click(Sender: TObject);
var
i,j :Integer;
k   :byte;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      for k:=0 to 2 do begin
          MAT[i,j,k]:=round(ln(MAT[i,j,k]+1)/ln(256) * 255);

      end;
      BM.Canvas.Pixels[i,j] := RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
    end;
  end;
  Image1.Picture.Assign(BM);
end;

end.

