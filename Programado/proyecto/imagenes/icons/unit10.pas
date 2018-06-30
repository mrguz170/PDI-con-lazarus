unit Unit10;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ColorBox,
  ExtCtrls, StdCtrls, ExtDlgs,LCLintf, Buttons;

type
    MATRGB=Array of Array of Array of Byte;
    MATCONV=Array[0..2,0..2] of Integer;
    BM_ARRAY = ARRAY[0..4] of Tbitmap;
  { TForm9 }

  TForm9 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    ScrollBox1: TScrollBox;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private

  public
    procedure gaussiano(var BM: Tbitmap);
    procedure suavizar(var arr_BM: BM_ARRAY);
    procedure veces(var BM:Tbitmap; indx:Integer);
  end;

  CONST
  //GAUSS mask
  gauss: MATCONV= ((1, 2, 1),
                   (2, 4, 2),
                   (1, 2, 1));

var
  Form9: TForm9;
  BM   : Tbitmap;
  MAT_tim, AUX : MATRGB;
  arr_BM  : BM_ARRAY;
  ALTO, ANCHO, cnt : Integer;

implementation
USES unit1;

{$R *.lfm}

{ TForm9 }
procedure TForm9.veces(var BM:Tbitmap; indx:Integer);
var i: Integer;
begin
   for i:=0 to indx do begin
       gaussiano(BM);
   end;
end;

//
procedure TForm9.suavizar(var arr_BM: BM_ARRAY);
 var i :Integer;
begin
  for i:=1 to 4 do begin
    veces(arr_BM[i],i);
  end;
end;

//GAUSS
procedure TForm9.gaussiano(var BM: Tbitmap);
var
  i,j,k,a,b,cnv   : Integer;
begin
  //hacer convoluvion de imagn con MASC
      for i:=1 to ANCHO-2 do begin
        for j:=1 to ALTO-2 do begin

            for k:=0 to 2 do begin
                cnv:=0;

                for a:=-1 to 1 do begin
                  for b:=-1to 1 do begin
                      cnv:= cnv + (gauss[a+1,b+1] * ((MAT_tim[i+a,j+b,k])));
                  end;
                end;//a

             AUX[i,j,k]:=abs(cnv) div 16; //almacenar en aux

            end;//k
        end;//j
      end;//i
      ///

      //copiar a MAT, BM
      for i:=0 to ANCHO-1 do begin
          for j:=0 to ALTO-1  do begin
              for k:=0 to 2 do begin
                  MAT_tim[i,j,k] := AUX[i,j,k];
              end;
              BM.Canvas.Pixels[i,j]:=RGB(MAT_tim[i,j,0],MAT_tim[i,j,1],MAT_tim[i,j,2]);
          end;
      end;

end;

//open
procedure TForm9.Button1Click(Sender: TObject);
var
  i,j  : Integer;
  c       : Tcolor;     //puede ser Tcolor o Integer
begin
  //abrir imagen
  if (OpenPictureDialog1.Execute) then
  begin

    ScrollBox1.Enabled:=True;
    //asignar archivo a BM
    for i:=0 to 4 do begin
      arr_BM[i].LoadFromFile(OpenPictureDialog1.FileName);
      if (arr_BM[i].PixelFormat<>pf24bit) then
      begin
      arr_BM[i].PixelFormat:=pf24bit;
      end;
    end;

    Image1.Picture.Assign(arr_BM[cnt]);

    ALTO:=arr_BM[cnt].Height;
    ANCHO:=arr_BM[cnt].Width;

    //crear arreglo 3D RGB de ALTOxANCHOx3
    setlength(MAT_tim,ANCHO,ALTO,3);
    setlength(AUX, ANCHO, ALTO,3);

    //leer y copiar RGB de imagen a MAT_tim
    for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1 do begin
        c:=arr_BM[cnt].Canvas.Pixels[i,j];
        //matriz para canvas
        MAT_tim[i,j,0]:=GetRvalue(c);
        MAT_tim[i,j,1]:=GetGvalue(c);
        MAT_tim[i,j,2]:=GetBvalue(c);
        //matriz para recargar

      end; //j
    end;//i

    suavizar(arr_BM);
  end;  //open

end;
//start
procedure TForm9.Button2Click(Sender: TObject);
begin
   if Button2.Caption='Start' then begin
      Button2.Caption:='Stop';
      Timer1.Enabled:=TRUE;
   end else begin
      Button2.Caption:='Start';
      Timer1.Enabled:=False;
   end;


end;
//conv
procedure TForm9.Button3Click(Sender: TObject);
begin
   gaussiano(arr_BM[0]);
end;

procedure TForm9.FormCreate(Sender: TObject);
var
i :Integer;
begin
  //BM:=Tbitmap.Create;
  for i:=0 to 4 do begin
      arr_BM[i]:=Tbitmap.Create; ;
  end;
  cnt:=0;
end;
//timer
procedure TForm9.Timer1Timer(Sender: TObject);
begin
   Image1.Picture.Assign(arr_BM[4-cnt]);
   Edit1.Text:=intTOstr(cnt+1);
   if cnt >= 4 then begin
     cnt:=0;
   end
   else  begin
     cnt:=cnt+1;
   end;
end;

end.

