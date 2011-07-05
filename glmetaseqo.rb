require 'dl/import'
require 'dl/struct'

module GLM
  extend DL::Importable
  dlload "dll/GLMetaseqDL.dll"
  extern "void mqoInit()"
  extern "void mqoCleanup()"
  extern "void mqoDeleteModel(void*)"
  extern "void* mqoCreateModel(char*, double)"
  extern "void mqoCallModel(void*)"
  extern 'void hogehoge()'
  extern 'long longhoge(void *)'
  extern "long adrcalc()"
end


