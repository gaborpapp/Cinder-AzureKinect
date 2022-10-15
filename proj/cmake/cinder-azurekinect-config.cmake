if ( NOT TARGET Cinder-AzureKinect )

	get_filename_component( CINDER_AZUREKINECT_PATH
		"${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE )
	get_filename_component( MASON_PATH
		"${CMAKE_CURRENT_LIST_DIR}/../../../mason/" ABSOLUTE )

	get_filename_component( CINDER_PATH "${CMAKE_CURRENT_LIST_DIR}/../../../.." ABSOLUTE )

	list( APPEND K4A_INCLUDES
		${CINDER_AZUREKINECT_PATH}/lib/include
	)
	list( APPEND K4A_LIBRARIES
		${CINDER_AZUREKINECT_PATH}/lib/x86_64-linux-gnu/libk4a.so
		${CINDER_AZUREKINECT_PATH}/lib/x86_64-linux-gnu/libk4arecord.so
		#${CINDER_AZUREKINECT_PATH}/lib/x86_64-linux-gnu/libk4a1.4/libdepthengine.so.2.0
		${CINDER_AZUREKINECT_PATH}/lib/x86_64-linux-gnu/libk4abt.so
	)

	list( APPEND CINDER_AZUREKINECT_INCLUDES
		${CINDER_AZUREKINECT_PATH}/src
	)
	list( APPEND CINDER_AZUREKINECT_SOURCES
		${CINDER_AZUREKINECT_PATH}/src/ck4a/CaptureAzureKinect.cpp
		${CINDER_AZUREKINECT_PATH}/src/ck4a/CaptureDevice.cpp
		${CINDER_AZUREKINECT_PATH}/src/ck4a/CaptureManager.cpp
		${CINDER_AZUREKINECT_PATH}/src/ck4a/CaptureTypes.cpp
		${CINDER_AZUREKINECT_PATH}/src/imguix/ImGuiFilePicker.cpp
	)

	list( APPEND MASON_INCLUDES
		${MASON_PATH}/src
	)

	list( APPEND MASON_SOURCES
		${MASON_PATH}/src/mason/Assets.cpp
		${MASON_PATH}/src/mason/Info.cpp
		${MASON_PATH}/src/mason/imx/ImGuiStuff.cpp
		${MASON_PATH}/src/mason/imx/ImGuiTexture.cpp
	)

	list( APPEND OSC_INCLUDES
		"${CINDER_AZUREKINECT_PATH}/../../../Cinder/blocks/OSC/src"
	)

	add_library( Cinder-AzureKinect ${CINDER_AZUREKINECT_SOURCES} ${MASON_SOURCES})
	target_link_libraries( Cinder-AzureKinect PUBLIC ${K4A_LIBRARIES} )

	target_include_directories( Cinder-AzureKinect PUBLIC ${K4A_INCLUDES} ${MASON_INCLUDES} ${CINDER_AZUREKINECT_INCLUDES} ${OSC_INCLUDES})
	target_include_directories( Cinder-AzureKinect PRIVATE BEFORE "${CINDER_PATH}/include" )

	if ( NOT TARGET cinder )
		include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		find_package( cinder REQUIRED PATHS
			"${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
			"$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()
	target_link_libraries( Cinder-AzureKinect PRIVATE cinder )

endif()
