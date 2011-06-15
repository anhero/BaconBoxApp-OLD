
set(RedBoxApp_framework_list  "Foundation" "AudioToolBox" "AVFoundation" "CoreGraphics" "OpenAL" "QuartzCore" "UIKit" "OpenGLES")
foreach(framework ${RedBoxApp_framework_list})
	findpkg_framework(${framework})		
	list(APPEND RedBoxApp_IncludeDir_list ${${framework}_FRAMEWORK_INCLUDES})
	list(APPEND RedBoxApp_libraries_list ${${framework}_LIBRARY_FWK})
endforeach(framework)

