
* What is CocoaOniguruma

CocoaOniguruma is an Objective-C binding of Oniguruma regular expression engine.
It's simple and tiny compared to the other bindings.

* How to use

CocoaOniguruma is provided as assorted source files primarily.
Follow the steps to use CocoaOniguruma in your project.

1. Copy "framework/core" directory into your project directory with name "CocoaOniguruma".
2. Open your project by Xcode.
3. Add all .h, .c and .m files under "Classes".
4. Import the header file, so you can use CocoaOniguruma.
    #import "OnigRegexp.h"

* How to use as a Framework

 1. Open CocoaOniguruma.xcodeproj by Xcode.
 2. Select "CocoaOniguruma" for Active Target and "Release" for Active Build Configuration.
 3. Build it.
 4. Copy "build/Release/CocoaOniguruma.framework" into your project directory.
 5. Open your project by Xcode.
 6. Add the framework to your project under "Frameworks".
 7. Open "Targets" in the project tree.
 8. Right click on the application target to open context menu and add a "New Copy Files Build Phase".
 9. Drag "CocoaOniguruma.framework" into the new "Copy Files" phase.
10. Import the header file, so you can use CocoaOniguruma.
    #import "CocoaOniguruma/OnigRegexp.h"

* The Author

Satoshi Nakagawa <psychs AT limechat DOT net>
http://limechat.net/psychs/
#limechat on irc.freenode.net

* Thanks

The specifications and implementations of split and replace functions are based on ruby 1.8.
Thanks to Matz.

* License

CocoaOniguruma contains a part of Oniguruma 5.9.1 source code currently.
See also the Oniguruma's COPYING file.

The revised BSD license

Copyright (c) 2008  Satoshi Nakagawa  <psychs AT limechat DOT net>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.