# MoltenPixels
# Simple 2D Graphics Cross Platform Fast Library for Delphi
# Win32 Win64 MacOS iOS Android
# Deploy on all Platforms!

MoltenPixels is a Delphi Project Application template for easy management of OpenGL and OpenGLES capabilities.

This "App template" <b> is not a VCL or Firemonkey app</b>, it manages his own App model that creates a native window with an OpenGL viewport.

The main idea of the project is to reduce the complexity of rendering 2D Images and Shapes with High Performance, High FPS and Full Cross Platform (Windows, Linux, MacOS, iOS and Android), by implementing OpenGL and OpenGLES primitives on each platform.

>special credits to <a href='https://github.com/neslib/DelphiLearnOpenGL.git'>nedlib/a>  where i start to learn openGl and cross platform for Delphi great reference


## First Release 0.1

* Cross-platform project template, app management, core event apps, and OpenGL libraries
- TMolpixImage (Image component for drawing images)
    - Rotate Image
    - Scale Image
    - Basic handling of PNG transparency
- TMolpixImgList (TMolpixImages Image List)
- Sample project


## To-Do

* TMolpixShape
* TMolpixLabel
* SetSize of TMolpixImage based on user-friendly coordinates (height and width in pixels)


## Fixes and Improovements

* Blending Png images to allow semi-transparent PNGs


## How to Use it

Clone this repository:
<code>git clone https://github.com/ututuco/MoltenPixels.git</code>

You can change the file https://github.com/ututuco/MoltenPixels/blob/main/src/Projects/MyProject1/Controller.pas to learn how its works!

You can add assets loading from file (methods) or just adding to a zipfile into .res project file




