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
    Label1: TLabel;
    Label2: TLabel;
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
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure RadioButton3Change(Sender: TObject);
  private

  public
    procedure suma(var M1, M2:MATRGB);
    procedure resta(var M1, M2:MATRGB);
    procedure mult(var M1, M2:MATRGB);
    procedure divn(var M1, M2:MATRGB);
    procedure op_and(var M1, M2:MATRGB);
    procedure op_OR(var M1, M2:MATRGB);
    procedure op_XOR(var M1, M2:MATRGB);
    procedure OP_MAX(var M1, M2:MATRGB);
    procedure op_min(var M1, M2:MATRGB);

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

//Operacion min
procedure tform8.OP_min(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= min(M1[i,j,k], M2[i,j,k]);

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

//Operacion MAX
procedure tform8.OP_MAX(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= MAX(M1[i,j,k], M2[i,j,k]);

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

//AND LOGICO
procedure tform8.op_and(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= (M1[i,j,k] AND  M2[i,j,k]);

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

 //OR LOGICO
procedure TForm8.op_OR(var M1, M2: MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= (M1[i,j,k] OR  M2[i,j,k]);

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;
//XOR LOGICO
procedure TForm8.op_XOR(var M1, M2: MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= (M1[i,j,k] XOR  M2[i,j,k]);

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

//resta
procedure tform8.resta(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin
        if  (M1[i,j,k] >= M2[i,j,k]) then begin
            MAT_ALU3[i,j,k]:= abs((M1[i,j,k] - M2[i,j,k]));
        end
        else begin
            MAT_ALU3[i,j,k]:= 0;
        end;
        BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
       end;
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

//multiplicacion
procedure tform8.mult(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= (M1[i,j,k] * M2[i,j,k]) div 255;

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

//division --NO FUNCIONA
procedure tform8.divn(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
     (*+++++++++++++++++++++++++++++++++++++++++++++++++*)
          if M2[i,j,0]=0 then begin
             MAT_ALU3[i,j,0]:= (M1[i,j,0]) ;
          end
          else begin
             MAT_ALU3[i,j,0]:= (M1[i,j,0] div M2[i,j,0]) ;
          end;

          if M2[i,j,1]=0 then begin
             MAT_ALU3[i,j,1]:= (M1[i,j,1]) ;
          end
          else begin
             MAT_ALU3[i,j,1]:= (M1[i,j,1] div M2[i,j,1]) ;
          end;

           if M2[i,j,2]=0 then begin
             MAT_ALU3[i,j,2]:= (M1[i,j,2]) ;
          end
          else begin
             MAT_ALU3[i,j,2]:= (M1[i,j,2] div M2[i,j,2]) ;
          end;
      (*+++++++++++++++++++++++++++++++++++++++++++++++++*)
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;
//suma
procedure tform8.suma(var M1, M2:MATRGB);
var
  nn,mm,i,j,k :Integer;
begin
   nn:=min(ANCHO_alu1,ANCHO_alu2);
   mm:=min(ALTO_alu1,ALTO_alu2);

   BM_alu3.SetSize(nn,mm);

   Edit1.Text:=inttostr(nn);
   Edit2.Text:=inttostr(mm);

   setlength(MAT_ALU3,nn,mm,3);

   for i:=0 to nn-1 do begin
     for j:=0 to mm-1 do begin
       for k:=0 to 2 do begin

        MAT_ALU3[i,j,k]:= (M1[i,j,k] + M2[i,j,k]) div 2;

       end;
       BM_alu3.Canvas.Pixels[i,j]:=RGB(MAT_ALU3[i,j,0],MAT_ALU3[i,j,1],MAT_ALU3[i,j,2]);
     end;
   end;

   Image3.Picture.Assign(BM_alu3);

end;

 //abrir imagen 1
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
 //save img 3
procedure TForm8.Button3Click(Sender: TObject);
begin
    if (SaveDialog1.Execute) then
  begin
    BM_alu3.SaveToFile(SaveDialog1.FileName);
  end;
end;
 //suma
procedure TForm8.Button4Click(Sender: TObject);
begin
  suma(MAT_alu1,MAT_alu2);
end;
//resta
procedure TForm8.Button5Click(Sender: TObject);
begin
     resta(MAT_alu1,MAT_alu2);
end;
 //multiplicación
procedure TForm8.Button6Click(Sender: TObject);
begin
     mult(MAT_alu1,MAT_alu2);
end;
//divison
procedure TForm8.Button7Click(Sender: TObject);
begin
    divn(MAT_alu1,MAT_alu2);
end;
 //and
procedure TForm8.Button8Click(Sender: TObject);
begin
  op_and(MAT_alu1,MAT_alu2);
end;

procedure TForm8.Button9Click(Sender: TObject);
begin
   op_OR(MAT_alu1,MAT_alu2);
end;

procedure TForm8.Button10Click(Sender: TObject);
begin
    op_XOR(MAT_alu1,MAT_alu2);
end;

procedure TForm8.Button11Click(Sender: TObject);
begin
  OP_MAX(MAT_alu1,MAT_alu2);
end;

procedure TForm8.Button12Click(Sender: TObject);
begin
  OP_MIN(MAT_alu1,MAT_alu2);
end;

procedure TForm8.FormCreate(Sender: TObject);
begin
   BM_alu1:=Tbitmap.Create;
   BM_alu2:=Tbitmap.Create;
   BM_alu3:=Tbitmap.Create;
end;

procedure TForm8.RadioButton1Change(Sender: TObject);
begin
    panel2.Enabled:=True;
    panel3.Enabled:=False;
    panel4.Enabled:=False;

    panel2.Color  :=RGB(0,255,0);
    panel3.Color  :=clWhite;
    panel4.Color  :=clWhite;
end;

procedure TForm8.RadioButton2Change(Sender: TObject);
begin
    panel2.Enabled:=False;
    panel3.Enabled:=True;
    panel4.Enabled:=False;

    panel2.Color  :=clWhite;
    panel3.Color  :=RGB(0,255,0); ;
    panel4.Color  :=clWhite;
end;

procedure TForm8.RadioButton3Change(Sender: TObject);
begin
  panel2.Enabled:=False;
  panel3.Enabled:=False;
  panel4.Enabled:=True;

  panel2.Color  :=clWhite;
  panel3.Color  :=clWhite;
  panel4.Color  :=RGB(0,255,0);
end;

end.

