# Generated on 2019-4-15 23:38:33 by version CURRENT_PROJECT_VERSION of mulle-xcode-to-cmake
# Command line:
#    mulle-xcode-to-cmake export pi_saver.xcodeproj

project( pi_saver)

cmake_minimum_required (VERSION 3.4)

#
# mulle-bootstrap environment
#

# check if compiling with mulle-bootstrap (works since 2.6)

if( NOT MULLE_BOOTSTRAP_VERSION)
  include_directories( BEFORE SYSTEM
dependencies/include
addictions/include
)

  set( CMAKE_FRAMEWORK_PATH
dependencies/Frameworks
addictions/Frameworks
${CMAKE_FRAMEWORK_PATH}
)

  set( CMAKE_LIBRARY_PATH
dependencies/lib
addictions/lib
${CMAKE_LIBRARY_PATH}
)

set( DEPENDENCIES_DIR dependencies)
set( ADDICTIONS_DIR addictions)

endif()


#
# Platform specific definitions
#

if( APPLE)
   # # CMAKE_OSX_SYSROOT must be set for CMAKE_OSX_DEPLOYMENT_TARGET (cmake bug)
   if( NOT CMAKE_OSX_SYSROOT)
      set( CMAKE_OSX_SYSROOT "/" CACHE STRING "SDK for OSX" FORCE)   # means current OS X
   endif()
   
   # baseline set to 10.6 for rpath
   if( NOT CMAKE_OSX_DEPLOYMENT_TARGET)
     set(CMAKE_OSX_DEPLOYMENT_TARGET "10.6" CACHE STRING "Deployment target for OSX" FORCE)
   endif()

   set( CMAKE_POSITION_INDEPENDENT_CODE FALSE)

   set( BEGIN_ALL_LOAD "-all_load")
   set( END_ALL_LOAD)
else()
   set( CMAKE_POSITION_INDEPENDENT_CODE TRUE)

   if( WIN32)
   # windows
   else()
   # linux / gcc
      set( BEGIN_ALL_LOAD "-Wl,--whole-archive")
      set( END_ALL_LOAD "-Wl,--no-whole-archive")
   endif()
endif()


##
## pi_saver Files
##

# uncomment this for mulle-objc to search libraries first
# set( CMAKE_FIND_FRAMEWORK "LAST")

set( SOURCES
pi_saver/pi_saverView.m
)

set( STATIC_DEPENDENCIES
)

find_library( FOUNDATION_LIBRARY Foundation)
message( STATUS "FOUNDATION_LIBRARY is ${FOUNDATION_LIBRARY}")

find_library(OSX_FRAMEWORK_SCREENSAVER ScreenSaver)
message( STATUS "OSX_FRAMEWORK_SCREENSAVER is ${OSX_FRAMEWORK_SCREENSAVER}")

find_library( COCOA_LIBRARY Cocoa)
message( STATUS "COCOA_LIBRARY is ${COCOA_LIBRARY}")




set( DEPENDENCIES
${FOUNDATION_LIBRARY}
${OSX_FRAMEWORK_SCREENSAVER}
${COCOA_LIBRARY}
)

set( PUBLIC_HEADERS
)

set( PROJECT_HEADERS
pi_saver/pi_saverView.h
)

set( PRIVATE_HEADERS
)

set( RESOURCES
README.md
)


##
## pi_saver
##

add_library( pi_saver MODULE
${SOURCES}
${PUBLIC_HEADERS}
${PROJECT_HEADERS}
${PRIVATE_HEADERS}
${RESOURCES}
)

target_include_directories( pi_saver
   PUBLIC
      pi_saver
)

target_link_libraries( pi_saver
${BEGIN_ALL_LOAD}
${STATIC_DEPENDENCIES}
${END_ALL_LOAD}
${DEPENDENCIES}
)

set_source_files_properties(
${RESOURCES}
   PROPERTIES
      MACOSX_PACKAGE_LOCATION
      Resources
)

if (APPLE)
   set_target_properties( pi_saver PROPERTIES
BUNDLE TRUE
MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/pi_saver-Info.plist.in"
)
endif()

# if (APPLE)
#    set_target_properties( pi_saver PROPERTIES
# MACOSX_BUNDLE_INFO_PLIST "${CMAKE_CURRENT_SOURCE_DIR}/pi_saver-Info.plist.in"
# )
# endif()
