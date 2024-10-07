abstract class FilesStates {}

class FilesInitialState extends FilesStates {}

class PickFilesLoadingState extends FilesStates {}

class PickFilesSuccessState extends FilesStates {}

class ClearFilesLoadingState extends FilesStates {}

class ClearFilesSuccessState extends FilesStates {}

class ClearSingleFileLoadingState extends FilesStates {}

class ClearSingleFileSuccessState extends FilesStates {}

class UploadFilesLoadingState extends FilesStates {}

class UploadFilesSuccessState extends FilesStates {}
