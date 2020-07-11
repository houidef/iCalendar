unit uFormParent;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls,PNGImage, ExtCtrls,
  gdipapi,gdipobj,GDIPUTIL,IniFiles;

type

  TRectangle = class
  public
    x:Integer;
    y:integer;
    width : integer;
		height : integer;
    procedure Position(x,y,width,Height: integer);
    function contains(x,y:integer):boolean;
  end;
  TFormParent =  class(TForm)
  protected
    procedure SetLayerForm(bitmap: tgpbitmap;show:boolean);
    procedure SetWindowModel(Desktop : Boolean);
  private
      oldpoint : TPoint;
     procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
     procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
     procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
     procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
     procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
     public
       isMouseDown : Boolean;
       isMouseMove : Boolean;
       isMouseIn : boolean;
       CurrentDate : TDateTime;
       closeIconRect : TRectangle;
       menuIconRect : TRectangle;
       FFile: TIniFile;
       procedure DrawMenuButton(Graphics: GPGraphics);
       constructor Create(AOwner: TComponent); override;
       destructor Destroy; override;
       procedure InitPosition();
       procedure PositionManagement(x,y:integer);

  end;
implementation

{ TFormParent }

procedure TFormParent.CMMouseEnter(var Message: TMessage);
begin
        isMouseIn := true;
        Repaint;
end;

procedure TFormParent.CMMouseLeave(var Message: TMessage);
begin
      isMouseIn := false;
      Repaint;
end;

constructor TFormParent.create(AOwner: TComponent);
begin
  inherited;
  isMouseMove := false;
  closeIconRect := TRectangle.Create;
  menuIconRect := TRectangle.Create;
  CurrentDate := Date;
  InitPosition;
end;

procedure TFormParent.DrawMenuButton(Graphics: GpGraphics);
var
  Image: tgpbitmap;
begin
   Image:= tgpbitmap.Create('BlackGlass\close.png');
   TGpGraphics(Graphics).DrawImage(Image,195,11);
   Image:= tgpbitmap.Create('BlackGlass\menu.png');
   TGpGraphics(Graphics).DrawImage(Image,55,13);
   closeIconRect.Position(195,11,16,16);
   menuIconRect.Position(55,13,16,16);
end;

procedure TFormParent.InitPosition;
var
   FormCalendarPosX, FormCalendarPosY : integer;
   FormWeatherPosX, FormWeatherPosY : integer;

begin

  FFile:= TIniFile.Create(GetCurrentDir + '\initializer.ini');
 // FFile.WriteInteger('FormCalendar', 'CurrentPosX', 5);
  FormCalendarPosX := FFile.ReadInteger('FormCalendar', 'CurrentPosX', 0);
  FormCalendarPosY := FFile.ReadInteger('FormCalendar', 'CurrentPosY', 0);
  FormWeatherPosX := FFile.ReadInteger('FormWeather', 'CurrentPosX', 0);
  FormWeatherPosY := FFile.ReadInteger('FormWeather', 'CurrentPosY', 0);
   if(Name = 'FormCalendar') then
        PositionManagement(FormCalendarPosX,FormCalendarPosY)
   else  if(Name = 'FormEvent') then  begin
        PositionManagement(10,10);
   end else begin
      PositionManagement(FormWeatherPosX,FormWeatherPosY);
   end;
end;

procedure TFormParent.SetLayerForm(bitmap: tgpbitmap;show:boolean);
var
   pt1, pt2 : TPoint;
  sz : TSize;
  bf : TBlendFunction;
  nTran : Integer;
  bmp, old_bmp : HBITMAP;
  DC : HDC;
begin
  nTran := 255;
   pt1 := Point(left,top);
  pt2 := Point(0, 0);
  sz.cx := {bitmap.Get}Width;
  sz.cy := {bitmap.Get}Height;
  bf.BlendOp := AC_SRC_OVER;
  bf.BlendFlags := 0;
  if (nTran<0) or (nTran>255) then nTran:=255;
  bf.SourceConstantAlpha := nTran;
  bf.AlphaFormat := AC_SRC_ALPHA;
  DeleteObject(bmp);
  bitmap.GetHBITMAP(0,bmp);
  DeleteDC(DC);
  DC := CreateCompatibleDC(Canvas.Handle);
  old_bmp := SelectObject(DC, bmp);
  UpdateLayeredWindow(Handle, Canvas.Handle, @pt1, @sz, DC, @pt2,0, @bf,ULW_ALPHA);
end;

procedure TFormParent.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  isMouseDown := true;
  oldpoint.X := X;
  oldpoint.Y := Y;
    if (closeIconRect.Contains(x,y)) then
    begin
       Close();
    end;
end;

procedure TFormParent.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (isMouseDown and (ssLeft in shift) and (oldpoint.X <> X) and (oldpoint.Y <> Y)) then
  begin
    isMouseMove := true;
    Left := Left+x-oldpoint.X;
    top := top+Y-oldpoint.Y;
  end;
end;

procedure TFormParent.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  isMouseDown := false;
  isMouseMove := false;
end;

procedure TFormParent.PositionManagement(x, y: integer);
begin
  Left := X;
  Top := Y;
end;

procedure TFormParent.SetWindowModel(Desktop: Boolean);
begin
  //hwndParent := FindWindowEx(Handle,Handle,'WorkerW', '');
  //SetParent(Application.Handle, Handle);
  //SetWindowLong(application.handle, GWL_EXSTYLE, WS_EX_TOOLWINDOW);
  //SetWindowPos(Self.Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOACTIVATE);
  if SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_LAYERED) = 0 then ShowMessage(SysErrorMessage(GetLastError));

end;

destructor TFormParent.Destroy;
begin

  inherited;
  FFile.Free;
end;

{ TRectangle }

function TRectangle.contains(x, y: integer): boolean;
begin
 Result := (self.X <= x) and (x < self.X + self.Width) and (self.Y <= y) and (y < self.Y + self.Height);
end;

procedure TRectangle.Position(x, y, width, Height: integer);
begin
  Self.x := X;
  Self.y := Y;
  Self.width := width;
  Self.height := height;
end;

end.
