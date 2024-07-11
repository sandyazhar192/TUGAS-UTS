unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls;

type
  TForm1 = class(TForm)
    lbl1: TLabel;
    lbl2: TLabel;
    edt1: TEdit;
    edt2: TEdit;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    dbgrd1: TDBGrid;
    lbl3: TLabel;
    edt3: TEdit;
    lbl4: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure dbgrd1CellClick(Column: TColumn);
    procedure posisiawal;
    procedure FormCreate(Sender: TObject);
    procedure edt3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a: string;

implementation

uses
  Unit2;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
DataModule2.Zsatuani1.SQL.Clear;
DataModule2.Zsatuani1.SQL.Add('insert into satuan values(null,"'+edt1.Text+'","'+edt2.Text+'")');
DataModule2.Zsatuani1.ExecSQL ;

DataModule2.Zsatuani1.SQL.Clear;
DataModule2.Zsatuani1.SQL.Add('select * from satuan');
DataModule2.Zsatuani1.Open;
ShowMessage('Data Berhasil DiSimpan!');
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
begin
  if edt1.Text = '' then
  begin
    ShowMessage('Nama Satuan Tidak Boleh Kosong!');
  end
  else if edt2.Text = '' then
  begin
    ShowMessage('Deskripsi Tidak Boleh Kosong!');
  end
  else if (edt1.Text = DataModule2.Zsatuani1.FieldByName('nama').AsString) and
          (edt2.Text = DataModule2.Zsatuani1.FieldByName('deskripsi').AsString) then
  begin
    ShowMessage('Data Satuan ' + edt1.Text + ' Tidak Ada Perubahan');
  end
  else
  begin
    // Update operation
    with DataModule2.Zsatuani1 do
    begin
      SQL.Clear;
      SQL.Add('update satuan set nama = "' + edt1.Text + '", deskripsi = "' + edt2.Text + '" where id = "' + a + '"');
      ExecSQL;

      SQL.Clear;
      SQL.Add('select * from satuan');
      Open;
    end;
    ShowMessage('Data Berhasil Diupdate!');
  end;
end;
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
begin
if MessageDlg('Apakah Anda Yakin Menghapus Data ini',mtWarning,[mbYes,mbNo],0)=mryes then
begin
with DataModule2.Zsatuani1 do
begin
SQL.Clear;
SQL.Add('delete from satuan where id= "'+a+'"');
ExecSQL ;

SQL.Clear;
SQL.Add('select * from satuan');
Open;
end;
ShowMessage('Data Berhasil DiDelete!');
end else
begin

ShowMessage('Data Batal Dihapus!');

end;
end;
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
edt1.Clear;
edt2.Clear;
edt1.Enabled:= True;
btn1.Enabled:= True;
btn2.Enabled:= False;
btn3.Enabled:= False;
btn4.Enabled:= False;
end;

procedure TForm1.dbgrd1CellClick(Column: TColumn);
begin
edt1.Text:= DataModule2.Zsatuani1.Fields[1].AsString;
edt2.Text:= DataModule2.Zsatuani1.Fields[2].AsString;
a:= DataModule2.Zsatuani1.Fields[0].AsString;

edt1.Enabled:= True;
btn1.Enabled:= False;
btn2.Enabled:= True;
btn3.Enabled:= True;
btn4.Enabled:= True;
end;

procedure TForm1.posisiawal;
begin
edt1.Enabled:= False;
btn1.Enabled:= True;
btn2.Enabled:= false;
btn3.Enabled:= false;
btn4.Enabled:= false;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
edt1.Enabled:= True;
btn1.Enabled:= True;
btn2.Enabled:= False;
btn3.Enabled:= False;
btn4.Enabled:= False;
end;

procedure TForm1.edt3Change(Sender: TObject);
begin
with DataModule2.Zsatuani1 do
begin
SQL.Clear;
SQL.Add('select * from satuan where nama like "%'+edt3.Text+'%"');
Open;
end;
end;

end.
