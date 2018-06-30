unit Unit7;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, LCLintf,
  ExtCtrls;

type
  kernel=Array[0..2,0..2] of Byte;
  MATRGB=Array of Array of Array of Byte;

  { TForm7 }

  TForm7 = class(TForm)
  private
    procedure erosionBin(var M:MATRGB);
    procedure dilatacionbin(var M:MATRGB);
    procedure erosionGris(var M:MATRGB);
    procedure dilatacionGris(var M:MATRGB);
    //FUNCTION dilatacionGris(var M:MATRGB):MATRGB;
  public
    procedure open(var M:MATRGB);
    procedure close(var M:MATRGB);

    procedure openGris(var M:MATRGB);
    procedure closeGris(var M:MATRGB);
    procedure tophat(var M, M_X:MATRGB);
    procedure gradiente(var M:MATRGB);


  end;

  CONST
  //estructura para operaciones morfologicas
  B1: kernel=((1, 1, 1),
              (1, 1, 1),
              (1, 1, 1  ));

var
  Form7: TForm7;
  Mtmp      : MATRGB;
  M1,M2: MATRGB;

implementation
uses unit1;

{$R *.lfm}

//---------------metodos gus-----------------//
//-------------------------------------------//


//Gradiente
procedure tform7.gradiente(var M:MATRGB);
var i,j,k:   Integer;
begin
  setlength(M1, unit1.Ancho, unit1.Alto,3);
  setlength(M2, unit1.Ancho, unit1.Alto,3);

  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          for k:=0 to 3 do begin
             M1[i,j,k]:=M[i,j,k];
             M2[i,j,k]:=M[i,j,k];
          end;
      end;
  end;

  dilatacionGris(M1);
  erosionGris(M2);

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          for k:=0 to 3 do begin
               M[i,j,k]:=M1[i,j,k]-M2[i,j,k];
          end;

        BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;

  form1.verImgHis();

end;

//tophat
procedure tform7.tophat(var M, M_X:MATRGB);
var
  i,j,sum: Integer;
begin
  //apertura sobre MAT
  opengris(M);

  //valor original - Mtmp
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          Mtmp[i,j,0]:=M_X[i,j,0]-M[i,j,0];
          Mtmp[i,j,1]:=M_X[i,j,1]-M[i,j,1];
          Mtmp[i,j,2]:=M_X[i,j,2]-M[i,j,2];
      end;
  end;

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
      M[i,j,0]:=Mtmp[i,j,0];
      M[i,j,1]:=Mtmp[i,j,1];
      M[i,j,2]:=Mtmp[i,j,2];
      BM.Canvas.Pixels[i,j]:=RGB(Mtmp[i,j,0],Mtmp[i,j,1],Mtmp[i,j,2]);
      end;
  end;
  form1.verImgHis();
end;

//Apertura GRIS
procedure tform7.openGris(var M:MATRGB);
begin
  erosionGris(M);
  dilatacionGris(M);
end;
//Clausura GRIS
procedure tform7.closeGris(var M:MATRGB);
begin
   dilatacionGris(M);
   erosionGris(M);
end;

//Apertura BIN
 procedure tform7.open(var M:MATRGB);
 begin
   erosionBin(M);
   dilatacionBin(M);
   form1.verImgHis();
 end;
 //Cierre BIN
 procedure tform7.close(var M:MATRGB);
 begin
   dilatacionBin(M);
   erosionBin(M);
   form1.verImgHis();
 end;

//Erosion GRIS
procedure tform7.erosionGris(var M:MATRGB);
var
  i,j,a,b,min : Integer;
begin
  setlength(Mtmp, ANCHO,ALTO,3);

  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

          min:=255;
          for a:=-1 to 1 do begin
             for b:=-1to 1 do begin

                 if M[i+a,j+b,0]<min then min:=M[i+a,j+b,0];

             end; //b
          end;//a

         Mtmp[i,j,0]:=min;
         Mtmp[i,j,1]:=min;
         Mtmp[i,j,2]:=min;

    end;
  end;//end i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
      M[i,j,0]:=Mtmp[i,j,0];
      M[i,j,1]:=Mtmp[i,j,1];
      M[i,j,2]:=Mtmp[i,j,2];
      //BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;

  form1.verImgHis();
end;

//Dilatacion GRIS
procedure tform7.dilatacionGris(var M:MATRGB);
var
  i,j,a,b,MAX : Integer;
begin
  setlength(Mtmp, ANCHO,ALTO,3);

  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

          MAX:=0;
          for a:=-1 to 1 do begin
             for b:=-1to 1 do begin

                 if M[i+a,j+b,0]>MAX then MAX:=M[i+a,j+b,0];

             end; //b
          end;//a

         Mtmp[i,j,0]:=MAX;
         Mtmp[i,j,1]:=MAX;
         Mtmp[i,j,2]:=MAX;

    end;
  end;//end i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
      M[i,j,0]:=Mtmp[i,j,0];
      M[i,j,1]:=Mtmp[i,j,1];
      M[i,j,2]:=Mtmp[i,j,2];
      //BM.Canvas.Pixels[i,j]:=RGB(M[i,j,0],M[i,j,1],M[i,j,2]);
      end;
  end;

  form1.verImgHis();
end;


//erosion BINARIA
procedure tform7.erosionBin(var M:MATRGB);
var
  i,j,a,b,val,bval : Integer;
  fnd           :Boolean;
begin

  setlength(Mtmp, ANCHO,ALTO,3);

  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin
        //bandera
        fnd:=True;

          for a:=-1 to 1 do begin
             for b:=-1to 1 do begin

                   val:=M[i+a,j+b,0];
                   bval:=B1[a+1,b+1];

                   if val <> bval then fnd:=False;

             end; //b
          end;//a

        //si coincide toda la estructura entonces no se preserva
        if fnd=True then
          begin
          //Si Coincide estructura

            Mtmp[i,j,0]:=255;
            Mtmp[i,j,1]:=255;
            Mtmp[i,j,2]:=255;

        end//end if
        Else begin
            Mtmp[i,j,0]:=0;
            Mtmp[i,j,1]:=0;
            Mtmp[i,j,2]:=0;
        end;
    end;
  end;//end i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
      M[i,j,0]:=Mtmp[i,j,0];
      M[i,j,1]:=Mtmp[i,j,1];
      M[i,j,2]:=Mtmp[i,j,2];
      BM.Canvas.Pixels[i,j]:=RGB(Mtmp[i,j,0],Mtmp[i,j,1],Mtmp[i,j,2]);
      end;
  end;
  //form1.verImgHis();
end;

//dilatacion BINARIA
procedure tform7.dilatacionbin(var M:MATRGB);
var
  i,j,a,b,val,bval : Integer;
  fnd           :Boolean;
begin
  //form1.ant();
  setlength(Mtmp, ANCHO,ALTO,3);

  for i:=1 to ANCHO-2 do begin
    for j:=1 to ALTO-2 do begin

        fnd:=False;

          for a:=-1 to 1 do begin
             for b:=-1to 1 do begin

                   val:=M[i+a,j+b,0];
                   bval:=B1[a+1,b+1];

                   if val=bval then fnd:=TRUE;

             end; //b
          end;//a

        //si coincide toda la estructura entonces no se preserva
        if fnd=True then
          begin
          //Si Coincide estructura
            for a:=-1 to 1 do begin
             for b:=-1to 1 do begin
                Mtmp[i,j,0]:=255;
                Mtmp[i,j,1]:=255;
                Mtmp[i,j,2]:=255;
             end; //b
          end;//a
        end //end if

    end;
  end;//end i

  //copiar a MAT, BM
  for i:=0 to ANCHO-1 do begin
      for j:=0 to ALTO-1  do begin
          M[i,j,0]:=Mtmp[i,j,0];
          M[i,j,1]:=Mtmp[i,j,1];
          M[i,j,2]:=Mtmp[i,j,2];
      BM.Canvas.Pixels[i,j]:=RGB(Mtmp[i,j,0],Mtmp[i,j,1],Mtmp[i,j,2]);
      end;
  end;
  //form1.verImgHis();
end;


end.

