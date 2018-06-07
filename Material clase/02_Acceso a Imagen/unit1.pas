unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ExtDlgs, LCLintf, ComCtrls, StdCtrls, Math;

type

  { TForm1 }

  //tipos propios definidos
  MATRGB=Array of Array of Array of Byte;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image3: TImage;
    Image4: TImage;

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
    GrisR: TMenuItem;
    GrisG: TMenuItem;
    GrisB: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
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
    procedure GrisRClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure GrisGClick(Sender: TObject);
    procedure GrisBClick(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure ScrollBox2Click(Sender: TObject);
  private

  public
    procedure grises (var M:MATRGB);
    procedure promedio (var pr:integer; R,G,B:integer);
    procedure grisRGB (valor:integer);
    procedure ColorRGB (valor:integer);
    procedure Histograma(img:MATRGB;valor:integer);
    procedure im1();
    procedure im2();
  end;

var
  Form1: TForm1;
  BM            : Tbitmap;
  ImaCo         : Tbitmap;
  MAT           : MATRGB;
  Matrix        : MATRGB;
  ALTO, ANCHO   : Integer;
  IMAGEN        : integer;

implementation
Uses Unit2;

{$R *.lfm}

{ TForm1 }
//procedimientos propios


{

procedure TForm1.Button1Click(Sender: TObject);
var
i,j,yp       : Integer;
MAX          : Integer;


begin
  //limpiar Canvas de Histograma
  Image2.Canvas.Pen.Color:=CLWhite;
  Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);


      //crear paleta de tonos 0...255 verde    en Image 3
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
       inc(HG[MAT[i,j,1]]);
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

}


procedure tform1.im2();
begin
    IMAGEN:=1;
    Image4.Canvas.Pen.Color:=CLWhite;
    Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
    RadioButton1.Checked:=true;
    Histograma(Matrix,0);
    Image1.Picture.Assign(ImaCo);


end;
procedure tform1.im1();
begin
    IMAGEN:=0;
    Image4.Canvas.Pen.Color:=CLWhite;
    Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
    RadioButton1.Checked:=true;
    Histograma(MAT,0);
    Image1.Picture.Assign(BM);
end;

procedure tform1.Histograma(img:MATRGB; valor:integer);
var
  i,j,MAX,yp:integer;
  HR: Array [0..255] of integer;
begin

  for i:=0 to 255 do begin
    HR[i]:=0;
  end;

  //calcular frecuencias

  for i:=0 to Ancho-1 do begin
    for j:=0 to Alto-1 do begin
       inc(HR[img[i,j,valor]]);
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

  Image4.Canvas.Pen.Color:=Clgray;
  //yp es el punto escalado y trasladado
  yp:=round((Image4.Height-1)*(1-HR[0]/MAX)   );
  image4.Canvas.MoveTo(0,yp);
  //comenzara a trazar lineas
  for i:=1 to 255 do begin
   yp:=round((Image4.Height-1)*(1-HR[i]/MAX)  );
   Image4.Canvas.LineTo(i,Image4.Height);
   Image4.Canvas.LineTo(i,yp);
  end;


end;

procedure tform1.ColorRGB(valor:integer);
var
   i,j:integer;
begin

  if(valor=1)then
  begin

      for i:=0 to 19 do begin
          for j:=0 to 255 do begin
              Image3.Canvas.Pixels[j,i]:= RGB(j,0,0);
          end;
      end;
  end
  else
  begin

    if(valor=2) then
    begin

        for i:=0 to 19 do begin
          for j:=0 to 255 do begin
              Image3.Canvas.Pixels[j,i]:= RGB(0,j,0);

          end;
      end;
    end
    else
    begin

       for i:=0 to 19 do begin
          for j:=0 to 255 do begin
              Image3.Canvas.Pixels[j,i]:= RGB(0,0,j);

          end;
      end;
    end;
  end;

end;

procedure tform1.grisRGB(valor:integer);
var
  i,j : Integer;

begin
    for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin

            Matrix[i,j,0]:=MAT[i,j,valor];
            Matrix[i,j,1]:=MAT[i,j,valor];
            Matrix[i,j,2]:=MAT[i,j,valor];

      ImaCo.Canvas.Pixels[i,j]:= RGB(Matrix[i,j,0],Matrix[i,j,1],Matrix[i,j,2]);

    end;
  end;

  //Image2.Picture.Assign(ImaCo);

  im2();

end;

procedure tform1.promedio(var pr:integer; R,G,B:integer);
var
  prom:real;
begin
  prom:=(R+G+B)/3;
  pr:=round(prom);
end;

procedure tform1.grises(var M:MATRGB);
var
  i,j : Integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      M[i,j,1]:=M[i,j,0];
      M[i,j,2]:=M[i,j,0];

      BM.Canvas.Pixels[i,j]:= RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);

    end;
  end;

  Image1.Picture.Assign(BM);

end;



procedure TForm1.MenuItem2Click(Sender: TObject);
var
  i,j   :Integer;
  c     :Tcolor;     //puede ser Tcolor o Integer
begin
  //abrir imagen
  if (OpenPictureDialog1.Execute) then
  begin

    ScrollBox1.Enabled:=True;
    IMAGEN:=0;
    //asignar archivo a BM
    BM.LoadFromFile(OpenPictureDialog1.FileName);

    if (BM.PixelFormat<>pf24bit) then
    begin
    BM.PixelFormat:=pf24bit;
    end;

    Button1.Visible:=true;
    Button2.Visible:=true;
    Image1.Picture.Assign(BM);


    ALTO:=BM.Height;
    ANCHO:=BM.Width;

    ImaCo.SetSize(ANCHO,ALTO);

    //crear arreglo 3D RGB de ALTOxANCHOx3
    setlength(MAT,ANCHO,ALTO,3);
    setlength(Matrix,ANCHO,ALTO,3);

    //leer y copiar RGB de imagen a MAT

    for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1 do begin
        c:=BM.Canvas.Pixels[i,j];
        MAT[i,j,0]:=GetRvalue(c);
        MAT[i,j,1]:=GetGvalue(c);
        MAT[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i
  end;

    RadioButton1.Visible:=true;
    RadioButton1.Checked:=true;
    RadioButton2.Visible:=true;
    RadioButton3.Visible:=true;

end;

procedure TForm1.MenuItem4Click(Sender: TObject);
var
i,j : Integer;
k   : Byte;

begin

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      for k:=0 to 2 do begin
        Matrix[i,j,k]:=255-MAT[i,j,k];
       // MAT[i,j,k]:=not(MAT[i,j,k]);
      end;
      ImaCo.Canvas.Pixels[i,j]:=RGB(Matrix[i,j,0],Matrix[i,j,1],Matrix[i,j,2]);

    end; //i
  end;  //j

 //visualizar resultado
 //Image2.Picture.Assign(ImaCo);
  im2();



end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  //grises(MAT);
end;

procedure TForm1.GrisGClick(Sender: TObject);
begin
grisRGB(1);
end;

procedure TForm1.GrisBClick(Sender: TObject);
begin
grisRGB(2);
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
var
   valor:integer;
    i,j : Integer;
begin

  for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin
            promedio(valor,MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
            Matrix[i,j,0]:=valor;
            Matrix[i,j,1]:=valor;
            Matrix[i,j,2]:=valor;
            ImaCo.Canvas.Pixels[i,j]:= RGB(valor,valor,valor);
     end;
  end;

  //Image2.Picture.Assign(ImaCo);
  im2();


end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem8Click(Sender: TObject);
var

    i,j:integer;
begin
   for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin
            Matrix[i,j,0]:=MAT[i,j,1];
            Matrix[i,j,1]:=MAT[i,j,0];
            Matrix[i,j,2]:=MAT[i,j,2];
            ImaCo.Canvas.Pixels[i,j]:=RGB(Matrix[i,j,0],Matrix[i,j,1],Matrix[i,j,2]);
     end;
  end;

  //Image2.Picture.Assign(ImaCo);
  im2();

end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var
    i,j:integer;
begin
   for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin
            Matrix[i,j,0]:=MAT[i,j,2];
            Matrix[i,j,1]:=MAT[i,j,1];
            Matrix[i,j,2]:=MAT[i,j,0];
            ImaCo.Canvas.Pixels[i,j]:=RGB(Matrix[i,j,0],Matrix[i,j,1],Matrix[i,j,2]);
     end;
  end;

 // Image2.Picture.Assign(ImaCo);
 im2();

end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin
  Image4.Canvas.Pen.Color:=CLWhite;
  Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
  colorRGB(1);

   if(IMAGEN=0) then begin
      Histograma(MAT,0);
   end
   else begin
      Histograma(Matrix,0);
   end;

end;

procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  Image4.Canvas.Pen.Color:=CLWhite;
  Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
  colorRGB(2);
    if(IMAGEN=0) then begin
        Histograma(MAT,1);
   end
   else begin
      Histograma(Matrix,1);
   end;

end;

procedure TForm1.RadioButton3Change(Sender: TObject);
begin
  Image4.Canvas.Pen.Color:=CLWhite;
  Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
  colorRGB(3);
   if(IMAGEN=0) then begin
        Histograma(MAT,2);
   end
   else begin
      Histograma(Matrix,2);
   end;

end;

procedure TForm1.RadioButton4Change(Sender: TObject);
begin

end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TForm1.ScrollBox2Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  BM:=Tbitmap.Create;
  ImaCo:=Tbitmap.Create;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  im1();
 { if(IMAGEN=1) then begin
    IMAGEN:=0;
    Image4.Canvas.Pen.Color:=CLWhite;
    Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
    RadioButton1.Checked:=true;
    Histograma(MAT,0);
    Image1.Picture.Assign(BM);
  end;   }


end;

procedure TForm1.Button2Click(Sender: TObject);
begin
   im2();
  {  if(IMAGEN=0) then begin
    IMAGEN:=1;
    Image4.Canvas.Pen.Color:=CLWhite;
    Image4.Canvas.Rectangle(0,0,Image4.Width,Image4.Height);
    RadioButton1.Checked:=true;
    Histograma(Matrix,0);
    Image1.Picture.Assign(ImaCo);
  end;  }

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  BM.Destroy;
  ImaCo.Destroy;
end;

procedure TForm1.GrisRClick(Sender: TObject);
begin
grisRGB(0);
end;

procedure TForm1.Image1Click(Sender: TObject);
begin

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

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

procedure TForm1.Image3Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem10Click(Sender: TObject);
var
    i,j:integer;
begin
   for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin
            Matrix[i,j,0]:=MAT[i,j,0];
            Matrix[i,j,1]:=MAT[i,j,2];
            Matrix[i,j,2]:=MAT[i,j,1];
            ImaCo.Canvas.Pixels[i,j]:=RGB(Matrix[i,j,0],Matrix[i,j,1],Matrix[i,j,2]);
     end;
  end;

  //Image2.Picture.Assign(ImaCo);
  im2();

end;

procedure TForm1.MenuItem11Click(Sender: TObject);
var
   valor,sumatoria,umbral:integer;
    i,j : Integer;
begin

  sumatoria:=0;
  for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin
            promedio(valor,MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
            Matrix[i,j,0]:=valor;
            Matrix[i,j,1]:=valor;
            Matrix[i,j,2]:=valor;
            sumatoria:=sumatoria+valor;
     end;
  end;

  umbral:=round(sumatoria/(ANCHO*ALTO));

  for i:=0 to ANCHO-1 do begin
     for j:=0 to ALTO-1 do begin

           if (Matrix[i,j,0]<umbral) then
              begin
            Matrix[i,j,0]:=0;
            Matrix[i,j,1]:=0;
            Matrix[i,j,2]:=0;
              end
           else
           begin
            Matrix[i,j,0]:=255;
            Matrix[i,j,1]:=255;
            Matrix[i,j,2]:=255;
           end;
           ImaCo.Canvas.Pixels[i,j]:=RGB(Matrix[i,j,0],Matrix[i,j,1],Matrix[i,j,2]);
     end;
  end;
  // Image2.Picture.Assign(ImaCo);
  im2();


end;

procedure TForm1.MenuItem13Click(Sender: TObject);


begin





end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin

end;

end.

