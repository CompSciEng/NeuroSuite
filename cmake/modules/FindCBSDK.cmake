#
# Try to find CBSDK library and include path.
# Once done this will define
#
# CBSDK_FOUND
# CBSDK_INCLUDE_PATH
# CBSDK_LIBRARY
#
IF (WIN32)
	FIND_PATH( CBSDK_INCLUDE_PATH cbsdk.h
		$ENV{CBDIR}/cbsdk/include
		${CBSDK_ROOT_DIR}/include
		DOC "The directory where cbsdk.h resides")

	# For 64bit builds use the x64 version of the library
	IF("${CMAKE_SIZEOF_VOID_P}" EQUAL "8")
		FIND_LIBRARY( CBSDK_LIBRARY
			NAMES cbsdkx64 CBSDK
			PATHS
			$ENV{CBDIR}/cbsdk/lib
			DOC "The CBSDK library"
		)
	ELSE()
		FIND_LIBRARY( CBSDK_LIBRARY
			NAMES cbsdk CBSDK
			PATHS
			$ENV{CBDIR}/cbsdk/lib
			DOC "The CBSDK library"
		)
	ENDIF()
ELSE (WIN32)
	FIND_PATH( CBSDK_INCLUDE_PATH cbsdk.h
		/usr/include

		/usr/local/include
		/sw/include
		/opt/local/include
		${CBSDK_ROOT_DIR}/include
		DOC "The directory where cbsdk.h resides")

	FIND_LIBRARY( CBSDK_LIBRARY
		NAMES CBSDK cbsdk
		PATHS
		/usr/lib64
		/usr/lib
		/usr/local/lib64
		/usr/local/lib
		/sw/lib
		/opt/local/lib
		${CBSDK_ROOT_DIR}/lib
		DOC "The CBSDK library")
ENDIF (WIN32)

SET(CBSDK_FOUND "NO")
IF (CBSDK_INCLUDE_PATH AND CBSDK_LIBRARY)
	SET(CBSDK_LIBRARIES ${CBSDK_LIBRARY})
	SET(CBSDK_FOUND "YES")
ENDIF (CBSDK_INCLUDE_PATH AND CBSDK_LIBRARY)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(CBSDK DEFAULT_MSG CBSDK_LIBRARY CBSDK_INCLUDE_PATH)
