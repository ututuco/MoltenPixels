# MoltenPixels
# Simple 2D Graphics Cross Platform Fast Library for Delphi
# Win32 Win64 MacOS iOS Android
# Deploy on all Platforms!

MoltenPixels is a Delphi Project Application template for easy management of OpenGL and OpenGLES capabilities.

This "App template" <b> is not a VCL or Firemonkey app</b>, it manages his own App model that creates a native window with an OpenGL viewport.

The main idea of the project is to reduce the complexity of rendering 2D Images and Shapes with High Performance, High FPS and Full Cross Platform (Windows, Linux, MacOS, iOS and Android), by implementing OpenGL and OpenGLES primitives on each platform. Also you can use a regular Firemoneky Form to create some UI interfaces including standard Firemonkey controls and Skia controls.

>special credits to https://github.com/neslib/DelphiLearnOpenGL.git where i start to learn openGl and cross platform for Delphi great reference


## First Release 0.1

* Cross-platform project template, app management, core event apps, and OpenGL libraries
- TMolpixImage (Image component for drawing images)
    - Rotate Image
    - Scale Image
    - Basic handling of PNG transparency
- TMolpixImgList (TMolpixImages Image List)
- Sample project
- Firemonkey Multi-Device Form for Windows and MacOS


## To-Do
Basic Controls
* TMolpixShape
* TMolpixLabel
* TMolpixButton
* SetSize of TMolpixImage based on user-friendly coordinates (height and width in pixels)
* Firemonkey Multi-Device Form for Android fix error ([DCC Error]... error: c:\program files (x86)\embarcadero\studio\21.0\lib\Android\debug\Androidapi.AppGlue.o: multiple definition of 'ANativeActivity_onCreate')... can Coexists with Firemonkey Forms? 
* Test on iOS


## Fixes and Improovements 

* Blending Png images to allow semi-transparent PNGs


## How to Use it

Clone this repository:
<code>git clone https://github.com/ututuco/MoltenPixels.git</code>

You can change the file https://github.com/ututuco/MoltenPixels/blob/main/src/Projects/MyProject1/Controller.pas to learn how its works!

You can add assets loading from file (methods) or just adding to a zipfile into .res project file

If you want to help me.. please write an email to ututuco.apps@gmail.com

Thanks!

Demos:
Windows:
https://drive.google.com/file/d/1KhYlFo9jEEIWMxR2WW7kwM6GHad00VVe/view?usp=share_link
Android:
https://drive.google.com/file/d/1zz5JVFsZpsqwicAqHCfpXRYqHiaZrU0o/view?usp=share_link




