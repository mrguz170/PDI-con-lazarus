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
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    OpenPictureDialog1: TOpenPictureDialog;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
      );
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
  private

  public
    procedure grises(var M:MATRGB);
    procedure promgris(var M:MATRGB);

  end;

var
  Form1: TForm1;
  BM            : Tbitmap;
  MAT           : MATRGB;
  ALTO, ANCHO   : Integer;

implementation

{$R *.lfm}

{ TForm1 }
//procedimientos propios

procedure tform1.grises(var M:MATRGB);
var
  i,j : Integer;
  //k   : Byte;
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

procedure tform1.promGris(var M:MATRGB);
var
  i,j,k   : Integer;
  sum     : Integer;
  x,y,z  : Byte;
  res    : Byte;
  d      : Byte;

begin
  sum:=0;
  Label1.Caption := 'Gris por promedio';
     for i:=0 to ANCHO-1 do begin
        for j:=0 to ALTO-1 do begin

            M[i,j,0]:= M[i,j,0] + M[i,j,1] + M[i,j,2];
            //res:= truncate(sum);
            BM.Canvas.Pixels[i,j]:= RGB(M[i,j,0],M[i,j,0],M[i,j,0]);
        end;
    end;
     //refresh img
  Image1.Picture.Assign(BM);

end;
//  fin procedimientos propios    //

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
    //promGris(MAT);
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
    promGris(MAT);
end;

procedure TForm1.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  BM:=Tbitmap.Create;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //grises(MAT);
  //promGris(MAT);
  Edit1.text:= 'Hola mundo';
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

end.

