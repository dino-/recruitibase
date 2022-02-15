module Dump
  ( doDump
  )
  where

import qualified Data.Text.Encoding as TE
import qualified Data.Text.IO as TIO

import Options ( Options (..) )
import Recruiter ( encodePretty, loadDatabase, recrConfig )


doDump :: Options -> IO ()
doDump (Options dbPath _) = do
  -- Load the data
  database <- loadDatabase dbPath
  let recoded = encodePretty recrConfig database
  TIO.putStrLn . TE.decodeUtf8 $ recoded
