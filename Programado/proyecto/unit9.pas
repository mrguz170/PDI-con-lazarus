unit Unit9;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons,LCLintf, ExtDlgs, math;

type

  { TForm8 }

  MATRGB=Array of Array of Array of Byte;

  TForm8 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    OpenPictureDialog2: TOpenPictureDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    SaveDialog1: TSaveDialog;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    ScrollBox3: TScrollBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure suma(var M1, M2:MATRGB);

  end;

var
  Form8: TForm8;
  BM_alu1,BM_alu2,BM_alu3          : Tbitmap;
  ALTO_alu1, ANCHO_alu1: Integer;
  ALTO_alu2, ANCHO_alu2: Integer;
  ALTO_alu3, ANCHO_alu3: Integer;
  MAT_ALU1, MAT_ALU2, MAT_ALU3    :MATRGB;

implementation

{$R *.lfm}

{ TForm8 }

//------------------------- METODOS gus ---------------------------//
//-----------------------------------------------------------------//

//suma --NO funciona
procedure tform8.suma(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=max(ANCHO_alu1,ANCHO_alu2);
   mm:=max(ALTO_alu1,ALTO_alu2);

   BM_alu3.Width:=nn;
   BM_alu3.Height:=mm;

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for j:=0 to mm-1 do begin
     for i:=0 to nn-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= (M1[i,j,k] + M2[i,j,k]) div 2;

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Canvas.Assign(BM_alu3);

end;

procedure TForm8.Button1Click(Sender: TObject);
var
  i,j   : Integer;
  c       : Tcolor;     //puede ser Tcolor o Integer
begin
  //abrir imagen
  if (OpenPictureDialog1.Execute) then
  begin
    ScrollBox1.Enabled:=True;
    //asignar archivo a BM_alu1
    BM_alu1.LoadFromFile(OpenPictureDialog1.FileName);
    if (BM_alu1.PixelFormat<>pf24bit) then
    begin
    BM_alu1.PixelFormat:=pf24bit;
    end;

    Image1.Picture.Assign(BM_alu1);

    ANCHO_alu1:=BM_alu1.Width;
    ALTO_alu1:=BM_alu1.Height;


    //crear arreglo 3D RGB de ALTOxANCHOx3
    setlength(MAT_ALU1,ANCHO_alu1,ALTO_alu1,3);

    //leer y copiar RGB de imagen a MAT
    for i:=0 to ANCHO_alu1-1 do begin
      for j:=0 to ALTO_alu1-1 do begin
        c:=BM_alu1.Canvas.Pixels[i,j];
        //matriz para canvas
        MAT_alu1[i,j,0]:=GetRvalue(c);
        MAT_alu1[i,j,1]:=GetGvalue(c);
        MAT_alu1[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i


  end;
end;

procedure TForm8.Button2Click(Sender: TObject);
var
  i,j   : Integer;
  c       : Tcolor;     //puede ser Tcolor o Integer
begin
  //abrir imagen
  if (OpenPictureDialog2.Execute) then
  begin
    ScrollBox2.Enabled:=True;
    //asignar archivo a BM_alu2
    BM_alu2.LoadFromFile(OpenPictureDialog2.FileName);
    if (BM_alu2.PixelFormat<>pf24bit) then
    begin
    BM_alu2.PixelFormat:=pf24bit;
    end;

    Image2.Picture.Assign(BM_alu2);

    ANCHO_alu2:=BM_alu2.Width;
    ALTO_alu2:=BM_alu2.Height;

    //crear arreglo 3D RGB de ALTOxANCHOx3
    setlength(MAT_alu2,ANCHO_alu2,ALTO_alu2,3);

    //leer y copiar RGB de imagen a MAT
    for i:=0 to ANCHO_alu2-1 do begin
      for j:=0 to ALTO_alu2-1 do begin
        c:=BM_alu2.Canvas.Pixels[i,j];
        //matriz para canvas
        MAT_alu2[i,j,0]:=GetRvalue(c);
        MAT_alu2[i,j,1]:=GetGvalue(c);
        MAT_alu2[i,j,2]:=GetBvalue(c);
      end; //j
    end;//i

  end;
end;

procedure TForm8.Button4Click(Sender: TObject);
begin
  suma(MAT_alu1,MAT_alu2);
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
   BM_alu1:=Tbitmap.Create;
   BM_alu2:=Tbitmap.Create;
   BM_alu3:=Tbitmap.Create;
end;

end.

