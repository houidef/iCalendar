program desktop;

uses
  Forms,
  uFormCalendar in 'uFormCalendar.pas' {FormCalendar},
  uSetting in 'uSetting.pas',
  uskin in 'uskin.pas',
  uFormParent in 'uFormParent.pas',
  GDIPAPI in 'GDIPlus\GDIPAPI.pas',
  GDIPOBJ in 'GDIPlus\GDIPObj.pas',
  DirectDraw in 'GDIPlus\DirectDraw.pas',
  GDIPUTIL in 'GDIPlus\GDIPUTIL.pas',
  uFormEventEdit in 'uFormEventEdit.pas' {FormEventEdit},
  iCalendar in 'iCalendar.pas',
  uFormWeather in '..\..\teste skin\uFormWeather.pas' {FormWeather};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormCalendar, FormCalendar);
  Application.CreateForm(TFormEventEdit, FormEventEdit);
  //Application.CreateForm(TFormWeather, FormWeather);
  Application.Run;
end.
