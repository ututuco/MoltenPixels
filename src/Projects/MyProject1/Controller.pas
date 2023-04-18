unit Controller;

interface

uses Molpix.app,System.Generics.Collections;

type



TController = class(TObject)
Private
 FApp:TApplication;
public
 procedure doInitialize;
 procedure doUpdate;
 procedure doShudown;
 constructor create(sender:TObject);
published
 property App:TApplication read FApp write FApp;
end;

implementation

uses App;

var  imgList1:TMolpixImgList;
     image1:TMolpixImage;
     d:double;
constructor TController.create(sender: TObject);
begin
 App:=TMolpixApp(sender);
end;

procedure TController.doInitialize;
begin
  //example 1
  //create an image from resource
  d:=0.01;
  image1:=TMolpixImage.create(App,'textures/delphi.png');
  image1.PositionX:=400;
  image1.Positiony:=300;
  image1.Scale:=0.3;
  image1.RotationAngle:=-45;
  //example 2
  //create a list of images
  imgList1:=TMolpixImgList.Create;
  for var j :=0 to 200 do
  begin
    var img:TMolpixImage;
    img:=imgList1[imgList1.Add(TMolpixImage.Create(App,'textures/redwin.png'))];
    img.PositionX:=Random(App.Width);
    img.PositionY:=Random(App.Height);
  end;


end;

procedure TController.doShudown;
begin
  imgList1.Free;
  image1.free;
end;


/////////////////////////////////////////
//// This event fires on every frame ////
/////////////////////////////////////////
procedure TController.doUpdate;
begin
  //scale an image
  image1.Scale:=image1.Scale+0.001;

  if imgList1[0].Scale>0.6 then d:=-0.01;
  if imgList1[0].Scale<0 then d:=0.01;


  //scale and rotate list of images
  for var img:TMolpixImage in imgList1 do
  begin
    img.Scale:=img.Scale+d;
    img.RotationAngle:=img.RotationAngle+0.03;
  end;

end;

end.
