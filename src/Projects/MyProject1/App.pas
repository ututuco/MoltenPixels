unit App;
{$INCLUDE 'Molpix.inc'}

interface

uses

  System.DateUtils,
  System.UITypes,
  Neslib.Stb.Image,
  Neslib.FastMath,
  System.SyncObjs,
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  System.Types,
  {$INCLUDE 'OpenGL.inc'}
  Molpix.Classes,
  Molpix.App,
  Controller;

type

  TMolpixApp = class;

  TMolpixImage = class;

  TMolpixImgList = class(TList<TMolpixImage>)
  public
    procedure free;
    destructor destroy;
  end;

  TTextureManager = class(TPersistent)
  private
    FTextureDic:TDictionary<String,GLuint>;
  public
    constructor create;
    procedure addTexture(aPath:string;aTexture:GLuint);
    function getTexture(aPath:string):GLuint;
    destructor destroy;
    procedure free;
  end;

  TMolpixImage = class(TPersistent)
  private
    FApp:TMolpixApp;
    FRotationAngle:Double;
    FPosition:TPointF ;
    FTranparency:Double;
    FFilePath:AnsiString;
    FResourcePath:AnsiString;
    FScale:Double;
    FTexture: GLuint;
    FUniformTransform: GLint;
    FUniformOurTexture: GLint;
    FData:TBytes;
    FWidth:Integer;
    FHeight:Integer;
    FComponents:Integer;
    Findex:integer;
    procedure SetRotationAngle(const Value: Double);
    procedure setApp(const Value: TMolpixApp);
    procedure resize;
    procedure SetPosition(const Value: TPointF);
    procedure SetPositionX(const Value: Single);
    procedure SetPositionY(const Value: Single);
    property App:TMolpixApp read FApp write setApp;
  public
    Rotation, Translation, Transform,Resizing: TMatrix4;
    constructor create(aApp:TApplication;path:string);
    destructor destroy;
    procedure draw;
    procedure free;
  published
    property RotationAngle:Double read FRotationAngle write SetRotationAngle;
    property Scale:Double read FScale write FScale;
    property Texture:GLuint read FTexture write FTexture;
    property PositionX:Single read FPosition.X write SetPositionX;
    property PositionY:Single read FPosition.Y write SetPositionY;
  end;


  TMolpixApp = class(TApplication)
  private
    FTextureManager: TTextureManager;
    FShader: IShader;
    FTexture: GLuint;
    FUImgList: TMolpixImgList;
    FUniformTransform: GLint;
    VERTICES: array [0..19] of Single;
    Controller: TController;
  public
    FVertexArray: IVertexArray;
    VertexLayout: TVertexLayout;
    Data: TBytes;
    oldt:TTime;
    Image: Pointer;
    Components: Integer;
    a:Double;

    procedure Initialize; override;
    procedure Update(const ADeltaTimeSec, ATotalTimeSec: Double); override;
    procedure Shutdown; override;
    procedure KeyDown(const AKey: Integer; const AShift: TShiftState); override;
  published
    property Images:TMolpixImgList read FUImgList write  FUImgList;
    property TextureManager:TTextureManager read FTextureManager write FTextureManager;
  end;

implementation



const

{ The indices define 2 triangles forming a rectangle }
  INDICES: array [0..5] of UInt16 = (
    0, 1, 3,
    1, 2, 3);


procedure TMolpixApp.Initialize;

begin
  Controller:=TController.Create(Self);
  TextureManager:=TTextureManager.create;

  VERTICES[0]:= -0.5;
  VERTICES[1]:= -0.5;
  VERTICES[2]:= 0.0;

  VERTICES[3]:= 1.0;
  VERTICES[4]:= 1.0;
  VERTICES[5]:= 0.5;

  VERTICES[6]:= -0.5;
  VERTICES[7]:= 0.0;
  VERTICES[8]:= 1.0;

  VERTICES[9]:= 0.0;
  VERTICES[10]:= 0.5;
  VERTICES[11]:= 0.5;

  VERTICES[12]:= 0.0;
  VERTICES[13]:= 0.0;
  VERTICES[14]:= 0.0;

  VERTICES[15]:= -0.5;
  VERTICES[16]:= 0.5;
  VERTICES[17]:= 0.0;

  VERTICES[18]:= 0.0;
  VERTICES[19]:= 1.0;

  { Initialize the asset manager }


  FUImgList:=TMolpixImgList.Create;
  oldt:=now;
  TAssets.Initialize;
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

  { Build and compile our shader program }

  FShader := TShader.Create('shaders/transform.vs', 'shaders/transform.fs');
  //FShader := TShader.Create('C:\Users\nerib\OneDrive\Documentos\shaders\transform.vs', 'C:\Users\nerib\OneDrive\Documentos\shaders\transform.fs');
  FUniformTransform := FShader.GetUniformLocation('transform');

  { Define layout of the attributes in the shader program. }
  VertexLayout.Start(FShader)
    .Add('position', 3)
    .Add('texCoord', 2);

  { Define Images and textures }
  glViewport(0, 0, Width, Height);
  FShader.Use;
  FVertexArray := TVertexArray.Create(VertexLayout,VERTICES, SizeOf(VERTICES), INDICES);

  Controller.doInitialize;

end;

procedure TMolpixApp.KeyDown(const AKey: Integer; const AShift: TShiftState);
begin
  { Terminate app when Esc key is pressed }
  if (AKey = vkEscape) then
    Terminate

end;

procedure TMolpixApp.Shutdown;
begin
  Controller.doShudown;
  for var img:TMolpixImage in Images do
    glDeleteTextures(1, @img.FTexture);
  for var img:TMolpixImage in Images do
    img.free;
  Images.free;
  TextureManager.free;
  Controller.Free;
end;

procedure TMolpixApp.Update(const ADeltaTimeSec, ATotalTimeSec: Double);

begin

    glClearColor(0.1, 0.1, 0.1, 1.0);
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    FVertexArray.BeginRender;
    for var img:TMolpixImage in Images do img.draw;
    Controller.doUpdate;
{   for var img:TMolpixImage in Images do
    begin

      img.Scale:=img.Scale+0.003;
      img.RotationAngle:=img.RotationAngle+0.1;

    end;
 }                              {
   for var img:TMolpixImage in Images do
    begin

      img.Scale:=img.Scale+0.003;
      img.RotationAngle:=img.RotationAngle+0.1;

    end;
                                 }
end;

{ TMolpixImage }

constructor TMolpixImage.create(aApp:TApplication; path:string);

begin
    App:=TMolpixApp(aApp);
    var tempTex:GLuint;
    tempTex:=App.TextureManager.getTexture(path);
    if tempTex<>0 then
    begin
      FTexture:=tempTex;
      exit;
    end;

  if FileExists(path) then
    FTexture:= LoadTextureFromFile(path,true)
  else
    FTexture:= LoadTexture(path,true);

  App.TextureManager.addTexture(path,FTexture);

  inherited create;

end;

destructor TMolpixImage.destroy;
begin
  inherited destroy;
end;

procedure TMolpixImage.draw;
begin
  glBindTexture(GL_TEXTURE_2D, FTexture);
  Translation.InitTranslation(((2/App.Width)*Fposition.x)-1,1-((2/App.Height)*FPosition.y), 0);
  Rotation.InitRotationZ(RotationAngle);
  Resizing.InitScaling(FScale);
  Transform := Rotation*Translation*Resizing;
  glUniformMatrix4fv(FUniformTransform, 1, GL_FALSE, @Transform);
  App.FVertexArray.Render;
end;

procedure TMolpixImage.free;
begin
  App.Images.Delete(App.Images.IndexOf(self));
  FreeAndNil(self);
  inherited free;
end;

procedure TMolpixImage.resize;
begin
 //
end;

procedure TMolpixImage.setApp(const Value: TMolpixApp);
begin
  FApp:=Value;
  App.Images.Add(Self);
end;

procedure TMolpixImage.SetPosition(const Value: TPointF);
begin
  FPosition := Value;
end;

procedure TMolpixImage.SetPositionX(const Value: Single);
begin
  FPosition.X := Value;
end;

procedure TMolpixImage.SetPositionY(const Value: Single);
begin
  FPosition.Y := Value;
end;

procedure TMolpixImage.SetRotationAngle(const Value: Double);
begin
  FRotationAngle := value;
end;

{ TTextureManager }

procedure TTextureManager.addTexture(aPath: string; aTexture: GLuint);
begin
  FTextureDic.TryAdd(aPath,aTexture);
end;

constructor TTextureManager.create;
begin
  FTextureDic:=TDictionary<string,GLuint>.Create
end;

destructor TTextureManager.destroy;
begin
  FreeAndNil(FTextureDic)
end;

procedure TTextureManager.free;
begin
  FTextureDic.Free;
  FreeAndNil(self);
  inherited Destroy;
end;

function TTextureManager.getTexture(aPath:string): GLuint;
begin
  Result:=0;
  FTextureDic.TryGetValue(apath,Result);
end;

{ TMolpixImgList }

destructor TMolpixImgList.destroy;
begin
  for var img:TMolpixImage in Self do
    img.free;
  inherited destroy;
end;

procedure TMolpixImgList.free;
begin
  destroy;
end;

end.
