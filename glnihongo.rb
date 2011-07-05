require 'dl/import'
require 'dl/struct'

module JPN
  extend DL::Importable
  dlload "dll/glnihongo.dll"
  extern "void kanjidraw(int, int, char*)"
end
