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
  MATCONV=Array[0..2,0..2] of Integer;

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;

    procedure Button1Click(Sender: TObject);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );

    procedure Label4Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);

    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
  private

  public
    procedure verImgHis();
    //filtros
    procedure grisR(var M:MATRGB);
    procedure grisG(var M:MATRGB);
    procedure grisB(var M:MATRGB);
    procedure grises_prom(var M:MATRGB);
    procedure chn2GRB(var M:MATRGB); //cambia canal a GRB
    procedure chn2BGR(var M:MATRGB); //cambia canal a BGR
    procedure chn2RBG(var M:MATRGB);
    procedure treshold();
    procedure log(var M:MATRGB);


    procedure initR(var M:MATRGB);   //carga histograma Rojo
    procedure initG(var M:MATRGB);   //carga histograma verde
    procedure initB(var M:MATRGB);   //carga histograma azul
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
  IMAGEN        : integer;

implementation
uses unit2,unit3,unit4,Unit5;
{$R *.lfm}

{ TForm1 }

//procedimientos propios

//logaritmo
//aplha = 1
procedure tform1.log(var M:MATRGB);
var
i,j :Integer;
k   :byte;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      for k:=0 to 2 do begin
          M[i,j,k]:=round(ln(M[i,j,k]+1)/ln(256) * 255);
      end;
      BM.Canvas.Pixels[i,j] := RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
    end;
  end;
  verImgHis();
end;

//Update histograma e Imagen1
procedure tform1.verImgHis();
  begin
     Image1.Picture.Assign(BM);

     if RadioButton1.Checked   then initI(MAT);
     if RadioButton2.Checked   then initR(MAT);
     if RadioButton3.Checked   then initG(MAT);
     if RadioButton4.Checked   then initB(MAT);

  end;

procedure tform1.grisR(var M:MATRGB);        // gris canal ROJO
var
  i,j : Integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      M[i,j,1]:=M[i,j,0];
      M[i,j,2]:=M[i,j,0];

      BM.Canvas.Pixels[i,j]:= RGB(M[i,j,0],M[i,j,1],M[i,j,2]);

    end;
  end;
  verImgHis();
end;
procedure tform1.grisG(var M:MATRGB);        // gris canal VERDE
var
  i,j : Integer;
begin
  //Label1.Caption := 'Gris por canal';
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      M[i,j,0]:=M[i,j,1];
      M[i,j,2]:=M[i,j,1];

      BM.Canvas.Pixels[i,j]:= RGB(M[i,j,0],M[i,j,1],M[i,j,2]);

    end;
  end;
  verImgHis();
end;
procedure tform1.grisB(var M:MATRGB);        // gris canal AZUL
var
  i,j : Integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      M[i,j,0]:=M[i,j,2];
      M[i,j,1]:=M[i,j,2];

      BM.Canvas.Pixels[i,j]:= RGB(M[i,j,0],M[i,j,1],M[i,j,2]);

    end;
  end;
  verImgHis();
end;
procedure tform1.grises_prom(var M:MATRGB);
var
  i,j  : Integer;
  sum, d  : Integer;
  x,y,z  : Integer;
begin
  d:=3;  //3 por canales RGB
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
  verImgHis();

end;
//canal a GRB
procedure tform1.chn2GRB(var M:MATRGB);
var
i,j  : Integer;
v    :byte;
begin
  for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin

         v := M[i,j,0];
         M[i,j,0]:=M[i,j,1];
         M[i,j,1]:=v;
         M[i,j,2]:=M[i,j,2];
         BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
     end;
  end;
  verImgHis();
end;
//canal a GRB
procedure tform1.chn2BGR(var M:MATRGB);
var
i,j  : Integer;
v    : byte;
begin
     for i:=0 to ANCHO-1 do begin
         for j:=0 to ALTO-1 do begin
            v:=M[i,j,0];
            M[i,j,0]:=M[i,j,2];
            M[i,j,1]:=M[i,j,1];
            M[i,j,2]:=v;
            BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
         end;
     end;
   verImgHis();
end;
//canal a RBG
procedure tform1.chn2RBG(var M:MATRGB);
var
i,j  : Integer;
v    : byte;
begin
     for i:=0 to ANCHO-1 do begin
         for j:=0 to ALTO-1 do begin
            v:=M[i,j,1];
            M[i,j,0]:=M[i,j,0];
            M[i,j,1]:=M[i,j,2];
            M[i,j,2]:=v;
            BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
         end;
      end;
   verImgHis();
end;

// binarización
procedure tform1.treshold();
var
   i,j,T :Integer;
begin
T:=0;
grises_prom(MAT); //pasamos a gris primero
//sacar T (treshold)
for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
        T := T + MAT[i,j,0];
    end;
end;
T := T div (ANCHO*ALTO);

//MAYOR > T -> 255
//menor_igual <= 0 -> 0
for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
        if MAT[i,j,0] <= T then
           begin
           MAT[i,j,0]:=0;
           MAT[i,j,1]:=0;
           MAT[i,j,2]:=0;
           BM.Canvas.Pixels[i,j] := RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
           end
        else
           begin
           MAT[i,j,0]:=255;
           MAT[i,j,1]:=255;
           MAT[i,j,2]:=255;
           BM.Canvas.Pixels[i,j] := RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
           end;
    end;
end;
 verImgHis();
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
  MAX     : Integer;
begin
  clsH();
  //grises_prom(M); //pasamos a gris primero

     for i:=0 to Image3.Height-1 do begin
         for j:=0 to image3.Width-1 do begin
             Image3.Canvas.Pixels[j,i]:=RGB(j,j,j);
         end;
     end;
     //

  loadmatI(M);
  //inicializar vector de frecuencias
  for i:=0 to 255 do begin
    HI[i]:=0;
  end;

  //calcular frecuencias
  for i:=0 to Ancho-1 do begin
    for j:=0 to Alto-1 do begin
      inc(HI[MAT_I[i,j,0]]);
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
//carga matriz intensidad
procedure tform1.loadMatI(M:MATRGB);
var
  i,j,sum : Integer;
  x,y,z : Integer;
begin
  ///
  for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin

          x := M[i,j,0];
          y := M[i,j,1];
          z := M[i,j,2];

          sum := (x+y+z) div 3;

          MAT_I[i,j,0] := sum;
          MAT_I[i,j,1] := sum;
          MAT_I[i,j,2] := sum;

        end;
  end;
  ///
end;

//  FIN METODOS PROPIOS

////  INTERFAZ    ////
procedure TForm1.MenuItem2Click(Sender: TObject);
var
  i,j   : Integer;
  c       : Tcolor;     //puede ser Tcolor o Integer
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
        //matriz para canvas
        MAT[i,j,0]:=GetRvalue(c);
        MAT[i,j,1]:=GetGvalue(c);
        MAT[i,j,2]:=GetBvalue(c);
        //matriz para recargar
        Maux[i,j,0]:=GetRvalue(c);
        Maux[i,j,1]:=GetGvalue(c);
        Maux[i,j,2]:=GetBvalue(c);
        //matriz para Intensidad
        MAT_I[i,j,0]:=GetRvalue(c);
        MAT_I[i,j,1]:=GetGvalue(c);
        MAT_I[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i

    Panel1.Visible:=true; //hacemos visible el panel de Hist
    //RadioButton1.Checked:=true;
    Menuitem3.enabled:=true;
    verImgHis();
  end;

end;

//filtro negativo
procedure TForm1.MenuItem4Click(Sender: TObject);
var
i,j : Integer;
k   : Byte;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      for k:=0 to 2 do begin
        MAT[i,j,k]:=255-MAT[i,j,k];
      end;
      BM.Canvas.Pixels[i,j]:=RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);

    end; //i
  end;  //j

 //visualizar resultado

verImgHis();


end;

//gris prom
procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  grises_prom(MAT);
end;
//CARGAR hist I
procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  //loadMatI(MAT_I);
  initI(MAT);
end;
//CARGAR hist R
procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  initR(MAT);
 end;
//CARGAR hist G
procedure TForm1.RadioButton3Change(Sender: TObject);
begin
  initG(MAT);
end;
 //CARGAR hist B
procedure TForm1.RadioButton4Change(Sender: TObject);
begin
 initB(MAT);
end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  grisR(MAT);
end;

procedure TForm1.MenuItem17Click(Sender: TObject);
begin
  grisG(MAT);
end;

procedure TForm1.MenuItem18Click(Sender: TObject);
begin
  grisB(MAT);
end;

procedure TForm1.MenuItem20Click(Sender: TObject);
begin
form4.showmodal;

  if Form4.ModalResult=MROK then begin
     form4.conv(MAT);

  end;
end;
//Tangente Hiperbolica
procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  form5.TrackBar1.Position:=form5.TrackBar1.min;
  form5.alpha:=form2.TrackBar1.Position;
  form5.Label1.Caption:=FloatToStr(form5.alpha*0.1);
  form5.showmodal;

  if form5.ModalResult=MROK then begin
     form5.TanHiper(MAT);
  end;
end;


//GAMMA
procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  form3.TrackBar1.Position:=form3.TrackBar1.Min;
  //form3.gma:=form3.TrackBar1.Position;
  form3.Label1.Caption:=inttostr(round(form3.gma));
  form3.showmodal;

  if Form3.ModalResult=MROK then begin
     Form3.gamma(MAT);
  end;

end;

procedure TForm1.MenuItem24Click(Sender: TObject);
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

  verImgHis();
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



procedure TForm1.Label4Click(Sender: TObject);
begin

end;
//RGB ->  GRB
procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  chn2GRB(MAT);
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
   chn2BGR(MAT);
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
   chn2RBG(MAT);
end;
//ln
procedure TForm1.MenuItem13Click(Sender: TObject);
begin
log(MAT);
end;

//binarización
procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  Treshold();
end;

//binarización-dinamic
procedure TForm1.MenuItem15Click(Sender: TObject);
var
i,j: Integer;
begin
  form2.TrackBar1.Position:=form2.TrackBar1.Min;
  form2.param:=form2.TrackBar1.Position;
  form2.Label1.Caption:=inttostr(form2.param);
  form2.showmodal;

  if Form2.ModalResult=MROK then begin
  //MAYOR > T -> 255
  //menor_igual <= 0 -> 0
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
            if MAT[i,j,0] <= form2.param then
               begin
               MAT[i,j,0]:=0;
               MAT[i,j,1]:=0;
               MAT[i,j,2]:=0;
               BM.Canvas.Pixels[i,j] := RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
               end
            else
               begin
               MAT[i,j,0]:=255;
               MAT[i,j,1]:=255;
               MAT[i,j,2]:=255;
               BM.Canvas.Pixels[i,j] := RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
               end;
           end;
    end;

 verImgHis();
  end;
end;




end.

