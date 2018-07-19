module Common
  ( recruitibasePath
  )
  where

import System.Directory ( getHomeDirectory )
import System.FilePath ( (</>), (<.>) )


recruitibasePath :: IO FilePath
recruitibasePath = do
  homeDir <- getHomeDirectory
  return $ homeDir </> ".config" </> "recruitibase" <.> "yaml"
