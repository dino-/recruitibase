module Dump
  ( doDump
  )
  where

import qualified Data.ByteString.Char8 as C8

import Options ( Options (..) )
import Recruiter ( encodePretty, loadDatabase, recrConfig )


doDump :: Options -> IO ()
doDump (Options dbPath _) = do
  -- Load the data
  database <- loadDatabase dbPath
  let recoded = encodePretty recrConfig database
  C8.putStrLn recoded
