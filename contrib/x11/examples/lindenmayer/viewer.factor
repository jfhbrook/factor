USING: kernel alien math arrays sequences opengl namespaces concurrency
x11 x gl concurrent-widgets lindenmayer ;

IN: lindenmayer

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

USE: sequences

: >float-array ( seq -- )
dup length "float" <c-array> swap dup length >array
[ pick set-float-nth ] 2each ;

USE: lindenmayer

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

SYMBOL: camera-position { 5 5 5 } camera-position set-global
SYMBOL: camera-focus    { 0 0 0 } camera-focus set-global
SYMBOL: camera-up       { 0 1 0 } camera-up set-global

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

lparser-dialect "" result set-global

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

: display ( -- )
GL_COLOR_BUFFER_BIT GL_DEPTH_BUFFER_BIT bitor glClear
glLoadIdentity
camera-position get first3 camera-focus get first3 camera-up get first3
gluLookAt
reset result get save-state interpret restore-state glFlush ;

: reshape ( { width height } -- )
>r 0 0 r> [ ] each glViewport
GL_PROJECTION glMatrixMode
glLoadIdentity -1.0 1.0 -1.0 1.0 1.5 200.0 glFrustum
GL_MODELVIEW glMatrixMode
display ;

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

: init ( -- ) axiom get result set display ;

: iterate ( -- ) result [ rewrite ] change display ;

! !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

: setup-window ( -- )

f initialize-x

create-pwindow
[ drop reshape ] over set-pwindow-resize-action
[ 2drop display ] over set-pwindow-expose-action
window-id win set
ExposureMask StructureNotifyMask bitor select-input
{ 500 500 } resize-window { 0 0 } move-window map-window

[ GLX_RGBA ] choose-visual create-context make-current

0.0 0.0 0.0 0.0 glClearColor
GL_SMOOTH glShadeModel

GL_FRONT_AND_BACK GL_SPECULAR { 1.0 1.0 1.0 1.0 } >float-array glMaterialfv
GL_FRONT_AND_BACK GL_SHININESS { 50.0 } >float-array glMaterialfv
GL_LIGHT0 GL_POSITION { 1.0 1.0 1.0 0.0 } >float-array glLightfv

GL_LIGHTING glEnable
GL_LIGHT0 glEnable
GL_DEPTH_TEST glEnable

[ concurrent-event-loop ] spawn ;