unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus, ExtDlgs, LCLintf, ComCtrls, StdCtrls;

type

  { TForm1 }

  //tipos propios definidos
  MATRGB=Array of Array of Array of Byte;

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    Panel1: TPanel;
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
    procedure Label1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    //procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
    procedure RadioButton4Change(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    procedure grises (var M:MATRGB);
    //procedure initF(HR:Array[0..255] of integer, HG:Array[0..255] of integer, HB:Array[0..255] of integer);
    procedure initR();
  end;

var
  Form1: TForm1;
  BM            : Tbitmap;
  MAT           : MATRGB;
  ALTO, ANCHO   : Integer;
  HR            : Array [0..255] of integer;
  HG            : Array [0..255] of integer;
  HB            : Array [0..255] of integer;

implementation

{$R *.lfm}

{ TForm1 }
//procedimientos propios
procedure tform1.initR();
var
  i,j : Integer;
begin
     for i:=0 to Image3.Height-1 do begin
         for j:=0 to image3.Width-1 do begin
             Image3.Canvas.Pixels[j,i]:=RGB(j,0,0);
         end;
     end;
end;

procedure tform1.grises(var M:MATRGB);
var
  i,j : Integer;
  k   : Byte;
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
  i,j   : Integer;
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

  Button1.Enabled:=True;

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

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  grises(MAT);
end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin

end;

//histograma rojo
procedure TForm1.RadioButton2Change(Sender: TObject);
begin
  //crear paleta de tono rojo
  initR();
  //calcular y graficar histograma rojo
end;

//histograma verde
procedure TForm1.RadioButton3Change(Sender: TObject);
var
i,j: Integer;
begin
  //crear paleta de tono rojo
  for i:=0 to Image3.Height-1 do begin
    for j:=0 to image3.Width-1 do begin
       Image3.Canvas.Pixels[j,i]:=RGB(0,j,0);
    end;
  end;
  //calcular y graficar histograma verde
end;

//histograma azul
procedure TForm1.RadioButton4Change(Sender: TObject);
var
i,j: Integer;
begin
  //crear paleta de tono rojo
  for i:=0 to Image3.Height-1 do begin
    for j:=0 to image3.Width-1 do begin
       Image3.Canvas.Pixels[j,i]:=RGB(0,0,j);
    end;
  end;
  //calcular y graficar histograma azul
end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  BM:=Tbitmap.Create;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
i,j,yp       : Integer;
MAX          : Integer;
begin
  //limpiar Canvas de Histograma
  Image2.Canvas.Pen.Color:=CLWhite;
  Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);

  //crear paleta de tonos 0...255 verde  en Image 3
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

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

end.

