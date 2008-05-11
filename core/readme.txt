
* What is CocoaOniguruma

CocoaOniguruma is an Objective-C binding of Oniguruma regular expression engine.
It's simple and tiny compared to the other bindings.

* How to use

CocoaOniguruma is designed as a static link library not a framework.

Follow the steps to use CocoaOniguruma in your project.

1. Copy "core" directory into your project directory with name "CocoaOniguruma".
   (Assume your project name is "YourProject" here.)

2. Open your project by Xcode.

3. Add all .h and .m files under "Classes".

  3.1 Right click on "Classes" and select [Add] -> [Existing Files...].
  3.2 select these files and push the OK button.

    - OnigRegexp.h
    - OnigRegexp.m
    - OnigRegexpUtility.h
    - OnigRegexpUtility.m

4. Add an external target under Targets.

  4.1 Right click on Targets and select [Add] -> [New Target...].
  4.2 In the Assistant dialog, select "External Target" under "Special Targets".
  4.3 Input "CocoaOniguruma" for "Target Name".
  4.4 Double click on the CocoaOniguruma target under "Targets".
  4.5 In the dialog, input "CocoaOniguruma/oniguruma" for "Directory" under "Custom Build Command".

5. Add the external target to the build process.

  5.1 Drag the CocoaOniguruma target item into "YourProject" item under "Targets".
      Then you can see the CocoaOniguruma target item under "YourProject".

6. Build the project. (This takes for a while. Then you will see some link errors, but it's no problem. Go ahead.)

7. Add libonig.a to "Linked Frameworks".

  7.1 Expand "Frameworks" item.
  7.2 Right click on "Linked Frameworks" and select [Add] -> [Existing Files...].
  7.3 Select "CocoaOniguruma/oniguruma/universal/libonig.a".

8. Import the header file, so you can use CocoaOniguruma.

    #import "CocoaOniguruma/OnigRegexp.h"

* The Author

Satoshi Nakagawa <artension AT gmail DOT com>
http://d.hatena.ne.jp/Psychs/ (in Japanese)
#limechat on irc.freenode.net

* License

See also the Oniguruma's COPYING file.

The revised BSD license

Copyright (c) 2008  Satoshi Nakagawa  <artension AT gmail DOT com>
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