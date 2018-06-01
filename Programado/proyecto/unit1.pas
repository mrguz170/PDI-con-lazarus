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
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
  private

  public
    procedure grises(var M:MATRGB);
    procedure grises_prom(var M:MATRGB);
    procedure initR(var M:MATRGB);
    procedure initG(var M:MATRGB);
    procedure initB(var M:MATRGB);
    procedure initI(var M:MATRGB);
    procedure loadMatI(M:MATRGB);
    procedure clsH();
  end;

var
  Form1: TForm1;
  BM            : Tbitmap;
  MAT, MAT_I, Maux     : MATRGB;
  ALTO, ANCHO   : Integer;
  HR            : Array [0..255] of integer;
  HG            : Array [0..255] of integer;
  HB            : Array [0..255] of integer;
  HI            : Array [0..255] of integer;

implementation
uses unit2;
{$R *.lfm}

{ TForm1 }

//procedimientos propios
procedure tform1.grises(var M:MATRGB);
var
  i,j : Integer;
begin
  Label1.Caption := 'Gris por canal';
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      M[i,j,1]:=M[i,j,0];
      M[i,j,2]:=M[i,j,0];

      BM.Canvas.Pixels[i,j]:= RGB(M[i,j,0],M[i,j,1],M[i,j,2]);

    end;
  end;
  Image1.Picture.Assign(BM);
end;

procedure tform1.grises_prom(var M:MATRGB);
var
  i,j  : Integer;
  sum, d  : Integer;
  x,y,z  : Integer;
begin
  d:=3;  //3 por canales RGB
  Label1.Caption := 'Gris por promedio';
     for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin

            x := M[i,j,0];
            y := M[i,j,1];
            z := M[i,j,2];

            sum := (x+y+z)div d;

            M[i,j,0] := sum;
            M[i,j,1] := sum;
            M[i,j,2] := sum;

            BM.Canvas.Pixels[i,j]:= RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
        end;
    end;
     //refresh img
  Image1.Picture.Assign(BM);

end;

// crear paleta de tono ROJO
procedure TForm1.initR(var M:MATRGB);
var
  i,j,yp : Integer;
  MAX    : Integer;
begin
  clsH();
     for i:=0 to Image3.Height-1 do begin
         for j:=0 to image3.Width-1 do begin
             Image3.Canvas.Pixels[j,i]:=RGB(j,0,0);
         end;
     end;

      //inicializar vector de frecuencias
  for i:=0 to 255 do begin
    HR[i]:=0;
  end;

  //calcular frecuencias
  for i:=0 to Ancho-1 do begin
    for j:=0 to Alto-1 do begin
       inc(HR[M[i,j,0]]);
    end;
  end;

  //pintar en Image 2
  //encontrar Maximo
  MAX:=HR[0];
  for i:=1 to 255 do begin
     if (HR[i]>MAX) then begin
        MAX:=HR[i];
     end;
  end;

  Image2.Canvas.Pen.Color:=Clgray;
  //yp es el punto escalado y trasladado
  yp:=round((Image2.Height-1)*(1-HR[0]/MAX)  );
  image2.Canvas.MoveTo(0,yp);
  //comenzara a trazar lineas
  for i:=1 to 255 do begin
   yp:=round((Image2.Height-1)*(1-HR[i]/MAX)  );
   Image2.Canvas.LineTo(i,Image2.Height);
   Image2.Canvas.LineTo(i,yp);
  end;

end;
// crear paleta de tono VERDE
procedure TForm1.initG(var M:MATRGB);
var
  i,j,yp : Integer;
  MAX    : Integer;
  begin
  clsH();
     for i:=0 to Image3.Height-1 do begin
         for j:=0 to image3.Width-1 do begin
             Image3.Canvas.Pixels[j,i]:=RGB(0,j,0);
         end;
     end;
  //inicializar vector de frecuencias
  for i:=0 to 255 do begin
    HG[i]:=0;
  end;

  //calcular frecuencias
  for i:=0 to Ancho-1 do begin
    for j:=0 to Alto-1 do begin
       inc(HG[M[i,j,1]]);
    end;
  end;

  //pintar en Image 2
  //encontrar Maximo
  MAX:=HG[0];
  for i:=1 to 255 do begin
     if (HG[i]>MAX) then begin
        MAX:=HG[i];
     end;
  end;

  Image2.Canvas.Pen.Color:=Clgray;
  //yp es el punto escalado y trasladado
  yp:=round((Image2.Height-1)*(1-HG[0]/MAX)  );
  image2.Canvas.MoveTo(0,yp);
  //comenzara a trazar lineas
  for i:=1 to 255 do begin
   yp:=round((Image2.Height-1)*(1-HG[i]/MAX)  );
   Image2.Canvas.LineTo(i,Image2.Height);
   Image2.Canvas.LineTo(i,yp);
  end;
end;
// crear paleta de tono BLUE
procedure TForm1.initB(var M:MATRGB);
var
  i,j,yp : Integer;
  MAX : Integer;
begin
  clsH();
     for i:=0 to Image3.Height-1 do begin
         for j:=0 to image3.Width-1 do begin
             Image3.Canvas.Pixels[j,i]:=RGB(0,0,j);
         end;
     end;
  //inicializar vector de frecuencias
  for i:=0 to 255 do begin
    HB[i]:=0;
  end;

  //calcular frecuencias
  for i:=0 to Ancho-1 do begin
    for j:=0 to Alto-1 do begin
      //se toma el valor de pixel en canal AZUL,
      //incrementando en +1 el valor del array HB en esa posicion
      inc(HB[M[i,j,2]]);
    end;
  end;

  //pintar en Image 2
  //encontrar Maximo
  MAX:=HB[0];
  for i:=1 to 255 do begin
     if (HB[i]>MAX) then begin
        MAX:=HB[i];
     end;
  end;

  Image2.Canvas.Pen.Color:=Clgray;
  //yp es el punto escalado y trasladado
  yp:=round((Image2.Height-1)*(1-HB[0]/MAX)  );
  image2.Canvas.MoveTo(0,yp);
  //comenzara a trazar lineas
  for i:=1 to 255 do begin
   yp:=round((Image2.Height-1)*(1-HR[i]/MAX)  );
   Image2.Canvas.LineTo(i,Image2.Height);
   Image2.Canvas.LineTo(i,yp);
  end;
end;
// crear paleta de Intensidad
procedure TForm1.initI(var M:MATRGB);
var
  i,j,yp  : Integer;
  x,y,z   : Integer;
  sum     : Integer;
  MAX     : Integer;
begin
  clsH();
     for i:=0 to Image3.Height-1 do begin
         for j:=0 to image3.Width-1 do begin
             Image3.Canvas.Pixels[j,i]:=RGB(j,j,j);
         end;
     end;
     //

  //inicializar vector de frecuencias
  for i:=0 to 255 do begin
    HI[i]:=0;
  end;

  //calcular frecuencias
  for i:=0 to Ancho-1 do begin
    for j:=0 to Alto-1 do begin
      inc(HI[M[i,j,0]]);
    end;
  end;

  //pintar en Image 2
  //encontrar Maximo
  MAX:=HI[0];
  for i:=1 to 255 do begin
     if (HI[i]>MAX) then begin
        MAX:=HI[i];
     end;
  end;

  Image2.Canvas.Pen.Color:=Clgray;
  //yp es el punto escalado y trasladado
  yp:=round((Image2.Height-1)*(1-HI[0]/MAX)  );
  image2.Canvas.MoveTo(0,yp);
  //comenzara a trazar lineas
  for i:=1 to 255 do begin
   yp:=round((Image2.Height-1)*(1-HI[i]/MAX)  );
   Image2.Canvas.LineTo(i,Image2.Height);
   Image2.Canvas.LineTo(i,yp);
  end;
end;
//limpia histograma
procedure Tform1.clsH();
begin
 //limpiar Canvas de Histograma
 Image2.Canvas.Pen.Color:=CLWhite;
 Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);
end;

procedure tform1.loadMatI(M:MATRGB);
var
  i,j,sum,d : Integer;
  x,y,z : Integer;
begin
  d:=3; 
  ///
  for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin

          x := MAT[i,j,0];
          y := MAT[i,j,1];
          z := MAT[i,j,2];

          sum := (x+y+z)div d;

          M[i,j,0] := sum;
          M[i,j,1] := sum;
          M[i,j,2] := sum;

        end;
  end;
  ///
end;

//  FIN METODOS PROPIOS
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
    setlength(MAT_I,ANCHO,ALTO,3);

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

        MAT_I[i,j,0]:=GetRvalue(c);
        MAT_I[i,j,1]:=GetGvalue(c);
        MAT_I[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i

  end;
  //loadMatI(MAT_I);
  Panel1.Visible:=true;
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

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  loadMatI(MAT_I);
  initI(MAT_I);
end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  initR(MAT);
end;

procedure TForm1.RadioButton3Change(Sender: TObject);
begin
  initG(MAT);
end;

procedure TForm1.RadioButton4Change(Sender: TObject);
begin
 initB(MAT);
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

procedure TForm1.Button2Click(Sender: TObject);
begin
 //limpiar Canvas de Histograma
 Image2.Canvas.Pen.Color:=CLWhite;
 Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);
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

