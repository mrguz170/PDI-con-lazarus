unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    //zona de declaraión de variables, procedimientos públicos

   procedure suma (S1:Integer; S2:Integer; var Res:Integer) ;

  end;

var
  //variables globales
  Form1: TForm1;
  //Variables sumandos
  A,B : Integer;
  //Resultado
  R: Integer;

  //     Arreglo unidimensional
  AR: Array[0..9] of Integer;

  //Arreglo bidimensional

  Mat: Array[0..5] of Array[0..9] of integer;


implementation

{$R *.lfm}

{ TForm1 }

procedure tform1.suma(S1:Integer; S2:Integer; var Res:Integer);
begin

  Res:=S1+S2;

end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  //Inicializar valores

  Edit2.Text:=' ';
  Edit3.Text:=' ';
  Edit4.Text:=' ';


end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  //Enviar cadena a la propiedad texto de Edit1
  Edit1.Text:='Hola Mundo...';

end;

procedure TForm1.Button2Click(Sender: TObject);
begin

  //almacenar valores de variables:

  A:=StrToInt(Edit2.Text);
  B:=StrToInt(Edit3.Text);
//  R:=A+B;
 //con procedimiento declarado llamado suma
  suma(A,B,R);
  Edit4.Text:=IntToStr(R);



end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i: byte;

begin
   //llenar el arreglo

  for i:=0 to 9 do
  begin
    AR[i]:=random(100);

  end;


end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i:Byte;
begin
   //recorrer arreglo y mostrar elementos en caja de texto
  Edit5.Text:=' ';

  for i:=0 to 9 do
  begin
     Edit5.Text:=Edit5.text+ ','+ IntToStr(AR[i]);



  end;


end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i,j: byte;
begin
  //llenar mariz con valores aleatorios
  for i:=0 to 5 do
  begin
      for j:=0 to 9 do
      begin
         Mat[i,j]:=Random(50);
      end;
  end;

end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i,j :Byte;
  Renglon:String;
begin

  Memo1.Text:=' ';


  //recorrer matriz y mostrar elementos en TMemo

  for i:=0 to 5 do
  begin
     Renglon:=' ';
     for j:=0 to 9 do
     begin
        Renglon:=Renglon + inttostr(MAT[i,j])+ ', ';
     end;
      Memo1.Lines.Add(Renglon);      //añadir renglon en Memo
  end;

end;
end.

