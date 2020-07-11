// Modified by houidef 18-01-2020 10:35:20

unit uFormCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls,PNGImage, ExtCtrls,uFormParent,gdipapi,gdipobj,
  GDIPUTIL, contnrs, iCalendar, ShellAPI ;

  const
    WM_ICONTRAY             = WM_USER + 1;
  type
  TFormCalendar = class(TFormParent)
    PopupMenu1: TPopupMenu;
    E1: TMenuItem;
    rightContextMenuStrip1: TPopupMenu;
    MenuItem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDoubleClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    eventList : TCalendarEvents;
    daySelected : TDateTime;
    procedure InitializeComponent;
    procedure DispalyUpdate(num : integer);
    procedure DrawCalendar(Graphics: GPGraphics;num:integer);
    procedure DrawButton(Graphics:  GPGraphics);
    function Heightcalculation(currentdate : TDatetime) : integer;
    //procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    //procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    { Private declarations }
  public
    rectNxt,rectPre : TRectangle;
     MouseSelectDay : Boolean;
    TrayIconData: TNotifyIconData;
    function FindEventByDate(DateTime: TdateTime) : TCalendarEvents;
    function IsInDateArea(x,y:integer; var num : integer):Boolean;
    procedure TrayMessage(var Msg: TMessage); message WM_ICONTRAY;
    { Public declarations }
  end;

var
  FormCalendar: TFormCalendar;
  strArray : array[0..6] of string = ('S','D','L','M','M','J','V');
  Shortmonth : array[1..12] of string = ('JAN','FEV','MARS','AVR','MAI','JUIN','JUIL','AOUT','SEPT','OCT','NOV','DEC');
  Longmonth : array[1..12] of string = ('JAN','FEV','MARS','AVR','MAI','JUIN','JUIL','AOUT','SEPT','OCT','NOV','DEC');

implementation

{$R *.dfm}
   uses
     uskin, DateUtils,uFormEventEdit, Math, uFormWeather;
procedure TFormCalendar.FormCreate(Sender: TObject);
var
 i : integer;
begin
  with TrayIconData do
  begin
    cbSize := SizeOf(TrayIconData);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_MESSAGE + NIF_ICON + NIF_TIP;
    uCallbackMessage := WM_USER + 1;
    hIcon := Application.Icon.Handle;
    StrPCopy(szTip, Application.Title);
  end;
 Shell_NotifyIcon(NIM_ADD, @TrayIconData);

  for i:= 1 to 12 do
  begin
    shortMonthNames[i] := Shortmonth[i];
    LongMonthNames[i] := Longmonth[i];
  end;

  InitializeComponent;
  SetWindowModel(True);
   Font.Color := clWhite;
  //GlassFrame.SheetOfGlass := True;
  //GlassFrame.Enabled := True;
  DispalyUpdate(-1);
  Formweather := TFormWeather.create(Owner);
  Formweather.show;
end;

{ TFormParent }

procedure  TFormCalendar.InitializeComponent;
begin
   Name := 'FormParent';
   eventList := TCalendarEvents.Create;
   //testing!
   eventList.load;
  // eventList.AjouterEvent(date-1,date-1,'Hello');
   rectNxt := TRectangle.Create;
   rectPre := TRectangle.Create;
   rectPre.x := 6;
   rectPre.y := 10;
   rectPre.width := 10;
   rectPre.height := 10;
   rectNxt.x :=  180;
   rectNxt.y :=  10;
   rectNxt.width := 10;
   rectNxt.height := 10;
end;


procedure TFormCalendar.E1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormCalendar.DispalyUpdate(num: integer);
  var
  Skin : TSkin;
  W:TPoint;
  bitmap,bitmapZ,Image: tgpbitmap;
  graphics : TGPGraphics;
  pen: TGPPen;
  encoderClsid: TGUID;
  S: WideString;
  GPFont: TGPFont;
  GPGraphics: TGPGraphics;
  GPSolidBrush: TGPSolidBrush;
  GPGraphicsPath: TGPGraphicsPath;
  stringFormat: TGPStringFormat ;
  destHeight : Integer;
begin
   Skin := TSkin.create;
   destHeight := Heightcalculation(currentdate);
   bitmap:=tgpbitmap.Create(Skin.CalFormBackground_Bitmap);
   if(destHeight <= bitmap.getHeight) then Height :=  bitmap.getHeight
   else Height :=  destHeight;
   Width :=  bitmap.getwidth;
   bitmapZ:=tgpbitmap.Create(width,Height,PixelFormat32bppARGB);
   graphics := TGPGraphics.Create(bitmapZ);
   Graphics.DrawImage(bitmap, 0, 0, Width, Height);
   DrawButton(graphics);
   DrawCalendar(graphics, num);
   SetLayerForm(bitmapZ,true);

end;

procedure TFormCalendar.DrawCalendar(Graphics: GPGraphics; num: integer);
var
  i,j,vspace,X,Y,D:integer;
  Year,Month,Day : Word;
  Point:TPoint;
  daySize : TPoint;
  dt : TDate;
  origin: TGPPointF ;
    S: WideString;
  GPFont: TGPFont;
  GPSolidBrush: TGPSolidBrush;
  GPGraphicsPath: TGPGraphicsPath;
  stringFormat: TGPStringFormat;
  WeekendColor,EventColor,color : TColor;
  Image,focus: tgpbitmap;
  list: TCalendarEvents;
begin
  WeekendColor := $FF8080FF;
  EventColor  := $FFF0C402;
  color := $FFFFFFFF;
   vspace := 20;
   DecodeDate(CurrentDate,Year,Month,Day);
   {Bitmap.Font.Color := $FFFFFFFF;
   Bitmap.Canvas.Font.Size := 10;
   Bitmap.Canvas.TextOut(20,8,);   }
   StringFormat  := TGpStringFormat.create();
   StringFormat.SetAlignment(StringAlignmentNear);
   StringFormat.SetLineAlignment(StringAlignmentNear);
    GPFont := TGPFont.Create('Muli', 10,1);
    GPSolidBrush := TGPSolidBrush.Create(color);
    GPGraphicsPath := TGPGraphicsPath.Create;
    GPGraphicsPath.AddString(S, Length(S), TGPFontFamily.Create(Font.Name),
    GPFont.GetStyle, GPFont.GetSize, MakePoint(20.0, 20.0), nil);
    S := FormatDateTime('yyyy',CurrentDate);
    TGPGraphics(Graphics).DrawString(S, Length(S), GPFont, MakePoint(130.0, 8.0), GPSolidBrush);
    S := ShortMonthNames[Month];
   TGPGraphics(Graphics).DrawString(S, Length(S), GPFont, MakePoint(20.0, 8.0), GPSolidBrush);
   Point.X:= 9;
   Point.Y:= 50;
   daySize.X := 30;
   {Bitmap.Canvas.Font.Color := clWhite;
   Bitmap.Canvas.Brush.Color := clBackground;
   Bitmap.Canvas.Brush.Style := bsClear; }
   for i:=0 to 6 do
   begin
       S := strArray[i];
       TGPGraphics(Graphics).DrawString(S, Length(S), GPFont, MakePoint(1.0 *(point.X + daySize.X * (((i + 6) mod 7) {+ (visible ? 1 : 0)}){+ num5}), (point.Y - font.Height) - 30), GPSolidBrush);
     // Bitmap.Canvas.TextOut(point.X + daySize.X * (((i + 6) mod 7) {+ (visible ? 1 : 0)}//){+ num5},(point.Y - font.Height) - 30,strArray[i]);
   end;
   D := DayOfWeek(EncodeDate(Year,Month,1));
   for j := D - 1 to DaysInMonth(CurrentDate) + (D - 1) - 1 do
   begin
     dt := EncodeDate(Year,Month,J - (D - 1) + 1);
     X := point.X + ((daySize.X) * ((j mod 7) {+ (visible ? 1 : 0)}));
     Y := point.Y + (vspace * (j div 7)) - 1 ;
     S := inttostr(J - D + 2);
      Image:= tgpbitmap.Create('BlackGlass\today.png');
      focus:= tgpbitmap.Create('BlackGlass\focus.png');
      if(dt = date) then
           TGPGraphics(Graphics).DrawImage(image,Makerect(X,Y,20,20));
      if( J  = num) then
      begin
        daySelected := dt;
        TGPGraphics(Graphics).DrawImage(focus,Makerect(X,Y,20,20));
      end;
      list := eventList.GetEvents(dt);//FindEventByDate(dt);
      if ((list <> nil) and (list.Count > 0))then
          TGPGraphics(Graphics).DrawString(S, Length(S), GPFont, MakePoint(1.0 * X, Y), {StringFormat ,}TGPSolidBrush.Create(EventColor))
      else if((J mod 7 = 6)or(J mod 7 = 5)) then
       TGPGraphics(Graphics).DrawString(S, Length(S), GPFont, MakePoint(1.0 * X, Y), {StringFormat ,}TGPSolidBrush.Create(WeekendColor))
     else
       TGPGraphics(Graphics).DrawString(S, Length(S), GPFont, MakePoint(1.0 * X, Y), {StringFormat ,}GPSolidBrush);
   end;
end;

procedure TFormCalendar.DrawButton(Graphics: GPGraphics);
var
  Image : tgpbitmap;
begin
    Image:= tgpbitmap.Create('BlackGlass\button-left.png');
    TGPGraphics(Graphics).DrawImage(Image,6,10);
   Image:= tgpbitmap.Create('BlackGlass\button-right.png');
   TGPGraphics(Graphics).DrawImage(Image,180,10);

   if(isMouseIn) then
      DrawMenuButton(Graphics);
end;

{
procedure TFormCalendar.CMMouseLeave(var Message: TMessage);
begin
end;

procedure TFormCalendar.CMMouseEnter(var Message: TMessage);
begin

end;           }

procedure TFormCalendar.FormPaint(Sender: TObject);
begin
 //DispalyUpdate(-1);
end;

function TFormCalendar.FindEventByDate(DateTime: TdateTime): TCalendarEvents;
var
  i : Integer;
begin
    Result := TCalendarEvents.Create;
    for i:= 0 to eventList.Count-1 do
       if(eventList.Event[i].StartEvent <= DateTime) and (eventList.Event[i].EndEvent >= DateTime) then
       Result.add(eventList.Event[i]);
end;

function TFormCalendar.IsInDateArea(x, y: integer;
  var num: integer): Boolean;
  var
    num2,num3,vspace,Dayspace,dayLines: Integer;
    rectFont,daySize : TRectangle;
begin
  {num2 := (Width - ClientSize.Width) / 2;
  num3 := (Height - ClientSize.Height) - num2;
  X := X + num2;
  Y := Y + num3; }
  rectFont := TRectangle.Create;
  daySize :=  TRectangle.Create;
  daySize.width  := 28;
  Dayspace := 28;
  vspace := 20;
  dayLines := 5;
  rectFont.X := 9;
  rectFont.Y := 50;
  rectFont.width := Dayspace * 7;
  rectFont.height := vspace * dayLines;

  if (rectFont.Contains(x,y))then
  begin
      num := trunc(trunc(((X - rectFont.X)) / daySize.Width) +(int((Y - rectFont.Y) / vspace ) * 7));
      result :=  true;
  end
  else
      result :=  false;
end;

procedure TFormCalendar.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    num :Integer;
begin
  inherited;
  if(ssleft in Shift)then FormMouseClick(Sender,Button,Shift,X,Y);
  if(ssDouble in Shift)then FormMouseDoubleClick(Sender,Button,Shift,X,Y);
  if (IsInDateArea(X,Y,num))  then
    DispalyUpdate(num)
  else
    DispalyUpdate(-1);
    //ShowMessage(IntToStr(num));
    Repaint;
end;

procedure TFormCalendar.FormMouseDoubleClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    num,num2,wchDaySlcted : integer;
    allCalendars : TCalendarEvents;
begin
  if (IsInDateArea(X,Y, num) and (num >= DayOfWeek(Date)))then
  begin
     num2 := num - DayOfWeek(Date) + 1;
     if (num2 <= DaysInMonth(Date))then
     begin
       allCalendars := eventList;//FormParent.objCalManager.GetAllCalendars();
       if (wchDaySlcted > 0)then
         { if (allCalendars.Count <= 0)then
             // MessageDlg('Please add a calendar first.','StringWarning',[btok,Exclamation]);
             MessageBox(Handle,'Please add a calendar first.','StringWarning',1)
          else }
          begin
            FormEventEdit.Initiliser(EventList,daySelected);
            if(FormEventEdit.ShowModal =  mrOk) then    // (daySelected, false).Show();
            begin
               eventList.AjouterEvent(
                    FormEventEdit.fromdate.DateTime,
                    FormEventEdit.todate.DateTime,
                    FormEventEdit.Summary.Text,
                    FormEventEdit.Description.Text,
                    FormEventEdit.Description.Text
               );
               DispalyUpdate(-1);//NeedRefresh;
               eventList.Save;
            end;
          end;

     end;
  end;
end;

procedure TFormCalendar.FormMouseClick(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if(not isMouseMove)then
 begin
   if (rectNxt.Contains(X,Y)) then
    begin

        CurrentDate := CurrentDate + DaysInMonth(CurrentDate);
        //ShouldRefresh(RefreshType.Appointment | RefreshType.Calendar);;
        DispalyUpdate(-1);
    end;
    if (rectPre.Contains(X,Y)) then
    begin
       CurrentDate := CurrentDate - DaysInMonth(CurrentDate);
       //ShouldRefresh(RefreshType.Appointment | RefreshType.Calendar);
       DispalyUpdate(-1);
    end;
    MouseSelectDay := false;
    if (menuIconRect.Contains(X,Y))then
    begin
       rightContextMenuStrip1.Popup(X,Y);
      // DealWithMenu();
    end;
   { if (closeIconRect.Contains(X,Y)) then
        Close(); }
 end;

end;

function TFormCalendar.Heightcalculation(currentdate: TDatetime): integer;
var
  Year,Month,day,dayLines,VerticalSpace : word;
  dt:TDateTime;
begin
  VerticalSpace := 25;
  DecodeDate(currentdate,Year,Month,day);
  dt := EncodeDate(Year,Month,1);
  dayLines :=  Ceil((DayOfWeek(dt)+ DaysInAMonth(Year,Month) - 1 ) / 7);
  Result :=  dayLines * VerticalSpace + 1 + 30;
end;

procedure TFormCalendar.FormDestroy(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
end;

procedure TFormCalendar.TrayMessage(var Msg: TMessage);
var
  p:TPoint;
begin
case Msg.lParam of
 WM_LBUTTONDOWN:
 begin
    ShowMessage('Left button clicked- let''s SHOW the Form!');
    FormCalendar.Show;
 end;
 WM_RBUTTONDOWN:
 begin
  GetCursorPos(p);
  PopUpMenu1.Popup(p.x,p.y);
  //ShowMessage('Right button clicked- let''s HIDE the Form!');
  //FormCalendar.Hide;
 end;
 end;
end;

end.


