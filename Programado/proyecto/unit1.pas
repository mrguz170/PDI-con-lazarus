unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ExtDlgs, LCLintf, ComCtrls, StdCtrls, Buttons;

type

  { TForm1 }

  //tipos propios definidos
  MATRGB=Array of Array of Array of Byte;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
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
    Timer1: TTimer;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem22Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem24Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem36Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    procedure clsH();
    procedure restaurar();
    procedure deshacer();

    procedure loadMatI(M:MATRGB);
    procedure ecualizar(var M:MATRGB);

  public
    //function ecualizado(j :Integer; ch: Integer):Integer;
    procedure verImgHis();
    procedure ant();
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
    procedure refl_x(var M:MATRGB);
    procedure refl_y(var M:MATRGB);
    procedure rotacion_I(var M:MATRGB);
    procedure rotacion_D(var M:MATRGB);
    procedure zoom_in(var M:MATRGB);
    procedure zoom_out(var M:MATRGB);


  end;


var
  Form1: TForm1;
  BM          : Tbitmap;
  MAT, MAT_I, Maux, MDes     : MATRGB;
  MATresp                    : MATRGB;
  MAT_rotacion, MAT_geo      : MATRGB;
  ALTO, ANCHO, W_aux, H_aux, cnt   : Integer;
  HR,HG,HB,HI   : Array [0..255] of integer;
  EHR,EHG,EHB   : Array [0..255] of integer;


implementation
uses unit2,unit3,unit4,Unit5,unit6,unit7,unit9;
{$R *.lfm}

{ TForm1 }

//////////////---------- metodos gus -----------////////////////////////
/////////////////////////////////////////////////////////////////////

//zoom OUT
procedure tform1.zoom_out(var M:MATRGB);
var i, j,k, zoomOUT_ANCHO, zoomOUT_ALTO  :Integer;
begin
  zoomOUT_ANCHO:=round(ANCHO/2);
  zoomOUT_ALTO:=round(ALTO/2); ;
  BM.SetSize(zoomOUT_ANCHO,zoomOUT_ALTO);
  setlength(MAT_geo,zoomOUT_ANCHO,zoomOUT_ALTO,3);

  for i:=0 to zoomOUT_ANCHO-1 do begin
        for j:=0 to zoomOUT_ALTO-1 do begin
            for k:=0 to 2 do begin
                MAT_geo[i,j,k]:=M[i*2,j*2,k];

            end;
        end;
  end;

    ANCHO:= zoomOUT_ANCHO;
    ALTO:= zoomOUT_ALTO;

    //Actualizamos matrices que se usaran para otras operaciones
    setlength(M, ANCHO, ALTO, 3);
    setlength(MAT_I, ANCHO,ALTO,3);
    setlength(MDes,ANCHO,ALTO,3);

      for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin
            for k:=0 to 2 do begin
                M[i,j,k]:=MAT_geo[i,j,k]
            end;
            BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
        end;
      end;

      verImgHis();

end;

//zoom in
procedure tform1.zoom_in(var M:MATRGB);
var i, j,k, zoomIN_ANCHO, zoomIN_ALTO  :Integer;
begin
  zoomIN_ANCHO:=2*ANCHO;
  zoomIN_ALTO:=2*ALTO;
  BM.SetSize(zoomIN_ANCHO,zoomIN_ALTO);
  setlength(MAT_geo,zoomIN_ANCHO,zoomIN_ALTO,3);

  for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin
            for k:=0 to 2 do begin
                MAT_geo[i*2, j*2, k]:=M[i,j,k];
                MAT_geo[i*2+1, j*2, k]:=M[i,j,k];
                MAT_geo[i*2, j*2+1, k]:=M[i,j,k];
                MAT_geo[i*2+1, j*2+1, k]:=M[i,j,k];
            end;
        end;
  end;

    ANCHO:= zoomIN_ANCHO;
    ALTO:= zoomIN_ALTO;

    //Actualizamos matrices que se usaran para otras operaciones
    setlength(M, ANCHO, ALTO, 3);
    setlength(MAT_I, ANCHO,ALTO,3);
    setlength(MDes,ANCHO,ALTO,3);

      for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin
            for k:=0 to 2 do begin
                M[i,j,k]:=MAT_geo[i,j,k]
            end;
            BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
        end;
      end;

      verImgHis();

end;

//rotar izquierda
procedure Tform1.rotacion_I(var M:MATRGB);
var
  i,j :integer;
begin
  setlength(MAT_rotacion,ALTO,ANCHO,3);

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      MAT_rotacion[j,(ANCHO-(i+1))]:=M[i,j];
      end;
  end;

  //--------------------------------------
  //cambiamos la dimenensiones M*N
  BM.SetSize(ALTO,ANCHO);

  //actualizamos el alto y ancho
  ALTO:=BM.Height;
  ANCHO:=BM.Width;

  //cambiamos forma de M
  setlength(M, ANCHO,ALTO,3);
  setlength(MAT_I, ANCHO,ALTO,3);
  setlength(MAT_geo,ANCHO,ALTO,3);
  setlength(MDes,ANCHO,ALTO,3);
  //----------------------------------------

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      M[i,j,0]:=MAT_rotacion[i,j,0];
      M[i,j,1]:=MAT_rotacion[i,j,1];
      M[i,j,2]:=MAT_rotacion[i,j,2];

      BM.Canvas.Pixels[i,j]:= RGB(MAT_rotacion[i,j,0],MAT_rotacion[i,j,1],MAT_rotacion[i,j,2]);
    end;
  end;

  verImgHis();

end;

//rotar Derecha
procedure Tform1.rotacion_D(var M:MATRGB);
var
  i,j :integer;
begin
  setlength(MAT_rotacion,ALTO,ANCHO,3);

  Edit1.Text:=inttostr(alto);
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      MAT_rotacion[(ALTO-(j+1)),i]:=M[i,j];
      end;
  end;

  //--------------------------------------
  //cambiamos la dimenensiones M*N
  BM.Height:=ANCHO;
  BM.Width:=ALTO;

  //actualizamos el alto y ancho
  ALTO:=BM.Height;
  ANCHO:=BM.Width;

  //cambiamos forma de M
  setlength(M, ANCHO,ALTO,3);
  setlength(MAT_I, ANCHO,ALTO,3);
  setlength(MAT_geo,ANCHO,ALTO,3);
  setlength(MDes,ANCHO,ALTO,3);
  //----------------------------------------

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      M[i,j,0]:=MAT_rotacion[i,j,0];
      M[i,j,1]:=MAT_rotacion[i,j,1];
      M[i,j,2]:=MAT_rotacion[i,j,2];

      BM.Canvas.Pixels[i,j]:= RGB(MAT_rotacion[i,j,0],MAT_rotacion[i,j,1],MAT_rotacion[i,j,2]);
    end;
  end;

  verImgHis();

end;

// reflejar en x
procedure tform1.refl_x(var M:MATRGB);
var
  i,j :integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      MAT_geo[i,j]:=M[i,ALTO-(j+1)];
      BM.Canvas.Pixels[i,j]:= RGB(MAT_geo[i,j,0],MAT_geo[i,j,1],MAT_geo[i,j,2]);
    end;
  end;

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      M[i,j]:=MAT_geo[i,j];
    end;
  end;
    verImgHis();
end;

// reflejar en y
procedure tform1.refl_y(var M:MATRGB);
var
  i,j :integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      MAT_geo[i,j]:=M[ANCHO-(i+1),j];
      BM.Canvas.Pixels[i,j]:= RGB(MAT_geo[i,j,0],MAT_geo[i,j,1],MAT_geo[i,j,2]);
    end;
  end;

  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin
      M[i,j]:=MAT_geo[i,j];
    end;
  end;
    verImgHis();
end;

//ecualizar
procedure tform1.ecualizar(var M:MATRGB);
var
i,j : Integer;
sum,sum2,sum3     : Integer;
begin
  clsH();
  ant();

  sum:=0;
  sum2:=0;
  sum3:=0;

 //star ecualizador
 for i:=0 to 255 do EHR[i]:=0;
 for i:=0 to 255 do EHG[i]:=0;
 for i:=0 to 255 do EHB[i]:=0;
 for i:=0 to 255 do HR[i]:=0;
 for i:=0 to 255 do HG[i]:=0;
 for i:=0 to 255 do HB[i]:=0;

 for i:=0 to ancho-1 do begin
   for j:=0 to ALTO-1 do begin
     inc(HR[M[i,j,0]]);
   end;
 end;

 for i:=0 to ancho-1 do begin
   for j:=0 to ALTO-1 do begin
     inc(HG[M[i,j,1]]);
   end;
 end;

 for i:=0 to ancho-1 do begin
   for j:=0 to ALTO-1 do begin
     inc(HB[M[i,j,2]]);
   end;
 end;

 for i:=0 to 255 do begin
     sum  := sum  + HR[i];
     sum2 := sum2 + HG[i];
     sum3 := sum3 + HB[i];
     EHR[i]:=round(255*sum/(ANCHO*ALTO));
     EHG[i]:=round(255*sum2/(ANCHO*ALTO));
     EHB[i]:=round(255*sum3/(ANCHO*ALTO));
 end;

  ///MIRAR
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

       M[i,j,0]:=EHR[M[i,j,0]];
       M[i,j,1]:=EHG[M[i,j,1]];
       M[i,j,2]:=EHB[M[i,j,2]];

      BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
    end;
  end;

 verImgHis();

end;

//restaurar
procedure tform1.restaurar();
var
i,j :Integer;
begin
 //RESET matrices RGB actualizamos el ANCHO Y ALTO
 setlength(MAT,W_aux,H_aux,3);
 setlength(MAT_I, W_aux,H_aux,3);
 setlength(MAT_geo,W_aux,H_aux,3);
 //setlength(Maux,W_aux,H_aux,3); --no estoy seguro si va jaja
 setlength(MDes,W_aux,H_aux,3);

 BM.Width:=W_aux;
 BM.Height:=H_aux;

 ANCHO:=W_aux;
 ALTO:= H_aux;

for i:=0 to BM.Width-1 do begin
    for j:=0 to BM.Height-1 do begin
      BM.Canvas.Pixels[i,j]:= RGB(Maux[i,j,0],Maux[i,j,1],Maux[i,j,2]);
      MAT[i,j,0]:=Maux[i,j,0];
      MAT[i,j,1]:=Maux[i,j,1];
      MAT[i,j,2]:=Maux[i,j,2];
    end;
end;
  verImgHis();
end;

//anterior
procedure TForm1.ant();
var
i,j :Integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      Mdes[i,j,0]:=MAT[i,j,0];
      Mdes[i,j,1]:=MAT[i,j,1];
      Mdes[i,j,2]:=MAT[i,j,2];

    end;
  end;
end;

//Deshace el utlimo filtro
procedure tform1.deshacer();
var
i,j :Integer;
begin
  for i:=0 to ANCHO-1 do begin
    for j:=0 to ALTO-1 do begin

      MAT[i,j,0]:=Mdes[i,j,0];
      MAT[i,j,1]:=Mdes[i,j,1];
      MAT[i,j,2]:=Mdes[i,j,2];

      BM.Canvas.Pixels[i,j]:= RGB(MAT[i,j,0],MAT[i,j,1],MAT[i,j,2]);
    end;
  end;
  verImgHis();
end;

//logaritmo (aplha=1)
procedure tform1.log(var M:MATRGB);
var
i,j :Integer;
k   :byte;
begin
  ant();
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
  ant();
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
  ant();
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
  ant();
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
  ant();
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
  ant();
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
  ant();
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
   ant();
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
ant();

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
   yp:=round((Image2.Height-1)*(1-HB[i]/MAX)  );
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

//////////////---------- INTERFAZ -----------////////////////////////
/////////////////////////////////////////////////////////////////////
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
    //preservar la altura y ancho original
    H_aux:=BM.Height;
    W_aux:=BM.Width;

    //crear arreglo 3D RGB de ALTOxANCHOx3
    setlength(MAT,ANCHO,ALTO,3);
    setlength(Maux,ANCHO,ALTO,3);
    setlength(MAT_I,ANCHO,ALTO,3);
    setlength(MDes,ANCHO,ALTO,3);
    setlength(MAT_geo,ANCHO,ALTO,3); //matriz aux para reflejar
    setlength(MAT_rotacion,ALTO,ANCHO,3); //matriz aux para rotar

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
        //matriz para Intensidad
        Mdes[i,j,0]:=GetRvalue(c);
        Mdes[i,j,1]:=GetGvalue(c);
        Mdes[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i

    Panel1.Visible:=true; //hacemos visible el panel de Hist
    //RadioButton1.Checked:=true;
    Menuitem3.enabled:=true;
    verImgHis();
  end;

end;
//erosion binaria
procedure TForm1.MenuItem32Click(Sender: TObject);
begin
    form7.erosionBin(MAT);
end;
//dilatacion binaria
procedure TForm1.MenuItem33Click(Sender: TObject);
begin
   form7.dilatacionbin(MAT);
end;

procedure TForm1.MenuItem36Click(Sender: TObject);
begin

end;

//ecualizar
procedure TForm1.MenuItem37Click(Sender: TObject);
begin
  ecualizar(MAT);
end;

procedure TForm1.MenuItem38Click(Sender: TObject);
begin
  restaurar();
end;

procedure TForm1.MenuItem39Click(Sender: TObject);
begin
   refl_x(MAT);
end;

procedure TForm1.MenuItem40Click(Sender: TObject);
begin
    refl_y(MAT);
end;

procedure TForm1.MenuItem41Click(Sender: TObject);
begin
  rotacion_D(MAT);
end;

procedure TForm1.MenuItem42Click(Sender: TObject);
begin
   rotacion_I(MAT);
end;

procedure TForm1.MenuItem43Click(Sender: TObject);
begin
  form8.showmodal;



end;

procedure TForm1.MenuItem44Click(Sender: TObject);
begin
  zoom_IN(MAT);
end;

procedure TForm1.MenuItem45Click(Sender: TObject);
begin
  zoom_OUT(MAT);
end;

//filtro negativo
procedure TForm1.MenuItem4Click(Sender: TObject);
var
i,j : Integer;
k   : Byte;
begin
  ant();

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

procedure TForm1.Timer1Timer(Sender: TObject);
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

//Tangente Hiperbolica
procedure TForm1.MenuItem21Click(Sender: TObject);
begin
  form5.TrackBar1.Position:=form5.TrackBar1.min;
  form5.Label1.Caption:=FloatToStr(form5.alpha*0.1);
  form5.showmodal;

  if form5.ModalResult=MROK then begin
     form5.TanHiper(MAT);
  end;
end;

//convolucion
procedure TForm1.MenuItem22Click(Sender: TObject);
begin
  form4.RadioButton2.Checked:=True;
  form4.showmodal;

  if Form4.ModalResult=MROK then begin
     if form4.RadioButton2.Checked then form4.sobel(MAT);
     if form4.RadioButton1.Checked then form4.prewitt(MAT);
  end;
end;

//GAMMA
procedure TForm1.MenuItem23Click(Sender: TObject);
begin
  form3.TrackBar1.Position:=form3.TrackBar1.Min;
  form3.gma:=form3.TrackBar1.Position;
  form3.Label1.Caption:=inttostr(form3.gma);
  form3.showmodal;

  if Form3.ModalResult=MROK then begin
     Form3.gamma(MAT);
  end;

end;

procedure TForm1.MenuItem24Click(Sender: TObject);
begin

end;

//convolución libre
procedure TForm1.MenuItem25Click(Sender: TObject);
begin
  form6.TrackBar1.Position:=form6.TrackBar1.Min;
  form6.dim:=form6.TrackBar1.Position;
  form6.Label1.Caption:=inttostr(form6.dim);
  form6.showmodal;

  if Form6.ModalResult=MROK then begin
     Form6.libre(MAT);

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  BM:=Tbitmap.Create;
end;

//Reload imagen a traves de una matriz auxiliar guardada al abrir la imagen
procedure TForm1.Button1Click(Sender: TObject);
begin
  restaurar();
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  deshacer();
end;

//ECUALIZAR rojo boton
procedure TForm1.Button3Click(Sender: TObject);
begin
  ecualizar(MAT);
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

