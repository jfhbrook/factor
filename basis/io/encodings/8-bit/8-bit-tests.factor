USING: io.encodings.string io.encodings.8-bit
io.encodings.8-bit.private tools.test strings arrays
io.encodings.8-bit.latin1 io.encodings.8-bit.windows-1252 ;

{ B{ char: f char: o char: o } } [ "foo" latin1 encode ] unit-test
[ { 256 } >string latin1 encode ] must-fail
{ B{ 255 } } [ { 255 } >string latin1 encode ] unit-test

{ "bar" } [ "bar" latin1 decode ] unit-test
{ { char: b 233 char: r } } [ B{ char: b 233 char: r } latin1 decode >array ] unit-test
{ { 0xfffd 0x20AC } } [ B{ 0x81 0x80 } windows-1252 decode >array ] unit-test

{ t } [ \ latin1 8-bit-encoding? ] unit-test
{ "bar" } [ "bar" \ latin1 decode ] unit-test
