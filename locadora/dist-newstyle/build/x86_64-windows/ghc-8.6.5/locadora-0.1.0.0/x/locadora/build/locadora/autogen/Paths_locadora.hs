{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_locadora (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\icaro\\AppData\\Roaming\\cabal\\bin"
libdir     = "C:\\Users\\icaro\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.6.5\\locadora-0.1.0.0-inplace-locadora"
dynlibdir  = "C:\\Users\\icaro\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.6.5"
datadir    = "C:\\Users\\icaro\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.6.5\\locadora-0.1.0.0"
libexecdir = "C:\\Users\\icaro\\AppData\\Roaming\\cabal\\locadora-0.1.0.0-inplace-locadora\\x86_64-windows-ghc-8.6.5\\locadora-0.1.0.0"
sysconfdir = "C:\\Users\\icaro\\AppData\\Roaming\\cabal\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "locadora_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "locadora_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "locadora_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "locadora_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "locadora_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "locadora_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
